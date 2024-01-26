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

### Git config

The local `~/.gitconfig` on each computer should specify the path to the
  signing tool. Go to "Configure" on an SSH key inside 1Password to get the
  correct path. The other settings are shared in the global `.gitconfig` in this repo.

```ini
[gpg "ssh"]
  program = "C:/Users/nbabcock/AppData/Local/1Password/app/8/op-ssh-sign.exe"
```

### SSH config

For using multiple Github accounts with SSH keys, you have to edit your
`~/.ssh/config` file to differentiate the hosts. For example:

```ini
# NOCAP Github
Match host github.com exec "git config user.email | grep -q nathan@nocapinc.com"
    IdentityFile ~/.ssh/nocap_github.pub

# Personal Github
Match host github.com exec "git config user.email | grep -vq nathan@nocapinc.com"
    IdentityFile ~/.ssh/personal_github.pub
```

Grep args:

- `-q`: quiet (only return exit code)
- `-v`: invert match

This a slightly more advanced method than what's recommended in the [1password docs](https://developer.1password.com/docs/ssh/agent/advanced/#use-multiple-github-accounts). The `Match ... exec` approach doesn't require changing git remote URLs, which can break other git extensions which read remotes.

### Github settings

In Github, add the SSH key **twice**; once as an authentication key, and once as
a signing key (new as of Git 2.34 in October 2022).

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
