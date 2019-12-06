# frozen_string_literal: true

require "optparse"
require "open3"

class RubyCrystalCodemod::Command
  CODE_OK = 0
  CODE_ERROR = 1
  CODE_CHANGE = 3

  def self.run(argv)
    want_check, exit_code, filename_for_dot_ruby_crystal_codemod, loglevel = parse_options(argv)
    new(want_check, exit_code, filename_for_dot_ruby_crystal_codemod, loglevel).run(argv)
  end

  def initialize(want_check, exit_code, filename_for_dot_ruby_crystal_codemod, loglevel)
    @want_check = want_check
    @exit_code = exit_code
    @filename_for_dot_ruby_crystal_codemod = filename_for_dot_ruby_crystal_codemod
    @dot_file = RubyCrystalCodemod::DotFile.new
    @squiggly_warning_files = []
    @logger = RubyCrystalCodemod::Logger.new(loglevel)
  end

  def exit_code(status_code)
    if @exit_code
      status_code
    else
      case status_code
      when CODE_OK, CODE_CHANGE
        0
      else
        1
      end
    end
  end

  def run(argv)
    status_code = if argv.empty?
                    format_stdin
                  else
                    format_args argv
                  end
    exit exit_code(status_code)
  end

  def format_stdin
    code = STDIN.read

    result = format(code, nil, @filename_for_dot_ruby_crystal_codemod || Dir.getwd)

    print(result) if !@want_check

    code == result ? CODE_OK : CODE_CHANGE
  rescue RubyCrystalCodemod::SyntaxError
    logger.error("Error: the given text is not a valid ruby program (it has syntax errors)")
    CODE_ERROR
  rescue => e
    logger.error("You've found a bug!")
    logger.error("Please report it to https://github.com/DocSpring/ruby_crystal_codemod/issues with code that triggers it\n")
    raise e
  end

  def format_args(args)
    file_finder = RubyCrystalCodemod::FileFinder.new(args)
    files = file_finder.to_a

    changed = false
    syntax_error = false
    files_exist = false

    files.each do |(exists, file)|
      if exists
        files_exist = true
      else
        logger.warn("Error: file or directory not found: #{file}")
        next
      end
      result = format_file(file)

      changed |= result == CODE_CHANGE
      syntax_error |= result == CODE_ERROR
    end

    return CODE_ERROR unless files_exist

    case
    when syntax_error then CODE_ERROR
    when changed      then CODE_CHANGE
    else                   CODE_OK
    end
  end

  def format_file(filename)
    logger.debug("Formatting: #{filename}")
    code = File.read(filename)

    begin
      result = format(code, filename, @filename_for_dot_ruby_crystal_codemod || File.dirname(filename))
    rescue RubyCrystalCodemod::SyntaxError
      # We ignore syntax errors as these might be template files
      # with .rb extension
      logger.warn("Error: #{filename} has syntax errors")
      return CODE_ERROR
    end

    # if code.force_encoding(result.encoding) != result
    if @want_check
      logger.warn("Formatting #{filename} produced changes")
    else
      crystal_filename = filename.sub(/\.rb$/, ".cr")
      File.write(crystal_filename, result)
      logger.log("Format: #{filename} => #{crystal_filename}")
    end

    # Run the post-processing command to handle BEGIN and END comments for Ruby / Crystal.
    post_process_cmd = File.expand_path(File.join(__dir__, '../../util/post_process'))
    unless File.exist?(post_process_cmd)
      raise "Please run ./bin/compile_post_process to compile the post-processing command " \
        "at: #{post_process_cmd}"
    end
    stdout, stderr, status = Open3.capture3(post_process_cmd, crystal_filename)
    unless status.success?
      warn "'./util/post_process' failed with status: #{status.exitstatus}\n\n" \
           "stdout: #{stdout}\n\n" \
           "stderr: #{stderr}"
    end

    # Format the Crystal file with the Crystal code formatter
    stdout, stderr, status = Open3.capture3("crystal", "tool", "format", crystal_filename)
    unless status.success?
      warn "'crystal tool format' failed with status: #{status.exitstatus}\n\n" \
           "stdout: #{stdout}\n\n" \
           "stderr: #{stderr}"
      puts "(This probably means that you will have to fix some errors manually.)"
    end

    return CODE_CHANGE
    # end
  rescue RubyCrystalCodemod::SyntaxError
    logger.error("Error: the given text in #{filename} is not a valid ruby program (it has syntax errors)")
    CODE_ERROR
  rescue => e
    logger.error("You've found a bug!")
    logger.error("It happened while trying to format the file #{filename}")
    logger.error("Please report it to https://github.com/DocSpring/ruby_crystal_codemod/issues with code that triggers it\n")
    raise e
  end

  def format(code, filename, dir)
    @squiggly_warning = false
    formatter = RubyCrystalCodemod::Formatter.new(code, filename, dir)

    options = @dot_file.get_config_in(dir)
    unless options.nil?
      formatter.init_settings(options)
    end
    formatter.format
    result = formatter.result
    result
  end

  def self.parse_options(argv)
    exit_code, want_check = true, false
    filename_for_dot_ruby_crystal_codemod = nil
    loglevel = :log

    OptionParser.new do |opts|
      opts.version = RubyCrystalCodemod::VERSION
      opts.banner = "Usage: ruby_crystal_codemod files or dirs [options]"

      opts.on("-c", "--check", "Only check formating changes") do
        want_check = true
      end

      opts.on("--filename=value", "Filename to use to lookup .ruby_crystal_codemod (useful for STDIN formatting)") do |value|
        filename_for_dot_ruby_crystal_codemod = value
      end

      opts.on("-x", "--simple-exit", "Return 1 in the case of failure, else 0") do
        exit_code = false
      end

      opts.on(RubyCrystalCodemod::Logger::LEVELS, "--loglevel[=LEVEL]", "Change the level of logging for the CLI. Options are: error, warn, log (default), debug, silent") do |value|
        loglevel = value.to_sym
      end

      opts.on("-h", "--help", "Show this help") do
        puts opts
        exit
      end
    end.parse!(argv)

    [want_check, exit_code, filename_for_dot_ruby_crystal_codemod, loglevel]
  end

  private

  attr_reader :logger
end
