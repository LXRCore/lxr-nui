--[[ ═══════════════════════════════════════════════════════════════════════════
     LXR-NUI — Server: toast to a player or everyone
     © 2026 iBoss21 / LXRCore — All Rights Reserved
     ═══════════════════════════════════════════════════════════════════════════ ]]

exports('Toast', function(src, opts)
    if src == -1 or src == nil then TriggerClientEvent('lxr-nui:client:toast', -1, opts)
    else TriggerClientEvent('lxr-nui:client:toast', src, opts) end
end)

CreateThread(function()
    Wait(1000)
    local rule = '^3  ═══════════════════════════════════════════════════════════════════════^7'
    local function row(label, value) print(('^7   %s %s %s^7'):format(label, string.rep('·', math.max(1, 17 - #label)), value)) end
    print('')
    for _, l in ipairs({
        '███╗   ██╗██╗   ██╗██╗',
        '████╗  ██║██║   ██║██║',
        '██╔██╗ ██║██║   ██║██║',
        '██║╚██╗██║██║   ██║██║',
        '██║ ╚████║╚██████╔╝██║',
        '╚═╝  ╚═══╝ ╚═════╝ ╚═╝',
    }) do print('^8    ' .. l .. '^7') end
    print('')
    print(rule)
    print('^3   🐺 LXR-NUI^7 · ^8Interface kit: toasts, menus, inputs, progress^7 · ^5RedM^7')
    print(rule)
    row('Resource', '^8' .. GetCurrentResourceName())
    row('Version', '^8' .. (GetResourceMetadata(GetCurrentResourceName(), 'version', 0) or '?'))
    row('Framework', '^8' .. ((GetResourceState('lxr-core') == 'started' and 'LXRCore (lxr-core)') or (GetResourceState('rsg-core') == 'started' and 'RSG Core') or (GetResourceState('vorp_core') == 'started' and 'VORP Core') or 'standalone'))
    row('Language', '^8' .. tostring(Config.Lang or 'en'))
    row('Kit stylesheet', '^8nui://lxr-nui/html/lxr-ui.css')
    row('Toasts', ('^8%s^7, %d visible'):format(tostring(Config.Toast.position), Config.Toast.maxVisible or 3))
    row('Core notify', Config.CoreNotify and '^2ROUTED^7' or '^3OFF^7')
    row('Theme', '^8' .. tostring(Config.Theme))
    print(rule)
    row('Website', '^4https://www.lxrcore.com')
    row('Discord', '^4https://discord.gg/GAhk8cgXe9')
    row('Store', '^4https://theluxempire.tebex.io')
    row('Developer', '^8iBoss21 / LXRCore')
    print(rule)
    print('')
end)
