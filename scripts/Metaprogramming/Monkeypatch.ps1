function define-method {
  param([string]$name, [ScriptBlock]$body)
  Set-Item -Path function:/"$name" $body -Force
}

$module = New-Module -Name "temp" {
  $hidden = 5
  function My-ExportedFunction {
    Write-Host "My secret value is: $hidden."
  }
  function instance-eval([ScriptBlock] $block) {
    . $MyInvocation.MyCommand.Module $block
  }
  Export-ModuleMember My-ExportedFunction
  Export-ModuleMember instance-eval
}

Import-Module $module 3> $null # Tell PowerShell to Shut Up
try {
  My-ExportedFunction
  Write-Host "Do we have the hidden value: " ($hidden -ne $null)
  instance-eval { 
    define-method "My-ExportedFunction" { Write-Host "$hidden Surprise!" }
  }
  My-ExportedFunction
} finally { Remove-Module $module.Name -ErrorAction SilentlyContinue }