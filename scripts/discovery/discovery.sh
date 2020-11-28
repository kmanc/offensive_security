#!/bin/sh

scan_web (){
  # Grab the IP address for this scan_web call
  ip_address=$1

  # Grab the port for this scan_web call
  port=$2

  # Run a background nikto scan on the given port - output its results to a file called "nikto_<port>"
  echo "Running a nikto scan on port $port"
  nikto -host $ip_address -port $port 1> nikto_$port 2>> discovery_errors.log &

  # Run a background gobuster scan on the given port - output its results to a file called "gobuster_dir_<port>"
  echo "Running a gobuster scan on port $port"
  gobuster dir -q -t 25 -r -w /usr/share/wordlists/seclists/directory-list-2.3-small.txt -u http://$ip_address:$port 1> gobuster_dirs_$port 2>> discovery_errors.log &

  # Get the pid of the gobuster command so we can wait for it
  pid=$!

  # Wait for that pid to complete
  wait $pid
  echo "\tGobuster scan complete! You can now see the results in the file gobuster_dirs_$port"

  # Run a background wfuzz scan on port the given port for each directory found - output its results to a file called "wfuzz_files_<port>"
  while read line; do
    directory=$(echo $line |  cut -d " " -f 1)
    echo "Running a wfuzz scan on port $port's $directory directory"
    wfuzz -w /usr/share/wordlists/seclists/raft-medium-files.txt -t 25 --hc 404,403 -o raw http://$ip_address:$port$directory/FUZZ 1>> wfuzz_files_$port 2>> discovery_errors.log
    echo "\tWfuzz scan on port $port's $directory directory complete!"
  done <gobuster_dirs_$port

  # Also scan just the root directory with wfuzz
  echo "Running a wfuzz scan on port $port's root directory"
  wfuzz -w /usr/share/wordlists/seclists/raft-medium-files.txt -t 25 --hc 404,403 -o raw http://$ip_address:$port/FUZZ 1>> wfuzz_files_$port 2>> discovery_errors.log
  echo "\tWfuzz scan on port $port's root directory complete!"
}

discover () {
  # Grab the IP address for this discover call
  ip_address=$1

  # Grab the username
  user=$2

  # Make a directory corresponding to the IP address provided
  mkdir ./$ip_address

  # cd into that directory
  cd $ip_address

  # Create a log file for any errors that happen on this particular machine
  echo "Errors" > discovery_errors.log

  # Call a super basic nmap scan on the host - output its results to a file called "basic_nmap"
  echo "Starting basic nmap scan"
  nmap -sV $ip_address 1> basic_nmap 2>> discovery_errors.log

  # Get the pid of the nmap command so we can wait for it
  pid=$!

  # Wait for that pid to complete, then inform the user it is complete
  wait $pid
  echo "\tBasic nmap scan complete! You can now see results in the file basic_nmap"

  # Check to see if the basic nmap scan reported port 80 as open and running http
  if grep -q -E "^(80/tcp)\s+(open)\s+(http)" basic_nmap;
    then
      # Run the scan_web funtion for the IP address on port 80
      scan_web $ip_address 80 &
  fi

  # Check to see if the basic nmap scan reported port 8080 as open and running http
  if grep -q -E "^(8080/tcp)\s+(open)\s+(http)" basic_nmap;
    then
      # Run the scan_web funtion for the IP address on port 8080
      scan_web $ip_address 8080 &
  fi

  # Run showmount to list any network filesystem directories that might be discoverable - output its results to a file called "mounts"
  echo "Starting a showmount scan"
  showmount -e $ip_address 1> mounts 2>> discovery_errors.log &

  # Get the pid of the showmount command so we can wait for it
  pid=$!

  # Wait for that pid to complete, then inform the user it is complete
  wait $pid
  echo "\tShowmount scan complete! You can now see results in the file mounts"

  # Run an in-depth scan for any open TCP ports - output the results to a file called "tcp_all_nmap"
  echo "Starting more in-depth nmap scan for all TCP ports"
  nmap -p- $ip_address 1> tcp_all_nmap 2>> discovery_errors.log

  # Get the pid of the nmap command so we can wait for it
  pid=$!

  # Wait for that pid to complete, then inform the user it is complete
  wait $pid
  echo "\tNmap scan on all TCP ports complete! You can now see results in the file tcp_all_nmap"

  # Change the owner of the directory and all created files to be the user, not root
  chown -R $user ../$ip_address 2>> discovery_errors.log

  # Change the group of the directory and all created files to be the user, not root
  chgrp -R $user ../$ip_address 2>> discovery_errors.log

  # Wait for all jobs related to this IP address to complete
  wait

  # Print to console that the host is complete, and add the completed IP address to the status file
  echo $ip_address | tee -a ../discovery_status.log
}


# If the person who called this isn't root and didn't run with sudo, print warning and exit
if [ `id -u` != 0 ];
  then
    echo "Please run me as root (with sudo) or I will not work"
    exit
fi

# Create a log file for status completed hosts
echo "Completed hosts" > discovery_status.log

# Get the user even though they are calling this script as root
user=`who | awk '{print $1}'`

# For any IP address that follows the invocation of the script
for ip in $@; do
  # Call the discover function in parallel, passing both the IP address and the username
  discover $ip $user &
done

# Wait until the last running discover function has completed
wait

# Let the user know that everything ran
echo
echo "All machines completed"