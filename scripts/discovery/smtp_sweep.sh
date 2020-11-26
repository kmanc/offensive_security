#!/bin/sh

# For all usernames in a file
for user in $(cat user_file.txt); do
  # Attempt to verify the user's email via SMTP at the given IP address
  echo VRFY $user | nc -nv -w 1 X.X.X.X 25 2>/dev/null | grep ^"250" &
done
# Wait for the last user's results
wait
