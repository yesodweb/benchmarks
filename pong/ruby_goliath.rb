#!/usr/bin/env ruby
require 'goliath'

class RubyGoliath < Goliath::API
  def response(env)
    [200, {}, "PONG"]
  end
end
