ENV['RACK_ENV'] = 'test'

require 'rubygems'
require 'bundler/setup'
require 'rspec'
require 'rack/test'
require 'webmock/rspec'
require 'pry'

$app = Rack::Builder.parse_file('config.ru').first

RSpec.configure do |c|
  c.include Rack::Test::Methods
end
