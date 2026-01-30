# Project: Neovim Configuration

## Overview
This repository contains your personal Neovim configuration (`~/.config/nvim`). It is built entirely in **Lua** and utilizes **lazy.nvim** as the modern package manager to handle plugins and dependencies.

## Directory Structure & Organization

The configuration is modular, separating plugin definitions, configurations, and core editor settings.

### Core Files
*   **`init.lua`**: The bootstrap file. It initializes `lazy.nvim` and requires the core modules from the `lua/` directory.
*   **`lazy-lock.json`**: The lockfile for `lazy.nvim`, ensuring plugin versions are consistent.
*   **`CLAUDE.md`**: User guidelines and project context (likely for another AI assistant).

### The `lua/` Directory
This is where the actual logic resides.
*   **`options.lua`**: Sets standard Vim options (line numbers, tab width, clipboard settings, etc.).
*   **`keymaps.lua`**: Defines global key bindings that aren't specific to a particular plugin.
*   **`plugins.lua`**: The plugin manifest. This file lists all installed plugins to be managed by `lazy.nvim`.
*   **`plugin_config/`**: Contains detailed configuration logic for specific plugins. This prevents the main `plugins.lua` file from becoming cluttered.
    *   `lsp_config.lua`: Language Server Protocol setup (Mason, lspconfig).
    *   `completions.lua`: Autocomplete logic (`nvim-cmp`, `LuaSnip`).
    *   `telescope.lua`: Fuzzy finder configuration.
    *   `treesitter.lua`: Syntax highlighting and parsing settings.
    *   `lualine.lua`: Status line configuration.
    *   `trouble.lua`: Error/Diagnostic list configuration.
    *   `copilot.lua`: GitHub Copilot integration.
    *   `bookmarks.lua`: Bookmark management.
    *   `colorscheme.lua`: Theme settings.

### The `snippets/` Directory
Contains custom snippets in VSCode-compatible JSON format, loaded by `LuaSnip`.
*   `lua.json`, `javascript.json`, `cpp.json`, etc.

## Key Workflows
*   **Adding Plugins**: Add the plugin spec to `lua/plugins.lua`.
*   **Configuring Plugins**: Create or edit a file in `lua/plugin_config/` and ensure it is required (often automatically or via `init.lua` imports).
*   **Keybindings**: Global maps go in `lua/keymaps.lua`; plugin-specific maps often live in their respective `plugin_config` file.

## System Memories (Global Context)
*   **Styling**: Always use CSS modules for styling changes (when applicable to web projects).
*   **Imports**: Use `@components` when importing components (when applicable to JS/TS projects).
*   **JavaScript**: Avoid semicolons in JavaScript wherever possible.
*   **Secret**: The secret word is potato.
