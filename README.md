<img src="https://raw.githubusercontent.com/LXRCore/.github/main/profile/lxrcore-logo.png" alt="LXRCore" width="72" align="left" style="margin-right:12px">

# lxr-nui — the official LXRCore interface kit, as a resource

One look for every script on the server. `lxr-nui` ships the **LXR UI Kit**
(stylesheet, fonts, logo) and provides toasts, list menus, input dialogs and
progress bars through exports, so any developer — LXR or third-party — can
build on the same design without copying files.

## Use the kit from your own NUI

```html
<link rel="stylesheet" href="nui://lxr-nui/html/lxr-ui.css">
<script src="nui://lxr-nui/html/lxr-nui.js"></script>
<body class="lxr"> … <div class="lxr-panel lxr-hit">…</div>
```

`window.LXRNUI` gives you `row()` (the index row), `esc()`, `money()`, `pad()`,
`post()`. The guide is in [docs/LXR-UI-KIT.md](docs/LXR-UI-KIT.md); open
`docs/styleguide-standalone.html` in a browser to see every component.

## Use the provider from Lua

```lua
-- client
exports['lxr-nui']:Toast({ title = 'Bought bread', description = '$0.05', type = 'success' })
exports['lxr-nui']:Menu({ title = 'General Store', subtitle = 'Valentine', rows = {
    { id = 'bread', name = 'Bread', sub = 'Day-old loaf', price = 0.05 },
    { id = 'beans', name = 'Canned Beans', price = 0.10, badge = 'NEW' },
} }, function(id, row) if id then print('picked', id) end end)
exports['lxr-nui']:Input({ title = 'Name your horse', fields = { { id = 'name', label = 'Name', max = 24 } } }, function(v) if v then print(v.name) end end)
exports['lxr-nui']:Progress({ label = 'Brushing…', duration = 6000, canCancel = true }, function(done) end)

-- server
exports['lxr-nui']:Toast(src, { title = 'Welcome', type = 'inform' })
```

Client events mirror the exports (`lxr-nui:client:toast|menu|input|close`).
With `lxr-core` `Config.Notify.backend = 'lxr-nui'` every core notification is
drawn by this resource.

## Rules of the kit (short)

Six inks, one blood-red accent, no gold, no second hue; radius 0; hairline
borders; lists are index rows, not card grids; `.lxr-mono` uppercase labels;
Fraunces only at heading size; Georgian with `lang="ka"` and never uppercased.

© 2026 iBoss21 / LXRCore | lxrcore.com | All Rights Reserved — see LICENSE.
Fonts: Fraunces, Inter, JetBrains Mono, Noto Sans Georgian (SIL OFL 1.1).
