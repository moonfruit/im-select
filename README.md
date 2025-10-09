# im-select

A command-line tool for switching and querying input methods on macOS, written in Swift.

This is a Swift implementation of [daipeihust/im-select](https://github.com/daipeihust/im-select).

## Features

- Query current input method
- Switch to a specified input method

## Build

### Using Make (Recommended)

Build the optimized release binary:

```bash
make
```

Build debug binary with symbols:

```bash
make debug
```

Install to `/usr/local/bin`:

```bash
make install
```

Clean build artifacts:

```bash
make clean
```

View all available targets:

```bash
make help
```

### Using Swift Compiler Directly

Compile using the Swift compiler:

```bash
swiftc main.swift -o im-select
```

Or compile with optimization:

```bash
swiftc -O main.swift -o im-select
```

## Usage

### Query Current Input Method

Run without arguments to output the current input method ID:

```bash
./im-select
```

Example output:
```
com.apple.keylayout.ABC
```

### Switch Input Method

Pass an input method ID as an argument to switch to the specified input method:

```bash
./im-select com.apple.keylayout.ABC
```

## Common Input Method IDs

Common input method IDs on macOS:

- `com.apple.keylayout.ABC` - English ABC keyboard
- `com.apple.inputmethod.SCIM.ITABC` - Simplified Chinese Pinyin

You can run `im-select` without arguments to see the complete ID of your current input method.

## Typical Use Cases

### Auto-switch Input Method in Vim/Neovim

Automatically switch input methods when transitioning between edit mode and normal mode, avoiding accidental Chinese input in normal mode.

#### Vim

```vim
" Automatically switch to English input method when leaving insert mode
autocmd InsertLeave * :silent !/path/to/im-select com.apple.keylayout.ABC
```

#### Neovim

Use with plugins like [im-select.nvim](https://github.com/keaising/im-select.nvim):

```lua
require('im_select').setup({
  default_im_select = 'com.apple.keylayout.ABC',
  default_command = '/path/to/im-select',
})
```

#### VSCodeVim

Configure in VSCode's `settings.json` to auto-switch input methods when using [VSCodeVim](https://marketplace.visualstudio.com/items?itemName=vscodevim.vim):

```json
{
  "vim.autoSwitchInputMethod.enable": true,
  "vim.autoSwitchInputMethod.defaultIM": "com.apple.keylayout.ABC",
  "vim.autoSwitchInputMethod.obtainIMCmd": "/path/to/im-select",
  "vim.autoSwitchInputMethod.switchIMCmd": "/path/to/im-select {im}"
}
```

## Technical Implementation

This tool uses macOS Text Input Services API:

- `TISCopyCurrentKeyboardInputSource()` - Get current input method
- `TISCreateInputSourceList()` - Find specified input method
- `TISSelectInputSource()` - Switch input method
- `TISGetInputSourceProperty()` - Get input method properties

## Why Choose the Swift Version?

Compared to the original C++ implementation, the Swift version offers:

- **More Concise Code**: Swift language features make the code more readable and maintainable
- **Better Safety**: Swift's memory management and type system provide better safety
- **Native Support**: Swift is Apple's official language, integrating more naturally with macOS APIs
- **No Extra Dependencies**: Directly uses system frameworks without third-party libraries

## License

MIT License

## Related Projects

- [daipeihust/im-select](https://github.com/daipeihust/im-select) - Original C++ implementation
- [im-select.nvim](https://github.com/keaising/im-select.nvim) - Neovim input method auto-switching plugin

## Contributing

Issues and Pull Requests are welcome!
