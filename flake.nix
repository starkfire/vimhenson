{
    description = "Nix flake for Vimhenson";
    inputs = {
        nixpkgs = {
            url = "github:NixOS/nixpkgs";
        };
    };
    outputs = { self, nixpkgs }:
        let
            systems = [
                "x86_64-linux"
                "aarch64-linux"
                "x86_64-darwin"
                "aarch64-darwin"
            ];
            
            forAllSystems = f: nixpkgs.lib.genAttrs systems (system: f system);

            pluginPackageNames = [
                "lazy-nvim"
                "nvim-treesitter-context"
                "telescope-nvim"
                "telescope-fzf-native-nvim"
                "telescope-file-browser-nvim"
                "nvim-cmp"
                "cmp-nvim-lsp"
                "cmp-buffer"
                "cmp-path"
                "cmp-cmdline"
                "cmp_luasnip"
                "luasnip"
                "friendly-snippets"
                "plenary-nvim"
                "nvim-tree-lua"
                "nvim-web-devicons"
                "trouble-nvim"
                "aerial-nvim" 
                "comment-nvim"
                "gitsigns-nvim"
                "haskell-tools-nvim"
                "indent-blankline-nvim"
                "nvim-lspconfig"
                "lualine-nvim"
                "nvim-cokeline"
                "persistence-nvim"
                "project-nvim"
                "rustaceanvim"
                "toggleterm-nvim"
                "gruvbox-material"
                "which-key-nvim"
            ];

            treesitterGrammarNames = [
                "c"
                "go"
                "html"
                "lua"
                "luadoc"
                "luap"
                "vim"
                "vimdoc"
                "query"
                "markdown"
                "markdown_inline"
                "javascript"
                "typescript"
                "tsx"
                "jsdoc"
                "python"
                "rust"
                "xml"
                "yaml"
            ];

            lspPackageNames = [
                "lua-language-server"
                "pyright"
                "clang-tools"
                "typescript-language-server"
                "typescript"
                "gopls"
                "zls"
                "elixir-ls"
                "nimlangserver"
                "nil"
                "vscode-langservers-extracted"
                "vue-language-server"
                "gleam"
                "rust-analyzer"
                "haskell-language-server"
            ];

            toolchainPackageNames = [
                "git"
                "ripgrep"
                "fd"
                "gnumake"
                "gcc"
                "tree-sitter"
                "nodejs"
                "go"
                "zig"
                "cargo"
                "rustc"
                "clippy"
                "ghc"
                "cabal-install"
                "nim"
            ];

            mkPackages =
                system:
                let
                    pkgs = import nixpkgs { inherit system; };
                    
                    lib = pkgs.lib;

                    pluginPackages = with pkgs.vimPlugins; [
                        lazy-nvim
                        nvim-treesitter-context
                        telescope-nvim
                        telescope-fzf-native-nvim
                        telescope-file-browser-nvim
                        nvim-cmp
                        cmp-nvim-lsp
                        cmp-buffer
                        cmp-path
                        cmp-cmdline
                        cmp_luasnip
                        luasnip
                        friendly-snippets
                        plenary-nvim
                        nvim-tree-lua
                        nvim-web-devicons
                        trouble-nvim
                        aerial-nvim
                        comment-nvim
                        gitsigns-nvim
                        haskell-tools-nvim
                        indent-blankline-nvim
                        nvim-lspconfig
                        lualine-nvim
                        nvim-cokeline
                        persistence-nvim
                        project-nvim
                        rustaceanvim
                        toggleterm-nvim
                        gruvbox-material
                        which-key-nvim
                    ];
                    
                    treesitterPlugins = pkgs.vimPlugins.nvim-treesitter.withPlugins (
                        parsers: with parsers; [
                            c
                            go
                            html
                            lua
                            luadoc
                            luap
                            vim
                            vimdoc
                            query
                            markdown
                            markdown_inline
                            javascript
                            typescript
                            tsx
                            jsdoc
                            python
                            rust
                            xml

                            yaml
                        ]
                    );

                    lspPackages = with pkgs; [
                        lua-language-server
                        pyright
                        clang-tools
                        typescript-language-server
                        typescript
                        gopls
                        zls
                        elixir-ls
                        nimlangserver
                        nil
                        vscode-langservers-extracted
                        vue-language-server
                        gleam
                        rust-analyzer
                        haskell-language-server
                    ];

                    toolchainPackages = with pkgs; [
                        git
                        ripgrep
                        fd
                        gnumake
                        gcc
                        tree-sitter
                        nodejs
                        go
                        zig
                        cargo
                        rustc
                        clippy
                        ghc
                        cabal-install
                        nim
                    ];

                    runtimePackages = toolchainPackages ++ lspPackages;

                    configDir = lib.cleanSourceWith {
                        src = ./.;
                        filter =
                            path: type:
                            let
                                base = baseNameOf path;
                            in
                                !(base == ".git" || base == ".nvimlog" || base == "result");
                    };

                    vimhenson = pkgs.wrapNeovim pkgs.neovim-unwrapped {
                        viAlias = true;
                        vimAlias = true;

                        withNodeJs = false;
                        withRuby = false;
                        withPython3 = false;

                        extraMakeWrapperArgs = lib.escapeShellArgs [
                            "--prefix"
                            "PATH"
                            ":"
                            (lib.makeBinPath runtimePackages)
                            "--set"
                            "VUE_LANGUAGE_SERVER_LIB_PATH"
                            "${pkgs.vue-language-server}/lib/language-tools"
                        ];

                        configure = {
                            customLuaRC = ''
                                vim.opt.runtimepath:prepend("${configDir}")
                                dofile("${configDir}/init.lua")
                            '';
                            packages.vimhenson.start = pluginPackages ++ [ treesitterPlugins ];
                        };
                    };
    in
    {
        default = vimhenson;
        vimhenson = vimhenson;
        inherit
            pluginPackages
            treesitterPlugins
            lspPackages
            runtimePackages
            ;
    };
    in
    {
        lib = forAllSystems (
            system:
                let
                    pkgs = import nixpkgs { inherit system; };
                in
                {
                    inherit
                        pluginPackageNames
                        treesitterGrammarNames
                        lspPackageNames
                        toolchainPackageNames
                        ;

                    pluginPackages = (mkPackages system).pluginPackages;
                    treesitterPlugins = (mkPackages system).treesitterPlugins;
                    lspPackages = (mkPackages system).lspPackages;
                    runtimePackages = (mkPackages system).runtimePackages;
                    
                    vueLanguageServerLibPath = "${pkgs.vue-language-server}/lib/language-tools";
                }
        );

        packages = forAllSystems mkPackages;

        apps = forAllSystems (system: {
            default = {
                type = "app";
                program = "${self.packages.${system}.default}/bin/vimhenson";
            };
        });

        devShells = forAllSystems (
            system:
                let
                    pkgs = import nixpkgs { inherit system; };
                    inherit ((mkPackages system)) runtimePackages;
                in
                {
                    default = pkgs.mkShell {
                        packages = [self.packages.${system}.default] ++ runtimePackages;
                    };
                }
        );
    };
}
