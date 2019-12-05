# frozen_string_literal: true

module RubyCrystalCodemod
  class Bug < StandardError; end

  class SyntaxError < StandardError; end

  def self.format(code, filename, dir, **options)
    Formatter.format(code, filename, dir, **options)
  end
end

require_relative "ruby_crystal_codemod/command"
require_relative "ruby_crystal_codemod/logger"
require_relative "ruby_crystal_codemod/dot_file"
require_relative "ruby_crystal_codemod/settings"
require_relative "ruby_crystal_codemod/formatter"
require_relative "ruby_crystal_codemod/version"
require_relative "ruby_crystal_codemod/file_finder"
