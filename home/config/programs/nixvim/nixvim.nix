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
      settings.flavour = config.catppuccin.flavor;
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
      lualine.enable = true;
      telescope.enable = true;
      which-key.enable = true;

      lsp = {
	enable = true;
	servers = {
	  lua-ls = {
            enable = true;
	    settings.telemetry.enable = false;
	  };
	};
      };

            cmp = {
	enable = true;
	autoEnableSources = true;
	settings.sources = [
	 {name = "nvim_lsp";}
	 {name = "path";}
	 {name = "buffer";}
	];

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
