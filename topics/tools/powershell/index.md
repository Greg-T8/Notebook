# My PowerShell Notes
- [My Custom PowerShell Prompt](prompt.md)

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
