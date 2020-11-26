#!/bin/sh

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
  nmap -oN basic_nmap $ip_address 2>> discovery_errors.log

  # Call a more in depth nmap scan that runs service discovery and the vuln NSE script - output its results to a file called "vuln_nmap"
  nmap -oN vuln_nmap -sV --script vuln $ip_address 2>> discovery_errors.log

  # Check to see if the basic nmap scan reported port 80 as open and running http
  if grep -q -E "^(80/tcp)\s+(open)\s+(http)" basic_nmap;
    then
      # Run a background nikto scan on port 80 - output its results to a file called "nikto_80"
      nikto -host $ip_address -port 80 1>> nikto_80 2>> discovery_errors.log &

      # Run a background gobuster scan on port 80 - output its results to a file called "gobuster_80"
      gobuster dir -q -t 20 -r -w /usr/share/wordlists/dirb/common.txt -u http://$ip_address 1>> gobuster_80 2>> discovery_errors.log &

      # Run a background wfuzz scan on port 80 - output its results to a file called "wfuzz_80"
      wfuzz -w /usr/share/wordlists/wfuzz/general/medium.txt --hc 404 http://$ip_address/FUZZ 1>> wfuzz_80 2>> discovery_errors.log &  
  fi

  # Check to see if the basic nmap scan reported port 8080 as open and running http
  if grep -q -E "^(8080/tcp)\s+(open)\s+(http)" basic_nmap;
    then
      # Run a nikto scan on port 8080 - output its results to a file called "nikto_8080"
      nikto -host $ip_address -port 8080 1>> nikto_8080 2>> discovery_errors.log &

      # Run a background gobuster scan on port 8080 - output its results to a file called "gobuster_8080"
      gobuster dir -q -t 20 -r -w /usr/share/wordlists/dirb/common.txt -u http://$ip_address:8080 1>> gobuster_8080 2>> discovery_errors.log &

      # Run a background wfuzz scan on port 8080 - output its results to a file called "wfuzz_8080"
      wfuzz -w /usr/share/wordlists/wfuzz/general/medium.txt --hc 404 http://$ip_address:8080/FUZZ 1>> wfuzz_8080 2>> discovery_errors.log &
  fi

  # Run showmount to list any network filesystem directories that might be discoverable - output its results to a file called "mounts"
  showmount -e $ip_address 1> mounts 2>> discovery_errors.log

  # Run an in-depth scan for any open TCP ports - output the results to a file called "tcp_all_nmap"
  nmap -oN tcp_all_nmap -p- $ip_address 2>> discovery_errors.log

  # UNCOMMENT IF you want to run a UDP scan, but know that it takes forever
  # Run an in-depth scan for any open UDP ports - output the results to a file called "udp_all_nmap"
  #nmap -oN udp_all_nmap -p- -sU $ip_address 2>> discovery_errors.log

  # Change the owner of the directory and all created files to be the user, not root
  chown -R $user ../$ip_address 2>> discovery_errors.log

  # Change the group of the directory and all created files to be the user, not root
  chgrp -R $user ../$ip_address 2>> discovery_errors.log

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
