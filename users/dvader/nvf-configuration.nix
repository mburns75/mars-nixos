{ config, pkgs, lib, ... }:

{
  vim = {
    theme = {
      enable = true;
      name = "gruvbox";
      style = "dark";
    };

    statusline.lualine.enable = true;
    telescope.enable = true;
    autocomplete.nvim-cmp.enable = true;
    
    languages = {
      enableLSP = true;
      enableTreesitter = true;
      
      bash.enable = true;
      css.enable = true;
      json.enable = true;
      lua.enable = true;
      markdown.enable = true;
      nix.enable = true;
      yaml.enable = true;
    };
  };
}
