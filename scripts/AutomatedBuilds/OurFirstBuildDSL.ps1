function build {
  param($block)
  $tasks = @{}
  
  function default {
    param([string[]]$dependson)
    $name = "default"
    $tasks[$name] = @{name=$name;block={};dependson=$dependson}
  }
  
  function task {
    param($name,[scriptblock]$block, [string[]]$dependson = @())
    $tasks[$name] = @{name=$name;block=$block;dependson=$dependson}
  }
  
  function execute-task {
    process {
      if($_) {
        Write-Host "Starting $($_.name)"
        $dependson = $_.dependson
        $dependson | % {$tasks[$_]} | execute-task
        & $_.block
        Write-Host "Finished $($_.name)"
      }
    }
  }
  & $block
  $tasks["default"] | execute-task
}
