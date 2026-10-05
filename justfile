run-vm config:
    nix run .#nixosConfigurations.{{config}}.config.system.build.vm --show-trace