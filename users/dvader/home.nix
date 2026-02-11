{ config, pkgs, lib, inputs, ... }:

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

  # Stylix
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/onedark-dark.yaml";
    targets.alacritty.enable = true;
    targets.starship.enable = true;
    targets.hyprlock.enable = true;

    fonts = {
      sizes.terminal = 9;
      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono Nerd Font";
      };
      sansSerif = {
        package = pkgs.inter;
        name = "Inter";
      };
      serif = {
        package = pkgs.prociono;
        name = "Prociono";
      };
      emoji = {
        package = pkgs.noto-fonts-color-emoji;
        name = "Noto Color Emoji";
      };
    };
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
      "$terminal" = "alacritty";
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
	"$mainMod, L, exec, hyprlock"
        
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
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        hide_cursor = true;
        ignore_empty_input = true;
      };
      animations = {
        enabled = true;
        fade_in = {
          duration = 300;
          bezier = "easeOutQuint";
        };
        fade_out = {
          duration = 300;
          bezier = "easeOutQuint";
        };
      };
      bezier = [
        "easeOutQuint, 0.23, 1, 0.32, 1"
      ];
      background = {
        path = "~/.dotfiles/users/dvader/wallpaper/winter-sunset.png";
        blur_passes = 3;
        blur_size = 8;
      };
      input-field = {
        size = "650, 100";
        position = "0, 0";
	halign = "center";
	valign = "center";
        monitor = "";
        dots_center = true;
        fade_on_empty = false;
        outline_thickness = 2;
        placeholder_text = ''Enter Password'';
	fail_text = ''<i>$FAIL ($ATTEMPTS)</i>''; 
        shadow_passes = 0;
	rounding = 0;
      };
    };
  };

  programs.waybar = {
    enable = true;
    
    settings = {
      mainBar = {
        reload_style_on_change = true;
	layer = "top";
        position = "top";
        spacing = 0;
	height = 26;

        modules-left = [
          "custom/launcher"
	  "hyprland/workspaces"
        ];
        
        modules-center = [
          "clock"
        ];
        
        modules-right = [
	  "group/tray-expander"
	  "backlight"
	  "bluetooth"
	  "network"
	  "pulseaudio"
	  "cpu"
	  "battery"
        ];
        
        "hyprland/workspaces" = {
          format = "{icon}";
          on-click = "activate";
	  format-icons = {
            default = "";
            "1" = "1";
            "2" = "2";
            "3" = "3";
            "4" = "4";
            "5" = "5";
            "6" = "6";
            "7" = "7";
            "8" = "8";
            "9" = "9";
            "10" = "0";
            active = "󱓻";
          };
          "persistent-workspaces" = {
            "1" = [];
            "2" = [];
            "3" = [];
            "4" = [];
            "5" = [];
          };
        };
          "custom/launcher" = {
            format = "";
            on-click = "${pkgs.walker}/bin/walker";
            on-click-right = "xdg-terminal-exec";
          };
          "cpu" = {
            interval = 5;
            format = "󰍛";
            on-click = "${pkgs.btop}/bin/btop";
            on-click-right = "alacritty";
          };
          "clock" = {
            format = "{:L%A %H:%M}";
            format-alt = "{:L%d %B W%V %Y}";
            tooltip = false;
          };
          "backlight" = {
            tooltip = false;
            format = " {}%";
            interval = 1;
            on-scroll-up = "brightnessctl -e4 -n2 set 5%+";
            on-scroll-down = "brightnessctl -e4 -n2 set 5%-";
          };
          "network" = {
            format-icons = ["󰤯" "󰤟" "󰤢" "󰤥" "󰤨"];
            format = "{icon}";
            format-wifi = "{icon}";
            format-ethernet = "󰀂";
            format-disconnected = "󰤮";
            tooltip-format-wifi = "{essid} ({frequency} GHz)\n⇣{bandwidthDownBytes}  ⇡{bandwidthUpBytes}";
            tooltip-format-ethernet = "⇣{bandwidthDownBytes}  ⇡{bandwidthUpBytes}";
            tooltip-format-disconnected = "Disconnected";
            interval = 3;
            spacing = 1;
            on-click = "${pkgs.alacritty}/bin/alacritty -e impala";
          };
          "battery" = {
            format = "{capacity}% {icon}";
            format-discharging = "{icon}";
            format-charging = "{icon}";
            format-plugged = "";
            format-icons = {
              charging = ["󰢜" "󰂆" "󰂇" "󰂈" "󰢝" "󰂉" "󰢞" "󰂊" "󰂋" "󰂅"];
              default = ["󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
            };
            format-full = "󰂅";
            tooltip-format-discharging = "{power:>1.0f}W↓ {capacity}%";
            tooltip-format-charging = "{power:>1.0f}W↑ {capacity}%";
            interval = 5;
            on-click = "omarchy-menu power";
            states = {
              warning = 20;
              critical = 10;
            };
          };
          "bluetooth" = {
            format = "";
            format-off = "󰂲";
            format-disabled = "󰂲";
            format-connected = "󰂱";
            format-no-controller = "";
            tooltip-format = "Devices connected: {num_connections}";
            on-click = "${pkgs.alacritty}/bin/alacritty -e bluetui";
          };
          "pulseaudio" = {
            format = "{icon}";
            on-click = "${pkgs.alacritty}/bin/alacritty -e wiremix";
            tooltip-format = "Playing at {volume}%";
            scroll-step = 5;
            format-muted = "";
            format-icons = {
              headphone = "";
              headset = "";
              default = ["" "" ""];
            };
          };
          "group/tray-expander" = {
            orientation = "inherit";
            drawer = {
              transition-duration = 600;
              children-class = "tray-group-item";
            };
            modules = ["custom/expand-icon" "tray"];
          };
          "custom/expand-icon" = {
            format = "";
            tooltip = false;
            on-scroll-up = "";
            on-scroll-down = "";
            on-scroll-left = "";
            on-scroll-right = "";
          };
          "tray" = {
            icon-size = 12;
            spacing = 17;
          };
      };
    };
    style = ''
      * {
        border: none;
        border-radius: 0;
        min-height: 0;
        font-family: 'JetBrainsMono Nerd Font';
        font-size: 12px;
      }
      
      .modules-left {
        margin-left: 8px;
      }
      
      .modules-right {
        margin-right: 8px;
      }
      
      #workspaces button {
        all: initial;
        padding: 0 6px;
        margin: 0 1.5px;
        min-width: 9px;
      }
      
      #workspaces button.empty {
        opacity: 0.5;
      }
      
      #cpu,
      #battery,
      #pulseaudio,
      #custom-launcher,
      
      #tray {
        margin-right: 16px;
      }
      
      #bluetooth {
        margin-right: 17px;
      }
      
      #network {
        margin-right: 13px;
      }
      
      #custom-expand-icon {
        margin-right: 18px;
      }
      
      tooltip {
        padding: 2px;
      }
      
      #custom-update {
        font-size: 10px;
      }
  
      #clock {
        margin-left: 8.75px;
      }
      
      .hidden {
        opacity: 0;
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
    extraConfig = ''
      set number
      set relativenumber
    '';
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

  programs.alacritty = {
    enable = true;
    settings = {
      env = {
        TERM = "xterm-256color";
      };
      font = {
        normal = { 
	  family = "JetBrainsMono Nerd Font";
	  style = "Regular";
	};
        bold = {
	  family = "JetBrainsMono Nerd Font";
	  style = "Bold";
	};
        italic = { 
	  family = "JetBrainsMono Nerd Font";
	  style = "Italic";
	};
      };
      
      window = {
        padding = {
	  x = 14;
          y = 14;
	};
        decorations = "None";
      };
      
      keyboard = {
        bindings = [
	  {
	    key = "Insert";
	    mods = "Shift";
	    action = "Paste"; 
	  }
          {
	    key = "Insert";
	    mods = "Control";
	    action = "Copy";
	  }
        ];
      };
    };
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
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

  # Enable Services
  services.hypridle = {
    enable = true;
    settings = {
      general = {
          lock_cmd = "pidof hyprlock || hyprlock";       # avoid starting multiple hyprlock instances.
          before_sleep_cmd = "loginctl lock-session";    # lock before suspend.
          after_sleep_cmd = "hyprctl dispatch dpms on";  # to avoid having to press a key twice to turn on the display.
      };
      listener = [
        {
          timeout = 150;                                # 2.5min.
          on-timeout = "brightnessctl -s set 10";         # set monitor backlight to minimum, avoid 0 on OLED monitor.
          on-resume = "brightnessctl -r";                 # monitor backlight restore.
        }
        {
          timeout = 150;                                         # 2.5min.
          on-timeout = "brightnessctl -sd rgb:kbd_backlight set 0"; # turn off keyboard backlight.
          on-resume = "brightnessctl -rd rgb:kbd_backlight";        # turn on keyboard backlight.
        }
        {
          timeout = 300;                                 # 5min
          on-timeout = "loginctl lock-session";          # lock screen when timeout has passed
        }
        {
          timeout = 330;                                               # 5.5min
          on-timeout = "hyprctl dispatch dpms off";                    # screen off when timeout has passed
          on-resume = "hyprctl dispatch dpms on && brightnessctl -r";  # screen on when activity is detected after timeout has fired.
        }
        {
          timeout = 1800;                                # 30min
          on-timeout = "systemctl suspend";                # suspend pc
        }
      ];
    };
  };

  services.gpg-agent = {
    enable = true;
    pinentry.package = pkgs.pinentry-qt;
  };

  services.swaync = {
    enable = true;
  };

  # Home Packages Installed
  home.packages = with pkgs; [
    alacritty
    brave
    brightnessctl
    btop
    git
    git-crypt
    gnupg
    nitch
    nwg-displays
    playerctl
    swww
    wget
    inter
    iosevka
    prociono
    noto-fonts-color-emoji
    nerd-fonts.heavy-data
    nerd-fonts.jetbrains-mono

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
