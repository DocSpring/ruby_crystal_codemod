require "spec_helper"
require 'open3'

RSpec.describe 'Crystal Codemod' do
  it 'transpiles the example Ruby code into Crystal and produces the same output' do
    root_folder = File.expand_path(File.join(__dir__, "../../.."))

    crystal_files = Dir.glob(File.join(root_folder, "spec/fixtures/**/*.cr"))
    FileUtils.rm_rf(crystal_files)

    source_folder = File.join(root_folder, "spec/fixtures/crystal_codemod_test")
    ruby_entry = File.join(source_folder, 'example.rb')
    crystal_entry = File.join(source_folder, 'example.cr')

    Dir.chdir source_folder do
      stdout, stderr, status = Open3.capture3('../../../exe/rufo', '--simple-exit', source_folder)
      unless status.success?
        raise "Rufo formatting failed with status: #{status.exitstatus}\n\n" \
          "stdout: #{stdout}\n\n" \
          "stderr: #{stderr}"
      end
    end

    stdout, stderr, status = Open3.capture3('ruby', ruby_entry)
    unless status.success?
      raise "Ruby failed with status: #{status.exitstatus}\n\n" \
        "stdout: #{stdout}\n\n" \
        "stderr: #{stderr}"
    end
    expected_output_file = File.join(source_folder, 'expected_output.txt')
    # File.open(expected_ruby_output_file, 'w') { |f| f.puts stdout.strip }
    expected_output = File.read(expected_output_file)
    expect(stdout.strip).to eq expected_output.strip

    default_crystal_path = `crystal env CRYSTAL_PATH`.chomp
    crystal_path = "#{default_crystal_path}:#{source_folder}"

    stdout, stderr, status = Open3.capture3({
      'CRYSTAL_PATH' => crystal_path,
    }, 'crystal', 'run', crystal_entry)
    unless status.success?
      raise "Crystal failed with status: #{status.exitstatus}\n\n" \
        "stdout: #{stdout}\n\n" \
        "stderr: #{stderr}"
    end
    expect(stdout.strip).to eq expected_output.strip
  end
end
