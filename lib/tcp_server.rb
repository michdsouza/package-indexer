require 'socket'
require 'thread'
require './lib/input_processor.rb'

PORT = 8080
processor = InputProcessor.new
mutex = Mutex.new

Socket.tcp_server_loop(PORT) {|socket, _|
  Thread.new {
    begin
      while line = socket.gets
        mutex.synchronize do  
          socket.print processor.process(line)
        end
      end
    end
  }
}

# README (Build script)
# Docker
# Run rubocop
# Dead comments