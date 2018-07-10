require "webrick"

class FileShareHTTPServer < WEBrick::HTTPServlet::AbstractServlet
  def do_GET(request, response)
  end

  def do_POST(request, response)
  end
end

server = WEBrick::HTTPServer.new(:Port => 8000)
server.mount Dir.pwd, FileShareHTTPServer

trap("INT") do
  server.shutdown
end

server.start