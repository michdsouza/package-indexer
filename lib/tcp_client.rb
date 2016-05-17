require 'socket'

hostname = 'localhost'
port = 8080

s = TCPSocket.open(hostname, port)
s.write(nil)
# s.write("INDEX REMOVE|a2ps|\n")
# s.close