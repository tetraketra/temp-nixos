run-vm config:
    find . -type f -name '*.qcow2' -delete
    nix run .#nixosConfigurations.{{config}}.config.system.build.vm --show-trace