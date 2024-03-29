# Azure Identity Protection

## Managing Azure Identity Protection with PowerShell
Reference:
- [Azure Active Directory Identity Protection and the Microsoft Graph PowerShell SDK](https://docs.microsoft.com/en-us/azure/active-directory/identity-protection/howto-identity-protection-graph-api)
- [New-SelfSignedCertificate](https://docs.microsoft.com/en-us/powershell/module/pki/new-selfsignedcertificate?view=windowsserver2022-ps)
- [New-AzureADApplication](https://docs.microsoft.com/en-us/powershell/module/azuread/new-azureadapplication?view=azureadps-2.0)
- [Grant Admin Consent](https://docs.microsoft.com/en-us/azure/active-directory/manage-apps/grant-consent-single-user)
- [Update Application Permissions](https://docs.microsoft.com/en-us/graph/migrate-azure-ad-graph-configure-permissions?tabs=powershell-1#step-2-add-azure-ad-graph-permissions-to-your-app)

Four steps to accessing Identity Protection data through Microsoft Graph:
- [Managing Azure Identity Protection with PowerShell](#managing-azure-identity-protection-with-powershell)
  - [Create a certificate](#create-a-certificate)
  - [Create a new app registration](#create-a-new-app-registration)

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
$cert = New-SelfSignedCertificate @params 
Export-Certificate -Cert $cert -FilePath ".\MSGraph_ReportingAPI.cer"
```

### Create a new app registration
Create a new app registration.  Note the `Application (client) ID` and `Directory (tenant) ID`.
