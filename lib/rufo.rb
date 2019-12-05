# frozen_string_literal: true

module Rufo
  class Bug < StandardError; end

  class SyntaxError < StandardError; end

  def self.format(code, filename, dir, **options)
    Formatter.format(code, filename, dir, **options)
  end
end

require_relative "rufo/command"
require_relative "rufo/logger"
require_relative "rufo/dot_file"
require_relative "rufo/settings"
require_relative "rufo/formatter"
require_relative "rufo/version"
require_relative "rufo/file_finder"
