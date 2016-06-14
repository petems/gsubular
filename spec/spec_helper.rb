require './gsubular'
require 'rspec'
require 'rack/test'
require 'capybara/rspec'
require 'capybara/poltergeist'
require 'capybara-screenshot/rspec'
Capybara.javascript_driver = :poltergeist

Capybara.app = Gsubular
Capybara.save_and_open_page_path = "./screenshots/"

RSpec.configure do |config|
  config.include Rack::Test::Methods
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  config.order = 'random'
end
