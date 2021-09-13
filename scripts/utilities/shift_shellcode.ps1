# Pick a key between 0 and 255
$key = 13
# Shellcode goes here
$buf = [Byte[]] (0x41, 0x41, 0x41)
# Ready result with an empty list
$ciphertext = New-Object System.Collections.Generic.List[System.Object]
# Iterate over each byte
foreach ($byte in $buf) {
    # Shift the byte
    $xored = ($byte + $key) % 255
    # Format the byte as a left-padded hex string with a leading "0x" and a trailing ","
    $formatted = "0x" + [System.Convert]::ToString($xored, 16).PadLeft(2, "0") + ","
    # Add it to the output
    $ciphertext.Add($formatted)
}
# Remove the comma from the last byte
$ciphertext[-1] = $ciphertext[-1].Substring(0, 4)
# Write the answer
Write-Host $ciphertext
