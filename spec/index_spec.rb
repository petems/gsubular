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
    expect(last_response).to be_ok
    expect(last_response.body).to include "<title>Gsubular</title>"
  end

  it "shows the ping page" do
    get '/ping'
    expect(last_response).to be_ok
    expect(last_response.body).to include "pong"
  end
end