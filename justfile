# list recepies
@default:
    just --list

# rebuild system
switch:
    sudo darwin-rebuild switch --flake .

# update flake
update:
    nix flake update --flake .

# update and switch in one
upgrade: update switch

# release new version
bump:
    git-cliff --bump -o CHANGELOG.md
