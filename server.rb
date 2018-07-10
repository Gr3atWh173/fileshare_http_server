require "webrick"

class FileShareHTTPServer < WEBrick::HTTPServlet::AbstractServlet
  def do_GET(request, response)
    return unless is_safe(request.path)
    if exists(request.path)
      response.status = 200
      response.body   = File.open(request.path, 'rb').read()
    else
      response.status = 404
      response.body   = "File does not exist on server"
    end
  end

  def do_POST(request, response)
  end

  private

  def is_safe(path)
    return true
  end

  def exists(path)
    File.file? path
  end
end

server = WEBrick::HTTPServer.new(:Port => 8000)
server.mount Dir.pwd, FileShareHTTPServer

trap("INT") do
  server.shutdown
end

server.start