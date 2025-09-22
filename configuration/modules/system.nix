{name, ...}: {
  networking.hostName = "max-${name}";
  system = {
    stateVersion = "25.11";
    activationScripts.cleanBackups = ''
      echo "Removing .backup_nix files..."
      find /home/maxag -type f -name "*.backup_nix" -delete
    '';
  };
}
