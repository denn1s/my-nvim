# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a personal Neovim configuration for development work, primarily focused on:
- Rust development
- Go development
- TypeScript/JavaScript development
- C/C++ development
- General text editing and navigation

### Important Editor Settings (options.lua)
- **Leader key**: `<Space>`
- **Tabs**: 2 spaces, expanded
- **Line numbers**: Relative + absolute
- **No swap files**: Disabled for cleaner workflow
- **Scrolloff**: 10 lines of context
- **Folding**: Indent-based, level 99 (all open by default)
- **Clipboard**: NOT synced with system (explicit `y` mappings handle this)

## Key Architecture Decisions

### Initialization Flow
1. `init.lua` loads in order:
   - `options.lua` - Editor settings (tabs, line numbers, folding, etc.)
   - `keymaps.lua` - Base keybindings (navigation, editing, buffers)
   - `plugins.lua` - Plugin declarations via lazy.nvim
   - `plugin_config/init.lua` - Plugin configurations
2. Additional init.lua setup:
   - Notification filters (offset encoding warnings)
   - Diagnostic configuration (virtual text disabled)
   - Autocmds (highlight on yank, DiagnosticUnnecessary styling, node_modules diagnostics)

### Plugin Management
- **Plugin Manager**: lazy.nvim (auto-installed if missing)
- **Plugins defined in**: `lua/plugins.lua`
- **Plugin configs in**: `lua/plugin_config/` directory
- **Config loaded via**: `lua/plugin_config/init.lua` (sequential requires)
- **Lazy-loading strategy**: Some plugins use `ft`, `event`, or `cmd` for performance

### Major Plugins by Category
**Language Support:**
- nvim-treesitter - Syntax highlighting and code understanding
- vim-go - Go development (`ft = "go"`, auto-updates binaries)
- nvim-lspconfig + mason.nvim - LSP infrastructure

**Completion & Snippets:**
- nvim-cmp - Completion engine with multiple sources
- LuaSnip - Snippet engine
- nvim-scissors - Visual snippet editing
- lspkind.nvim - VSCode-like completion pictograms

**UI & Navigation:**
- telescope.nvim - Fuzzy finder (files, grep, commands, LSP symbols)
- lspsaga.nvim - Enhanced LSP UI (hover, code actions, finder, outline)
- arena.nvim - Frecency-based buffer management
- bookmarks.nvim - Per-project bookmarks
- lualine.nvim - Status line
- github-nvim-theme - Color scheme

**Editor Enhancement:**
- flash.nvim - Enhanced f/t navigation with labels
- treesj - Smart split/join for code blocks
- nvim-autopairs - Auto-closing brackets
- rip-substitute - Better find/replace with preview
- vim-commentary - Easy commenting

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
All servers auto-installed via mason and enabled via `vim.lsp.enable()`:
- **lua_ls** (Lua) - Neovim runtime integration
- **clangd** (C/C++) - Background indexing, clang-tidy, iwyu
- **cssls** (CSS) - Unknown at-rules ignored
- **jsonls** (JSON) - Schema validation for common config files
- **eslint** (JS/TS linting) - Format on type
- **ts_ls** (TypeScript/JavaScript) - Inlay hints for parameters
- **html** (HTML) - Also handles templ files
- **rust_analyzer** (Rust) - Clippy checks, some diagnostics filtered
- **gopls** (Go) - gofumpt, integration test tags, extensive hints

## Custom Solutions & Workarounds

### Bookmarks Plugin Display
**Issue**: The bookmarks.nvim plugin's Telescope integration shows verbose absolute paths by default.

**Solution**: Custom wrapper function in `lua/plugin_config/telescope.lua:38-121`
- Function: `custom_bookmarks_list()`
- Shows paths relative to project directory (e.g., `src/main.rs` instead of `/home/dennis/Dev/project/src/main.rs`)
- Falls back to filename only for files outside the project
- Exported from the telescope module for use in bookmarks keybindings
- Custom entry_maker with 3-column display: line number | annotation text | relative path

**Important**: The custom function bypasses the plugin's built-in entry_maker because it's not overrideable. Plugin updates won't affect our custom display logic.

### Bookmarks Storage Architecture
- **Per-project storage**: Bookmarks saved in `~/.local/share/nvim/nvim_bookmarks/<cwd_with_underscores>.json`
- **Directory creation**: On-demand via `ensure_dir_and_run()` wrapper in `bookmarks.lua:60-66`
- **Reasoning**: Prevents errors when bookmark directory doesn't exist; allows lazy initialization

