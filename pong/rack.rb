require 'rubygems'
require 'rack'
class RackApp
  def call(env)
    [200, {} ["PONG"]]
  end
end
run RackApp.new
