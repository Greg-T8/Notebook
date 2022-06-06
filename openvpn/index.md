This is my notes collection on using the OpenVPN client.

## General Usage

Run the command the following command to launch an OpenVPN session:
```
sudo openvpn --config <config file>
```
The command is successful when you receive the message **Initialization Sequence Completed**.

&emsp;![](img/1.1.png)

Run `ip route` to confirm presence of routes.

&emsp;![](img/1.2.png)

If you receive an error indicating unrecognized option or missing or extra parameter(s) then you may need to install a later version.

&emsp;![](img/1.3.png)

Refer to [OpenVPN Software Repos](https://community.openvpn.net/openvpn/wiki/OpenvpnSoftwareRepos#DebianUbuntu:UsingOpenVPNaptrepositories) for guidance on installing the latest version.
