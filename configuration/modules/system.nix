{device-name, ...}: {
  networking.hostName = "max-${device-name}";
  system = {
    stateVersion = "25.11";
    activationScripts.cleanBackups = ''
      echo "Removing .backup_nix files..."
      find /home/maxag -type f -name "*.backup_nix" -delete
    '';
  };
}
