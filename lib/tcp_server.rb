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
          response = processor.process(line)
          puts response
          socket.print response
        end
      end
    end
  }
}

# TODO: Refactor & write tests
# Comment code / Add logging
# README (Build script)

# Fix tests
# Docker
# Run rubocop
# Dead comments
# Fix the ruby version
# Remove tcp_client file
