# [proxychains](https://web.archive.org/web/20191115232017/https://www.linuxbabe.com/desktop-linux/how-to-use-proxychains-to-redirect-your-traffic-through-proxy-server):
#### `proxychains <command you would have run>`
  * configuration is done in `/etc/proxychains.conf`
  * Add a line at the end of the form `socks5 X.X.X.X YYY`
    * For chaining with an SSH tunnel make the IP 127.0.0.1 and the port whatever port you used in the tunnel
  
# [rinetd](https://web.archive.org/web/20191202033419/http://man.docs.sk/8/rinetd.html):
  * port forwarding tool whose configuration is done in `/etc/rinetd.conf`


# [ssh](https://linux.die.net/man/1/ssh):
#### `ssh -fN -D YYY user@X.X.X.X`
#### `ssh -L BBB:A.A.A.A:YYY user@X.X.X.X`
#### `ssh -R YYY:A.A.A.A:BBB user@X.X.X.X`
  * Note, *by far* the easiest way to do ssh tunneling is going to be with `-D`
  * -D defines the local port (YYY) to use for communication to the remote (X.X.X.X) server's port (ZZZ)
  * -N tells SSH not to execute a remote command making it good for forwarding things
  * -f requires -N and tells SSH to run in the background once all authorization stuff has happened so it's perfect for setting up tunnels
    * Just don't forget to eventually find the PID and kill the process or something
  * -L defines the local (A.A.A.A) port (BBB) to send its traffic to the remote (X.X.X.X) port (YYY)
    * After running this, `wget http://localhost:BBB/hello` FROM A.A.A.A results in a request to `http://X.X.X.X:YYY/hello`
  * -R defines the remote (X.X.X.X) port (YYY) to send its traffic to the local (A.A.A.A) port (BBB)
    * After running this, `wget http://localhost:YYY/hello` FROM X.X.X.X results in a request to `http://A.A.A.A:BBB/hello`

