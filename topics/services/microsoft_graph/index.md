# Microsoft Graph

## Using App-Only Authentication with Microsoft Graph PowerShell
App-only access is used for unattended scripts.  The following instructions provide basic guidance for setting up an app registration for use with Microsoft Graph PowerShell.

References: 
- [Use app-only authentication with the Microsoft Graph PowerShell SDK](https://docs.microsoft.com/en-us/powershell/microsoftgraph/app-only?view=graph-powershell-1.0&tabs=azure-portal&preserve-view=true)
- [Create a self-signed public certificate to authenticate your application](https://docs.microsoft.com/en-us/azure/active-directory/develop/howto-create-self-signed-certificate)

### Step 1: Create a self-signed certificate
You need an X.509 certificate installed in your machine's trusted store when you run the script. The application that initiates the session requires the private key while the application that confirms the authentication requires the public key. The means you only export the public key (.cer file) and upload it to Azure. Your PowerShell app uses the private key from the local certificate store. In the case of Azure Automation, you upload the private key (.pfx file). 

Things to note:
- 2048-bit key length is recommended
- RSA key algorithm is recommended
- The certificate is valid for only one year 

The following code creates and exports a certificate with only the private key. Supply the .cer file to the application that is configured with resource permissions, e.g. Microsoft Graph.

```powershell
$params = @{
    Subject           = 'CN=MyAppName'
    CertStoreLocation = 'Cert:\CurrentUser\My'
    KeyExportPolicy   = 'Exportable'
    KeySpec           = 'Signature'
    KeyLength         = 2048
    KeyAlgorithm      = 'RSA'
    HashAlgorithm     = 'SHA256'
}
$cert = New-SelfSignedCertificate @params 
Export-Certificate -Cert $cert -FilePath '.\MyAppName.cer'
```

The following code creates and exports a certificate with the private key. Use the resulting .pfx file for the client application, e.g. Azure Automation or your own machine for interactive PowerShell use.

```powershell
$params = @{
    String = "my password"
    AsPlainText = $true
    Force = $true
}
$myPwd = ConvertTo-SecureString @params

$params = @{
    
}