# Pick a key between 0 and 255
$key = 13
# Shellcode goes here
$buf = [Byte[]] (0x41, 0x41, 0x41)
# Ready result with an empty list
$ciphertext = New-Object System.Collections.Generic.List[System.Object]
# Iterate over each byte
foreach ($byte in $buf) {
    $ciphertext.Add(($byte + $key) % 255)
}
# Write the answer
Write-Host $ciphertext