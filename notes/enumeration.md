# [aureport](https://linux.die.net/man/8/aureport):
#### `aureport --tty | grep su`
#### `aureport --tty | grep sudo`
  * -tty reports on tty keystrokes - think hands on shell
  * -l reports on logins
  * -n reports on anomaly events
  * -r reports on responses to anomalies

# [fgdump](https://web.archive.org/web/20191115054845/https://www.aldeid.com/wiki/FGDump):
#### `fgdump.exe`
#### `fgdump.exe -h X.X.X.X -l <file>`
  * -h specifies the host
  * -l logs the output to a file

# [find](https://linux.die.net/man/1/find): 
#### `find / -name ssh`
#### `find /bin -name ssh`
#### `find /bin -name ssh -exec file {} \`
#### `find / -perm -u=s -type f 2>/dev/null`
  * searches the given path (recursively) for what you entered
  * the last example finds SUID files, which can sometimes be used for privilege escalation

# [locate](https://linux.die.net/man/1/locate):
#### `locate ssh`
  * run `updatedb` to make sure locate is working with the most current data

# [netstat](https://linux.die.net/man/8/netstat):
#### `netstat antp`
#### `netstat nao`
  * -a shows all (including established TCP connections)
  * -n shows numbers instead of trying to resolve them
  * -t shows TCP
  * -u shows UDP
  * -p shows the PID to which the socket belongs

# [procdump](https://docs.microsoft.com/en-us/sysinternals/downloads/procdump):
#### `procdump.exe -ma <executable>`
#### `procdump.exe -ma YYY` <-- YYY being a PID
  * -ma makes a dump file with all process memory (instead of the default thread and handle information)

# [ps](https://man7.org/linux/man-pages/man1/ps.1.html):
#### `ps aux`
  * a shows more than just the current user's active processes
  * u shows the user whose permissions are applied to the process 
  * x shows processes without a tty

# [tcpdump](https://linux.die.net/man/8/tcpdump):
#### `tcpdump -n -r <pcap_file>`
#### `tcpdump -n src host X.X.X.X -r <pcap_file>`
  * -n prevents DNS lookups of ip addresses
  * -r selects an input file
  * -c chooses a number of packets after which tcpdump stops reading
  * -I puts an interface in monitor mode
  * -w defines the output file

# [which](https://linux.die.net/man/1/which):
#### `which python3` 
#### `which ssh`
  * searches the path for the executable that corresponds to what you entered

# [Windows Credential Editor](https://web.archive.org/web/20191115055522/https://www.aldeid.com/wiki/Windows-credentials-editor):
#### `cwe.exe`
#### `cwe.exe -r`
  * -o logs output to a file
  * -r checks every 5 seconds until command is terminated
