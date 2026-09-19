--[[
    LXR Core - NUI configuration
    © 2026 iBoss21 / LXRCore | lxrcore.com | All Rights Reserved
]]

Config = Config or {}

-- Language for the provider page's own labels (Confirm / Cancel / hints): any bundle in locales/ ('en', 'ka').
Config.Lang = 'en'

-- 'auto' follows lxr-core's Config.UI.theme (LXR Night / LXR Morning); or force 'night' | 'morning' for a standalone install
Config.Theme = 'auto'

Config.Toast = {
    position    = 'top-right',  -- 'top-right' | 'top-left' | 'bottom-right' | 'bottom-left' | 'top-center' | 'bottom-center'
    offsetTop   = 180,          -- px from the top for the top-* positions: under lxr-hud's date / name / cash block
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
