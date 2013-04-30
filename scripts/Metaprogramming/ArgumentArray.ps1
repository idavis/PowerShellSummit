#
# Argument Array
#
$here = Split-Path -parent $PSCommandPath
. $here\ExtendingTypeData.ps1

function reverse {
  $args | % { $_.Reverse }
}

(reverse "ti", "si", "dediced") -join " "