require 'socket'

server = TCPServer.new(8080)

loop do
  Thread.start(server.accept) do |socket|
    while line = socket.gets  
      puts line.chop        
    end
  end  
end