require 'socket'
require 'thread'
require './lib/input_processor.rb'

processor = InputProcessor.new
mutex = Mutex.new

Socket.tcp_server_loop(8080) {|socket, _|
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

# TODO: Refactor & write tests
# Concurrency = 100
# Comment code / Add logging
# README
# Build script


