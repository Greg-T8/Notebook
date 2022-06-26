# Git Notes

## First Time Git Setup
Always run the following commands when using a new installation of Git:
```bash
git config --global user.name "My Name"
git config --global user.email <my email address>
```
Every Git commit includes the username and email address. The `--global` option writes to the `~/.gitconfig` file rather than the repository `.git/config` file. You can override this for specific projects by omitting the `--global` option when you're in the project.

Set your editor using the command
```bash
git config --global core.editor vim
```
You only need to do this in Linux. In Windows, the installer package lets you choose. 

Use the following command to confirm settings:
```bash
git config --list
```
