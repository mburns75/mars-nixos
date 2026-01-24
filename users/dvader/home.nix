{ config, pkgs, inputs, ... }:

{
  imports = [
    inputs.walker.homeManagerModules.default
  ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "dvader";
  home.homeDirectory = "/home/dvader";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.11"; # Please read the comment before changing.

  programs.gpg = {
    enable = true;
  };

  # Enable Stylix theming
  stylix = {
    enable = true;
    image = ./wallpaper/gruvbox-pixel-city.png; 
    polarity = "dark";
    targets.neovim.enable = true;
  };

  # Hyperland
  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages."${pkgs.stdenv.hostPlatform.system}".hyprland;
    
    settings = {
      # Environment variables
      env = [
        "XCURSOR_SIZE,24"
	"HYPRCURSOR_SIZE,24"
      ];

      # Program variables
      "$terminal" = "kitty";
      "$fileManager" = "dolphin";
      "$browser" = "firefox";
      "$menu" = "walker";
      "$mainMod" = "SUPER";

      # Monitor configuration
      monitor = [
        "desc:InfoVision Optoelectronics (Kunshan) Co.Ltd China 0x8C78 0x00000004,1920x1080@60.01,0x120,1.0"
        "desc:Dell Inc. DELL U2412M 7XTXG8AR00AS,1920x1200@59.95,3840x0,1.0"
        "desc:Dell Inc. DELL U2412M 7XTXG8AR0N6S,1920x1200@59.95,1920x0,1.0"
      ];

      # Autostart
      exec-once = [
        "swww-daemon"
	"nm-applet &"
	"hyprpaper"
	"walker --gapplication-service"
      ];

      # General settings
      general = {
        gaps_in = 5;
	gaps_out = 20;
	border_size = 2;
	resize_on_border = false;
	allow_tearing = false;
	layout = "dwindle";
      };

      # Decoration
      decoration = {
        rounding = 10;
	active_opacity = 1.0;
	inactive_opacity = 1.0;
	shadow = {
          enabled = true;
	  range = 4;
	  render_power = 3;
	};
	blur = {
          enabled = true;
	  size = 3;
	  passes = 1;
	  vibrancy = 0.1696;
	};      
      };

      # Animations
      animations = {
        enabled = true;
	bezier = [
          "easeOutQuint, 0.23, 1, 0.32, 1"
          "easeInOutCubic, 0.65, 0.05, 0.36, 1"
          "linear, 0, 0, 1, 1"
          "almostLinear, 0.5, 0.5, 0.75, 1"
          "quick, 0.15, 0, 0.1, 1"
	];
	animation = [
          "global, 1, 10, default"
          "border, 1, 5.39, easeOutQuint"
          "windows, 1, 4.79, easeOutQuint"
          "windowsIn, 1, 4.1, easeOutQuint, popin 87%"
          "windowsOut, 1, 1.49, linear, popin 87%"
          "fadeIn, 1, 1.73, almostLinear"
          "fadeOut, 1, 1.46, almostLinear"
          "fade, 1, 3.03, quick"
          "layers, 1, 3.81, easeOutQuint"
          "layersIn, 1, 4, easeOutQuint, fade"
          "layersOut, 1, 1.5, linear, fade"
          "fadeLayersIn, 1, 1.79, almostLinear"
          "fadeLayersOut, 1, 1.39, almostLinear"
          "workspaces, 1, 1.94, almostLinear, fade"
          "workspacesIn, 1, 1.21, almostLinear, fade"
          "workspacesOut, 1, 1.94, almostLinear, fade"
          "zoomFactor, 1, 7, quick"
	];
      };

      # Layouts
      dwindle = {
        pseudotile = true;
	preserve_split = true;
      };
      master = {
        new_status = "master";
      };

      # Misc
      misc = {
        force_default_wallpaper = -1;
	disable_hyprland_logo = false;
      };

      # Input
      input = {
        kb_layout = "us";
	follow_mouse = 1;
	sensitivity = 0;
	touchpad = {
          natural_scroll = false;
	};
      };

      # Device-specific
      device = {
        name = "epic-mouse-v1";
	sensitivity = -0.5;
      };

      # Keybindings
      bind = [
        # Application launches
        "$mainMod, RETURN, exec, $terminal"
        "$mainMod, F, exec, $fileManager"
        "$mainMod, SPACE, exec, $menu"
        "$mainMod, A, exec, $terminal -e wiremix"
        "$mainMod SHIFT, B, exec, $browser"
        
        # Window management
        "$mainMod, W, killactive,"
        "$mainMod, M, exit,"
        "$mainMod, V, togglefloating,"
        "$mainMod, P, pseudo,"
        "$mainMod, J, togglesplit,"
        
        # Focus movement
        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"
        
        # Workspace switching
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"
        
        # Move window to workspace
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"
        
        # Special workspace (scratchpad)
        "$mainMod, S, togglespecialworkspace, magic"
        "$mainMod SHIFT, S, movetoworkspace, special:magic"
        
        # Mouse workspace scrolling
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"
      ];
      
      # Mouse bindings
      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];
      
      # Multimedia keys (repeatable with held key)
      bindel = [
        ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
        ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ",XF86MonBrightnessUp, exec, brightnessctl -e4 -n2 set 5%+"
        ",XF86MonBrightnessDown, exec, brightnessctl -e4 -n2 set 5%-"
      ];
      
      # Media controls (locked, works even in locked screen)
      bindl = [
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPause, exec, playerctl play-pause"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioPrev, exec, playerctl previous"
      ];
    };
    
    # Extra Config and Window Rules
    extraConfig = ''
      windowrule = suppress_event maximize, match:class .*
      windowrule = no_focus on, match:class ^$, match:title ^$, match:xwayland 1, match:float 1, match:fullscreen 0, match:pin 0
      gesture = 3, horizontal, workspace
    '';
  };

  # Enabled Programs
  programs.waybar = {
    enable = true;
    
    settings = {
      mainBar = {
        layer = "top";
        
        modules-left = [
          "custom/launcher"
          "cpu"
          "memory"
          "network"
        ];
        
        modules-center = [
          "hyprland/workspaces"
        ];
        
        modules-right = [
          "custom/wallpaper"
          "backlight"
          "pulseaudio"
	  "battery"
          "clock"
          "custom/power"
        ];
        
        "hyprland/workspaces" = {
          format = "{id}";
          on-click = "activate";
          all-outputs = true;
          active-only = false;
        };
        
        "pulseaudio" = {
          tooltip = false;
          scroll-step = 5;
          format = "{icon} {volume}%";
          format-muted = "{icon} {volume}%";
          on-click = "pactl set-sink-mute @DEFAULT_SINK@ toggle";
          format-icons = {
            default = ["" "" ""];
          };
        };
        
        "network" = {
          tooltip = false;
          format-wifi = "   {essid} ";
          format-ethernet = " 󰈀 ";
        };
        
        "backlight" = {
          tooltip = false;
          format = " {}%";
          interval = 1;
          on-scroll-up = "brightnessctl -e4 -n2 set 5%+";
          on-scroll-down = "brightnessctl -e4 -n2 set 5%-";
        };
        
        "battery" = {
          states = {
            good = 95;
            warning = 30;
            critical = 20;
          };
          format = "{icon}  {capacity}%";
          format-charging = "󱐋 {capacity}%";
          format-plugged = " {capacity}%";
          format-alt = "{time} {icon}";
          format-icons = ["" "" "" "" ""];
        };
        
        "clock" = {
	  interval = 60;
          format = "{:%I:%M %p}";
	  format-alt = "{:%-m/%-d/%Y}";
	  tooltip = true;
	  tooltip-format = "{:%I:%M %p %A, %B %d, %Y}";
        };
        
        "cpu" = {
          interval = 15;
          format = " {}%";
          max-length = 10;
        };
        
        "memory" = {
          interval = 30;
          format = " {}%";
          max-length = 10;
        };
        
        "custom/launcher" = {
          format = " ";
          on-click = "${pkgs.walker}/bin/walker";
          on-click-right = "killall walker";
        };
        
        "custom/power" = {
          format = "󰐥 ";
          on-click = "${pkgs.wlogout}/bin/wlogout";
        };
        
        "custom/wallpaper" = {
          format = " ";
          on-click = "pkill swww || swww init";
        };
      };
    };
    
    style = ''
      * {
        border: none;
        border-radius: 10px;
        font-family: "JetbrainsMono Nerd Font";
        font-size: 15px;
        min-height: 10px;
      }
      
      window#waybar {
        background: transparent;
      }
      
      window#waybar.hidden {
        opacity: 0.2;
      }
      
      #window {
        margin-top: 6px;
        padding-left: 10px;
        padding-right: 10px;
        border-radius: 10px;
        transition: none;
        color: transparent;
        background: transparent;
      }
      
      #workspaces {
        margin-top: 6px;
        margin-left: 12px;
        font-size: 4px;
        margin-bottom: 0px;
        border-radius: 10px;
        background: #1d2021;
        transition: none;
      }
      
      #workspaces button {
        transition: none;
        color: #d4be98;
        background: transparent;
        font-size: 16px;
        border-radius: 2px;
      }
      
      #workspaces button.active {
        color: #a9b665;
        border-top: 2px solid #a9b665;
        border-bottom: 2px solid #a9b665;
      }
      
      #workspaces button:hover {
        transition: none;
        box-shadow: inherit;
        text-shadow: inherit;
        color: #d8a657;
        border-color: #ea6962;
      }
      
      #workspaces button.active:hover {
        color: #ea6962;
      }
      
      #network {
        margin-top: 6px;
        margin-left: 8px;
        padding-left: 10px;
        padding-right: 10px;
        margin-bottom: 0px;
        border-radius: 10px;
        transition: none;
        color: #1d2021;
        background: #7daea3;
      }
      
      #pulseaudio {
        margin-top: 6px;
        margin-left: 8px;
        padding-left: 10px;
        padding-right: 10px;
        margin-bottom: 0px;
        border-radius: 10px;
        transition: none;
        color: #1d2021;
        background: #d8a657;
      }
      
      #battery {
        margin-top: 6px;
        margin-left: 8px;
        padding-left: 10px;
        padding-right: 10px;
        margin-bottom: 0px;
        border-radius: 10px;
        transition: none;
        color: #1d2021;
        background: #89b482;
      }
      
      #battery.charging, #battery.plugged {
        color: #1d2021;
        background-color: #89b482;
      }
      
      #battery.critical:not(.charging) {
        background-color: #ea6962;
        color: #1d2021;
        animation-name: blink;
        animation-duration: 0.5s;
        animation-timing-function: linear;
        animation-iteration-count: infinite;
        animation-direction: alternate;
      }
      
      @keyframes blink {
        to {
          background-color: #ea6962;
          color: #d4be98;
        }
      }
      
      #backlight {
        margin-top: 6px;
        margin-left: 8px;
        padding-left: 10px;
        padding-right: 10px;
        margin-bottom: 0px;
        border-radius: 10px;
        transition: none;
        color: #1d2021;
        background: #e78a4e;
      }
      
      #clock {
        margin-top: 6px;
        margin-left: 8px;
        padding-left: 10px;
        padding-right: 10px;
        margin-bottom: 0px;
        border-radius: 10px;
        transition: none;
        color: #1d2021;
        background: #a9b665;
      }
      
      #memory {
        margin-top: 6px;
        margin-left: 8px;
        padding-left: 10px;
        margin-bottom: 0px;
        padding-right: 10px;
        border-radius: 10px;
        transition: none;
        color: #1d2021;
        background: #d3869b;
      }
      
      #cpu {
        margin-top: 6px;
        margin-left: 8px;
        padding-left: 10px;
        margin-bottom: 0px;
        padding-right: 10px;
        border-radius: 10px;
        transition: none;
        color: #1d2021;
        background: #7daea3;
	font-family: "JetBrainsMono Nerd Font";
      }
      
      #custom-launcher {
        font-size: 24px;
        margin-top: 6px;
        margin-left: 8px;
        padding-left: 10px;
        padding-right: 5px;
        border-radius: 10px;
        transition: none;
        color: #7daea3;
        background: #1d2021;
      }
      
      #custom-power {
        font-size: 20px;
        margin-top: 6px;
        margin-left: 8px;
        margin-right: 8px;
        padding-left: 10px;
        padding-right: 5px;
        margin-bottom: 0px;
        border-radius: 10px;
        transition: none;
        color: #1d2021;
        background: #ea6962;
      }
      
      #custom-wallpaper {
        margin-top: 6px;
        margin-left: 8px;
        padding-left: 10px;
        padding-right: 10px;
        margin-bottom: 0px;
        border-radius: 10px;
        transition: none;
        color: #1d2021;
        background: #a9b665;
      }
    '';
  };

  programs.neovim = {
    enable = true;
    vimAlias = true;
    viAlias = true;
    extraPackages = with pkgs; [
      stylua
      lua-language-server
      yaml-language-server
      vscode-langservers-extracted
      marksman
      ruff
      ];
  };

  programs.zsh = {
    enable = true;
    shellAliases = {
      ls = "eza -lah --icons";
    };
    #ensure nix-profile paths are available to zsh
    initContent = '';  
      if [ -e $HOME/.nix-profile/etc/profile.d/nix.sh ]; then
        . $HOME/.nix-profile/etc/profile.d/nix.sh
      fi
    '';
  };

  programs.kitty = {
    enable = true;
    font = {
      package = pkgs.nerd-fonts.jetbrains-mono; 
      name = "Jetbrains Mono Nerd Font";
      size = 11;
    };
    enableGitIntegration = true;
    themeFile = "GruvboxMaterialDarkHard";
    settings = {
      disable_ligatures = false;
      enable_audio_bell = false;
    };
    extraConfig = ''
      cursor_shape block
      url_style curly
      remember_window_size no
      window_padding_width 15
      background_opacity 0.80
      sync_to_monitor no
      confirm_os_window_close 0 
    '';
  };

  programs.eza = {
    enable = true;
    enableZshIntegration = true;
    git = true;
    icons = "always";
    colors = "always";
  };

  programs.walker.enable = true;

  programs.wlogout = {
    enable = true;
    layout = [
#      {
#        label = " ";
#	action = "hyprlock";
#	text = " ";
#	keybind = "l";
#      }
      {
        label = "󰍃";
	action = "hyprctl dispatch exit";
	text = "󰍃";
	keybind = "e";
      }
      {
        label = "󰐥";
	action = "systemctl poweroff";
	text = "󰐥";
	keybind = "s";
      }
      {
        label = "󰜉";
	action = "systemctl reboot";
	text = "󰜉";
	keybind = "r";
      }
    ];
    style = ''
      * {
        background-image: none;
        box-shadow: none;
	font-family: "JetBrainsMono Nerd Font";
	font-size: 150px;
      }
      
      window {
        background-color: rgba(29, 32, 33, 0.95);
      }
      
      button {
        color: #d4be98;
        background-color: #1d2021;
        border-style: solid;
        border-width: 2px;
        background-repeat: no-repeat;
        background-position: center;
        background-size: 20%;
        border-radius: 10px;
        margin: 40px;
	min-width: 20px;
	min-height: 20px;
      }
      
      button:focus, button:active, button:hover {
        background-color: #7daea3;
        color: #1d2021;
        outline-style: none;
      }
    '';
    };

  services.gpg-agent = {
    enable = true;
    pinentry.package = pkgs.pinentry-qt;
  };

  # Home Packages Installed
  home.packages = with pkgs; [
    brave
    brightnessctl
    btop
    git
    git-crypt
    gnupg
    nerd-fonts.jetbrains-mono
    nitch
    nwg-displays
    playerctl
    swww
    wget
    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/dvader/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
