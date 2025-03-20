{
  lib,
  pkgs,
  catppuccin,
  ...
}:
{
  colorschemes.catppuccin = {
    enable = catppuccin.enable;
    settings = {
      flavour = catppuccin.flavor;
      transparent_background = true;
      integrations = {
        harpoon = true;
        noice = true;
        notify = true;
        rainbow_delimiters = true;
        mini.enabled = true;
      };
    };
  };

  globals.mapleader = " ";

  opts = {
    number = true;
    relativenumber = true;
    shiftwidth = 2;
    smartcase = true;
    smartindent = true;
    autoindent = true;
  };

  keymaps = [
    {
      action = "<cmd>Telescope live_grep<CR>";
      key = "<leader>sg";
    }
    {
      action = "<cmd>Telescope git_files<CR>";
      key = "<leader>sf";
    }
    {
      action = "<cmd>Telescope find_files<CR>";
      key = "<leader>sa";
    }
    {
      action = "<cmd>Oil<CR>";
      key = "<leader>f";
    }
    {
      action = "<cmd>LazyGit<CR>";
      key = "<leader>g";
    }
    {
      action = "<cmd>Noice telescope<CR>";
      key = "<leader>n";
    }
  ];

  plugins = {
    lualine = {
      enable = true;
      settings = {
        options = {
          component_separators = "";
          section_separators = {
            left = "";
            right = "";
          };
        };
        sections = {
          lualine_a = [
            {
              __unkeyed-1 = "mode";
              separator = {
                right = "";
              };
              right_padding = 2;
            }
          ];
          lualine_b = [
            "filename"
            "branch"
          ];
          lualine_c = [
            "diff"
          ];
          lualine_x = [
            {
              __unkeyed-1.__raw = ''
                require("noice").api.statusline.mode.get
              '';
              cond.__raw = ''
                function()
                  local noice = require("noice")
                  if noice.api.statusline.mode.has() and noice.api.statusline.mode.get():find("^recording") then
                    return true
                  else
                    return false
                  end
                end
              '';
              color = {
                fg = "#f38ba8";
              };
            }
          ];
          lualine_y = [
            "filetype"
            "progress"
          ];
          lualine_z = [
            {
              __unkeyed-1 = "location";
              separator = {
                left = "";
              };
              left_padding = 2;
            }
          ];
        };
      };
    };

    rainbow-delimiters.enable = true;
    telescope.enable = true;
    which-key.enable = true;
    oil.enable = true;
    dressing.enable = true;
    web-devicons.enable = true;
    lsp-format = {
      enable = true;
      autoLoad = true;
    };
    mini = {
      enable = true;
      modules = {
        ai = {
          n_lines = 50;
          search_method = "cover_or_next";
        };
        comment = {
          mappings = {
            comment = "<leader>/";
            comment_line = "<leader>/";
            comment_visual = "<leader>/";
            textobject = "<leader>/";
          };
        };
        diff = {
          view = {
            style = "sign";
          };
        };
        starter = {
          content_hooks = {
            "__unkeyed-1.adding_bullet" = {
              __raw = "require('mini.starter').gen_hook.adding_bullet()";
            };
            "__unkeyed-2.indexing" = {
              __raw = "require('mini.starter').gen_hook.indexing('all', { 'Builtin actions' })";
            };
            "__unkeyed-3.padding" = {
              __raw = "require('mini.starter').gen_hook.aligning('center', 'center')";
            };
          };
          evaluate_single = true;
          header = ''
            ███╗   ██╗██╗██╗  ██╗██╗   ██╗██╗███╗   ███╗
            ████╗  ██║██║╚██╗██╔╝██║   ██║██║████╗ ████║
            ██╔██╗ ██║██║ ╚███╔╝ ██║   ██║██║██╔████╔██║
            ██║╚██╗██║██║ ██╔██╗ ╚██╗ ██╔╝██║██║╚██╔╝██║
            ██║ ╚████║██║██╔╝ ██╗ ╚████╔╝ ██║██║ ╚═╝ ██║
          '';
          items = {
            "__unkeyed-1.buildtin_actions" = {
              __raw = "require('mini.starter').sections.builtin_actions()";
            };
            "__unkeyed-2.recent_files_current_directory" = {
              __raw = "require('mini.starter').sections.recent_files(10, false)";
            };
            "__unkeyed-3.recent_files" = {
              __raw = "require('mini.starter').sections.recent_files(10, true)";
            };
            "__unkeyed-4.sessions" = {
              __raw = "require('mini.starter').sections.sessions(5, true)";
            };
          };
        };
        surround = {
          mappings = {
            add = "gsa";
            delete = "gsd";
            find = "gsf";
            find_left = "gsF";
            highlight = "gsh";
            replace = "gsr";
            update_n_lines = "gsn";
          };
        };
      };
    };
    lsp-lines = {
      enable = true;
    };
    lsp-signature = {
      enable = true;
      settings = {
        handler_opts.border = "rounded";
        hint_inline = "inline";
      };
    };
    lspkind = {
      enable = true;
    };
    luasnip.enable = true;
    friendly-snippets.enable = true;
    lazygit.enable = true;
    nix.enable = true;
    cursorline.enable = true;
    autoclose.enable = true;
    indent-blankline.enable = true;

    harpoon = {
      enable = true;
      enableTelescope = true;
      keymaps = {
        addFile = "<leader>ha";
        toggleQuickMenu = "<leader>hl";
        navFile = {
          "1" = "<leader>1";
          "2" = "<leader>2";
          "3" = "<leader>3";
          "4" = "<leader>4";
          "5" = "<leader>5";
          "6" = "<leader>6";
          "7" = "<leader>7";
          "8" = "<leader>8";
        };
      };
    };
    treesitter = {
      enable = true;
      settings = {
        highlight.enable = true;
        indent.enable = true;
        incremental_selection.enable = true;
      };
    };
    treesitter-context.enable = true;
    treesitter-textobjects = {
      enable = true;
      lspInterop = {
        enable = true;
        border = "rounded";
      };
      select = {
        enable = true;
        lookahead = true;
        keymaps = {
          "if" = "@function.inner";
          "af" = "@function.outer";
          "ic" = "@class.inner";
          "ac" = "@class.outer";
          "i=" = "@assignment.inner";
          "a=" = "@assignment.outer";
          "v=" = "@assignment.rhs";
          "n=" = "@assignment.lhs";
          "il" = "@loop.inner";
          "al" = "@loop.outer";
          "ii" = "@conditional.inner";
          "ai" = "@conditional.outer";
          "i#" = "@comment.inner";
          "a#" = "@comment.outer";
        };
      };
    };

    notify.enable = true;
    tmux-navigator.enable = true;

    lsp = {
      enable = true;
      inlayHints = true;
      servers = {
        lua_ls = {
          enable = true;
          settings.telemetry.enable = false;
        };
        nixd.enable = true;
        ts_ls.enable = true;
        vuels = {
          enable = true;
          package = pkgs.vue-language-server;
        };
        jsonls.enable = true;
        gopls.enable = true;
        yamlls.enable = true;
        rust_analyzer = {
          enable = true;
          installRustc = false;
          installCargo = false;
        };
      };
    };

    noice = {
      enable = true;
      settings = {
        cmdline.enabled = true;
        messages.enabled = true;
        notify.enabled = true;
        popupmenu = {
          enabled = true;
          backend = "cmp";
        };
        lsp.override = {
          "cmp.entry.get_documentation" = true;
          "vim.lsp.util.convert_input_to_markdown_lines" = true;
          "vim.lsp.util.stylize_markdown" = true;
        };
      };
    };

    cmp = {
      enable = true;
      autoEnableSources = true;
      settings = {
        sources = [
          { name = "nvim_lsp"; }
          { name = "path"; }
          { name = "buffer"; }
          { name = "calc"; }
          { name = "conventionalcommits"; }
          { name = "cmdline"; }
          { name = "luasnip"; }
        ];
        view.entries = {
          name = "custom";
          selection_order = "top_down";
        };
        window = {
          completion = {
            scrollbar = false;
            completeopt = "menu,menuone,preview,noselect";
            winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None";
            col_offset = -3;
            side_padding = 0;
            border = "rounded";
          };
          documentation = {
            border = "rounded";
          };
        };
        formatting = {
          fields = [
            "kind"
            "abbr"
            "menu"
          ];
          format = lib.mkForce ''
            function(entry, vim_item)
              local kind = require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
              local strings = vim.split(kind.kind, "%s", { trimempty = true })
              kind.kind = " " .. (strings[1] or "") .. " "
              kind.menu = "    (" .. (strings[2] or "") .. ")"

              return kind
            end,
          '';
        };
      };
      settings.mapping = {
        "<CR>" = ''
          cmp.mapping({
            i = function(fallback)
              if cmp.visible() then
                if not cmp.get_active_entry() then
                  cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
                end
                cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
              else
                fallback()
              end
            end,
            s = cmp.mapping.confirm({ 
              select = true 
            }),
            c = cmp.mapping.confirm({ 
              behavior = cmp.ConfirmBehavior.Replace, 
              select = true 
            })
          })
        '';
        "<Tab>" = ''
          cmp.mapping(
            function(fallback)
              if cmp.visible() then
                cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
              else
                fallback()
              end
            end,
            { "i", "s", "c" }
          )
        '';
        "<S-Tab>" = ''
          cmp.mapping(
            function(fallback)
              if cmp.visible() then
                cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
              else
                fallback()
              end
            end,
            { "i", "s", "c" }
          )
        '';
      };
    };
    cmp-path.enable = true;
    cmp-treesitter.enable = true;
    cmp-calc.enable = true;
    cmp-conventionalcommits.enable = true;
    cmp-git.enable = true;
    cmp-clippy.enable = true;
    cmp-cmdline.enable = true;
  };
}
