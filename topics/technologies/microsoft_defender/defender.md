# Microsoft Defender

<details><summary>Microsoft Defender Exam Topics</summary>
<br>

<img src='img/20231259-035927.png' width=700px>

</details>


## Microsoft Learning Path
Expand the sections below to view notes from the SC-200 learning paths.

<details open><summary>SC-200: Mitigate threats using Microsoft Defender XDR</summary>
<br>

The following sections cover content from the Microsoft Learning Path [SC-200: Mitigate threats using Microsoft Defender XDR](https://learn.microsoft.com/en-us/training/paths/sc-200-mitigate-threats-using-microsoft-365-defender/).

### Introduction to Microsoft 365 Threat Protection

<details><summary>Microsoft Defender XDR Overview</summary>

Reference:
- [Microsoft Defender XDR](https://learn.microsoft.com/en-us/microsoft-365/security/defender/microsoft-365-defender?view=o365-worldwide)

Microsoft Defender XDR is an integrated threat protection suite that combines
signals from endpoints, identities, email, and applications. The following graphic, taken from the [Microsoft Cybersecurity Reference
Architectures](https://learn.microsoft.com/en-us/security/cybersecurity-reference-architecture/mcra),
shows the relationship between Microsoft Defender technologies and Microsoft
Defender XDR.

<img src='img/20231206-040604.png' width=700px>

</details>

<details>
  <summary>An Example Defender XDR Scenario</summary>

Reference:
- [Explore Extended Detection & Response (XDR) response use cases](https://learn.microsoft.com/en-us/training/modules/introduction-microsoft-365-threat-protection/2-explore-extended-detection-response-use-cases)

In the following scenario, a victim unknowingly triggers a malware infection by opening a malicious attachment received via personal email or USB drive, bypassing Microsoft Defender for Office 365 (MDO) protection. However, Microsoft Defender for Endpoints (MDE) detects the attack, alerts the security operations, and triggers a response in Intune and Microsoft Entra ID, leading to the user's access being blocked due to noncompliance with organizational policy.

<img src='img/20231212-041248.png' width=700px>

Microsoft Defender for Endpoint (MDE) informs Intune about device risk, leading Intune to update the device's compliance status in Entra ID, which Conditional Access uses to manage access. Consequently, the user's access to corporate resources is restricted, affecting both new requests and existing sessions, while allowing access to general internet tasks that don't require corporate authentication.

<img src='img/20231224-042415.png' width=700px>

Once infected devices are remediated, Microsoft Defender for Endpoints (MDE) informs Intune to update the device risk status, allowing Microsoft Entra ID Conditional Access to restore access to enterprise resources. Additionally, the threat signals in Microsoft Threat Intelligence are utilized by Microsoft Defender for Office 365 (MDO) and Microsoft Defender for Cloud to detect and address threats across various platforms, including email, office collaboration, and Azure.

</details>

<details><summary>Defender XDR in a Security Operations Center (SOC)</summary>

Reference:
- [Understand Microsoft Defender XDR in a Security Operations Center (SOC)](https://learn.microsoft.com/en-us/training/modules/introduction-microsoft-365-threat-protection/3-understand-defender-security-operations-center)

The Security Operations Model is structured with multiple distinct functions, each having a specific focus area and requiring close collaboration among themselves and with external teams for effective operation. In smaller organizations, these roles tend to be consolidated into fewer teams or individuals, typically under IT Operations for technical responsibilities. Additionally, some functions, like incident management, may be assigned temporarily to leadership or designated delegates, highlighting the model's flexibility to adapt to different organizational structures.
  
<img src='img/20231251-045113.png' width=700px>

</details>

<details><summary>Explore Microsoft Security Graph</summary>

Reference:
- [Explore Microsoft Security Graph](https://learn.microsoft.com/en-us/training/modules/introduction-microsoft-365-threat-protection/4-explore-microsoft-security-graph)
- [Microsoft Graph security API overview](https://learn.microsoft.com/en-us/graph/security-concept-overview)

Microsoft Graph provides REST APIs and client libraries to access data on various Microsoft cloud services, including Microsoft 365 core services (like Bookings, Calendar, OneDrive), Enterprise Mobility + Security services (such as Advanced Threat Analytics, Intune), Windows services (like devices, notifications), Dynamics 365 Business Central services, and the Microsoft Graph Security API.

The Microsoft Graph Security API acts as a broker, connecting multiple Microsoft security providers and returning aggregated results in a common schema. Developers use this API to integrate and correlate security alerts, stream alerts to SIEM solutions, automate threat response, and enhance investigations.

The Microsoft Graph Security API has two versions: the stable v1.0 and the Beta version with preview APIs that may change. Both versions support advanced hunting with the runHuntingQuery method using Kusto Query Language (KQL), as demonstrated in the example with Microsoft Defender XDR. The Graph Explorer tool can run these hunting queries. For more details, the Microsoft Graph Security API documentation provides additional information.

You can even embed Kusto Query Language (KQL) queries in Graph calls:

```html
POST https://graph.microsoft.com/v1.0/security/runHuntingQuery

{
    "Query": "DeviceProcessEvents | where InitiatingProcessFileName =~ \"powershell.exe\" | project Timestamp, FileName, InitiatingProcessFileName | order by Timestamp desc | limit 2"
}
```
The following screenshot shows how you can run a hunting query in the Graph Explorer tool.

<img src='img/20231242-034211.png' width=700px>

</details>

### Mitigate Incidents Using Microsoft Defender XDR



</details> <!-- End Parent-->

