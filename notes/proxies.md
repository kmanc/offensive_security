# [proxychains](https://web.archive.org/web/20191115232017/https://www.linuxbabe.com/desktop-linux/how-to-use-proxychains-to-redirect-your-traffic-through-proxy-server):
#### `proxychains <command you would have run>`
  * configuration is done in `/etc/proxychains.conf`
  * Add a line at the end of the form `socks5 X.X.X.X YYY`
    * For chaining with an SSH tunnel make the IP 127.0.0.1 and the port whatever port you used in the tunnel
  
# [rinetd](https://web.archive.org/web/20191202033419/http://man.docs.sk/8/rinetd.html):
  * port forwarding tool whose configuration is done in `/etc/rinetd.conf`


# [ssh](https://linux.die.net/man/1/ssh):
#### `ssh X.X.X.X -p YYY -L ZZZ:A.A.A.A:BBB`
#### `ssh X.X.X.X -p YYY -R ZZZ:A.A.A.A:BBB`
#### `ssh -fN -D YYY user@X.X.X.X`
  * -p defines the local port (YYY) to use to connect to the remote (X.X.X.X) server
  * -L defines the local port (ZZZ) to proxy through the other local port (YYY) to hit the other remote (A.A.A.A) server's port (BBB)
  * -R defines the remote port (BBB) to proxy through the other remote port (YYY) to the local (X.X.X.X) server's local port (ZZZ)
  * -D defines the local port (YYY) to use for communication to the remote (X.X.X.X) server's port (ZZZ)
  * -N tells SSH not to execute a remote command making it good for forwarding things
  * -f requires -N and tells SSH to run in the background once all authorization stuff has happened so it's perfect for setting up tunnels
    * Just don't forget to eventually find the PID and kill the process or something
