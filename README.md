# ox_engraving_machine

Drag-and-drop Ox Inventory addon module for engraving custom metadata labels onto items.

**Requirements**
- FiveM server
- `ox_lib` and `ox_inventory` resources
- Lua 5.4 runtime (fxmanifest.lua declares `lua54 'yes'`)

**Installation**
- Place the `ox_engraving_machine` folder in your server `resources` directory.
- Add the resource to your `server.cfg`:

```cfg
ensure ox_engraving_machine
```

**Configuration**
- Edit `config.lua` to adjust behavior and notifications.
- Important keys for overwrite protection:
  - `Config.AllowReEngrave` (bool) — allow overwriting engravings at all.
  - `Config.RequireReEngraveAce` (bool) — when true, requires an ACE permission to overwrite.
  - `Config.ReEngraveAcePermission` (string) — default `engraving.overwrite` (change to fit your ACL).

**Server ACL example**
Grant the ACE permission to an admin group and assign players to that group (adjust identifiers):

```cfg
# create permission and allow it for group.admin
add_ace group.admin engraving.overwrite allow

# assign a player identifier to group.admin
add_principal identifier.steam:110000112345678 group.admin
```

**Usage**
- Players use the configured item (`Config.MachineItem`) from `ox_inventory` to prepare an engraving, then apply it to a target item.
- If an item already has an engraving and `Config.RequireReEngraveAce` is enabled, the player must have the ACE permission configured by `Config.ReEngraveAcePermission` to overwrite.

**Notes**
- The resource logs admin actions to Discord when `Config.Webhook.Enabled` is `true` and `Config.Webhook.Url` is set.
- See `install/` for example `ox_inventory` item data used by this resource.