#!/bin/bash
# Pick a key between 0 and 255
key=0x6A
# Shellcode goes here
buf=(0x41, 0x41, 0x41)
# Ready variable to store result
declare -a ciphertext
# Iterate over each byte
for byte in ${buf[@]}
do
    # Remove comma from hex representation
    byte=$(echo "$byte" | sed "s/\,//")
    # XOR the byte by the key and save in a temp variable
    new_value="$((($byte + $key) % 256))"
    # Format the string and add it to the ciphertext
    ciphertext+="0x$(printf %02X $new_value), "
done
# Remove the comma from the last byte and print
echo $ciphertext | sed "s/.$//"
