require 'socket'
require 'thread'
require './lib/input_processor.rb'

server = TCPServer.new(8080)
processor = InputProcessor.new
mutex = Mutex.new

loop do
  Thread.start(server.accept) do |socket|
    while line = socket.gets
      mutex.synchronize do  
        socket.print processor.process(line)
      end
    end
  end
end

# loop do
#   socket = server.accept
#   while line = socket.gets
#     response = processor.process(line)
#     socket.print response
#   end
# end

# TODO: Refactor & write tests
# Concurrency = 100
# Comment code / Add logging
# README
# Build script


