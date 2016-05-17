require 'socket'
require './lib/input_processor.rb'

server = TCPServer.new(8080)
processor = InputProcessor.new

# Socket.tcp_server_loop(8080) {|sock, client_addrinfo|
#   Thread.new {
#     begin
#       line = sock.readline
#       puts line
#       response = InputProcessor.new(line, graph).process
#       puts response
#       sock.puts "#{response}"
#     # ensure
#     #   sock.close
#     end
#   }
# }

count = 0

# Thread.start(server.accept) do |socket|
#   while line = socket.gets  
#     count = count + 1
#     puts "#{count}: #{line}"
#     response = processor.process(line)
#     puts response
#     socket.print response
#   end
# end

socket = server.accept
loop do
  line = socket.gets
  count = count + 1
  response = processor.process(line)
  puts "#{count}: #{line}"
  puts response
  socket.print response
end



