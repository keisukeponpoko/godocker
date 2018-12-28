this_dir = File.expand_path(File.dirname(__FILE__))
lib_dir = File.join(this_dir, 'pb')
$LOAD_PATH.unshift(lib_dir) unless $LOAD_PATH.include?(lib_dir)

require 'sinatra'
require 'sinatra/reloader'
require 'grpc'
require 'helloworld_services_pb'
require "net/http"

get '/' do
  "no world"
end

get '/service' do
  "service"
end

get '/service/ruby' do
  "service ruby"
end

get '/grpc' do
  stub = Helloworld::Greeter::Stub.new('localhost:5000', :this_channel_is_insecure)
  message = stub.say_hello_world(Helloworld::HelloRequest.new(name: 'sekai')).message
  "Greeting: #{message}"
end

get '/grpc2' do
  stub = Helloworld::Greeter::Stub.new('localhost:8080', :this_channel_is_insecure)
  message = stub.say_hello_world(Helloworld::HelloRequest.new(name: 'sekai')).message
  "Greeting: #{message}"
end

get '/ruby' do
  uri = URI.parse("http://localhost:5000/service/ruby")
  response = Net::HTTP.get_response(uri)
  response.body
end
