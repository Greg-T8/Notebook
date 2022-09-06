# Chapter 7 - Working with SQL

This chapter covers
- Building SQL databases and tables
- Inserting and updating data
- Retrieving data
- Using data validation before writing to SQL

In the previous chapter, the author used JSON files as a data source for driving automation. This is fine when the data is static, and you have tight control over who can update it.  However, when multiple people are working with data, you should be using a database.

When starting this chapter, the author advises to run a local instance of Microsoft SQL Server. The script [SQLExpressInstall.ps1](Helper%20Scripts/SQLExpressInstall.ps1) will download tools and set up a local instance of SQL Server for you. The script also installs a number of tools, including PowerShell, Git, VS Code, and the dbatools PowerShell module.

After setup, run the following code to create the `PoshAssetMgmt` database:
```powershell
$SqlInstance = "$($env:COMPUTERNAME)\SQLEXPRESS"
$DatabaseName = 'PoshAssetMgmt'
$DbaDatabase = @{
    SqlInstance   = $SqlInstance
    Name          = $DatabaseName
    RecoveryModel = 'Simple'
}
New-DbaDatabase @DbaDatabase
```
Here's an example of the output:
![](img/2022-09-06-04-42-52.png)

## 7.1 - Setting Your Schema
The schema for this chapter is based on asset management for virtual machines. Some of the columns considered are
- Identity - automatically populated by the database
- Name - the name of the asset
- OS Type - Linux or Windows
- OS Version
- Status - in service, being repaired, retired
- Remote Method - SSH, WSMan, Power CLI
- UUID - The unique identifier from the source systems
- Source - Hyper-V, VMware, Azure, AWS
- Source Instance - vSphere cluster, Azure subscription

### 7.1.1 - Data Types
When building your table schema, you need to consider data types. The string data type is an important consideration because SQL has a number of them.  The most common one used is the `nvarchar` type. When you declare a `nvarchar`, you need to set a maximum character length.  

Here is the map of the data types that will be used:  

| Name | Type | MaxLength | Nullable | Identity |
| - | - | - | - | - | 
ID | int | N/A | No | Yes |
Name | nvarchar | 50 | No | No |
OSType | nvarchar | 15 | No | No |
OSVersion | nvarchar | 50 | No | No |
Status | nvarchar | 15 | No | No |
RemoteMethod | nvarchar | 25 | No | No |
UUID | nvarchar | 255 | No | No |
Source | nvarchar | 15 | No | No |
SourceInstance | nvarchar | 255 | No | No |

The following script crates the `Servers` table using the column mapping defined above:  
```powershell
$SqlInstance = "$($env:COMPUTERNAME)\SQLEXPRESS"
$DatabaseName = 'PoshAssetMgmt'
$ServersTable = 'Servers'
$ServersColumns = @(
    @{Name = 'ID';
        Type = 'int'; MaxLength = $null;
        Nullable = $false; Identity = $true;
    }
    @{Name = 'Name';
        Type = 'nvarchar'; MaxLength = 50;
        Nullable = $false; Identity = $false;
    }
    @{Name = 'OSType';
        Type = 'nvarchar'; MaxLength = 15;
        Nullable = $false; Identity = $false;
    }
    @{Name = 'OSVersion';
        Type = 'nvarchar'; MaxLength = 50;
        Nullable = $false; Identity = $false;
    }
    @{Name = 'Status';
        Type = 'nvarchar'; MaxLength = 15;
        Nullable = $false; Identity = $false;
    }
    @{Name = 'RemoteMethod';
        Type = 'nvarchar'; MaxLength = 25;
        Nullable = $false; Identity = $false;
    }
    @{Name = 'UUID';
        Type = 'nvarchar'; MaxLength = 255;
        Nullable = $false; Identity = $false;
    }
    @{Name = 'Source';
        Type = 'nvarchar'; MaxLength = 15;
        Nullable = $false; Identity = $false;
    }
    @{Name = 'SourceInstance';
        Type = 'nvarchar'; MaxLength = 255;
        Nullable = $false; Identity = $false;
    }
)
$DbaDbTable = @{
    SqlInstance = $SqlInstance
    Database    = $DatabaseName
    Name        = $ServersTable
    ColumnMap   = $ServersColumns
}
New-DbaDbTable @DbaDbTable
```
The script doesn't give you any useful output on the table columns, but you can use SQL Server Management Studio to confirm column creation:  
![](img/2022-09-06-05-09-48.png)
