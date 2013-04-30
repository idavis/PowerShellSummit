$moduleName = "temp"
$module = New-Module -Name $moduleName {
  $hidden = 5
  function Display-Internals {
    Write-Host $hidden
  }
  function instance-eval([ScriptBlock] $block) {
    #. $module $block #bad
    . $MyInvocation.MyCommand.Module $block
  }
  Export-ModuleMember Display-Internals
  Export-ModuleMember instance-eval
}

Import-Module $module 3> $null  #Tell PowerShell to Shut Up
try {
  Display-Internals
  Write-Host "try to access private: $hidden"
  instance-eval { Write-Host "try to access private: $hidden" }
} finally { Remove-Module $moduleName }