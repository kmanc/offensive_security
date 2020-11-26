#!/usr/bin/python3

import argparse
import socket

parser = argparse.ArgumentParser(description="Sweep SMTP for users given a user file and ip address")
parser.add_argument('-f', dest='filename', type=str)
parser.add_argument('-i', dest='ip_address', type=str)
args = parser.parse_args()
user_file = args.filename
ip_address = args.ip_address

if user_file is None or ip_address is None:
    print(parser.description)
    exit(0)

with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
    connect = s.connect((ip_address, 25))
    banner = s.recv(1024)
    ip_address = ip_address.encode()
    print(banner)
    with open(user_file) as f:
        for line in f:
            s.send(b'VRFY ' + ip_address + b'\r\n')
            result = s.recv(1024)
            if b"250" in result:
                print(result)
