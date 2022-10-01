fx_version 'adamant'
game 'gta5'

author 'Gusti Agung'
description 'Script System Giveaway'
version '1.0.0'

client_script "client.lua"

server_script {
    '@mysql-async/lib/MySQL.lua',
    "server.lua",
}

shared_script {
    '@es_extended/locale.lua',
    'config.lua',
    'locales/id.lua',
    'locales/en.lua'
}