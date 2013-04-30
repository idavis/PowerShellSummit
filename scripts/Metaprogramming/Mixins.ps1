$here = Split-Path -parent $PSCommandPath
. $here\ParasiticInheritance.ps1

filter Mixin-Circular {
  param($radius = 3.0)
  $_ | Add-Property Radius $radius
}

filter Mixin-Cylindrical {
  param($radius = 3.0, $height = 4.0)
  $_ | Mixin-Circular $radius
  $_ | Add-Property Height $height
}

function New-Cylinder {
  $prototype = New-Prototype
  $prototype | Mixin-Cylindrical
  $prototype
}

$cylinder = New-Cylinder
Write-Host "the radius is $($cylinder.Radius)"
Write-Host "the height is $($cylinder.height)"