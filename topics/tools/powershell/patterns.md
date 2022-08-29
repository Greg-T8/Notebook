# PowerShell Patterns

## Check if a string or object is null or empty
Use the following block of code to check if a string is null or empty.  You can also pass in a variable to an object.  

```powershell
if ([string]::IsNullOrEmpty('String')) { ... }
if ([string]::IsNullOrEmpty($variable)) { ... }
```

## Use a generic list for custom PowerShell objects
```powershell
[System.Collections.Generic.List[PSObject]] $myCollection = @()
foreach ($o in $objects) {
  $myCollection.add([PSCustomObject]@{
    Name = o.Name
    Key1 = $null
    Key2 = $null
  })
}
...
# To set value
$myCollection[-1].Key1 = $o.Value1
```
You can shorten the syntax with the `using namespace` statement:
```powershell
using namespace System.Collections.Generic
$myList = [List[int]]@(1,2,3)
```

References
- [Generic List](https://docs.microsoft.com/en-us/powershell/scripting/learn/deep-dives/everything-about-arrays?view=powershell-7.2#generic-list)
- [PSCustomObject](https://docs.microsoft.com/en-us/powershell/scripting/learn/deep-dives/everything-about-pscustomobject?view=powershell-7.2)
- [Array Do's and Don'ts](https://gist.github.com/kevinblumenfeld/4a698dbc90272a336ed9367b11d91f1c)

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

## Execute a string as PowerShell code
This is useful technique for managing data in a string with replaceable data and operator.
```powershell
$Data = 3
$Operator = 'in'
$Expected = '1..15'
$cmd = 'if($Data -{0} {1}){{$true}}' -f $Operator, $Expected
Invoke-Expression $cmd
```

## Using Scriptblocks with Parameters 
This is a useful technique for running a common series of commands. In this case, the text you need to modify resides in the middle of the command, and you don't want to navigate to the middle each time you need to update the text.  So you use a script block and pass the text at the end as a parameter.
```powershell
& {param($comment) git add .; git commit -m $comment; git push} "Updated notes on PowerShell"
```
See [about_Script_Blocks](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_script_blocks?view=powershell-7.2).


## Using Custom Logging Functions
This is a snippet of code from Chapter 6 of Practical Automation with PowerShell that I found was interesting for custom logging functions.
```powershell
# A small function to ensure consistent logs are written for an activity starting
    Function Write-StartLog {
        param(
            $Message
        )
        "`n$('#' * 50)`n# $($Message)`n" | Out-File $LogFile -Append
        Write-Host $Message
    }

    # A small function to ensure consistent logs are written for an activity completing
    Function Write-OutputLog {
        param(
            $Object
        )
        $output = $Object | Format-Table | Out-String
        if ([string]::IsNullOrEmpty($output)) {
            $output = 'No data'
        }
        "$($output.Trim())`n$('#' * 50)" | Out-File $LogFile -Append
        Write-Host $output
    }
    $msg = "Start Server Setup - $(Get-Date)`nFrom JSON $($ConfigJson)"
    Write-StartLog -Message $msg

    # Set Windows Features first
    Write-StartLog -Message "Set Features"
    $Features = Install-RequiredFeatures -Features $Config.Features
    Write-OutputLog -Object $Features
```


