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

## Troubleshooting GPG-agent

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
max-cache-ttl 999999
```

### Attempt 3:

Manually set the parameter every time git bash loads:

In `%USERPROFILE%/.bash_profile`:

```sh
gpg-agent --max-cache-ttl 999999
```
