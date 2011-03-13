require 'rubygems'
require 'rack'
class RackApp
  def call(env)
    Rack::Response.new(
      tableBody("<html><body><table>\n") <<
      "</table></body></html>"
    ).finish
  end

  def tableBody str
    (1..1000).each do |n|
      str = tableRow(str << "<tr><td>#{n}</td>") << "</tr>\n"
    end
    str
  end

  def tableRow str
    (1..50).each do |n|
      str << "<td>#{n}</td>"
    end
    str
  end
end
run RackApp.new
