run-vm config:
    git add . && git commit -am "none(none) flake sync"
    find . -type f -name '*.qcow2' -delete
    nix run .#nixosConfigurations.{{config}}.config.system.build.vm --show-trace