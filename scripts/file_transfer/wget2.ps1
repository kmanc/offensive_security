param (
    [Parameter(Mandatory=$true)][string]$url
)
$curDir = $pwd
$outfile = $url.Split("/")[-1]
$output = -join($curDir, "\", $outfile)
Invoke-WebRequest $url -OutFile $output
