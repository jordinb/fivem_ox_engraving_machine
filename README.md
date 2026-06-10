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

### Item Registration
- Add the engraving machine item to your `ox_inventory/data/items.lua` using the example provided in `ox_engraving_machine/install/install into ox_inventory data/items.lua`.
- Copy the icon file (`engraving_machine.png`) from the install folder to `ox_inventory/web/images/` directory.
- Restart `ox_inventory` and `ox_engraving_machine` after editing items.lua.

## Configuration
- Edit `config.lua` to adjust behavior, notifications, and metadata display.
- All settings are documented inline in `config.lua` with detailed comments.
- Key settings:
  - `Config.MachineItem` — the ox_inventory item name used as the engraving machine.
  - `Config.MachineUses` — total durability uses for a full engraving machine; this should match your `ox_inventory` item definition.
  - `Config.AllowReEngrave` (bool) — allow overwriting existing engravings.
  - `Config.RequireReEngraveAce` (bool) — when true, requires an ACE permission to overwrite an engraving.
  - `Config.ReEngraveAcePermission` (string) — default `engraving.overwrite`.
  - `Config.FullStackEngraveAcePermission` — ACE permission required to engrave entire stacks in place.
  - `Config.BlockedItems` — item names that cannot be engraved (includes the machine item plus `money` and `black_money` by default).
  - `Config.Webhook` — optional Discord logging settings.
  - `Config.Tooltip` — controls tooltip display options, including description fallback for compatibility.
  - `Config.MinLength` / `Config.MaxLength` — engraving text length limits (default 1–64 characters).

### Startup validation
- On server startup, this resource checks that the configured machine item exists in your `ox_inventory` item list and warns if `ox_inventory/data/items.lua` is out of sync.

## Server ACL example
Grant the ACE permissions to an admin group and assign players to that group (adjust identifiers):

```cfg
# create permissions for engraving operations
add_ace group.admin engraving.overwrite allow
add_ace group.admin engraving.stacks allow

# assign a player identifier to group.admin
add_principal identifier.steam:110000112345678 group.admin
```

- `engraving.overwrite` (default `Config.ReEngraveAcePermission`) — allows players to overwrite existing engravings when `Config.RequireReEngraveAce` is enabled.
- `engraving.stacks` (default `Config.FullStackEngraveAcePermission`) — allows players to engrave entire stacks in place instead of splitting off a single item.

## Usage
- Players use the configured item (`Config.MachineItem`) from `ox_inventory` to prepare an engraving.
- After preparing an engraving, the player applies it to a valid target item.
- If a target item already has an engraving and `Config.RequireReEngraveAce` is enabled, the player must have the ACE permission specified by `Config.ReEngraveAcePermission` to overwrite it.
- If the player lacks `Config.FullStackEngraveAcePermission`, engraving a stack will only apply to a single item and move it into a new stack instead of engraving the full stack in place.

### Debug Command
- Use `/engravingdebug` in-game to inspect engraved items in your inventory.
- This command logs all engraved items with their metadata to the server console.
- Cooldown: `Config.DebugCooldown` (default: 300 seconds).

## Notes
- The resource logs admin actions to Discord when `Config.Webhook.Enabled` is `true` and `Config.Webhook.Url` is set.
- See the `install/` folder for:
  - `install into ox_inventory data/items.lua` — Item definition to add to your ox_inventory data file
  - `install into ox_inventory data/engraving_machine.png` — Icon file for the engraving machine item
  - `optional fallback fix/metadata_display.lua` — Optional compatibility snippet for heavily customized ox_inventory forks where displayMetadata does not work reliably
- `Config.Tooltip` controls whether engraving metadata is visible in item tooltips and whether existing descriptions are preserved.
- Use `Config.Tooltip.UseDescriptionFallback` to enable description-based fallback for metadata display compatibility.
- Use `Config.Notify` to customize user-facing notifications.
- Engraving audit data (who engraved an item and when) is stored in internal metadata and logged to Discord if webhooks are enabled.
