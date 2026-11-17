{ pkgs }:
pkgs.writeShellScriptBin "ninbot" ''
  export LD_LIBRARY_PATH="${pkgs.lib.makeLibraryPath [
    pkgs.libxkbcommon
    pkgs.libx11
    pkgs.libxtst
    pkgs.libxi
    pkgs.libxt
  ]}:$LD_LIBRARY_PATH"
  export XKB_CONFIG_ROOT="${pkgs.xkeyboard_config}/share/X11/xkb"
  export _JAVA_AWT_WM_NONREPARENTING=1
  unset WAYLAND_DISPLAY
  unset WAYLAND_SOCKET
  exec ${pkgs.openjdk17}/bin/java \
    -Dswing.defaultlaf=javax.swing.plaf.metal.MetalLookAndFeel \
    -Dawt.useSystemAAFontSettings=on \
    -jar ${./../dotfiles/waywall/resources/Ninjabrain-Bot-1.5.2.jar} "$@"
''
