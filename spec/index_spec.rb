ENV['RACK_ENV'] = 'test'

require './gsubular'
require 'rspec'
require 'rack/test'

describe 'The Gsubular App' do
  include Rack::Test::Methods

  def app
    Gsubular
  end

  it "displays the title" do
    get '/'
    last_response.should be_ok
    last_response.body.should include "<title>Gsubular</title>"
  end
end