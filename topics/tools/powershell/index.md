# My PowerShell Notes
- [My Custom PowerShell Prompt](prompt.md)

# PowerShell Patterns

## Checking if a string is null or empty
Use the following block of code to check if a string is null or empty.

```powershell
if ([string]::IsNullOrEmpty('String')) { ... }
```