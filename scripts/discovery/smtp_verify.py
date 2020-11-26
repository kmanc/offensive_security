import argparse
import socket
import sys

parser = argparse.ArgumentParser(description='SMTP script')
parser.add_argument('-u', dest='username', type=str, help='username to attempt to verify')
parser.add_argument('-i', dest='ip', type=str, help='ip address to verify against')
args = parser.parse_args()
username = args.username.encode('utf-8')
ip = args.ip

if username is None or ip is None:
  print("Usage: smtp_verify.py -u <username> -i <ip_address>")
  exit(0)

# Create a Socket
s=socket.socket(socket.AF_INET, socket.SOCK_STREAM)
# Connect to the Server
connect=s.connect((ip, 25))
# Receive the banner
banner=s.recv(1024)
print(banner)
# VRFY a user
s.send(b'VRFY ' + username + b'\r\n')
result=s.recv(1024)
print(result)
# Close the socket
s.close()
