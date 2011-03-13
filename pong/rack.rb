require 'rubygems'
require 'rack'
class RackApp
  def call(env)
    Rack::Response.new("PONG").finish
  end
end
run RackApp.new