### Diagnostic Configuration
- **Virtual text disabled**: Diagnostics shown only via LSP keybindings, not inline (init.lua:15-17)
- **DiagnosticUnnecessary styling**: Overridden to prevent rust-analyzer from graying out entire files (init.lua:21-28)
- **node_modules diagnostics**: Disabled via autocommand (init.lua:35)

### Editor Notification Filters
- **Offset encoding warnings**: Filtered out to reduce noise (init.lua:6-13)
- **Reason**: Multiple LSP servers with different offset encodings (utf-8 vs utf-16) cause harmless warnings

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

### Buffer Management (Arena)
- `<Space><Space>` - Arena buffer picker (frecency-based)
- `x` (in arena) - Remove buffer from arena
- `<esc>` (in arena) - Close arena window

### Editing & Navigation
- `<Tab>` / `<S-Tab>` - Indent/unindent (normal/visual mode)
- `<C-s>` - Save file (normal/insert mode)
- `<C-d>` - Duplicate line/selection
- `<A-Up>` / `<A-Down>` - Move lines up/down
- `<A-o>` / `<A-S-o>` - Open new line above/below without entering insert
- `<C-Left>` / `<C-Right>` - Move by words
- `<C-Up>` / `<C-Down>` - Move by paragraphs
- `<C-S-Up>` / `<C-S-Down>` - Move by functions
- `<A-Left>` / `<A-Right>` - Navigate buffers
- `y` - Copy to system clipboard (normal/visual)
- `s` / `S` - Flash jump (forward/backward)
- `<C-S-r>` - Rip substitute (better find/replace)

### Code Manipulation
- `<leader>b` - Toggle split/join code blocks (treesj)
- `<leader>B` - Recursive split/join

### Snippets
- `<leader>se` - Edit snippet
- `<leader>sa` - Add new snippet
- `<C-n>` / `<C-N>` - Jump to next/previous snippet placeholder

### Completion (nvim-cmp)
- `<C-j>` / `<C-k>` - Navigate completion items
- `<Tab>` / `<S-Tab>` - Navigate items (when visible)
- `<CR>` - Confirm selected item
- `<C-s>` - Confirm with autoselect

## File Structure

```
~/.config/nvim/
├── init.lua                      # Entry point: loads options, keymaps, plugins, plugin configs
├── lua/
│   ├── options.lua              # Vim options and global settings
│   ├── keymaps.lua              # Base keybindings (navigation, editing, buffers)
│   ├── plugins.lua              # Plugin declarations via lazy.nvim
│   └── plugin_config/
│       ├── init.lua             # Loads all plugin configs
│       ├── lsp_config.lua       # LSP setup (mason, lspsaga, vim.lsp.config)
│       ├── telescope.lua        # Telescope + arena + custom bookmarks picker
│       ├── bookmarks.lua        # Bookmarks plugin + keybindings
│       ├── completions.lua      # nvim-cmp + LuaSnip configuration
│       ├── other.lua            # treesj, flash.nvim, rip-substitute configs
│       ├── colorscheme.lua      # Theme configuration
│       ├── lualine.lua          # Status line configuration
│       ├── treesitter.lua       # Treesitter syntax highlighting
│       └── [others]
├── snippets/                     # LuaSnip snippets directory
└── CLAUDE.md                    # This file
```

## Common Patterns & Workflows

### Adding a New LSP Server
1. Add server to mason-lspconfig's `ensure_installed` list in `lsp_config.lua:3-13`
2. Define config using `vim.lsp.config.server_name = {}` following existing patterns
3. Include required fields: `cmd`, `filetypes`, `root_markers`, `capabilities`, `on_attach`
4. Add server name to the servers table and loop at `lsp_config.lua:317-323`
5. Consider adding server-specific settings in the `settings = {}` block
6. Test and commit

### LSP Configuration Structure
All LSP servers follow this pattern:
```lua
vim.lsp.config.server_name = {
  cmd = { "server-binary", "args" },
  filetypes = { "filetype1", "filetype2" },
  root_markers = { "marker-file", ".git" },
  capabilities = capabilities,  -- Shared nvim-cmp capabilities
  on_attach = on_attach,        -- Standard attach function
  settings = {
    -- Server-specific settings
  },
}
```

