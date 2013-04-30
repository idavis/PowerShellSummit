#
# Parasitic Inheritance
#

function New-Prototype {
  param($baseObject = (new-object object))
  process {
    $prototype = [PSObject]::AsPSObject($baseObject)
    $prototype.PSObject.TypeNames.Insert(0,"Prototype")
    $prototype
  }
}

function Update-TypeName {
  process {
    $caller = (Get-PSCallStack)[1].Command
    $caller = $caller -replace "new-", [string]::Empty
    $caller = $caller -replace "mixin-", [string]::Empty
    $derivedTypeName = $_.PSObject.TypeNames[0]
    if($derivedTypeName) {
      $derivedTypeName = "$derivedTypeName#{0}" -f $caller
    }
    $_.PSObject.TypeNames.Insert(0,"$derivedTypeName")
  }
}

function Add-Property {
  param(
    [string]$name,
    [object]$value = $null,
    [System.Management.Automation.ScopedItemOptions]$options = [System.Management.Automation.ScopedItemOptions]::None,
    [Attribute[]]$attributes = $null
  )
  process {
    $variable = new-object System.Management.Automation.PSVariable $name, $value, $options, $attributes
    $property = new-object System.Management.Automation.PSVariableProperty $variable
    $_.psobject.properties.remove($name)
    $_.psobject.properties.add($property)
  }
}

function Add-Function {
  param(
    [string]$name,
    [scriptblock]$value
  )
  process {
    $method = new-object System.Management.Automation.PSScriptMethod "$name", $value
    $_.psobject.methods.remove($name)
    $_.psobject.methods.add($method)
  }
}

function New-SapiVoice {
  $prototype = New-Prototype
  $prototype | Update-TypeName
  $prototype | Add-Function Say {
    param([string]$message)
    $speaker = new-object -com SAPI.SpVoice
    ($speaker.Speak($message,2)) | out-null
  }
  $prototype | Add-Property Message "Hello, World!"
  $prototype
}

#$voice = New-SapiVoice
#$voice.Say($voice.Message) # Says "Hello, World1"
#$voice | Get-Member -View Extended # Show what we have added to the base object