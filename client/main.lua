--[[ ═══════════════════════════════════════════════════════════════════════════
     LXR-NUI — Client: exports for toasts, menus, inputs, progress
     ═══════════════════════════════════════════════════════════════════════════
       exports['lxr-nui']:Toast(text | { title, description, type, duration })
       exports['lxr-nui']:Menu({ title, subtitle, rows = { { id, name, sub, meta, price, badge, disabled } } }, function(id, row) end)
       exports['lxr-nui']:Input({ title, fields = { { id, label, type = 'text'|'number'|'select', options, value, max } } }, function(values) end)
       exports['lxr-nui']:Progress({ label, duration, canCancel }, function(finished) end)
       exports['lxr-nui']:Close()
     Every call is also available as a client event 'lxr-nui:client:<toast|menu|input|progress|close>'
     and the toast as a server → client event 'lxr-nui:client:toast'.
     ═══════════════════════════════════════════════════════════════════════════
     © 2026 iBoss21 / LXRCore — All Rights Reserved
     ═══════════════════════════════════════════════════════════════════════════ ]]

local focus = false
local pending = {}   -- request id → callback
local nextId = 0
local progress = nil

local function send(action, payload) SendNUIMessage({ action = action, payload = payload }) end
local function setFocus(on)
    if focus == on then return end
    focus = on
    SetNuiFocus(on, on)
end

local function request(kind, payload, cb)
    nextId = nextId + 1
    local id = nextId
    pending[id] = cb
    payload = payload or {}
    payload.id = id
    send(kind, payload)
    return id
end

-- ═══════════════════════════════════════════════════════════════════════════════
-- 🔔 TOAST
-- ═══════════════════════════════════════════════════════════════════════════════
local function toast(opts)
    if type(opts) ~= 'table' then opts = { title = tostring(opts) } end
    opts.type = ({ success = 'ok', ok = 'ok', error = 'bad', bad = 'bad', warning = 'warn', warn = 'warn' })[tostring(opts.type or 'inform')] or 'inform'
    opts.duration = tonumber(opts.duration) or Config.Toast.durationMs
    send('toast', { title = opts.title, description = opts.description, type = opts.type, duration = opts.duration, position = Config.Toast.position, max = Config.Toast.maxVisible })
    if Config.Toast.sound then PlaySoundFrontend('NAV_UP', 'HUD_SHOP_SOUNDSET', true, 0) end
end
exports('Toast', toast)
RegisterNetEvent('lxr-nui:client:toast', toast)
-- the core's 'event' backend and lxr-notify consumers
if Config.CoreNotify then
    AddEventHandler('lxr-notify:client:show', function(opts) toast(opts) end)
end

-- ═══════════════════════════════════════════════════════════════════════════════
-- 📋 MENU
-- ═══════════════════════════════════════════════════════════════════════════════
local function menu(def, cb)
    if type(def) ~= 'table' then return false end
    def.position = def.position or Config.Menu.position
    def.width = def.width or Config.Menu.width
    def.closeOnSelect = def.closeOnSelect ~= false and Config.Menu.closeOnSelect
    setFocus(true)
    return request('menu', def, cb)
end
exports('Menu', menu)
RegisterNetEvent('lxr-nui:client:menu', function(def, event) menu(def, function(id, row) if event then TriggerEvent(event, id, row) end end) end)

-- ═══════════════════════════════════════════════════════════════════════════════
-- ⌨️ INPUT
-- ═══════════════════════════════════════════════════════════════════════════════
local function input(def, cb)
    if type(def) ~= 'table' or type(def.fields) ~= 'table' then return false end
    if #def.fields > Config.Input.maxFields then return false end
    def.maxLength = Config.Input.maxLength
    setFocus(true)
    return request('input', def, cb)
end
exports('Input', input)

-- ═══════════════════════════════════════════════════════════════════════════════
-- ⏳ PROGRESS
-- ═══════════════════════════════════════════════════════════════════════════════
local function progressBar(def, cb)
    if progress then return false end
    def = def or {}
    local duration = tonumber(def.duration) or 3000
    progress = { cb = cb, until_ = GetGameTimer() + duration, cancelled = false }
    send('progress', { label = def.label or '', duration = duration, canCancel = def.canCancel ~= false, position = Config.Progress.position })
    CreateThread(function()
        local dc = Config.Progress.disableControls
        while progress do
            Wait(0)
            if dc.combat then DisableControlAction(0, 0x07CE1E61, true) DisableControlAction(0, 0xF84FA74F, true) end
            if dc.movement then DisableControlAction(0, 0x8FD015D8, true) DisableControlAction(0, 0xD27782E3, true) DisableControlAction(0, 0x7065027D, true) DisableControlAction(0, 0xB4E465B4, true) end
            if def.canCancel ~= false and IsControlJustReleased(0, Config.Progress.cancelKey) then progress.cancelled = true break end
            if GetGameTimer() >= progress.until_ then break end
        end
        local p = progress
        progress = nil
        send('progressEnd', { cancelled = p and p.cancelled })
        if p and p.cb then p.cb(not p.cancelled) end
    end)
    return true
end
exports('Progress', progressBar)
exports('IsProgressActive', function() return progress ~= nil end)
exports('CancelProgress', function() if progress then progress.cancelled = true progress.until_ = 0 end end)

-- ═══════════════════════════════════════════════════════════════════════════════
-- 🧹 CLOSE / CALLBACKS
-- ═══════════════════════════════════════════════════════════════════════════════
local function close()
    send('close', {})
    setFocus(false)
    for id, cb in pairs(pending) do pending[id] = nil if cb then cb(nil) end end
end
exports('Close', close)
RegisterNetEvent('lxr-nui:client:close', close)

RegisterNUICallback('select', function(d, cb)
    local fn = pending[tonumber(d.id) or -1]
    pending[tonumber(d.id) or -1] = nil
    if d.closeOnSelect ~= false then setFocus(false) end
    if fn then fn(d.value, d.row) end
    cb('ok')
end)
RegisterNUICallback('submit', function(d, cb)
    local fn = pending[tonumber(d.id) or -1]
    pending[tonumber(d.id) or -1] = nil
    setFocus(false)
    if fn then fn(d.values) end
    cb('ok')
end)
RegisterNUICallback('close', function(_, cb) close() cb('ok') end)

CreateThread(function()
    while true do
        Wait(focus and 0 or 500)
        if focus and IsControlJustReleased(0, Config.Menu.closeKey) then close() end
    end
end)

AddEventHandler('onResourceStop', function(res) if res == GetCurrentResourceName() then setFocus(false) end end)
