{ catppuccin, ... }:
{
  catppuccin = {
    enable = catppuccin.enable;
    flavor = catppuccin.flavor;
    accent = catppuccin.accent;
    autoEnable = catppuccin.autoEnable;
    mako.enable = false;
  };
}
