{ outputs, ... }:
{
  nixpkgs = {
    overlays = [
      # Add overlays flake exports (from overlays and pkgs dir)
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.stable-packages

      # Add overlays exported from other flakes
      # inputs.neovim-nightly-overlay.overlays.default

      # Define inline
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [./change-hello-to-hi.patch];
      #   });
      # })
    ];
    # Configure nixpkgs instance
    config = {
      allowUnfree = true;
    };
  };
}
