--[[
    LXR Core - NUI configuration
    © 2026 iBoss21 / LXRCore | lxrcore.com | All Rights Reserved
]]

Config = Config or {}

Config.Toast = {
    position    = 'top-right',  -- 'top-right' | 'top-left' | 'bottom-right' | 'bottom-left' | 'top-center' | 'bottom-center'
    durationMs  = 4000,
    maxVisible  = 5,
    sound       = true,         -- short UI sound on toast (native frontend sound)
}

Config.Menu = {
    position    = 'left',       -- 'left' | 'center' | 'right'
    width       = 460,
    closeKey    = 0x156F7119,   -- BACKSPACE (ESC always works inside the NUI)
    closeOnSelect = true,
}

Config.Progress = {
    position    = 'bottom-center',
    cancelKey   = 0x8CC9CD42,   -- X
    disableControls = { movement = false, combat = true, mount = false },
}

Config.Input = {
    maxFields   = 6,
    maxLength   = 120,
}

-- Route the core's notifications through lxr-nui when it is running.
-- (lxr-core: Config.Notify.backend = 'lxr-nui')
Config.CoreNotify = true
