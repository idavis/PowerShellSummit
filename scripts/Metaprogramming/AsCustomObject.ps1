# From Windows PowerShell in Action, section 11.4.3
function New-Point {
  New-Module -ArgumentList $args -AsCustomObject {
    param ([int]$x, [int]$y)
    function ToString() {
      "($x, $y)"
    }
    Export-ModuleMember -Function ToString -Variable x,y
  }
}

$point = New-Point 2 3
$point.ToString()
$point.GetType() # What do you think this is?