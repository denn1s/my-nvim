# Neovim Configuration - Claude Code Context

This file provides context for Claude Code when working on this Neovim configuration.

## Project Overview

This is a personal Neovim configuration for development work, primarily focused on:
- Rust development
- Go development
- TypeScript/JavaScript development
- C/C++ development
- General text editing and navigation

## Key Architecture Decisions

### Plugin Management
- **Plugin Manager**: lazy.nvim
- **Plugins defined in**: `lua/plugins.lua`
- **Plugin configs in**: `lua/plugin_config/` directory
- **Config loaded via**: `lua/plugin_config/init.lua`

### LSP Configuration (IMPORTANT)
- **Neovim Version**: 0.11.4
- **API Used**: New `vim.lsp.config` API (NOT the deprecated `lspconfig.setup()`)
- **Location**: `lua/plugin_config/lsp_config.lua`
- **Migration completed**: The config has been migrated from the old lspconfig API to the new vim.lsp.config API
- **Key differences**:
  - Use `vim.lsp.config.server_name = {}` instead of `require('lspconfig').server_name.setup()`
  - Use `root_markers` instead of `root_dir` with patterns
  - Must explicitly call `vim.lsp.enable()` to activate servers
  - Capabilities use `require("cmp_nvim_lsp").default_capabilities()` directly

### Configured LSP Servers
- lua_ls (Lua)
- clangd (C/C++)
- cssls (CSS)
- jsonls (JSON)
- eslint (JavaScript/TypeScript linting)
- ts_ls (TypeScript/JavaScript)
- html (HTML)
- rust_analyzer (Rust)
- gopls (Go)

## Custom Solutions & Workarounds

### Bookmarks Plugin Display
**Issue**: The bookmarks.nvim plugin's Telescope integration shows verbose absolute paths by default.

**Solution**: Custom wrapper function in `lua/plugin_config/telescope.lua`
- Function: `custom_bookmarks_list()`
- Shows paths relative to project directory (e.g., `src/main.rs` instead of `/home/dennis/Dev/project/src/main.rs`)
- Falls back to filename only for files outside the project
- Exported from the telescope module for use in bookmarks keybindings

**Important**: The custom function bypasses the plugin's built-in entry_maker because it's not overrideable. Any plugin updates won't affect our custom display logic.

### Bookmarks Storage
- **Per-project storage**: Bookmarks are saved per-project in `~/.local/share/nvim/nvim_bookmarks/`
- **Filename format**: Current working directory path with slashes replaced by underscores
- **Directory creation**: Handled on-demand via wrapper functions

## Key Keybindings

### Bookmarks (prefix: `b`)
- `bb` - Toggle bookmark
- `ba` - Add/edit bookmark annotation
- `bo` / `bl` - Show bookmarks (uses custom picker)
- `bc` - Clear all bookmarks
- `bx` - Delete bookmark at line
- `bp` - Previous bookmark
- `bn` - Next bookmark

### Telescope
- `<C-p>` - Find files
- `<C-h>` - Old files
- `<C-g>` - Live grep
- `<C-l>` - Commands
- `<C-a>` - LSP document symbols

### LSP (via Lspsaga)
- `K` - Hover documentation
- `<leader>.` - Code actions
- `<leader>P` - Peek definition
- `<leader>p` - Peek type definition
- `<leader>i` - Find references/implementations
- `<leader>rn` - Rename
- `<leader>e` - Show buffer diagnostics
- `<leader>o` - Outline
- `<leader>g` - Go to definition

### Buffer Management
- `<Space><Space>` - Arena buffer picker

## File Structure

```
~/.config/nvim/
├── init.lua                      # Main entry point
├── lua/
│   ├── plugins.lua              # Plugin definitions (lazy.nvim)
│   └── plugin_config/
│       ├── init.lua             # Loads all plugin configs
│       ├── lsp_config.lua       # LSP setup (vim.lsp.config API)
│       ├── telescope.lua        # Telescope + custom bookmarks picker
│       ├── bookmarks.lua        # Bookmarks plugin + keybindings
│       └── [other configs]
└── CLAUDE.md                    # This file
```

## Common Patterns

### Adding a New LSP Server
1. Add server to mason-lspconfig's `ensure_installed` list
2. Define config using `vim.lsp.config.server_name = {}`
3. Include required fields: `cmd`, `filetypes`, `root_markers`
4. Add server name to the `vim.lsp.enable()` call
5. Test and commit

### Modifying Telescope Pickers
- Default settings in `require('telescope').setup({ defaults = {} })`
- Per-picker settings in `pickers = { picker_name = {} }`
- Extension settings in `extensions = { extension_name = {} }`
- Custom pickers can be created and exported from the module

### Plugin Updates Consideration
- Some plugins may overwrite customizations on update
- The bookmarks custom picker is update-proof (separate wrapper)
- Check git diff after plugin updates to catch any config conflicts

## Development Preferences

- **Language**: Primarily Rust, Go, TypeScript/JavaScript, C/C++
- **Lua usage**: Minimal, mainly for Neovim config and simple scripts
- **Commit style**: Conventional commits with detailed descriptions
- **Path display preference**: Relative paths from project root

## Known Issues & Solutions

### Lua LSP Data Conversion Error (RESOLVED)
- **Error**: "Invalid 'data': Cannot convert given Lua table"
- **Cause**: Workspace library configuration with boolean-keyed tables
- **Solution**: Use `vim.api.nvim_get_runtime_file("", true)` instead of manual paths

## Tips for Future Sessions

1. **Before modifying LSP config**: Remember we're on Neovim 0.11+ using the new API
2. **Before modifying plugins**: Check if there's already a custom solution in place
3. **When adding features**: Consider update-proofing (custom wrappers vs. direct modification)
4. **Git commits**: Separate feature commits from refactoring commits
5. **Testing changes**: User prefers to test before committing, especially for large changes
