# ox_engraving_machine

Drag-and-drop Ox Inventory addon module for engraving custom metadata labels onto items.

## Requirements
- FiveM server
- `ox_lib` and `ox_inventory` resources
- Lua 5.4 runtime (`fxmanifest.lua` declares `lua54 'yes'`)

## Installation
- Place the `ox_engraving_machine` folder in your server `resources` directory.
- Add the resource to your `server.cfg`:

```cfg
ensure ox_engraving_machine
```

## Configuration
- Edit `config.lua` to adjust behavior, notifications, and metadata display.
- Important settings:
  - `Config.MachineItem` — the ox_inventory item name used as the engraving machine.
  - `Config.MachineUses` — total durability uses for a full engraving machine; this should match your `ox_inventory` item definition.
  - `Config.AllowReEngrave` (bool) — allow overwriting existing engravings.
  - `Config.RequireReEngraveAce` (bool) — when true, requires an ACE permission to overwrite an engraving.
  - `Config.ReEngraveAcePermission` (string) — default `engraving.overwrite`.
  - `Config.FullStackEngraveAcePermission` — ACE permission required to engrave entire stacks in place.
  - `Config.BlockedItems` — item names that cannot be engraved (includes the machine item plus `money` and `black_money` by default).
  - `Config.Webhook` — optional Discord logging settings.

### Startup validation
- On server startup, this resource checks that the configured machine item exists in your `ox_inventory` item list and warns if `ox_inventory/data/items.lua` is out of sync.

## Server ACL example
Grant the ACE permission to an admin group and assign players to that group (adjust identifiers):

```cfg
# create permission and allow it for group.admin
add_ace group.admin engraving.overwrite allow

# assign a player identifier to group.admin
add_principal identifier.steam:110000112345678 group.admin
```

If you also want admins to engrave full stacks in place, ensure `Config.FullStackEngraveAcePermission` is set to your admin group or permission.

## Usage
- Players use the configured item (`Config.MachineItem`) from `ox_inventory` to prepare an engraving.
- After preparing an engraving, the player applies it to a valid target item.
- If a target item already has an engraving and `Config.RequireReEngraveAce` is enabled, the player must have the ACE permission specified by `Config.ReEngraveAcePermission` to overwrite it.
- If the player lacks `Config.FullStackEngraveAcePermission`, engraving a stack will only apply to a single item and move it into a new stack instead of engraving the full stack in place.

## Notes
- The resource logs admin actions to Discord when `Config.Webhook.Enabled` is `true` and `Config.Webhook.Url` is set.
- See the `install/` folder for example `ox_inventory` item data and optional compatibility fixes for metadata display.
- `Config.Tooltip` controls whether engraving metadata is visible in item tooltips and whether existing descriptions are preserved.
- Use `Config.Notify` messages to customize user-facing notifications.
