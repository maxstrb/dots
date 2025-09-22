{pkgs, ...}: {
  users.users.maxag = {
    isNormalUser = true;
    description = "Max Ag";
    extraGroups = ["networkmanager" "wheel" "video" "input"];

    shell = pkgs.nushell;
  };
}
