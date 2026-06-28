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
- Core: fd, fzf, neovim, starship, usage, hl (log viewer), hunk (diff tool)
- Containers: docker-cli, docker-compose
- Languages: go, node
- Python: uv
- Cloud: awscli, gcloud, aws-sso
- Kubernetes: kubectl, k9s, helm, argocd, kubectx, kubens
- Development: github-cli, claude-code, pre-commit, herdr, acryl-datahub (pipx)
- Security: 1password-cli, sops, cosign

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

### gh-dash
Terminal dashboard for GitHub PRs and notifications. Configures custom PR sections (my open PRs, approved-to-merge, needs review, failing checks, team review), notification views, repo paths for `acryldata`/`datahub-project`, and uses `diffnav` as its diff pager.

### diffnav
TUI diff viewer used as a pager (e.g. by gh-dash and git). Configured for side-by-side view with diff stats, nerd-font icons, and a 30-column file tree.

### herdr
Terminal multiplexer / agent runner. Only `herdr/config.toml` is tracked (runtime state, logs, and plugins are gitignored). Uses the Catppuccin theme with auto light/dark switching and defines worktrunk plugin keybindings (`prefix+shift+g` to switch/create a worktree, `prefix+shift+d` to remove one).

### worktrunk
Git worktree manager. Worktrees are created under `~/datahub/repos/worktrees/`. Post-create hooks copy machine-local files into new worktrees (`.mise.local.toml`, `.netrc`, `.vscode`, `.claude`) and trust mise; a pre-remove hook preserves `.claude/plans` back to the primary worktree.

## Files Requiring Symlinks

The following files need to be symlinked from this repository to their expected locations in your home directory:

```bash
ln -s ~/.config/.zshrc ~/.zshrc
ln -s ~/.config/.vimrc ~/.vimrc
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
- `argocd/` - ArgoCD CLI credentials and context
- `observe.yaml` - Observe CLI configuration
- `mise/config.local.toml` - Machine-local mise tool overrides
- `herdr/` - herdr runtime state, logs, and plugins (only `herdr/config.toml` is tracked)
- `hunk/state.json` - hunk local state

## Setup

- Clone this repository to `~/.config`
- Install mise: `curl https://mise.run | sh`
- Run `mise install` to install all tools
- Create necessary symlinks (see above)
- Restart your shell or source `~/.zshrc`

- It is recommended that the completion scripts are regenerated on your system for the various tools for maximum compatibility
> NOTE: Some files may have hardcoded system paths to /Users/devashish.chandra or other system paths. If something does not work as intended check and update paths.
