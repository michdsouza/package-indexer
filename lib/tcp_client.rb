require 'socket'

hostname = 'localhost'
port = 8080

s = TCPSocket.open(hostname, port)
s.write("INDEX|pkg-config|\n")
# s.write("INDEX|makedepend|pkg-config")
# s.write("INDEX|openssl|makedepend,pkg-config")
