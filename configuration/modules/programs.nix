{
  programs = {
    firefox.enable = true;
    bash.blesh.enable = true; # Enhanced bash
    nix-ld = {
      enable = true;
      #libraries = with pkgs; [
      # Add libraries here
      #];
    };
  };
}
