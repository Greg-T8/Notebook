# Azure Identity Protection

## Managing Azure Identity Protection with PowerShell
Reference:
- [Azure Active Directory Identity Protection and the Microsoft Graph PowerShell SDK](https://docs.microsoft.com/en-us/azure/active-directory/identity-protection/howto-identity-protection-graph-api)
- [New-SelfSignedCertificate](https://docs.microsoft.com/en-us/powershell/module/pki/new-selfsignedcertificate?view=windowsserver2022-ps)

Four steps to accessing Identity Protection data through Microsoft Graph:
1. [Create a certificate](#create-a-certificate)
2. Create a new app registration
3. Configure API permissions
4. Configure a valid credential

### Create a certificate  
This example uses a self-signed certificate. In a production environment, you would use a certificate from your Certificate Authority.

```powershell
$params = @{
  Subject = 'CN=MSGraph_ReportingAPI'
  CertStoreLocation = 'Cert:\CurrentUser\My'
  KeyExportPolicy = 'Exportable'
  KeySpec = 'Signature'
  KeyLength = 2048
  KeyAlgorithm = 'RSA'
  HashAlgorithm = 'SHA256'
}
$cert = New-SelfSignedCertificate      
Export-Certificate -Cert $cert -FilePath ".\MSGraph_ReportingAPI.cer"
```