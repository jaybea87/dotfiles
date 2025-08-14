# Dotfiles

Personal macOS development environment setup with automated configuration for shell, development tools, and applications.

## Requirements
- macOS
- Homebrew (will be installed if missing)

## First time on a completely fresh macOS machine

1. Download the dotfiles repository as a zip and extract it (since you have yet to install git).
2. Open a terminal and run the following commands:
   ```bash
   cd ~/Downloads/dotfiles-master
   sh bootstrap.sh
   ```
3. Create local configuration (optional):
   ```bash
   touch fish/local.fish
   Add any private/local configurations to fish/local.fish - this file is gitignored.
   ```

## Keep you machine up to date

Execute the bootstrap as often as you like to keep your machine up to date with the latest configurations and tools. \
**It is designed to be idempotent, meaning it will only apply changes that are**
necessary.

   ```bash
   sh bootstrap.sh
   ```

## Features

- **Shell**: Fish shell with Starship prompt
- **Development**: Java (multiple versions with jenv), Maven, Kotlin, Python
- **Cloud**: Google Cloud SDK, Kubernetes CLI, Terraform/OpenTofu
- **Applications**: Essential development and productivity apps via Homebrew
- **Automation**: One-command setup with detailed logging

## Customization
- Add personal configurations to fish/local.fish
- Modify Brewfile to change installed applications
- Edit fish configuration files for shell customization
- Update Java versions in jenv-install.sh as needed

## Structure
```
├── bootstrap.sh          # Main setup script
├── Brewfile              # Homebrew package definitions
├── fish/                 # Fish shell configuration
│   ├── config.fish       # Main fish config
│   └── local.fish        # Local/private config (create yourself)
├── starship/             # Starship prompt config
├── jenv-install.sh       # Java environment setup
└── lib.sh                # Shared utility functions
```