### Modifying Telescope Pickers
- Default settings in `telescope.lua:4-20`
- Per-picker settings in `pickers = {}` section
- Extension settings in `extensions = {}` section
- Custom pickers: Create function and export at module bottom (see `custom_bookmarks_list`)

### Adding Keybindings
- **Global editor keybindings**: Add to `lua/keymaps.lua`
- **Plugin-specific keybindings**: Add to respective `plugin_config/<name>.lua` file
- **LSP keybindings**: Add to `plugin_config/lsp_config.lua:68-84` (uses lspsaga commands)
- **Pattern**: Use descriptive `desc` field for documentation

### Plugin Configuration Workflow
1. Add plugin declaration to `lua/plugins.lua` (with lazy-loading if appropriate)
2. Create config file in `lua/plugin_config/<name>.lua`
3. Require the config in `lua/plugin_config/init.lua`
4. Test functionality
5. Commit with descriptive message

### Update Considerations
- Bookmarks custom picker is update-proof (separate wrapper function)
- Check git diff after plugin updates to catch config conflicts
- The `vim.lsp.config` API is forward-compatible (Neovim 0.11+)

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

## Key Plugin Features & Usage

### Arena (Buffer Management)
- Frecency-based buffer picker (frequency + recency algorithm)
- `always_context` files: `mod.rs`, `init.lua`, `CMakeLists.txt`, `index.html` show parent folder
- `ignore_current = true`: Hides current buffer from list
- Configurable at `telescope.lua:144-197`

### Flash.nvim (Navigation)
- Enhanced f/F/t/T motions with labels
- Treesitter-based selection in operator-pending mode
- Single-window mode (no multi-window jumping)
- Operator remotes: `r`/`R` for remote operations, `s`/`S` for treesitter selections

### Treesj (Code Manipulation)
- Smart split/join for code blocks (arrays, objects, function params, etc.)
- Language-aware using treesitter
- Recursive mode via `<leader>B`
- Max join length: 120 characters

### Rip-substitute
- Better find/replace with incremental preview
- Supports PCRE2 regex (disabled by default for performance)
- Range backdrop during preview (10% blend)
- History navigation with Up/Down arrows

### LuaSnip & Scissors
- Snippets stored in `/home/dennis/.config/nvim/snippets`
- Visual snippet editing via scissors plugin
- Jump between placeholders with `<C-n>` / `<C-N>`

### Completion Sources Priority (nvim-cmp)
1. calc (2000) - Math calculations
2. luasnip (1500) - Snippets
3. nvim_lsp (1000) - LSP completions
4. buffer (500) - Buffer text
5. path (300) - File paths

## Critical Implementation Details

### Completion Behavior
- `preselect = cmp.PreselectMode.None`: Don't autoselect first item
- `<CR>` confirms only if item is explicitly selected
- `<C-s>` confirms with autoselect
- Tab/Shift-Tab for navigation when popup visible
- Custom `has_words_before()` check prevents unnecessary completions

### LSP Capabilities
- Uses `cmp_nvim_lsp.default_capabilities()` for completion support
- `offsetEncoding = { "utf-16", "utf-8" }` for compatibility with multiple servers
- Shared across all LSP servers for consistency

### Language-Specific LSP Settings
- **rust_analyzer**: Clippy on save, some diagnostics disabled (unresolved-module, unresolved-import, unlinked-file)
- **gopls**: gofumpt formatting, integration test tags (`-tags=integration`), extensive inlay hints
- **ts_ls**: Inlay hints for parameters and types
- **jsonls**: Schema validation for package.json, tsconfig.json, eslintrc, etc.
- **clangd**: Background indexing, clang-tidy integration, iwyu header insertion

## Tips for Future Sessions

1. **Before modifying LSP config**: Remember we're on Neovim 0.11+ using the new `vim.lsp.config` API (NOT lspconfig)
2. **Before modifying plugins**: Check if there's already a custom solution in place (search CLAUDE.md)
3. **When adding features**: Consider update-proofing (custom wrappers vs. direct modification)
4. **Git commits**: Separate feature commits from refactoring commits
5. **Testing changes**: User prefers to test before committing, especially for large changes
6. **Keybinding conflicts**: Check `keymaps.lua` before adding new global bindings
7. **Plugin lazy-loading**: Consider `ft`, `event`, or `cmd` for performance
