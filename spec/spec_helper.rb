ENV['RACK_ENV'] = 'test'

require './gsubular'
require 'rspec'
require 'rack/test'
require 'capybara/rspec'
# require 'capybara/poltergeist'
# Capybara.javascript_driver = :poltergeist

Capybara.app = Gsubular

RSpec.configure do |config|
  config.include Rack::Test::Methods
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  config.order = 'random'
end
