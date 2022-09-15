# Chapter 2 - Get Started Automating

Goal of this chapter is to take a simple script and turn it into a reusable building block.  The script cleans up old log files.  

## 2.1 - Cleaning Up Old Files
Requirements for the script are to remove old log files to keep the drive from filling up. Logs must be retained for at least seven years but can go into cold storage after 30 days.

### 2.1.1 - Your First Function
As a good practice, always include `[CmdletBinding()]` and `[OutputType()]` in your functions. 

Here's a look at the first function. This function creates the name of a zip file based on a supplied date and prefix. 
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

### 2.1.2 - Returning Data from Functions
Best practice is to use a single line when returning data to the output stream.  You can either use `return`, which exits the function, or `Write-Output`, which may be used multiple times in a function. `Write-Output` can have performance impacts and has been known to cause issues with different data types.  

### 2.1.3 - Testing Your Functions
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

### 2.1.4 - Problems to Avoid...