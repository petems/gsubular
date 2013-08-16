require 'sinatra/base'
require 'sinatra/partial'
require 'newrelic_rpm'
require 'haml'
require 'sass'
require 'json'

class Gsubular < Sinatra::Base
  register Sinatra::Partial

  get '/style.css' do
    headers 'Content-Type' => 'text/css; charset=utf-8'
    sass :style
  end

  get '/' do
    haml :index
  end

  # create
  post '/' do
    response = {}
    begin
      str = params[:test_string]
      regex_do_this = Regexp.new(params[:pattern])
      gsubbed_string = str.gsub!(regex_do_this, params[:replacement])
    rescue Exception => e
      response[:error] = e.message
      return response.to_json
    end
    response[:gsub_string] = []
    response[:gsub_string].push(gsubbed_string)
    response.to_json
  end

  get '/ping' do
    'pong'
  end

  run! if app_file == $0
end
