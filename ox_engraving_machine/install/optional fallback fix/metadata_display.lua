-- Optional fallback snippet for heavily customized ox_inventory forks.
-- Usually not needed because ox_engraving_machine registers these automatically client-side.

exports.ox_inventory:displayMetadata({
    { 'engraving', 'Engraving' },
    -- Uncomment these only if you want audit data visible in the tooltip globally.
    -- { 'engraved_by', 'Engraved By' },
    -- { 'engraved_at', 'Engraved At' },
})
