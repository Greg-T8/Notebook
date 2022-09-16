# Chapter 2 - Get Started Automating
- [2.1 - Cleaning Up Old Files](#21---cleaning-up-old-files)
  - [2.1.1 - Function: Set-ArchiveFilePath](#211---function-set-archivefilepath)
  - [2.1.2 - Script to Generate Random Log files](#212---script-to-generate-random-log-files)
  - [2.1.3 - Function: Remove-ArchivedFiles](#213---function-remove-archivedfiles)
  - [2.1.4 - Combining Functions](#214---combining-functions)

Goal of this chapter is to take a simple script and turn it into a reusable building block.  The script cleans up old log files.  

## 2.1 - Cleaning Up Old Files
Requirements for the script are to remove old log files to keep the drive from filling up. Logs must be retained for at least seven years but can go into cold storage after 30 days.

### 2.1.1 - Function: Set-ArchiveFilePath
This function creates the name of a zip file based on a supplied date and prefix. 
```powershell
# Listing 1 - Set-ArchiveFilePath Function
# Declare the function and set required parameters
Function Set-ArchiveFilePath{
    # Declare CmdletBinding and OutputType
    [CmdletBinding()]
    [OutputType([string])]
    # Define the parameters
    param(
    [Parameter(Mandatory = $true)]
    [string]$ZipPath,

    [Parameter(Mandatory = $true)]
    [string]$ZipPrefix,

    [Parameter(Mandatory = $true)]
    [datetime]$Date
    )

    # Check if the folder path exists and create it if it doesn't
    if(-not (Test-Path -Path $ZipPath)){
        New-Item -Path $ZipPath -ItemType Directory | Out-Null
        # Include verbose output for testing and troubleshooting
        Write-Verbose "Created folder '$ZipPath'"
    }

    # Create the timestamp based on the date
    $timeString = $Date.ToString('yyyyMMdd')
    # Create the file name
    $ZipName = "$($ZipPrefix)$($timeString).zip"
    # Set the full path of the zip file
    $ZipFile = Join-Path $ZipPath $ZipName

    # confirm the file doesn't already exist. Throw a terminating error if it does
    if(Test-Path -Path $ZipFile){
        throw "The file '$ZipFile' already exists"
    }

    # Return the file path to the script
    $ZipFile
}
```

### 2.1.2 - Script to Generate Random Log files
The author provides the following script that generates a set of log files with random size. Note the use of the `[DateTime]` parameter:  PowerShell is smart enough to parse a string and convert it into a DateTime object for you. Use `(Get-Date).GetDateTimeFormats()` to determine the string types that PowerShell accepts.

```powershell
# Set directory to create logs in
$Directory = "L:\Logs"
# Set number of days, in the past, to create log files for
$days = 90

# create the folder if not found
if(-not (Test-Path $Directory)){
    New-Item -Path $Directory -ItemType Directory
}

# this function creates randomly sized files
Function Set-RandomFileSize {
   param( [string]$FilePath )
    $size = Get-Random -Minimum 1 -Maximum 50
    $size = $size*1024*1024
    $file = [System.IO.File]::Open($FilePath, 4)
    $file.SetLength($Size)
    $file.Close()
    Get-Item $file.Name
}

# loop to create a file for each day back
for($i = 0; $i -lt $days; $i++) {
    # Get Date and create log file
    $Date = (Get-Date).AddDays(-$i)
    # create unique file name with the date in it
    $FileName = "u_ex$($date.ToString('yyyyMMdd')).log"
    # set the file path
    $FilePath = Join-Path -Path $Directory -ChildPath $FileName
    # write the date inside the file, will override existing files
    $Date | Out-File $FilePath
    # set a random file size
    Set-RandomFileSize -FilePath $FilePath 

    # Set the Creation, Write, and Access time of log file to past date
    Get-Item $FilePath | ForEach-Object { 
        $_.CreationTime = $date
        $_.LastWriteTime = $date
        $_.LastAccessTime = $date 
    }
}
```

### 2.1.3 - Function: Remove-ArchivedFiles
This function removes a file from the local disk if that file has already been archived, i.e. added to a zip file.

Things to note:
- The use of `Add-Type` to load a Microsoft .NET class to the PowerShell session

```powershell
# Listing 2 - Deleting Archived Files
Function Remove-ArchivedFiles {
    [CmdletBinding()]
    [OutputType()]
    param(
    [Parameter(Mandatory = $true)]
    [string]$ZipFile,

    [Parameter(Mandatory = $true)]
    [object]$FilesToDelete,

    [Parameter(Mandatory = $false)]
    [switch]$WhatIf = $false
    )
    # Load the System.IO.Compression.FileSystem assembly so you can use dot sourcing later
    $AssemblyName = 'System.IO.Compression.FileSystem'
    Add-Type -AssemblyName $AssemblyName | Out-Null

    $OpenZip = [System.IO.Compression.ZipFile]::OpenRead($ZipFile)
    # Get the information on the files inside the zip
    $ZipFileEntries = $OpenZip.Entries

    # Confirm each file to delete has a match in the zip file
    foreach($file in $FilesToDelete){
        $check = $ZipFileEntries | Where-Object{ $_.Name -eq $file.Name -and
            $_.Length -eq $file.Length }
        # If $check does not equal null, then you know the file was found and can be deleted
        if($null -ne $check){
            # Add WhatIf to allow for testing without actually deleting the files
            $file | Remove-Item -Force -WhatIf:$WhatIf
        }
        else {
            Write-Error "'$($file.Name)' was not find in '$($ZipFile)'"
        }
    }
}
```
### 2.1.4 - Combining Functions
The following script combines the functions `Set-ArchiveFilePath` and `Remove-ArchivedFiles` into one script. The end result is a script that archives files that haven't been modified beyond a certain date.  The script places the files in a zip file and then deletes the original files from local disk.

```powershell
# Listing 3 - Putting it All Together
[CmdletBinding()]
[OutputType()]
param(
    [Parameter(Mandatory = $true)]
    [string]$LogPath,

    [Parameter(Mandatory = $true)]
    [string]$ZipPath,

    [Parameter(Mandatory = $true)]
    [string]$ZipPrefix,

    [Parameter(Mandatory = $false)]
    [double]$NumberOfDays = 30
)

# Declare your functions before the script code
Function Set-ArchiveFilePath{
    [CmdletBinding()]
    [OutputType([string])]
    param(
    [Parameter(Mandatory = $true)]
    [string]$ZipPath,

    [Parameter(Mandatory = $true)]
    [string]$ZipPrefix,

    [Parameter(Mandatory = $false)]
    [datetime]$Date = (Get-Date)
    )

    if(-not (Test-Path -Path $ZipPath)){
        New-Item -Path $ZipPath -ItemType Directory | Out-Null
        Write-Verbose "Created folder '$ZipPath'"
    }

    $ZipName = "$($ZipPrefix)$($Date.ToString('yyyyMMdd')).zip"
    $ZipFile = Join-Path $ZipPath $ZipName

    if(Test-Path -Path $ZipFile){
        throw "The file '$ZipFile' already exists"
    }

    $ZipFile
}

Function Remove-ArchivedFiles {
    [CmdletBinding()]
    [OutputType()]
    param(
    [Parameter(Mandatory = $true)]
    [string]$ZipFile,

    [Parameter(Mandatory = $true)]
    [object]$FilesToDelete,

    [Parameter(Mandatory = $false)]
    [switch]$WhatIf = $false
    )

    $AssemblyName = 'System.IO.Compression.FileSystem'
    Add-Type -AssemblyName $AssemblyName | Out-Null

    $OpenZip = [System.IO.Compression.ZipFile]::OpenRead($ZipFile)
    $ZipFileEntries = $OpenZip.Entries

    foreach($file in $FilesToDelete){
        $check = $ZipFileEntries | Where-Object{ $_.Name -eq $file.Name -and
            $_.Length -eq $file.Length }
        if($null -ne $check){
            $file | Remove-Item -Force -WhatIf:$WhatIf
        }
        else {
            Write-Error "'$($file.Name)' was not find in '$($ZipFile)'"
        }
    }
}

# Set the date filter based on the number of days in the past
$Date = (Get-Date).AddDays(-$NumberOfDays)
# Get the files to archive based on the date filter
$files = Get-ChildItem -Path $LogPath -File |
    Where-Object{ $_.LastWriteTime -lt $Date}

$ZipParameters = @{
    ZipPath = $ZipPath
    ZipPrefix = $ZipPrefix
    Date = $Date
}
# Get the archive file path
$ZipFile = Set-ArchiveFilePath @ZipParameters

# Add the files to the archive file
$files | Compress-Archive -DestinationPath $ZipFile

$RemoveFiles = @{
    ZipFile = $ZipFile
    FilesToDelete = $files
}
# confirm files are in the archive and delete
Remove-ArchivedFiles @RemoveFiles
```

