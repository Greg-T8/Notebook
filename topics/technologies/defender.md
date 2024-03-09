# Microsoft Defender


- [Product Overview](#product-overview)
  - [Products and features of Microsoft Defender XDR](#products-and-features-of-microsoft-defender-xdr)
    - [Defender for Office 365](#defender-for-office-365)
    - [Defender for Cloud Apps](#defender-for-cloud-apps)
    - [Defender for Cloud](#defender-for-cloud)
    - [Defender for Identity](#defender-for-identity)
    - [Defender Antivirus](#defender-antivirus)
    - [Defender for Endpoint](#defender-for-endpoint)
    - [Defender Vulnerability Management](#defender-vulnerability-management)
    - [Defender Threat Intelligence](#defender-threat-intelligence)
    - [Defender Experts](#defender-experts)
  - [Resources for learning and getting help](#resources-for-learning-and-getting-help)
- [Technical Notes](#technical-notes)
  - [Defender XDR Role-Based Access Control (RBAC)](#defender-xdr-role-based-access-control-rbac)

## Product Overview

### Products and features of Microsoft Defender XDR

XDR (Extended Detection and Response) is a cybersecurity industry term for solutions that extend beyond traditional endpoint security. XDR solutions collect and correlate data across multiple security layers - email, endpoint, cloud, and network.

Per the [Microsoft Defender XDR FAQ](https://www.microsoft.com/en-us/security/business/siem-and-xdr/microsoft-defender-xdr#x775d8d7905b145e88deb34493a003a0d), Microsoft Defender XDR (formerly known as Microsoft Defender) is the unified portal experience encompassing all the Defender products. Microsoft XDR provides provides protection across endpoints, hybrid identities, email collaboration and tools, cloud services (Azure, Amazon, and Google), and IoT devices.

[Microsoft Sentinel](https://learn.microsoft.com/en-us/azure/sentinel/overview) complements capabilities of Microsoft XDR with security information and event management (SIEM) and security orchestration, automation, and response (SOAR) capabilities to ingest logs from your entire digital estate.

Microsoft Defender XDR includes the following features:

- Cross-product single pane of glass in the Microsoft Defender portal
- Incident and alerts
- Automatic response to threats
- [Threat Hunting](https://learn.microsoft.com/en-us/microsoft-365/security/defender/advanced-hunting-overview?view=o365-worldwide)
- [Threat Analytics](https://learn.microsoft.com/en-us/microsoft-365/security/defender/threat-analytics?view=o365-worldwide)
- Self-healing for compromised devices, user identities, and mailboxes
- [Multi-tenant Management](https://learn.microsoft.com/en-us/microsoft-365/security/defender/mto-overview?view=o365-worldwide)

Microsoft Defender XDR includes the following products:

#### Defender for Office 365
Defender for Office 365 is a cloud-based email filtering service. It was previously known as Office 365 Advanced Threat Protection (ATP) before being rebranded. 

Key features of Defender for Office 365 include:

1. **Safe Attachments**: Scans email attachments in a virtual environment to detect and block malware before it reaches the user's mailbox.

2. **Safe Links**: Checks links in emails and Office documents in real-time to protect users from clicking on malicious links leading to phishing sites or malware downloads.

3. **Anti-phishing policies**: Helps detect and block phishing attempts by analyzing email content, sender reputation, and other indicators of phishing activity.

4. **Spoof Intelligence**: Detects and blocks spoofed emails impersonating legitimate senders within the organization to prevent phishing attacks.

5. **Threat Intelligence**: Utilizes threat intelligence from Microsoft's vast network of sensors and security partners to enhance protection against emerging threats.

6. **Threat Explorer**: Provides administrators with visibility into email threats targeting their organization, allowing them to investigate and take appropriate action.

7. **Real-time Reports and Alerts**: Generates reports and alerts to keep administrators informed about security incidents and trends within their organization.

##### Defender for Office 365 Plans

- [Defender for Office 365 Plan 1](https://learn.microsoft.com/en-us/microsoft-365/security/office-365-security/mdo-security-comparison?view=o365-worldwide#defender-for-office-365-plan-1-vs-plan-2-cheat-sheet)
  - License
    - Defender for Office 365 Plan 1 ($2 user/mo)
    - Microsoft 365 Business Premium ($22 user/mo)
    - Office 365 E5 ($38 user/mo)
    - Microsoft 365 E5 ($57 user/mo)
  - Features
    - [Advanced Anti-Phishing](https://learn.microsoft.com/en-us/microsoft-365/security/office-365-security/anti-phishing-policies-about?view=o365-worldwide)
    - [Real-Time Reports](https://learn.microsoft.com/en-us/microsoft-365/security/office-365-security/reports-defender-for-office-365?view=o365-worldwide)
    - [Safe Attachments](https://learn.microsoft.com/en-us/microsoft-365/security/office-365-security/safe-attachments-about?view=o365-worldwide)
    - [Safe Links](https://learn.microsoft.com/en-us/microsoft-365/security/office-365-security/safe-links-about?view=o365-worldwide)
- [Defender for Office 365 Plan 2](https://learn.microsoft.com/en-us/microsoft-365/security/office-365-security/mdo-security-comparison?view=o365-worldwide#defender-for-office-365-plan-1-vs-plan-2-cheat-sheet)
  - License
    - Defender for Office 365 Plan 2 ($5 user/mo)
    - Office 365 E5 ($38 user/mo)
    - Microsoft 365 E5 ($57 user/mo)
  - Features
    - [Attack Simulation Training](https://learn.microsoft.com/en-us/microsoft-365/security/office-365-security/attack-simulation-training-get-started?view=o365-worldwide)
    - [Automated Investigation & Response (AIR)](https://learn.microsoft.com/en-us/microsoft-365/security/office-365-security/air-about-office?view=o365-worldwide)
    - [Campaign Views](https://learn.microsoft.com/en-us/microsoft-365/security/office-365-security/campaigns?view=o365-worldwide)
    - [Compromised User Detection](https://learn.microsoft.com/en-us/microsoft-365/security/office-365-security/address-compromised-users-quickly?view=o365-worldwide)
    - [Threat Explorer](https://learn.microsoft.com/en-us/microsoft-365/security/office-365-security/threat-explorer-about?view=o365-worldwide)
    - [Threat Trackers](https://learn.microsoft.com/en-us/microsoft-365/security/office-365-security/threat-trackers?view=o365-worldwide)


#### Defender for Cloud Apps

Defender for Cloud Apps is a Microsoft security solution designed to help organizations protect their cloud-based applications and services. It was previously known as Microsoft Cloud App Security (MCAS) before being rebranded as part of Microsoft's broader Defender suite of products.

Defender for Cloud Apps offers a range of capabilities aimed at enhancing the security of cloud-based applications, including:

1. **Shadow IT Discovery**: Identifies cloud applications and services being used within the organization, even those not sanctioned by IT, to provide visibility into potential security risks.

2. **Data Loss Prevention (DLP)**: Monitors and controls the sharing of sensitive data within cloud applications to prevent data leaks and ensure compliance with regulatory requirements.

3. **Threat Protection**: Detects and responds to threats targeting cloud applications, such as unauthorized access attempts, account compromise, malware uploads, and anomalous user behavior.

4. **Conditional Access Policies**: Enforces access controls and policies based on user behavior, device health, and other contextual factors to secure access to cloud applications.

5. **App Governance**: Provides governance capabilities to manage and control the usage of cloud applications, including app discovery, risk assessment, and access reviews.

6. **Compliance Monitoring**: Monitors cloud applications for compliance with regulatory standards and organizational policies, helping to ensure data protection and privacy requirements are met.

7. **Integration with Microsoft 365 Security Center**: Seamlessly integrates with the Microsoft 365 Security Center to provide a unified view of security alerts, incidents, and compliance across Microsoft cloud services.

Defender for Cloud Apps helps organizations secure their cloud environments, mitigate risks associated with cloud adoption, and ensure the confidentiality, integrity, and availability of their data and applications in the cloud. By providing visibility, control, and threat protection across cloud services, organizations can confidently embrace the benefits of cloud computing while maintaining a strong security posture.

##### Defender for Cloud Apps Plans

- [Defender for Cloud Apps](https://learn.microsoft.com/en-us/defender-cloud-apps/what-is-defender-for-cloud-apps)
  - License
    - Defender for Cloud Apps ($3.50 user/mo)
    - Enterprise Mobility + Security E5 ($16.40 user/mo)
    - Microsoft 365 E5 ($57 user/mo)
  - Features
    - Cloud access security broker (CASB) functionality - helps to discover Shadow IT, provides visibility into cloud app Usage
    - SaaS Security Posture Management (SSPM) - provides recommendations for strengthening security posture of each connected app
    - Advanced Threat Protection - enables correlation of signal and visibility across full kill chain of advanced attacks
    - App-to-app protection - enables security management of OAuth-enabled apps
    - Information Protection - DLP features and responses to sensitivity labels on detected count, can apply sensitivity labels, block downloads to unmanaged devices, and remove external collaborators on confidential files

#### Defender for Cloud

Microsoft Defender for Cloud, formerly known as Azure Security Center, is a cloud-native application protection platform (CNAPP) that is made up of security measures and practices that are designed to protect cloud-based applications from cyber threats and vulnerabilities. Defender for Cloud combines the following capabilities:

- A development security operations (DevSecOps) solution that unifies security management at the code level across multi-cloud and multi-pipeline environments
- A cloud security posture management (CSPM) solution that surfaces actions you can take to prevent breaches
- A cloud workload protection platform (CWPP) with specific protection for servers, containers, storage, databases, and other workloads

See [here](https://learn.microsoft.com/en-us/azure/defender-for-cloud/concept-integration-365) to understand how Defender for Cloud integrates with Microsoft Defender XDR.

##### Defender for Cloud Plans

- [Defender for Cloud Pricing](https://azure.microsoft.com/en-us/pricing/details/defender-for-cloud/) - separate plans for cloud security posture management (CSPM) and cloud workload protection (CWPP)
- Foundational CSPM (Free)
- Defender Cloud Security Posture Management (CSPM) plan
  - [CSPM Pricing](https://learn.microsoft.com/en-us/azure/defender-for-cloud/concept-cloud-security-posture-management#plan-pricing) - $0.007/Billable resource/hour
  - [Features and Availability](https://learn.microsoft.com/en-us/azure/defender-for-cloud/concept-cloud-security-posture-management#plan-availability)
- [External Attack Surface Management (EASM)](https://azure.microsoft.com/en-us/pricing/details/defender-external-attack-surface-management/) - $0.011 asset/day

##### DevSecOps

- [Code Pipeline Insights](https://learn.microsoft.com/en-us/azure/defender-for-cloud/defender-for-devops-introduction) - protects Azure DevOps, GitHub, and GitLab
  - Plan
    - Foundational CSPM (Free) - the free plan will for DevSecOps will go away on March 1, 2024
    - Defender CSPM

##### Cloud Security Posture Management (CSPM)

- Plan: Foundational CSPM (Free)
  - [Defender Cloud Security Posture Management (CSPM) dashboard](https://learn.microsoft.com/en-us/azure/defender-for-cloud/concept-cloud-security-posture-management)
  - [Centralized policy management](https://learn.microsoft.com/en-us/azure/defender-for-cloud/security-policy-concept)
  - [Secure score in Defender for Cloud](https://learn.microsoft.com/en-us/azure/defender-for-cloud/secure-score-security-controls)
  - [Multicloud coverage](https://learn.microsoft.com/en-us/azure/defender-for-cloud/plan-multicloud-security-get-started) - Azure, AWS, Google, hybrid

- Plan: Defender CSPM
  - [Security Governance](https://learn.microsoft.com/en-us/azure/defender-for-cloud/governance-rules) - Drives accountability and SLA around remediating security recommendations
  - [Regulatory compliance dashboard](https://learn.microsoft.com/en-us/azure/defender-for-cloud/concept-regulatory-compliance) 
  - [Cloud security explorer](https://learn.microsoft.com/en-us/azure/defender-for-cloud/how-to-manage-cloud-security-explorer) - Enables you to query security issues across all assets across all multiple clouds
  - [Attack path analysis](https://learn.microsoft.com/en-us/azure/defender-for-cloud/how-to-manage-attack-path) - Provides recommendations for specific attack paths
  - [Agentless scanning for VMs](https://learn.microsoft.com/en-us/azure/defender-for-cloud/concept-agentless-data-collection)
  - [Agentless container posture](https://learn.microsoft.com/en-us/azure/defender-for-cloud/concept-agentless-containers)
  - [Data-aware security posture](https://learn.microsoft.com/en-us/azure/defender-for-cloud/concept-data-security-posture) - discovers sensitive data in cloud assets and surfaces in a dashboard
  - [Permissions Management (Preview)](https://learn.microsoft.com/en-us/azure/defender-for-cloud/enable-permissions-management) - integrates with Entra to provide permissions management recommendations, including overprovisionined identities, super identities, and unused identities
  - [Integration with Defender EASM](https://learn.microsoft.com/en-us/azure/defender-for-cloud/concept-easm) - EASM scans and discovers Defender for Cloud assets and provides insights for publicly-exposed assets

##### Cloud Workload Protection Platform (CWPP)

- [Defender for Servers](https://learn.microsoft.com/en-us/azure/defender-for-cloud/plan-defender-for-servers-select-plan )
  - Licensing Requirements
    - Microsoft Defender for Servers Plan 1 or Plan 2 (as part of the Defender for Cloud offering, i.e. through Azure)
    - Microsoft Defender for Endpoint for Servers ($5 server/mo)
    - Microsoft Defender for Business Servers (for < 300 users)
    - See [Licensing Requirements](https://learn.microsoft.com/en-us/microsoft-365/security/defender-endpoint/minimum-requirements?view=o365-worldwide#licensing-requirements) and [Defender for Servers FAQ](https://learn.microsoft.com/en-us/azure/defender-for-cloud/faq-defender-for-servers#can-i-get-a-discount-if-i-already-have-a-microsoft-defender-for-endpoint-license-)
  - Defender for Servers Plan 1
    - Description: Entry-level and enabled at the Azure subscription level but with an [option to enable at the resource level](https://learn.microsoft.com/en-us/azure/defender-for-cloud/tutorial-enable-servers-plan#enable-the-plan-at-the-resource-level)
    - Features
      - Defender for Endpoint Integration
      - Licensing - charged by the hour per seat, and only when VMs are in use
      - Defender for Endpoint Provisioning - automatically provisions on every supported VMs
      - Threat detection at OS-level (agent-based) - behavioral detection and _fileless attack detection_
  - Defender for Servers Plan 2
    - Description: Provides all features and must be enabled both at the Azure subscription level and (to get full coverage) at the Log Analytics workspace level. There is an option to [exclude items at the resource level](https://learn.microsoft.com/en-us/azure/defender-for-cloud/tutorial-enable-servers-plan#enable-the-plan-at-the-resource-level).
    - Features
      - Free data ingestion (500MB) to Log Analytics workspaces
      - Free Azure Update Manager Remediation for Arc machines
      - Threat detection at network-level (agentless security alerts)
      - [Security policy and regulatory compliance](https://learn.microsoft.com/en-us/azure/defender-for-cloud/security-policy-concept) - compare VM configuration with industry standards and benchmarks
      - [Qualys vulnerability assessment](https://learn.microsoft.com/en-us/azure/defender-for-cloud/deploy-vulnerability-assessment-vm) - deploy Qualys scanner and display findings (as an alternative to Microsoft Defender Vulnerability Management)
      - [Adaptive application controls](https://learn.microsoft.com/en-us/azure/defender-for-cloud/adaptive-application-controls) - define allowlists of known safe applications
      - [Just-in-time VM access](https://learn.microsoft.com/en-us/azure/defender-for-cloud/just-in-time-access-overview?tabs=defender-for-container-arch-aks) - locks down open management ports to reduce attack surface
      - [Adaptive network hardening](https://learn.microsoft.com/en-us/azure/defender-for-cloud/adaptive-network-hardening) - Provides recommendations for hardening NSG rules
      - [File integrity monitoring](https://learn.microsoft.com/en-us/azure/defender-for-cloud/file-integrity-monitoring-overview) - Examines OS files, Windows registries, application software, and Linux system files for changes that might indicate an attack
      - [Docker host hardening](https://learn.microsoft.com/en-us/azure/defender-for-cloud/harden-docker-hosts) - Identifies unmanaged containers hosted on IaaS Linux VMs and provides hardening recommendations
      - [Agentless scanning](https://learn.microsoft.com/en-us/azure/defender-for-cloud/concept-agentless-data-collection) - Provides actionable postures for Windows and Linux VMs without requiring an agent
    - Add-Ons
      - Microsoft Defender Vulnerability Management 

  - [Defender for App Service](https://learn.microsoft.com/en-us/azure/defender-for-cloud/defender-for-app-service-introduction)
  - [Defender for Databases](https://learn.microsoft.com/en-us/azure/defender-for-cloud/tutorial-enable-databases-plan) - Includes Azure SQL, SQL Servers, Azure Cosmos DB, open-source relational databases (PostgreSQL, MySQL, MariaDB)
  - [Defender for Storage](https://learn.microsoft.com/en-us/azure/defender-for-cloud/defender-for-storage-introduction) - Azure-native  layer that protects storage accounts
  - [Defender for Containers](https://learn.microsoft.com/en-us/azure/defender-for-cloud/defender-for-containers-introduction) - imporve, monitor, and maintain security of containerized assets (Kubernetes clusters)
  - [Defender for Key Vault](https://learn.microsoft.com/en-us/azure/defender-for-cloud/defender-for-key-vault-introduction) - Detects unusual attempts to access certificates, connection strings, and passwords
  - [Defender for Resource Manager](https://learn.microsoft.com/en-us/azure/defender-for-cloud/defender-for-resource-manager-introduction) - monitors resource management operations in Azure Resource Manager
  - [Defender for APIs](https://learn.microsoft.com/en-us/azure/defender-for-cloud/defender-for-apis-introduction)
  - [Defender for DNS](https://learn.microsoft.com/en-us/azure/defender-for-cloud/defender-for-dns-introduction) - provides security alerts for resources that use Azure DNS

##### External Attack Surface Management (EASM)

- [External Attack Surface Management (Defender EASM)](https://learn.microsoft.com/en-us/azure/external-attack-surface-management/)
  - EASM collects data for publicly exposed assetws ("outside-in"). Defender for Cloud CSPM ("inside-out") uses that data to assist with internet-exposure validation and discovery capabilities
  - Monitors the following public assets: domains, hostnames, web pages, IP blocks, IP addresses, ASNs, SSL certs, WHOIS contacts

#### Defender for Identity

Defender for Identity is a security solution developed by Microsoft as part of their broader suite of security products under the Microsoft Defender brand. Formerly known as Azure Advanced Threat Protection (ATP), Defender for Identity focuses specifically on protecting enterprise networks and systems from advanced cyber threats that target user identities and credentials.

##### Defender for Identity Plans

- [Defender for Identity](https://learn.microsoft.com/en-us/defender-for-identity/what-is)
  - License
    - Defender for Identity ($5.50 user/mo)
    - Enterprise Mobility + Security E5 ($16.40 user/mo)
    - Microsoft 365 E5 ($57 user/mo)
  - Description: integrates with Active Directory and Entra to help identify, detect, and investigate advanced threats, including reconnaissance, compromised credentials, lateral movements, and domain dominance

#### Defender Antivirus

Defender Antivirus, previously known as Windows Defender Antivirus, is a built-in antivirus and antimalware solution provided by Microsoft for Windows operating systems. It is designed to protect users' devices from various forms of malware, including viruses, spyware, ransomware, and other types of malicious software.

Here are some key features and functions of Defender Antivirus:

1. Real-time protection: Defender Antivirus continuously monitors files, programs, and processes on your device in real-time to detect and block any malicious activity.

2. Threat detection and removal: It uses a combination of signature-based detection, heuristic analysis, and machine learning algorithms to identify and remove known and unknown malware threats.

3. Automatic updates: Defender Antivirus receives regular updates from Microsoft to keep its virus definitions and detection capabilities up to date, ensuring protection against the latest threats.

4. Scheduled scans: Users can schedule periodic scans of their devices to perform thorough checks for malware and other potentially unwanted software.

5. Integration with Windows Security Center: Defender Antivirus is integrated with the Windows Security Center, providing users with a centralized dashboard to manage security settings, view threat protection status, and take action against potential security risks.

##### Defender Antivirus Plans

- [Defender Antivirus](https://learn.microsoft.com/en-us/microsoft-365/security/defender-endpoint/microsoft-defender-antivirus-windows?view=o365-worldwide)
  - License
    - Microsoft 365 Business Premium ($22 user/mo)
    - Microsoft 365 E3 ($36 user/mo)
    - Microsoft 365 E5 ($57 user/mo)

#### Defender for Endpoint

Defender for Endpoint is a comprehensive endpoint security solution developed by Microsoft. Formerly known as Microsoft Defender Advanced Threat Protection (ATP), it is designed to help organizations protect their endpoints (such as desktops, laptops, servers, and mobile devices) from various cyber threats, including advanced malware, exploits, and cyber attacks.

Here are some key features and functionalities of Defender for Endpoint:

1. Threat protection: Defender for Endpoint uses a combination of signature-based detection, behavioral analysis, machine learning, and threat intelligence to detect and prevent a wide range of threats, including viruses, ransomware, phishing attacks, and zero-day exploits.

2. Endpoint detection and response (EDR): It provides advanced endpoint detection and response capabilities, allowing security teams to quickly investigate and respond to security incidents on endpoints. This includes capabilities such as timeline-based forensic analysis, threat hunting, and automated response actions.

3. Attack surface reduction: Defender for Endpoint helps organizations minimize their attack surface by providing features such as application control, device control, network protection, and exploit protection to prevent attackers from exploiting vulnerabilities and gaining unauthorized access to endpoints.

4. Secure configuration management: It offers recommendations and guidance to help organizations improve the security posture of their endpoints by identifying and remediating security configuration issues and misconfigurations.

5. Threat and vulnerability management: Defender for Endpoint helps organizations prioritize and remediate security vulnerabilities on their endpoints by providing insights into vulnerable software, missing security updates, and misconfigurations that could be exploited by attackers.

6. Integration with Microsoft 365 Defender: Defender for Endpoint is part of the Microsoft 365 Defender suite, which integrates endpoint security, email security, identity protection, and cloud application security into a unified security platform for comprehensive threat protection and response across the organization.

##### Defender for Endpoint Plans

- [Defender for Business](https://learn.microsoft.com/en-us/microsoft-365/security/defender-business/mdb-overview?view=o365-worldwide)
  - Description: Defender for Business is an endpoint security solution designed for small- and medium-sized businesses (up to 300 employees)
  - License
    - Microsoft Defender for Business ($3 user/mo)
    - Microsoft 365 Business Premium ($22 user/mo)
  - Add-on License
    - Microsoft Defender for Business Servers ($3 server/mo)
  - Features
    - [Block at First Sight](https://learn.microsoft.com/en-us/microsoft-365/security/defender-endpoint/configure-block-at-first-sight-microsoft-defender-antivirus?view=o365-worldwide)
    - [Cross-Platform Support](https://learn.microsoft.com/en-us/microsoft-365/security/defender-endpoint/non-windows?view=o365-worldwide)
    - [Enhanced ASR (Attack Surface Reduction)](https://learn.microsoft.com/en-us/microsoft-365/security/defender-endpoint/overview-attack-surface-reduction?view=o365-worldwide)
    - [Mobile Threat Defense](https://learn.microsoft.com/en-us/microsoft-365/security/defender-endpoint/mtd?view=o365-worldwide)
    - [Next Gen Protection](https://learn.microsoft.com/en-us/microsoft-365/security/defender-endpoint/next-generation-protection?view=o365-worldwide)
    - [Tamper Protection](https://learn.microsoft.com/en-us/microsoft-365/security/defender-endpoint/prevent-changes-to-security-settings-with-tamper-protection?view=o365-worldwide)
    - [Web Content Filtering](https://learn.microsoft.com/en-us/microsoft-365/security/defender-endpoint/web-content-filtering?view=o365-worldwide)
- [Defender for Endpoint Plan 1](https://learn.microsoft.com/en-us/microsoft-365/security/defender-endpoint/defender-endpoint-plan-1?view=o365-worldwide)
  - License
    - Defender for Endpoint Plan 1 ($3 user/mo)
    - Microsoft 365 E3 ($36 user/mo)
    - Microsoft 365 E5 ($57 user/mo)
  - Features
    - [Next Generation Protection](https://learn.microsoft.com/en-us/microsoft-365/security/defender-endpoint/next-generation-protection?view=o365-worldwide) - Antivirus signal sharing, Cloud Protection (rapid identification of new threats)
    - [Manual Response Actions](https://learn.microsoft.com/en-us/microsoft-365/security/defender-endpoint/defender-endpoint-plan-1?view=o365-worldwide#manual-response-actions) - Isolate device, AV scan, stop and quarantine files, block or allow files
    - [Ransomware Mitigation](https://learn.microsoft.com/en-us/microsoft-365/security/defender-endpoint/controlled-folders?view=o365-worldwide) - Controlled folder access (boot sector, user profile folders)
    - [Attack Surface Reduction](https://learn.microsoft.com/en-us/microsoft-365/security/defender-endpoint/overview-attack-surface-reduction?view=o365-worldwide)
    - [Web Filtering](https://learn.microsoft.com/en-us/microsoft-365/security/defender-endpoint/web-content-filtering?view=o365-worldwide)
    - [Web Threat Detection](https://learn.microsoft.com/en-us/microsoft-365/security/defender-endpoint/web-protection-overview?view=o365-worldwide)
    - [Web Firewall](https://learn.microsoft.com/en-us/microsoft-365/security/defender-endpoint/defender-endpoint-plan-1?view=o365-worldwide#network-firewall)
    - [Device Control](https://learn.microsoft.com/en-us/microsoft-365/security/defender-endpoint/mde-device-control-device-installation?view=o365-worldwide) - USB devices and removable media
    - [Application Control](https://learn.microsoft.com/en-us/microsoft-365/security/defender-endpoint/defender-endpoint-plan-1?view=o365-worldwide#application-control)
    - [Centralized Management](https://learn.microsoft.com/en-us/microsoft-365/security/defender-endpoint/defender-endpoint-plan-1?view=o365-worldwide)
    - [Cross-Platform Support](https://learn.microsoft.com/en-us/microsoft-365/security/defender-endpoint/non-windows?view=o365-worldwide) - Windows, macOS, Linux, Android, iOS
      - See [Supported Microsoft Defender for Endpoint capabilities by platform](https://learn.microsoft.com/en-us/microsoft-365/security/defender-endpoint/supported-capabilities-by-platform?view=o365-worldwide)
    - [Block at First Sight (BAFS)](https://learn.microsoft.com/en-us/microsoft-365/security/defender-endpoint/configure-block-at-first-sight-microsoft-defender-antivirus?view=o365-worldwide) - Blocks suspicious but undetected files and then uses heuristics and machine learning to determine if files are malicious or not a threat
    - [Mobile Threat Defense](https://learn.microsoft.com/en-us/microsoft-365/security/defender-endpoint/mtd?view=o365-worldwide) - Anti-phishing, blocking unsafe network connections, detection of malicious apps and jail-broken devices, risky device signals, privacy in threat reports
    - [Tamper Protection](https://learn.microsoft.com/en-us/microsoft-365/security/defender-endpoint/prevent-changes-to-security-settings-with-tamper-protection?view=o365-worldwide) - Protects virus and threat protection from being disabled
    - [Investigate Incidents Involving Sensitivity Labels](https://learn.microsoft.com/en-us/microsoft-365/security/defender-endpoint/information-protection-investigation?view=o365-worldwide)
    - [SIEM Integration](https://learn.microsoft.com/en-us/microsoft-365/security/defender-endpoint/configure-siem?view=o365-worldwide)
    - [Threat Protection Reports](https://learn.microsoft.com/en-us/microsoft-365/security/defender-endpoint/threat-protection-reports?view=o365-worldwide)
- [Defender for Endpoint Plan 2](https://learn.microsoft.com/en-us/microsoft-365/security/defender-endpoint/microsoft-defender-endpoint?view=o365-worldwide)
  - Formerly known as "Defender for Endpoint"
  - License
    - Defender for Endpoint Plan 2 ($5 user/mo)
    - Microsoft 365 E5 ($57 user/mo)
  - Features
    - [Defender for Cloud Apps Integration](https://learn.microsoft.com/en-us/microsoft-365/security/defender-endpoint/microsoft-cloud-app-security-integration?view=o365-worldwide)
    - [Core Defender Vulnerability Management](https://learn.microsoft.com/en-us/microsoft-365/security/defender-vulnerability-management/defender-vulnerability-management?view=o365-worldwide)
    - [Endpoint Detection and Response](https://learn.microsoft.com/en-us/microsoft-365/security/defender-endpoint/overview-endpoint-detection-response?view=o365-worldwide)
      - Investigate device alerts
      - View and approve remediation actions
    - [Automated Investigation and Remediation (AIR)](https://learn.microsoft.com/en-us/microsoft-365/security/defender-endpoint/automated-investigations?view=o365-worldwide) - alerts from the same device are consolidated into the current investigation, and if the same threat appears on other devices or spreads to 10 or more devices, the investigation expands to include these devices.
    - [Microsoft Secure Score for Devices](https://learn.microsoft.com/en-us/microsoft-365/security/defender-vulnerability-management/tvm-microsoft-secure-score-devices?view=o365-worldwide)
    - [Endpoint Attack notifications](https://learn.microsoft.com/en-us/microsoft-365/security/defender-endpoint/endpoint-attack-notifications?view=o365-worldwide) - Provides proactive alerts on non-automated attacks
    - [Live Response](https://learn.microsoft.com/en-us/microsoft-365/security/defender-endpoint/live-response?view=o365-worldwide) - Provides instant access to a device using a remote shell
    - [Power BI Connections](https://learn.microsoft.com/en-us/microsoft-365/security/defender-endpoint/api/api-power-bi?view=o365-worldwide)
    - [Threat Analytics](https://learn.microsoft.com/en-us/microsoft-365/security/defender-endpoint/threat-analytics?view=o365-worldwide) - Set of report from export Microsoft security researchers covering active threat actors, new attack techniques, critical vulnerabilities, common attack surfaces, prevalent malware
    - [6-Months Searchable Data](https://learn.microsoft.com/en-us/microsoft-365/security/defender-endpoint/data-storage-privacy?view=o365-worldwide) - 6 months in the portal, 30 days via query in the advanced hunting investigation experience
    - [Evaluation Lab](https://learn.microsoft.com/en-us/microsoft-365/security/defender-endpoint/evaluation-lab?view=o365-worldwide) - Retiring in January 2024 per MC698829
  - Add-ons
    - Microsoft Defender Vulnerability Management (premium)
    - Microsoft Defender Experts for Hunting (EA or MCA)
    - Microsoft Defender Experts for XDR (EA)
    - Microsoft Defender for Servers (Plan 1 or Plan 2)

#### Defender Vulnerability Management

Defender Vulnerability Management is part of Microsoft's security services, aimed at providing organizations with tools and insights necessary to identify, assess, and mitigate vulnerabilities across their IT environments. It's a feature within Microsoft Defender for Endpoint, designed to enhance the overall security posture of an organization by providing:

1. **Vulnerability Assessment:** It scans devices, applications, and network devices for known vulnerabilities, assessing their risk level based on the potential impact and exploitability.

2. **Security Recommendations:** Based on the findings from the assessments, it offers actionable recommendations for mitigating risks. These recommendations are prioritized to help IT security teams focus on the most critical vulnerabilities first.

3. **Threat and Vulnerability Management (TVM):** This component helps in identifying and prioritizing vulnerabilities and misconfigurations in real time, leveraging Microsoft's extensive security intelligence to correlate vulnerabilities with active threats.

4. **Integration with Endpoint Protection:** It seamlessly integrates with Microsoft Defender for Endpoint, providing a unified platform for endpoint security that includes preventive protection, post-breach detection, automated investigation, and response.

5. **Software Inventory:** It provides detailed visibility into installed software, allowing for better management and control over the software landscape and associated vulnerabilities.

6. **Configuration Management:** Helps ensure that security configurations and settings are correctly applied across the organization's devices and applications, reducing the attack surface.

7. **Risk-based Prioritization:** It uses machine learning and Microsoft's vast dataset to prioritize vulnerabilities based on the likelihood of exploitation in the organization's specific environment.

##### Defender Vulnerability Management Plans

- [Microsoft Defender Vulnerability Management](https://learn.microsoft.com/en-us/microsoft-365/security/defender-vulnerability-management/defender-vulnerability-management-capabilities?view=o365-worldwide)
  - License
    - Microsoft Defender Vulnerability Management ($3 user/mo)
    - Microsoft Defender for Endpoint Plan 2 ($5 user/mo)
    - Microsoft Defender Vulnerability Management Add-on ($2 user/mo)
  - Features
    - Microsoft Defender for Endpoint Plan 2
      - [Device Discovery](https://learn.microsoft.com/en-us/microsoft-365/security/defender-endpoint/device-discovery?view=o365-worldwide) - Find unmanaged devices on monitored networks, including workstations, servers, mobile devices, network devices, printers, and IoT devices
      - [Device Inventory](https://learn.microsoft.com/en-us/microsoft-365/security/defender-endpoint/machines-view-overview?view=o365-worldwide) - Shows a list of devices on network seen within last 30 days
      - [Vulnerability Assessment](https://learn.microsoft.com/en-us/microsoft-365/security/defender-vulnerability-management/tvm-weaknesses?view=o365-worldwide) - View vulnerabilities devices are exposed to by listing the Common Vulnerabilities and Exposures (CVE) ID
      - [Configuration Assessment (i.e. Secure Score for Devices)](https://learn.microsoft.com/en-us/microsoft-365/security/defender-vulnerability-management/tvm-microsoft-secure-score-devices?view=o365-worldwide)
      - [Risk Based Prioritization](https://learn.microsoft.com/en-us/microsoft-365/security/defender-vulnerability-management/tvm-security-recommendation?view=o365-worldwide) - Prioritizes vulnerabilities according to impact and actionable security recommendations
      - [Remediation Tracking](https://learn.microsoft.com/en-us/microsoft-365/security/defender-vulnerability-management/tvm-remediation?view=o365-worldwide) - Provides remediation workflow for Help Desk through Intune integration
      - [Continuous Monitoring](https://learn.microsoft.com/en-us/microsoft-365/security/defender-endpoint/configure-vulnerability-email-notifications?view=o365-worldwide) - Email notifications for vulnerability events
      - [Software Inventory](https://learn.microsoft.com/en-us/microsoft-365/security/defender-vulnerability-management/tvm-software-inventory?view=o365-worldwide) - List of known software in the organization with [Common Platform Enumerations (CPE)](https://nvd.nist.gov/products/cpe)
      - [Software Usage Insights](https://learn.microsoft.com/en-us/microsoft-365/security/defender-vulnerability-management/tvm-usage-insights?view=o365-worldwide) - Provides total number of devices using an application in the past 30 days
      - [Zero-Day Vulnerabilities](https://learn.microsoft.com/en-us/microsoft-365/security/defender-vulnerability-management/tvm-zero-day-vulnerabilities?view=o365-worldwide)
      - [Device Restart Status](https://learn.microsoft.com/en-us/microsoft-365/security/defender-vulnerability-management/device-restart-status?view=o365-worldwide)
    - Microsoft Defender Vulnerability Management Add-on
      - [Security Baselines Assessment](https://learn.microsoft.com/en-us/microsoft-365/security/defender-vulnerability-management/tvm-security-baselines?view=o365-worldwide) - Monitor baseline compliance and identify changes in real time. Provides support for CIS benchmarks.
      - [Block Vulnerable Applications](https://learn.microsoft.com/en-us/microsoft-365/security/defender-vulnerability-management/tvm-block-vuln-apps?view=o365-worldwide) - Enables security admins to take immediate action and block all currently known vulnerable versions of an application
      - [Browser Extensions Assessment](https://learn.microsoft.com/en-us/microsoft-365/security/defender-vulnerability-management/tvm-browser-extensions?view=o365-worldwide) - View browser extensions and permissions across Edge, Chrome, and Firefox
      - [Digital Certificate Assessment](https://learn.microsoft.com/en-us/microsoft-365/security/defender-vulnerability-management/tvm-certificate-inventory?view=o365-worldwide) - View certificates on devices, including expiration date
      - [Network Share Analysis](https://learn.microsoft.com/en-us/microsoft-365/security/defender-vulnerability-management/tvm-network-share-assessment?view=o365-worldwide) - Identify and block vulnerable network shares
      - [Hardware and Firmware Assessment](https://learn.microsoft.com/en-us/microsoft-365/security/defender-vulnerability-management/tvm-hardware-and-firmware?view=o365-worldwide) - Provides list of hardware and firmware in the organization and displays security updates
      - [Authenticated Scan for Windows](https://learn.microsoft.com/en-us/microsoft-365/security/defender-vulnerability-management/windows-authenticated-scan?view=o365-worldwide) - Scans unmanaged devices on the network for software vulnerabilities. Requires the **MDATP Network Scanner** device.

#### Defender Threat Intelligence

Defender Threat Intelligence, formerly known as Microsoft Threat Intelligence, is a part of Microsoft's security products and services designed to provide comprehensive insights into the threat landscape. It leverages the vast data Microsoft collects through its various services, devices, and products to help organizations understand, prioritize, and mitigate potential threats.

Defender Threat Intelligence offers several key capabilities:

1. **Threat Intelligence**: It provides detailed information on threat actors, their tactics, techniques, and procedures (TTPs), and indicators of compromise (IOCs). This information helps security teams to understand the nature of threats targeting their organizations and the broader cybersecurity landscape.

2. **Security Alerts**: It generates alerts based on the analysis of the data collected across the Microsoft ecosystem. These alerts can include information on phishing campaigns, malware infections, and other security threats.

3. **Vulnerability Management**: Defender Threat Intelligence includes tools for identifying and managing vulnerabilities within an organization's network. By understanding the vulnerabilities that are being actively exploited in the wild, security teams can prioritize patching and mitigate risks more effectively.

4. **Integration with Security Solutions**: It integrates with other Microsoft Defender products and services, such as Microsoft Defender for Endpoint, Microsoft Defender for Identity, and Microsoft Defender for Cloud. This integration allows for a unified approach to threat detection, investigation, and response.

5. **Advanced Hunting and Query Capabilities**: It provides advanced hunting capabilities that allow security professionals to proactively search through historical data for signs of intrusion and suspicious activities. This is facilitated through query capabilities that leverage the vast datasets Microsoft has access to.

Defender Threat Intelligence is designed for security analysts, threat researchers, and IT professionals who need to stay ahead of the evolving threat landscape. By providing a deep understanding of threats and their mechanisms, it enables organizations to build more resilient defenses and respond more effectively to incidents.

- [Defender Threat Intelligence (Defender TI)](https://learn.microsoft.com/en-us/defender/threat-intelligence/what-is-microsoft-defender-threat-intelligence-defender-ti)
  - License
    - Defender Threat Intelligence (free)
    - Defender Threat Intelligence (Defender TI) Premium ($4,200/mo)
  - Features
    - Defender Threat Intelligence Portal: https://ti.defender.microsoft.com/
    - Defender TI articles that provide latest information on threat actors
    - Correlates indicators to published articles and vulnerabilities to build Indicators of Compromise (IOCs)
    - Search IP addresses and domain names of known threat actors
    - Published articles on recent threats
    - Integration with Security Copilot

#### Defender Experts

"Defender Experts" refers to a suite of services offered by Microsoft under the umbrella of their cybersecurity solutions, which includes "Defender Experts for Hunting" and "Defender Experts for XDR" (Extended Detection and Response). Here's a brief overview of both services:

1. **Microsoft Defender Experts for Hunting**: This is a proactive threat hunting service that goes beyond the endpoint to hunt across endpoints, Office 365, cloud applications, and identity. The service involves Microsoft's experts who investigate threats they find, then provide the contextual alert information along with remediation instructions. This allows organizations to quickly respond to threats.

2. **Microsoft Defender Experts for XDR**: This is a managed extended detection and response service that helps security operations centers (SOCs) focus and accurately respond to incidents that matter. It provides extended detection and response for customers using Microsoft Defender XDR services, which include Microsoft Defender for Endpoint, Microsoft Defender for Office 365, and other Microsoft Defender solutions. The service is designed to extend the capacity of security operations centers, providing detection and response across Microsoft 365 Defender, investigating alerts, and using automation and human expertise.

These services are part of Microsoft's efforts to enhance cybersecurity for organizations by providing expert support for threat detection, hunting, and response.

- [Defender Experts for Hunting](https://learn.microsoft.com/en-us/microsoft-365/security/defender-endpoint/experts-on-demand?view=o365-worldwide)
  - Description: Managed threat hunting service that proactively looks for threats 24/7/365 across endpoints, email, identity, and cloud apps using Microsoft  Defender data.
  - Availability: Enterprise Agreement (EA) or Microsoft Customer Agreement (MCA)
  - Features:
    - Threat hunting and analysis
    - Defender Experts notifications
    - Experts on Demand - Select **Ask Defender Experts** from an incident
    - Hunter-trained AI
    - Reports
- [Defender Experts for XDR](https://learn.microsoft.com/en-us/microsoft-365/security/defender/dex-xdr-overview?view=o365-worldwide)
  - Availability: Enterprise Agreement (EA)
  - Description: Managed service for customers with constrained security operations centers (SOCs) that are overburdened on alert volume
  - Features
    - Defender Experts for Hunting
    - Partner with your team to manage incident queue and handle triage and investigation
    - Live dashboards and reports with noise-free and actionable view and detailed analytics
    - Periodic check-ins with your team
  - See the [FAQ](https://learn.microsoft.com/en-us/microsoft-365/security/defender/frequently-asked-questions?view=o365-worldwide)

### Resources for learning and getting help

The following resources are invaluable for learning and getting help on Windows Defender XDR:

- [Reddit: Microsoft Defender ATP](https://www.reddit.com/r/DefenderATP/)
- [Microsoft Sentinel & Defender XDR Virtual Ninja Training](https://adoption.microsoft.com/en-us/ninja-show/)
- [Microsoft Security, Compliance, and Identity Tech Community](https://techcommunity.microsoft.com/t5/security-compliance-and-identity/ct-p/MicrosoftSecurityandCompliance)

The following items are specific resources related to various Defender topics:

- [How to tune alerts in Microsoft Defender](https://blog.admindroid.com/how-to-tune-alerts-in-microsoft-365-defender/)
- [Introducing the new alert suppresion experience](https://techcommunity.microsoft.com/t5/microsoft-defender-for-endpoint/introducing-the-new-alert-suppression-experience/ba-p/3562719)

## Technical Notes

### Defender XDR Role-Based Access Control (RBAC)

Per [Manage access to Microsoft Defender XDR](https://learn.microsoft.com/en-us/microsoft-365/security/defender/m365d-permissions?view=o365-worldwide), there are two ways to manage access:

- Global Microsoft Entra roles
- Custom role access

Per [Permissions pre-requisites](https://learn.microsoft.com/en-us/microsoft-365/security/defender/manage-rbac?view=o365-worldwide#permissions-pre-requisites), you must be an Entra Global Administrator or an Entra Security Administrator  to access the **Permissions and Roles** node in the Microsoft Defender portal.

See [Required roles and permissions](https://learn.microsoft.com/en-us/microsoft-365/security/defender/custom-roles?view=o365-worldwide#required-roles-and-permissions) for a table that outlines the roles and permissions required to access each experience in the Defender XDR workload. 

In December 2023, Microsoft introduced a unified role-based access control model for Microsoft Defender XDR. This RBAC model enables role assignment across Defender products without having to manage role assignments separately for each product.  See [Microsoft Defender XDR Unified role-based access control (RBAC)](https://learn.microsoft.com/en-us/microsoft-365/security/defender/manage-rbac?view=o365-worldwide). 

The unified RBAC model covers the following products:

- Microsoft Defender XDR
- Microsoft Defender for Endpoint
- Microsoft Defender Vulnerability Management
- Microsoft Defender for Office 365
- Microsoft Defender for Identity
- Microsoft Defender for Cloud
- Microsoft Secure Score
  
Permissions for the following products must still be managed separately: 

- Microsoft Defender for Cloud Apps
- Microsoft Purview Compliance

Here are some caveats I've found during testing:

- To manage incidents from Defender for Cloud Apps, users must be explicitly assigned to the Defender for Cloud Apps Security Operator role. Expect this requirement to be in effect until Microsoft integrates Defender for Cloud Apps into the unified RBAC model.
- 

See [What's new in Microsoft Defender XDR RBAC](https://learn.microsoft.com/en-us/microsoft-365/security/defender/whats-new-in-microsoft-defender-urbac?view=o365-worldwide) for the latest updates.


