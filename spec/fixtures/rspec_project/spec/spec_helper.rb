$:.push(File.expand_path("../..", __FILE__))
$:.push(File.dirname(__FILE__))

require 'rspec'
require 'gelauto'
require 'pry-byebug'
require 'lib/example_class'

Dir.chdir('spec') do
  Dir.glob('support/*.rb').each do |f|
    require f
  end
end

# quiet logs for test runs
Gelauto.logger.level = :fatal
