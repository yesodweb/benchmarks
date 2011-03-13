require 'goliath'

class Hello < Goliath::API
  def response(env)
    [200, {}, 
      tableBody("<html><body><table>\n") <<
      "</table></body></html>"
    ]
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
