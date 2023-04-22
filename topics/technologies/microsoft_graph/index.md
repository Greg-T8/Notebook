# Microsoft Graph

## Using App-Only Authentication with Microsoft Graph PowerShell
App-only access is used for unattended scripts.  The following instructions provide basic guidance for setting up an app registration for use with Microsoft Graph PowerShell.

References: 
- [Use app-only authentication with the Microsoft Graph PowerShell SDK](https://docs.microsoft.com/en-us/powershell/microsoftgraph/app-only?view=graph-powershell-1.0&tabs=azure-portal&preserve-view=true)
- [Create a self-signed public certificate to authenticate your application](https://docs.microsoft.com/en-us/azure/active-directory/develop/howto-create-self-signed-certificate)

### Step 1: Create a self-signed certificate
You need an X.509 certificate installed in your machine's trusted store when you run the script. The application that initiates the session requires the private key while the application that confirms the authentication requires the public key. The means the public key (.cer file) goes in the app registration and the private key (.pfx file) is used by the client app, e.g. Azure Automation or your interactive PowerShell session. 

Things to note:
- 2048-bit key length is recommended
- RSA key algorithm is recommended
- The certificate is valid for only one year 
- The cert is supported for both client and server authentication

The following code creates and exports a certificate with only the private key. Supply the .cer file to the application that is configured with resource permissions, e.g. Microsoft Graph.

```powershell
$certName = 'MyMSGraphApp'
$params = @{
    Subject           = "CN=$certName"
    CertStoreLocation = 'Cert:\CurrentUser\My'
    KeyExportPolicy   = 'Exportable'
    KeySpec           = 'Signature'
    KeyLength         = 2048
    KeyAlgorithm      = 'RSA'
    HashAlgorithm     = 'SHA256'
}
$cert = New-SelfSignedCertificate @params 
Export-Certificate -Cert $cert -FilePath ".\$certName.cer"
```

If you want another client system to use the certificate, then you must export the certificate with its private key as a .pfx file.
1. Use the process above to generate a self-signed certificate
2. Create a password
3. Export the certificate with the private key

```powershell
# Create a password and store it as a secure string
$params = @{
    String = "my password"
    AsPlainText = $true
    Force = $true
}
$myPwd = ConvertTo-SecureString @params

# Export the certificate with private key as a .pfx file
$params = @{
    Cert = $cert  # Uses the $cert variable from the previous process
    FilePath = '.\MyAppName.pfx'
    Password = $myPwd
}
Export-PfxCertificate @params
```

### Step 2: Create Application and Grant Admin Consent
```powershell
# Connect to Microsoft Graph using delegated access
$params = @{
    TenantId = 'c20737c4-bc9c-49aa-a451-90862566d79c'
    Scopes = @(
        'User.Read'
        'Application.ReadWrite.All'
    )
}
Connect-MgGraph @params

# Create application and service principal
$appName = 'MyMSGraphApp'
$certName = 'MyMSGraphApp'

$clientApp = New-MgApplication -DisplayName $appName 
$clientSp = New-MgServicePrincipal -AppId $clientApp.AppId

# Attach public certificate to application
$cert = Get-ChildItem -Path Cert:\CurrentUser\My\ | 
    Where-Object -Property Subject -match $certName
$params = @{
    Type = 'AsymmetricX509Cert'
    Usage = 'Verify'
    Key = $cert.RawData
}
Update-MgApplication -ApplicationId $clientApp.Id @params


```
