require 'sinatra'
require 'json'
require 'csv'
require_relative 'lib/array_parser'

if development?
  require 'sinatra/reloader'
  require 'pry'
end

application_settings = {
  logger_level: ENV.fetch('APP_LOGGER_LEVEL') { 'info' }
}

configure do
  if application_settings[:logger_level] == 'debug'
    set :logging, Logger::DEBUG
  end
end

before do
  @request_body =
    if request.body.size > 0
      request.body.rewind
      request.body.read
    end

  logger.debug("REQUEST_BODY #{@request_body.inspect}")
  logger.debug("PARAMS #{params.inspect}")
end

post '/array' do
  options = JSON.parse(@request_body)
  result = ArrayParser.new(options).output

  send_data result
end

post '/csv' do
  result = ArrayParser.new({
    'filename' => options['filename'],
    'data' => CSV.read(params['file']['tempfile'])
  }).output

  render result
end

def send_data(result)
  content_type 'application/octet-stream'
  attachment result['filename']

  result['body']
end
