require "find"

class RubyCrystalCodemod::FileFinder
  include Enumerable

  # Taken from https://github.com/ruby/rake/blob/f0a897e3fb557f64f5da59785b1a4464826f77b2/lib/rake/application.rb#L41
  RAKEFILES = [
    "rakefile",
    "Rakefile",
    "rakefile.rb",
    "Rakefile.rb",
  ]

  FILENAMES = [
    "Gemfile",
    *RAKEFILES,
  ]

  EXTENSIONS = [
    ".rb",
    ".gemspec",
    ".rake",
    ".jbuilder",
  ]

  EXCLUDED_DIRS = [
    "vendor",
  ]

  def initialize(files_or_dirs)
    @files_or_dirs = files_or_dirs
  end

  def each
    files_or_dirs.each do |file_or_dir|
      if Dir.exist?(file_or_dir)
        all_rb_files(file_or_dir).each { |file| yield [true, file] }
      else
        yield [File.exist?(file_or_dir), file_or_dir]
      end
    end
  end

  private

  attr_reader :files_or_dirs

  def all_rb_files(file_or_dir)
    files = []
    Find.find(file_or_dir) do |path|
      basename = File.basename(path)
      if File.directory?(path)
        Find.prune if EXCLUDED_DIRS.include?(basename)
      else
        if EXTENSIONS.include?(File.extname(basename)) || FILENAMES.include?(basename)
          files << path
        end
      end
    end
    files
  end
end
