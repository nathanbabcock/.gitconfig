# .gitconfig

## Installation

Include the `.gitconfig` in this repo in the machine's global config:

- `%USERPROFILE%/.gitconfig` for Windows
- `~/.gitconfig` for Mac/Linux

```ini
[include]
  path = f:/git/.gitconfig/.gitconfig
```

## Limitations

Commands added with `git config --global` will be written into the global `.gitconfig`, not the shared repo version. They will need to be manually transferred over, committed, and pushed.

## 1Password SSH agent integration

The local `~/.gitconfig` on each computer should specify the path to the
  signing tool. Go to "Configure" on an SSH key inside 1Password to get the
  correct path. The other settings are shared in the global `.gitconfig` in this repo.

```ini
[gpg "ssh"]
  program = "C:/Users/nbabcock/AppData/Local/1Password/app/8/op-ssh-sign.exe"
```

For using multiple Github accounts with SSH keys, you have to edit your
`~/.ssh/config` file to differentiate the hosts. For example:

```ini
# Personal GitHub
Host personal-github
  HostName github.com
  User git
  IdentityFile ~/.ssh/personal_gihub.pub
  IdentitiesOnly yes

# Work GitHub
Host nocap-github
  HostName github.com
  User git
  IdentityFile ~/.ssh/nocap_github.pub
  IdentitiesOnly yes
```

Then use the custom `Host` name instead of `git@github.com`:

```bash
git remote set-url origin personal-github:nathanbabcock/.gitconfig.git
```

[Reference](https://developer.1password.com/docs/ssh/agent/advanced/#use-multiple-github-accounts)

## Troubleshooting GPG-agent (old)

> ⚠ This section is outdated; [1Password SSH Agent](https://developer.1password.com/docs/ssh/get-started/) is now used instead.

---

Don't use gpg4win or Kleopatra, use Git's bundled `gpg.exe` found in `%ProgramFiles%\Git\usr\bin`

```sh
which gpg
# /usr/bin/gpg
```

Configure the default pin cache expiration time:

```sh
gpg-agent --default-cache-ttl 999999999
```

### Attempt 2: Alternate method (if that didn't work):

Find the default config location for Git's copy of gpg. It most likely does not exist initially.

```sh
gpgconf --list-config
# gpgconf: can not open global config file '/etc/gnupg/gpgconf.conf': No such file or directory
```

1. Open Git Bash **as administrator**
2. `vi /etc/gnupg/gpgconf.conf`
3. Add one line:

```properties
# max-cache-ttl 999999 # Incorrect -- see attempt 4
```

### Attempt 3:

Manually set the parameter every time git bash loads:

In `%USERPROFILE%/.bash_profile`:

```sh
gpg-agent --max-cache-ttl 999999
```

### Attempt 4:

Fix syntax in `vi /etc/gnupg/gpgconf.conf`:

```properties
* gpg-agent max-cache-ttl [default] 999999
```
