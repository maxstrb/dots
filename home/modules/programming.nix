{pkgs, ...}: {
  home.packages = with pkgs; [
    godot
    lazygit
  ];
}
