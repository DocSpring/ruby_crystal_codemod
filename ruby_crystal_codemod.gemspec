# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "ruby_crystal_codemod/version"

Gem::Specification.new do |spec|
  spec.name = "ruby_crystal_codemod"
  spec.version = RubyCrystalCodemod::VERSION
  spec.authors = ["Ary Borenszweig", "Nathan Broadbent"]
  spec.email = ["asterite@gmail.com", "nathan@docspring.com"]

  spec.summary = %q{Ruby => Crystal codemod}
  spec.description = %q{Attempts to transpile Ruby code into Crystal code}
  spec.homepage = "https://github.com/docspring/ruby_crystal_codemod"
  spec.license = "MIT"

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.required_ruby_version = ">= 2.4.5"

  spec.add_dependency "gelauto", "~> 1.3.0"
  spec.add_dependency "awesome_print", "~> 1.8.0"
  spec.add_dependency "byebug", "~> 10.0.2"

  spec.add_development_dependency "bundler", ">= 1.15"
  spec.add_development_dependency "guard-rspec", "~> 4.0"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rspec_junit_formatter", "~> 0.4.1"
  spec.add_development_dependency "rubocop", "~> 0.63.1"
  spec.add_development_dependency "rufo", "~> 0.7.0"
end
