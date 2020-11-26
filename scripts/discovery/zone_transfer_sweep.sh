#!/bin/sh

if [ -z "$1" ]; then
  echo "[*] Simple zone transfer script"
  echo "[*] Usage: $0 <domain_name>"
  exit 0
fi

# For nameserver in the domain
for server in $(host -t ns $1 | cut -d " " -f 4);do
  # Attempt a zone transfer on that nameserver
  host -l $1 $server | grep "has address" &
done
# Wait until all servers have responded
wait
