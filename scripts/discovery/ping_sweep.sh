#!/bin/sh

# For a /34
for ip in $(seq 0 255); do
  # Ping every host in it and only show me results if the host responds
  ping -c 1 10.11.1.$ip | grep "bytes from" | cut -d " " -f 4 | cut -d ":" -f 1 &
done
# Wait for the last host to return
wait
