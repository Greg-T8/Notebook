# Chapter 3 - Scheduling Automation Scripts

- [3.1 Scheduled Scripts](#31-scheduled-scripts)
  - [3.1.1 - Using Windows Task Scheduler](#311---using-windows-task-scheduler)
    - [Security Options](#security-options)
  - [3.1.2 - Create Scheduled Task with PowerShell](#312---create-scheduled-task-with-powershell)
  - [3.1.3 - Exporting and Importing Scheduled Tasks](#313---exporting-and-importing-scheduled-tasks)
- [3.2 - Watcher Scripts](#32---watcher-scripts)
  - [3.2.1 - Designing Watcher Scripts](#321---designing-watcher-scripts)

There are two different types of scripts you run on a scheduled basis:
1. Scheduled Script - runs regularly
2. Watcher Script - runs continuously

## 3.1 Scheduled Scripts
Scheduled scripts run on a regular basis but not continuously. Examples include
- Inventory collection
- Checks on user accounts
- Checks on system resources
- Data backups

When running scheduled scripts, know your dependencies and take care of them beforehand. Make sure dependent modules are installed on the system beforehand. Do not have your scheduled scripts install modules!  Doing so could lead to unintended consequences. For example, a script may fail to install a module and never complete successfully or two scripts that try to install a module may continuously override each other, causing failures between each other. 

### 3.1.1 - Using Windows Task Scheduler
When using Windows Task Scheduler, copy the module folder where the script can access it.  The default paths for PowerShell modules are:

- **PowerShell v5.1**:  `C:\Program Files\WindowsPowerShell\Modules`
- **PowerShell v7.0**:  `C:\Program Files\PowerShell\7\Modules`

#### Security Options
Selecting the option **Do not store password** forces the task to run under the system context. This allows the task to access local resources but not network resources. Unselect this option and use a service account when needing to access resources over the network.  

![](img/2022-09-17-04-25-21.png)

When creating an Action, set the program to the path of the PowerShell executable. Then specify the remaining arguments in the **Add arguments** box. For example, use `-File "C:\Scripts\Invoke-LogFileCleanup.ps1" -LogPath "L:\Logs\" -ZipPath "L:\Archives\" -ZipPrefix "LogArchive-" -NumberOfDays 30`:

![](img/2022-09-17-04-28-24.png)

For PowerShell 5.1, include the `-WindowStyle` argument and have it set to Hidden so that your script will run silently. See [about_PowerShell_exe](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_powershell_exe?view=powershell-5.1) for command options.

### 3.1.2 - Create Scheduled Task with PowerShell
Creating a scheduled task is done in three steps:
1. Define a trigger using `New-ScheduledTaskTrigger`
2. Define the action using `New-ScheduledTaskAction`
3. Create scheduled task using `Register-ScheduledTask`

Here's an example script that creates a scheduled task.  Things to note:
- The `$Argument` variable uses a string that begins with single quotes to preserve the usage of double quotes for the command argument
- The scheduled task creates a folder structure instead of placing the task at the root
- When using a service account you must also specify the `-Password` argument

```powershell
$Trigger = New-ScheduledTaskTrigger -Daily -At 8am
$Execute = "C:\Program Files\PowerShell\7\pwsh.exe"
$Argument = '-File ' +
    '"C:\Scripts\Invoke-LogFileCleanup.ps1"' +
    ' -LogPath "L:\Logs\" -ZipPath "L:\Archives\"' +
    ' -ZipPrefix "LogArchive-" -NumberOfDays 30'
$ScheduledTaskAction = @{
    Execute = $Execute
    Argument = $Argument
}
$Action = New-ScheduledTaskAction @ScheduledTaskAction
$ScheduledTask = @{
    TaskName = "PoSHAutomation\LogFileCleanup"
    Trigger  = $Trigger
    Action   = $Action
    User     = 'NT AUTHORITY\SYSTEM'
}
Register-ScheduledTask @ScheduledTask
```

### 3.1.3 - Exporting and Importing Scheduled Tasks
Use `Export-ScheduledTask` to export any task to XML. Then use `Register-ScheduledTask` to recreate the task from the XML file.

```powershell
PS P:\> $ScheduledTask = @{
     >>    TaskName = "LogFileCleanup"
     >>    TaskPath = "\PoSHAutomation\"
     >>}
PS P:\> $export = Export-ScheduledTask @ScheduledTask
PS P:\> $export | Out-File "\\srv01\PoSHAutomation\LogFileCleanup.xml"
```

Here's how to import:  
```powershell
$FilePath = ".\CH03\Monitor\Export\LogFileCleanup.xml"
$xml = Get-Content $FilePath -Raw
[xml]$xmlObject = $xml
$TaskName = $xmlObject.Task.RegistrationInfo.URI
Register-ScheduledTask -Xml $xml -TaskName $TaskName
```

Here's an example for importing from multiple files:  
```powershell
$Share = "\\srv01\PoSHAutomation\"
$TaskFiles = Get-ChildItem -Path $Share -Filter "*.xml"
foreach($task in $TaskFiles){
    $xml = Get-Content $FilePath -Raw
    [xml]$xmlObject = $xml
    $TaskName = $xmlObject.Task.RegistrationInfo.URI
    Register-ScheduledTask -Xml $xml -TaskName $TaskName
}
```

## 3.2 - Watcher Scripts
A watcher script is a scheduled script that runs continuously or at least every few minutes. Any script that needs to run every 15 minutes or less should be considered a watcher. Examples include
- File watcher that monitors a folder for updated files
- Monitor for a SharePoint list
- Checking a shared mailbox for new emails
- Alerting on stopped services or an unresponsive web app

With watcher scripts the most important thing to be aware of is execution time. You don't want a script that executes once a minute and takes 2 minutes to complete.

Use action scripts to reduce a watcher script's runtime. A watcher script monitors for a specific condition. Once that condition is met, the watcher script invokes the action script. You can also invoke multiple action scripts in parallel from a single watcher.

### 3.2.1 - Designing Watcher Scripts
The author demonstrates with the following scenario: You need to monitor a folder for new files. Once a file is added, it needs to be moved to another folder. The monitor should be as real-time as possible, i.e. once a minute. The goal is to have the watch script run as efficiently as possible and have the ability to pick up from where the last watcher left off. 

Here's an illustration of the process. Things to note:
- Watcher script invokes action script
- Action script moves files to another folder

![](img/2022-09-17-05-05-24.png)
