#
# Extension Methods/Properties, usually done in a ps1xml document
#
Update-TypeData -TypeName System.String -MemberName Reverse -MemberType ScriptProperty -Force -Value {
  $chars = $this -split ""
  [Array]::Reverse($chars)
  $result = $chars -join ""
  return $result
}

"hello".Reverse

Update-TypeData -TypeName System.Int32 -MemberName Times -MemberType ScriptMethod -Force -Value {
  param([ScriptBlock] $block)
  1..$this | % { & $block}
}

$value = 3
$value.Times({ Write-Host $psitem })



function Get-ConvertedValue {
  param($object)
  if($object -eq $null) {return $null}
  $thisType = $object.GetType()
  $value = $object
  $isConvertable = [IConvertible].IsAssignableFrom([Type]$thisType)
  if($isConvertable) {
    $value = $object.ToDouble($null)
  } 
  $value
}

Update-TypeData -TypeName System.Object -MemberName Hours -MemberType ScriptProperty -Force  -Value {
  $value = Get-ConvertedValue $this
  [TimeSpan]::FromHours($value)
}

Update-TypeData -TypeName System.Object -MemberName Days -MemberType ScriptProperty -Force -Value {
  $value = Get-ConvertedValue $this
  [TimeSpan]::FromDays($value)
}

Update-TypeData -TypeName System.TimeSpan -MemberName Ago -MemberType ScriptProperty -Force -Value {
  [DateTime]::Now.Add(-$this)
}

$value.Hours.Ago
$value.Days.Ago