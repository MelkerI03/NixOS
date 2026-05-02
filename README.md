# NixOS + Home Manager Configuration

This repository contains a unified, flake-based configuration for both NixOS system setup and Home Manager user environment.

It is designed to be:

* Declarative
* Modular
* Scalable across multiple machines
* Easy to reason about and extend

---

## Overview

The configuration follows a layered architecture:

Host -> Profiles -> Modules

Each layer has a clear responsibility:

* Hosts define machine-specific configuration
* Profiles define roles (e.g. desktop, work)
* Modules implement actual functionality

---

## Structure

```
.
├── flake.nix
├── hosts/
│   ├── laptop/
│   │   ├── default.nix
│   │   └── home.nix
│   └── work/
│       ├── default.nix
│       └── home.nix
├── modules/              # NixOS modules
├── home/
│   ├── modules/          # Home Manager modules
│   ├── profiles/         # Home Manager profiles
│   └── users/
```

---

## Key Concepts

### Hosts

Hosts represent actual machines.

Examples:

* laptop
* work

Each host defines:

* Hardware
* System services
* Which Home Manager configuration to use

---

### Profiles

Profiles represent roles or environments.

Examples:

* desktop (full setup with UI, apps, etc.)
* work (minimal, no distractions)

Profiles compose modules into meaningful setups.

---

### Modules

Modules are reusable configuration units.

Examples:

* git configuration
* zsh setup
* nixvim configuration
* networking
* services

They should be:

* Small
* Focused
* Reusable

---

### Home Manager Integration

Home Manager is integrated directly into NixOS.

This means a single command configures:

* System
* User environment

No separate home-manager invocation is needed.

---

## Usage

### Build configuration

```
nixos-rebuild build --flake .#laptop
```

### Apply configuration

```
sudo nixos-rebuild switch --flake .#laptop
or
nixos # alias after first application
```

### Boot into new generation

```
sudo nixos-rebuild boot --flake .#laptop
```

---

## Adding a new host

1. Create a new directory under `hosts/`
2. Add:

   * default.nix (system configuration)
   * home.nix (home-manager entry)
   * hardware.nix (easily generated from nixos-generate-config)
3. Register it in `flake.nix`

---

## Customization

* Add or remove modules in profiles to change behavior
* Create new profiles for different environments
* Extend modules for new features

---

## Nixvim

The Neovim configuration is modularized into:

* core (options, keymaps, UI)
* plugins (editor, navigation, visuals)
* lsp (servers, formatting, UI)
* completion (cmp, snippets)
* languages (language-specific configs)
* ai (optional integrations)

This allows easy enabling/disabling of features per profile.

---

## Design Goals

* Keep modules simple and composable
* Avoid hidden coupling between modules
* Prefer explicit imports over magic
* Keep evaluation predictable (no dynamic imports)
* Make it easy to scale to more machines

---

## Notes

* Always use flake commands (do not use legacy nixos-rebuild without `--flake`)
* Keep `system.stateVersion` and `home.stateVersion` stable

---

## Future Improvements

* Feature flags for optional components (e.g. AI, LaTeX)
* Shared profiles across system and home

---

## License

Personal configuration — adapt as needed.
