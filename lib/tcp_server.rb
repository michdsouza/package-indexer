require 'socket'
require './lib/input_processor.rb'
require './lib/graph.rb'

server = TCPServer.new(8080)
graph = Graph.new

loop do
  Thread.start(server.accept) do |socket|
    while line = socket.gets  
      puts InputProcessor.new(line, graph).process
    end
  end  
end



