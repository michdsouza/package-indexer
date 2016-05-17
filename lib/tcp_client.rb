require 'socket'

hostname = 'localhost'
port = 8080

s = TCPSocket.open(hostname, port)
s.write("INDEX|actionmailer|ruby\n")
s.close