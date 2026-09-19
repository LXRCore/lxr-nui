# Changelog — lxr-nui

## 3.0.0 — 2026-09-19
* Toasts sit under lxr-hud's top-right block (`Config.Toast.offsetTop`, 180 px) instead of over the name and cash.
* LXRCore v3 release line: every resource ships as 3.0.0 from here (the entries below are the road to it).

## 1.0.1 — 2026-09-19
* Toast: a call with no title uses its description; one with nothing to say draws nothing (no empty bar).

## [1.0.0] — 2026-09-17
- LXR UI Kit 1.0.0 shipped as a resource (`nui://lxr-nui/html/lxr-ui.css`, fonts, logo, `lxr-nui.js` helpers).
- Toast, Menu, Input, Progress exports + client/server events; core notification backend.
