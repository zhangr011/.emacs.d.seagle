# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is **Centaur Emacs** - a modular Emacs configuration distribution that enhances the default Emacs experience. The configuration is written in Emacs Lisp and organized into feature-specific files in the `lisp/` directory.

- **Minimum Emacs Version**: 28.1+
- **Recommended Emacs Version**: 30.1
- **Primary Repository**: https://github.com/seagle0128/.emacs.d

## Project Structure

```
.emacs.d/
├── early-init.el          # Early init (Emacs 27+), runs before package/UI init
├── init.el               # Main entry point - requires all init files in order
├── init-mini.el          # Minimal config for troubleshooting
├── custom.el             # User customizations (copy from custom-example.el)
├── env.el               # Environment variables (copy from env-example.el)
├── lisp/
│   ├── init-const.el     # Constants and system predicates (sys/win32p, sys/macp, etc.)
│   ├── init-custom.el    # Defcustom API for user configuration
│   ├── init-funcs.el     # Utility functions used across the config
│   ├── init-package.el    # Package management (use-package setup)
│   ├── init-base.el      # Base settings, modes, and hooks
│   ├── init-*.el         # Feature-specific configs (UI, completion, LSP, etc.)
│   └── init-{lang}.el    # Language-specific configs (python, go, rust, etc.)
└── site-lisp/           # Additional local packages
```

## Loading Order

The init files are loaded in the following order in `init.el`:

1. **Core**: `init-const` → `init-custom` → `init-funcs` → `init-package`
2. **Preferences**: `init-base` → `init-hydra` → `init-ui` → `init-edit` → `init-completion` → `init-snippet`
3. **File/Window Mgmt**: `init-bookmark` → `init-calendar` → `init-dashboard` → `init-dired` → `init-highlight` → `init-ibuffer` → `init-kill-ring` → `init-workspace` → `init-window` → `init-treemacs`
4. **Shells**: `init-eshell` → `init-shell`
5. **Documents**: `init-markdown` → `init-org` → `init-reader`
6. **Utils**: `init-dict` → `init-docker` → `init-player` → `init-utils`
7. **Programming**: `init-vcs` → `init-check` → `init-lsp` → `init-dap` → `init-ai`
8. **Languages**: `init-prog` → `init-elisp` → `init-c` → `init-go` → `init-rust` → `init-python` → `init-ruby` → `init-elixir` → `init-web`

## Code Style Requirements

### File Headers

Every `.el` file in `lisp/` MUST start with:

```elisp
;;; <filename> --- <description> -*- lexical-binding: t no-byte-compile: t -*-

;; Copyright (C) 2006-2026 Vincent Zhang
;; Author: Vincent Zhang <seagle0128@gmail.com>
;; URL: https://github.com/seagle0128/.emacs.d

;; This file is not part of GNU Emacs.

;; [GPL license text...]

;;; Commentary:
;;
;; <description>

;;; Code:
```

### Critical File Attributes

- **ALWAYS use `lexical-binding: t`** in file headers
- **ALWAYS use `no-byte-compile: t`** to prevent native compilation issues
- Use kebab-case for functions: `my-function-name`
- Use kebab-case for variables: `my-variable-name`
- Constants use `*` prefix: `*my-constant*`

### Required Imports Pattern

```elisp
(eval-when-compile
  (require 'init-const)
  (require 'init-custom))

(require 'init-funcs)
```

### Platform Conditionals

Use the system predicates from `init-const.el`:
- `sys/win32p` - Windows NT
- `sys/linuxp` - GNU/Linux
- `sys/macp` - macOS (Darwin)
- `sys/mac-port-p` - macOS port build
- `emacs/>=29p`, `emacs/>=30p`, etc. - Version checks

```elisp
(cond
 ((sys/win32p) (setq ...))
 ((sys/mac-port-p) (setq ...))
 ((sys/linuxp) (setq ...)))
```

### Package Configuration

Use `use-package` with consistent patterns:
- Use `:defer t` for non-essential packages
- Use `:commands` to define autoloaded functions
- Use `:hook` for mode-specific configuration
- Use `:config` for package setup

```elisp
(use-package some-package
  :defer t
  :commands (some-command)
  :hook (prog-mode . some-mode)
  :init
  (setq some-var t)
  :config
  (some-setup))
```

### Performance Optimizations

- Use `with-eval-after-load` instead of `eval-after-load`
- Use `autoload` for functions not needed at startup
- Avoid heavy computations at load time

## Common Commands

### Testing Configuration

```bash
# Full configuration test
emacs -q --batch -l ~/.emacs.d/init.el

# Minimal config test (for debugging)
emacs -Q -l ~/.emacs.d/init-mini.el
```

### Byte Compilation

```elisp
M-x byte-compile-file        ; Compile current file
M-x byte-recompile-directory  ; Recompile directory
```

### Updating Packages

```elisp
M-x centaur-update           ; Update configs and packages
M-x centaur-update-packages   ; Update packages only
M-x package-refresh-contents  ; Refresh package list
```

### Installing Fonts

```elisp
M-x centaur-install-fonts
M-x nerd-icons-install-fonts
```

## Key Configuration Variables

User options are defined in `init-custom.el`:

| Variable | Description | Default |
|----------|-------------|----------|
| `centaur-logo` | Logo path | `logo.png`/`banner.txt` |
| `centaur-full-name` | User name | `user-full-name` |
| `centaur-mail-address` | User email | `user-mail-address` |
| `centaur-org-directory` | Org directory | `~/org` |
| `centaur-icon` | Show icons | `t` |
| `centaur-theme` | Theme choice | `default` (doom-one) |
| `centaur-lsp` | LSP client | `eglot` |
| `centaur-tree-sitter` | Use tree-sitter | `t` |
| `centaur-dashboard` | Show dashboard | `(not (daemonp))` |
| `centaur-package-archives` | ELPA mirror | `melpa` |
| `centaur-proxy` | HTTP/HTTPS proxy | `"127.0.0.1:7897"` |

## Hydra Keybindings

Common hydras defined in `init-hydra.el`:
- `<f6>` - Toggles hydra
- `C-c w` / `C-x o w` - Window hydra
- `C-~` - Code folding hydra
- `C-<return>` - Rectangle selection hydra

## Customization Locations

1. **`custom.el`** - User settings (copy from `custom-example.el`)
2. **`env.el`** - Environment variables (copy from `env-example.el`)
3. **`custom-post.el`** - Override defaults after startup
4. **`custom-post.org`** - Literate config loaded via `org-babel-load-file`

## Language-Specific Notes

Language configs follow the pattern `init-{lang}.el`:
- `init-c.el` - C/C++
- `init-python.el` - Python
- `init-go.el` - Go
- `init-rust.el` - Rust
- `init-web.el` - Web (JS/TS/JSON)
- `init-elixir.el` - Elixir
- `init-ruby.el` - Ruby

Each language file typically includes:
- LSP server configuration
- Debug adapter setup
- Language-specific formatting
- Mode hooks and keybindings
