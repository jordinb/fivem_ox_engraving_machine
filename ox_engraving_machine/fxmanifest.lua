fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name 'ox_engraving_machine'
author 'Infamous Development Studios / Jordin B.'
description 'Drag-and-drop Ox Inventory addon module for engraving custom metadata labels onto items.'
version '1.2.0'

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua'
}

client_scripts {
    'client/client.lua'
}

server_scripts {
    'version_control.lua',
    'server/server.lua'
}

dependencies {
    'ox_lib',
    'ox_inventory'
}
