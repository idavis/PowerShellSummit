#
# Definition Macro
#

function define-method {
  param([string]$name, [string]$body, [string]$scopeLevel = "script")
  $text = "function $($scopeLevel):$name() { $body }"
  Invoke-Expression -Command $text
}

define-method "HelloWorld" 'Write-Host "Hello, World!"'
HelloWorld

function define-method {
  param([string]$name, [ScriptBlock]$body, [string]$scopeLevel = "script")
  Set-Item -Path function:/"$($scopeLevel):$name" $body -Force
}

define-method "HelloWorld" {param($x) Write-Host "Hello, World $x!"}
HelloWorld 3