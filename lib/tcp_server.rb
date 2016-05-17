require 'socket'
require './lib/input_processor.rb'

server = TCPServer.new(8080)
processor = InputProcessor.new

# loop do
#   Thread.start(server.accept) do |socket|
#     while line = socket.gets
#       count = count + 1
#       puts "#{count}: #{line}"
#       response = processor.process(line)
#       puts response
#       socket.print response
#     end
#   end
# end

loop do
  count = 0
  socket = server.accept
  while line = socket.gets
    count = count + 1
    puts "#{count}: #{line}"
    response = processor.process(line)
    puts response
    socket.print response
  end
end


