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
