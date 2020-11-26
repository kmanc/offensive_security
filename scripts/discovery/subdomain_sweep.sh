#!/bin/sh

# For subdomain candidates in a file
for name in $(cat subdomains.txt);do
  # Run host on the subdomain and return results if the subdomain exists
  host $name.website.com | grep "has address" | cut -d " " -f 1,4 &
done
# Wait for the last possible subdomain to respond
wait
