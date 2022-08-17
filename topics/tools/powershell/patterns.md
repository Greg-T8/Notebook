# PowerShell Patterns

## Check if a string is null or empty
Use the following block of code to check if a string is null or empty.

```powershell
if ([string]::IsNullOrEmpty('String')) { ... }
```

## Use a collection of custom PowerShell objects
```powershell
[System.Collections.Generic.List[PSObject]] $myCollection = @()
foreach ($o in $objects) {
  $myCollection.add([PSCustomObject]@{
    Name = o.Name
    Key1 = $null
    Key2 = $null
  }])
}

You can shorten the syntax with the `using namespace` statement:
```powershell
using namespace System.Collections.Generic
$myList = [List[int]]@(1,2,3)
```

See [Generic List](https://docs.microsoft.com/en-us/powershell/scripting/learn/deep-dives/everything-about-arrays?view=powershell-7.2#generic-list) for more info. 
...
# To set value
$myCollection[-1].Key1 = $o.Value1
```

## Use a timer to monitor something
```powershell
$timer = [system.diagnostics.stopwatch]::StartNew()
do {
  # code to monitor
} while { $timer.Elapsed.TotalSeconds -lt $SecondsToWait }
```

## Use a calculated property
The following cmdlets support calculated properties:
- Select-Object, Group-Object, Sort-Object, Compare-Object, Measure-Object
- Format-List, Format-Table, Format-Custom
See [about_Calculated_Properties](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_calculated_properties?view=powershell-7.2).
```powershell
$updated = $checks |
    Select-Object -Property *, @{l='Type';e={'DWORD'}},
        @{l='Data';e={$_.Tests[0].Value}}
```

## Use a date string
See [Get-Date](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/get-date?view=powershell-7.2).
```powershell
$DateString = (Get-Date).ToString('yyMMdd')
```
