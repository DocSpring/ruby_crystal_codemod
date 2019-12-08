# typed: strict
$:.push(File.expand_path("../..", __FILE__))
$:.push(File.dirname(__FILE__))

require 'rspec'
require 'pry-byebug'
require 'sorbet-runtime'
require 'src/example_class_annotated'

Dir.chdir('spec') do
  Dir.glob('support/*.rb').each do |f|
    require f
  end
end

# quiet logs for test runs
# Gelauto.logger.level = :fatal
