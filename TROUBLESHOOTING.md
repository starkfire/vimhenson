# Troubleshooting

## [Windows] nvim crashes when opening Telescope and/or when Treesitter parsers are activated

On Windows, Treesitter parsers and telescope-fzf-native must be compiled with toolchains like MSVC or MSYS MinGW.

One way to know if your parsers are compiled using other toolchains like Cygwin would be to run `objdump` on a treesitter parser. For example:

```powershell
# treesitter parsers
objdump -p "$env:LOCALAPPDATA\nvim-data\lazy\nvim-treesitter\parser\markdown.so"

# telescope-fzf-native
objdump -p "$env:LOCALAPPDATA\nvim-data\lazy\telescope-fzf-native.nvim\build\libfzf.dll"
```

If you already have toolchains like MSYS but parsers are not being compiled with MinGW, you may need to install MinGW and update your `PATH`:

```powershell
C:\msys64\usr\bin\pacman.exe -S mingw-w64-ucrt-x86_64-gcc mingw-w64-ucrt-x86_64-make
$env:PATH = "C:\msys64\ucrt64\bin;$env:PATH"

where.exe gcc
gcc --version
```

`cc`, `gcc`, `make`, and/or `cmake` should now point to binaries provided by MinGW. Once that is done, you may reinstall the parsers and telescope-fzf-native:

```
nvim
:TSUninstall all
:TSInstall
:Lazy build telescope-fzf-native.nvim
```

## LSP

### Go

You will need to install [Go](https://go.dev/doc/install) for `gopls` to work.

### Elixir & Gleam

[Gleam](https://gleam.run/) requires [installing Gleam](https://gleam.run/install/).

One easy way to install Gleam would be to use [asdf](https://asdf-vm.com/):

```sh
asdf plugin add erlang https://github.com/asdf-vm/asdf-erlang.git
asdf plugin add rebar https://github.com/Stratus3D/asdf-rebar.git
asdf plugin add gleam https://github.com/vic/asdf-gleam.git

asdf set -u erlang latest
asdf set -u rebar latest
asdf set -u gleam latest

asdf install
```

Then run:

```
asdf exec gleam -V
```

You may also install Elixir in the same manner:

```sh
asdf plugin add elixir https://github.com/asdf-vm/asdf-elixir.git

# install the version compatible with your current Erlang/OTP version.
asdf install elixir 1.19.5
```

This project is also configured to link `asdf` to Neovim (see `init.lua`). The `~/.asdf/shims` directory needs to exist for nvim-lspconfig to be able to resolve `gleam` through `asdf` (and subsequently `gleam lsp`).

If Elixir fails to load when running `asdf exec elixir`, see [this issue comment](https://github.com/asdf-vm/asdf-erlang/issues/319#issuecomment-2746127824).

### Haskell

You need to install Haskell, preferably through [GHCup](https://www.haskell.org/ghcup/):

```sh
curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh
```

You may opt out by removing `hls` from `lua/plugins/lsp.lua`.

### Python

This configuration may not work well in **Windows** environments when using pyenv-win. See this [issue](https://github.com/williamboman/mason.nvim/issues/1753]).

### Rust

If `rust_analyzer` is not being detected, you can try to check for the `~/.local/state/nvim/lsp.log` file for the following error:

```
"error: Unknown binary 'rust-analyzer' in official toolchain 'stable-x86_64-unknown-linux-gnu'.\n"
```

In this case, if you have already pre-installed Cargo and `rustc`, you need to manually retrieve the standard library sources:

```sh
rustup component add rust-analyzer
```

### Nim

You need to install [nimlangserver](https://github.com/nim-lang/langserver) using the `nimble` package manager:

```sh
nimble install nimlangserver
```

In some cases, this may fail because some package repositories provide outdated versions of Nim. In this case, you may use [choosenim](https://github.com/dom96/choosenim) to install Nim.

### TypeScript

You will need the `typescript-language-server` and `typescript` packages globally installed:

```sh
npm install -g typescript-language-server typescript
```

### Volar

By default, this configuration uses Volar's default Hybrid Mode.

To use Volar, you will need to install `@vue/language-server` globally:

```sh
npm install -g @vue/language-server
```

You may also need to set up `@vue/typescript-plugin`:

```sh
npm install -g @vue/typescript-plugin
```

If Volar fails to run whenever Vue files are being opened, you can check out this [issue](https://github.com/vuejs/language-tools/issues/4706).


