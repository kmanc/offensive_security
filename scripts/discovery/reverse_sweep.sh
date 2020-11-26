#!/bin/sh

# For /24
for ip in $(seq 0 255);do
  # Run host on the IP and show me results if the IP doesn't respond saying it wasn't found
  host 10.11.1.$ip | grep -v "not found" | cut -d " " -f 1,5 &
done
# Wait for the last IP to respond
wait
