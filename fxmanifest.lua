fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'Falkowski-M'
description 'System granatów hukowych z efektem oślepienia'
version '1.0.0'

ui_page 'html/index.html'

client_script 'client.lua'
server_script 'server.lua'

files {
    'html/index.html',
    'html/sounds/flashbang.ogg',
    "flashbang/loadouts.meta",
	"flashbang/weaponarchetypes.meta",
	"flashbang/weaponanimations.meta",
	"flashbang/pedpersonality.meta",
	"flashbang/weapons.meta"
}

shared_script '@ox_lib/init.lua'

data_file 'AUDIO_WAVEPACK' 'sounds'
data_file "WEAPON_METADATA_FILE" "flashbang/weaponarchetypes.meta"
data_file "WEAPON_ANIMATIONS_FILE" "flashbang/weaponanimations.meta"
data_file "LOADOUTS_FILE" "flashbang/loadouts.meta"
data_file "WEAPONINFO_FILE" "flashbang/weapons.meta"
data_file "PED_PERSONALITY_FILE" "flashbang/pedpersonality.meta"