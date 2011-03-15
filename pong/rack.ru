class RackApp
  def call(env)
    [200, {'Content-Type' => 'text/plain'}, "PONG"]
  end
end
run RackApp.new
