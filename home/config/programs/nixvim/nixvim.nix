{ config, lib, ... }:
let
  helpers = lib.nixvim;
in
{
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    vimdiffAlias = true;
    colorschemes.catppuccin = {
      enable = config.catppuccin.enable;
      settings = {
        flavour = config.catppuccin.flavor;
        transparent_background = true;
        integrations = {
          harpoon = true;
          noice = true;
          notify = true;
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
            lualine_c = lib.mkForce [

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

      telescope.enable = true;
      which-key.enable = true;
      oil.enable = true;
      dressing.enable = true;
      web-devicons.enable = true;
      lspkind = {
        enable = true;
        mode = "symbol";
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
          toggleQuickMenu = "<leader>ht";
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
      treesitter-context = {
        enable = true;
      };
      notify.enable = true;
      tmux-navigator.enable = true;

      lsp = {
        enable = true;
        inlayHints = true;
        servers = {
          lua-ls = {
            enable = true;
            settings.telemetry.enable = false;
          };
          nil-ls.enable = true;
        };
      };

      noice = {
        enable = true;
        cmdline = {
          enabled = true;
          view = "cmdline";
        };
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

      cmp = {
        enable = true;
        autoEnableSources = true;
        settings = {
          sources = [
            { name = "nvim_lsp"; }
            { name = "path"; }
            { name = "buffer"; }
            { name = "luasnip"; }
          ];
        };
        settings.mapping = {
          "<CR>" = "cmp.mapping.confirm({ select = true })";
          "<Tab>" = "   cmp.mapping(\n     function(fallback)\n	if cmp.visible() then\n	 cmp.select_next_item()\n	else\n	 fallback()\n	end\n     end\n   ,\n   { \"i\", \"s\" }\n )\n ";
        };
      };
    };
  };
}
