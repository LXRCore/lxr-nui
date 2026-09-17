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
    print(('^5LXR-NUI^7 ^3v%s^7 — interface kit ready (nui://lxr-nui/html/lxr-ui.css)'):format(GetResourceMetadata(GetCurrentResourceName(), 'version', 0) or '?'))
end)
