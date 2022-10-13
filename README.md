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
