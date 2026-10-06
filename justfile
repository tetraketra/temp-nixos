run-vm config:
    git add . && git commit -am "automated commit for vm rebuild"
    find . -type f -name '*.qcow2' -delete
    nix run .#nixosConfigurations.{{config}}.config.system.build.vm --show-trace