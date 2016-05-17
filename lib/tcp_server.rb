require 'socket'
require './lib/input_processor.rb'

server = TCPServer.new(8080)
processor = InputProcessor.new
count = 0

loop do
  Thread.start(server.accept) do |socket|
    while line = socket.gets
      count = count + 1
      puts "#{count}: #{line}"
      response = processor.process(line)
      puts response
      socket.print response
    end
  end
end



