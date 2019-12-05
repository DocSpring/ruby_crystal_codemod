require "spec_helper"
require "fileutils"

VERSION = Gem::Version.new(RUBY_VERSION)
FILE_PATH = Pathname.new(File.dirname(__FILE__))

def assert_source_specs(source_spec_path)
  relative_path = Pathname.new(source_spec_path).relative_path_from(FILE_PATH).to_s

  describe relative_path do
    tests = []
    current_test = nil

    File.foreach(source_spec_path).with_index do |line, index|
      begin
        case
        when line =~ /^#~# ORIGINAL ?([\w\s]+)$/
          # save old test
          tests.push current_test if current_test

          # start a new test

          name = $~[1].strip
          name = "unnamed test" if name.empty?

          current_test = {
            name: name,
            line: index + 1,
            options: {},
            original: "",
            source: source_spec_path,
          }
        when !current_test
          next
        when line =~ /^#~# EXPECTED$/
          current_test[:expected] = ""
        when line =~ /^#~# PENDING$/
          current_test[:pending] = true
        when line =~ /^#~# ERRORS$/
          current_test[:errors] = []
        when line =~ /^#~# (.+)$/
          current_test[:options] = eval("{ #{$~[1]} }")
        when current_test[:errors]
          # Remove any quotes around the string (just to fix syntax highlighting in VS Code)
          if line.strip != ""
            current_test[:errors] << line
          end
        when current_test[:expected]
          current_test[:expected] += line
        when current_test[:original]
          current_test[:original] += line
        end
      rescue StandardError => ex
        puts "Error in #{source_spec_path}:"
        raise ex
      end
    end

    tests.concat([current_test]).each do |test|
      it "formats #{test[:name]} (line: #{test[:line]})" do
        pending if test[:pending]
        options = test[:options] || {}
        options[:store_logs] = true

        formatter = described_class.new(
          test[:original],
          test[:source],
          File.dirname(test[:source]),
          **options,
        )
        expect(formatter.logs).to eq []
        formatter.format
        formatted = formatter.result
        expected = test[:expected].rstrip + "\n"
        expect(formatted).to eq(expected)

        if test[:errors]
          all_logs = formatter.logs.join("\n")
          test[:errors].each do |expected_error|
            if expected_error.match?(/^["']|["']$/)
              error_string = expected_error.strip.gsub(/^["']|["']$/, "")
            elsif expected_error.match?(/^\/.*\/$/)
              error_regex = Regexp.new(expected_error.strip.gsub(/^\/|\/$/, ""), Regexp::MULTILINE)
            else
              error_string = expected_error.strip
            end
            if error_string
              expect(all_logs).to include(error_string)
            else
              expect(all_logs).to match(error_regex)
            end
          end
        end

        # Ruby => Crystal can't be idempotent!
        # (Surprisingly, this test was passing until I added &: => &. for the block shorthand)
        # idempotency_check = described_class.format(formatted, "example_dir/example_file.rb", "example_dir", **options)
        # expect(idempotency_check).to eq(formatted)
      end
    end
  end
end

def assert_format(code, expected = code, **options)
  expected = expected.rstrip + "\n"

  line = caller_locations[0].lineno

  ex = it "formats #{code.inspect} (line: #{line})" do
    actual = RubyCrystalCodemod.format(code, "example_dir/example_file.rb", "example_dir", **options)
    if actual != expected
      fail "Expected\n\n~~~\n#{code}\n~~~\nto format to:\n\n~~~\n#{expected}\n~~~\n\nbut got:\n\n~~~\n#{actual}\n~~~\n\n  diff = #{expected.inspect}\n         #{actual.inspect}"
    end

    second = RubyCrystalCodemod.format(actual, "example_dir/example_file.rb", "example_dir", **options)
    if second != actual
      fail "Idempotency check failed. Expected\n\n~~~\n#{actual}\n~~~\nto format to:\n\n~~~\n#{actual}\n~~~\n\nbut got:\n\n~~~\n#{second}\n~~~\n\n  diff = #{second.inspect}\n         #{actual.inspect}"
    end
  end

  # This is so we can do `rspec spec/ruby_crystal_codemod_spec.rb:26` and
  # refer to line numbers for assert_format
  ex.metadata[:line_number] = line
end

RSpec.describe RubyCrystalCodemod::Formatter do
  source_specs = Dir[File.join(FILE_PATH, "/formatter_source_specs/*")]
  source_specs += Dir[File.join(FILE_PATH, "/formatter_crystal_specs/*")]

  source_specs.each do |source_spec|
    assert_source_specs(source_spec) if File.file?(source_spec)
  end

  if VERSION >= Gem::Version.new("2.6")
    Dir[File.join(FILE_PATH, "/formatter_source_specs/2.6/*")].each do |source_specs|
      assert_source_specs(source_specs) if File.file?(source_specs)
    end
  end

  # Empty
  describe "empty" do
    assert_format "", ""
    assert_format "   ", "   "
    assert_format "\n", ""
    assert_format "\n\n", ""
    assert_format "\n\n\n", ""
  end
end
