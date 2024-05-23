# list recepies
@default:
    just --list

# rebuild system
switch:
    darwin-rebuild switch --flake .

# update flake
update:
    nix flake update .

# update and switch in one
upgrade: update switch

# release new version
bump:
    cog bump --auto
