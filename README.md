# eh8's dotfiles

> [!NOTE]
> *March 21, 2024*: I currently manage my [dotfiles using NixOS](https://github.com/eh8/chenglab). While I don't plan on actively maintaining this repository anymore, feel free to reach out if you encounter issues with my configuration.

These are my dotfiles, which use [chezmoi](https://www.chezmoi.io/). I was inspired by [chimurai's dotfiles](https://github.com/chimurai/dotfiles).

To rapidly provision a macOS or Arch Linux machine:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/eh8/dotfiles/master/install.sh)"
```

> These dotfiles contain a number of hardcoded values, assume you use 1Password, and may also add my SSH key to your `authorized_keys` file. Be sure to carefully and fully examine this repository before deploying on your own systems!
