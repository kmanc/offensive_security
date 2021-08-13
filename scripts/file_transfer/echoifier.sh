#!/bin/sh

echo
cat << EOF
########################################
######## Echo transfer protocol ########
################ Koins #################
########################################
EOF
echo

if [ -z "$1" ]; then
  echo "[*] Turn any script into a set of echo-able commands so you can echo-transfer-protocol it"
  echo "[*] Usage: $0 <script_name>"
  exit 0
fi

# Make a new filename
newfile="echo_$1"
# Echo the first line in with just a single arrow
echo "echo $(head -n 1 $1) > $1" > $newfile
# For all lines in a file
while read -r line; do
  # If the flag is set (all lines but the first)
  if [ ! -z "$flag" ]; then
    # Echo the line into the echo'd version
    echo "echo $line >> $1" >> "$newfile"
  else
    flag=1
  fi
done < $1
echo "See $newfile for results"
echo