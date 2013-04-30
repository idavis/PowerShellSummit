filter =~ {
  param([regex]$regex, [switch]$caseSensitive)
  process {
    $matches = $null # gets defined automatically when we do the matching
    $mached = $false
    if($caseSensitive) {
      $matched = $_ -cmatch $regex
    } else {
      $matched = $_ -match $regex
    }
    if(!$matched) { return $false }
    foreach( $key in $matches.keys) {
      $name = "$key"
      $value = 0
      $isInt = [int]::TryParse($name, [ref] $value)
      if(!$isInt -or $value -lt 1) { continue }
      $value = $matches[$key]
      Set-Variable -Name $name -Value $value -Scope 1
    }
    return $true
  }
}

# before:
if("4.3.2.1" -match "(\d)[.](\d)[.](\d)") {
  Write-Host "before:"
  Write-Host "Matched on: $($matches[0])"
  $major = $matches[1]
  $minor = $matches[2]
  $build = $matches[3]
  Write-Host "$major.$minor.$build"
}

# after:
if("4.3.2.1" | =~ "(\d)[.](\d)[.](\d)") {
  Write-Host "after:"
  Write-Host "Matched on: $0"
  $major = $1
  $minor = $2
  $build = $3
  Write-Host "$major.$minor.$build"
}