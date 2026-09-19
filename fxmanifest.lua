--[[
    ██╗     ██╗  ██╗██████╗       ███╗   ██╗██╗   ██╗██╗
    ██║     ╚██╗██╔╝██╔══██╗      ████╗  ██║██║   ██║██║
    ██║      ╚███╔╝ ██████╔╝█████╗██╔██╗ ██║██║   ██║██║
    ██║      ██╔██╗ ██╔══██╗╚════╝██║╚██╗██║██║   ██║██║
    ███████╗██╔╝ ██╗██║  ██║      ██║ ╚████║╚██████╔╝██║
    ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝      ╚═╝  ╚═══╝ ╚═════╝ ╚═╝

    LXR Core - NUI: the official LXRCore interface kit as a resource

    Ships the LXR UI Kit (stylesheet, fonts, logo) so any resource links it
    with nui://lxr-nui/html/lxr-ui.css, and provides toasts, list menus,
    input dialogs and progress bars through exports — one look, everywhere.

    Brand:       LXRCore — Lux Empire eXperience RedM Core
    Developer:   iBoss21 / LXRCore
    Website:     https://www.lxrcore.com
    Discord:     https://discord.gg/GAhk8cgXe9
    GitHub:      https://github.com/LXRCore

    Version: 1.0.0
    Performance Target: 0.00 ms idle

    © 2026 iBoss21 / LXRCore | lxrcore.com | All Rights Reserved
]]

fx_version 'cerulean'
game 'rdr3'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'
lua54 'yes'

name 'lxr-nui'
author 'iBoss21 / LXRCore'
description 'LXRCore v3 interface kit: shared stylesheet + fonts, toasts, menus, inputs, progress bars'
version '1.0.0'
repository 'https://github.com/LXRCore/lxr-nui'

shared_scripts {
    'shared/locale.lua',
    'locales/*.lua',
    'config.lua',
}
client_script 'client/main.lua'
server_script 'server/main.lua'

ui_page 'html/index.html'

files {
    'html/index.html',
    'html/lxr-ui.css',
    'html/lxr-nui.js',
    'html/app.js',
    'html/fonts/*.woff2',
    'html/img/*.png',
}
