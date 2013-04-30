$value = [PSObject]::AsPSObject("The Dude Abides")

Write-Host ("Size is " + $value."size")

$value | Add-Member -Name "size" -MemberType ScriptProperty -Value { $this.Length }
Write-Host "trying again"
Write-Host ("Size is " + $value."size")