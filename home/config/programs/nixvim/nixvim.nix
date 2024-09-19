{ config, lib, ... }:
let
  helpers = config.lib.nixvim;
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
        };
      };
    };

    globals.mapleader = " ";

    opts = {
      number = true;
      relativenumber = true;
      shiftwidth = 2;
    };

    keymaps = [
      {
        action = "<cmd>Telescope live_grep<CR>";
        key = "<leader>sg";
      }
      {
        action = "<cmd>Telescope find_files<CR>";
        key = "<leader>sf";
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
	    lualine-c = [
	    ];
            lualine-x = [
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
	  inactive_sections = {
            lualine_a = [
	      "filename" 
	    ];
	    lualine_z = [
	      "location"
	    ];
	  };
	};
      };

      telescope.enable = true;
      which-key.enable = true;
      dressing.enable = true;
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
      fidget.enable = true;
      harpoon = {
        enable = true;
        enableTelescope = true;
        keymaps = {
          addFile = "<leader>ha";
          toggleQuickMenu = "<leader>ht";

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
        settings = {
          line_numbers = false; 
        };
      };
      notify.enable = true;


      lsp = {
	enable = true;
        inlayHints = true;
	servers = {
	  lua-ls = {
            enable = true;
	    settings.telemetry.enable = false;
	  };
	};
      };

      noice = {
        enable = true;
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

      cmp = {
	enable = true;
	autoEnableSources = true;
        settings = {
          sources = [
	    {name = "nvim_lsp";}
	    {name = "path";}
	    {name = "buffer";}
	    {name = "luasnip";}
          ];
        };
	settings.mapping = {
	 "<CR>" = "cmp.mapping.confirm({ select = true })";
	 "<Tab>" = ''
	   cmp.mapping(
	     function(fallback)
		if cmp.visible() then
		 cmp.select_next_item()
		else
		 fallback()
		end
	     end
	   ,
	   { "i", "s" }
	 )
	 '';
	};
      };
    };
  };
}
