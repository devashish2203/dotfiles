# Dotfiles Configuration Repository

A centralized configuration repository for development tools and environment setup. This repository manages configurations for shell, editors, version managers, and cloud CLI tools.

## Purpose

This repository tracks configuration files for various development tools, providing a consistent development environment across machines. Configurations are organized by tool and can be version controlled to maintain a reproducible setup.

## Tools Configuration

### zsh
Shell configuration with custom completions, aliases, and plugins. Includes support for fzf-tab, starship prompt integration, and mise activation.

**Note:** The `zsh/custom/` folder contains user-specific overrides (aliases, environment variables, completions) and is maintained separately for ease of customization. The `zsh/datahub/` folder contains project-specific configurations and is not checked into git.

### vim
Classic Vim editor configuration with custom settings and plugins.

### nvim
Modern Neovim configuration based on LazyVim starter with custom plugins and LSP setup. Includes comprehensive language support and IDE-like features.

### git
Git configuration with helpful aliases (e.g., `olog`, `sb` for branch switching with fzf), sensible defaults for diff/merge, and automatic remote tracking. Uses histogram diff algorithm and enables rerere for conflict resolution.

**Important Config:**
- Default branch: `main`
- Auto-setup remote: enabled
- Pull strategy: fast-forward only
- Fetch: auto-prune enabled

### starship
Cross-shell prompt with custom Catppuccin Mocha theme. Displays git status, cloud context (AWS/Kubernetes), language versions (Go, Node, Java, Python), and command duration with notifications for long-running commands (>45s).

### ghostty
Modern GPU-accelerated terminal emulator configuration.

**Important Config:**
- Font: Monaspace Argon NF (size 14, thickened) (Might have to be installed separately)
- Theme: Nvim Dark
- Ligatures: disabled
- Global keybind: `Cmd+\`` for quick terminal toggle

### mise
Development tool version manager (formerly rtx). Manages runtime versions for multiple languages and CLI tools.

**Managed Tools:**
- Core: fd, fzf, neovim, starship, usage
- Containers: docker-cli, docker-compose
- Python: uv
- Cloud: awscli, gcloud, aws-sso
- Kubernetes: kubectl, k9s
- Development: github-cli, claude-code

**Important Config:**
- AWS CLI symlink bins enabled
- Docker default platform: linux/arm64
- Custom claude-code installation from Anthropic's distribution

### gh
GitHub CLI configuration with git protocol set to HTTPS and custom aliases.

**Aliases:**
- `co`: shorthand for `pr checkout`

### gcloud
Google Cloud SDK configuration directory.

### aws-sso
AWS SSO CLI configuration for managing multiple AWS accounts and profiles.

## Files Requiring Symlinks

The following files need to be symlinked from this repository to their expected locations in your home directory:

```bash
ln -s ~/.config/.zshrc ~/.zshrc
ln -s ~/.config/.vimrc ~/.vimrc
ln -s ~/.config/starship.toml ~/.config/starship.toml
ln -s ~/.config/git/.gitconfig ~/.gitconfig
```

## Excluded from Version Control

The following directories contain sensitive or machine-specific data and are excluded via `.gitignore`:

- `zsh/datahub/` - Project-specific shell configurations
- `raycast/` - Personal Raycast settings
- `jgit/` - JGit cache and credentials
- `AWSVPNClient/` - VPN connection profiles
- `aws-sso/` - AWS SSO session data
- `gcloud/` - Google Cloud credentials and state
- `gh/` - GitHub CLI authentication tokens

## Setup

1. Clone this repository to `~/.config`
2. Install mise: `curl https://mise.run | sh`
3. Run `mise install` to install all tools
4. Create necessary symlinks (see above)
5. Restart your shell or source `~/.zshrc`
