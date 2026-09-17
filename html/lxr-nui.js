/* LXR-NUI helper — load from any resource: <script src="nui://lxr-nui/html/lxr-nui.js"></script>
   window.LXRNUI = { esc, money, pad, post, row, toast } | © 2026 iBoss21 / LXRCore */
(function () {
  const esc = (s) => String(s == null ? '' : s).replace(/[&<>"']/g, c => ({ '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' }[c]));
  const money = (n, sym) => (sym == null ? '$' : sym) + (Math.round((Number(n) || 0) * 100) / 100).toFixed(2);
  const pad = (i) => String(i).padStart(2, '0');
  const post = (name, body, res) => fetch(`https://${res || (typeof GetParentResourceName === 'function' ? GetParentResourceName() : 'lxr-nui')}/${name}`,
    { method: 'POST', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify(body || {}) }).then(r => r.json()).catch(() => ({ ok: false }));
  /** Build the kit's index row. r = { index, name, sub, ka, meta, price, badge, active, locked, compact, onclick } */
  function row(r) {
    const b = document.createElement('button');
    b.type = 'button';
    b.className = 'lxr-row' + (r.sub || r.ka ? ' lxr-row--sub' : '') + (r.compact ? ' lxr-row--compact' : '') + (r.active ? ' is-active' : '') + (r.locked ? ' is-locked' : '');
    if (r.locked) b.disabled = true;
    b.innerHTML = `<span class="lxr-row-index">${pad(r.index)}</span>` +
      (r.sub || r.ka ? `<span class="lxr-row-body lxr-grow"><span class="lxr-row-name">${esc(r.name)}</span>${r.ka ? `<span class="lxr-row-ka" lang="ka">${esc(r.ka)}</span>` : ''}${r.sub ? `<span class="lxr-row-sub">${r.subHtml ? r.sub : esc(r.sub)}</span>` : ''}</span>` : `<span class="lxr-row-name lxr-grow">${esc(r.name)}</span>`) +
      (r.badge ? `<span class="lxr-row-badge">${esc(r.badge)}</span>` : '') +
      (r.meta ? `<span class="lxr-row-meta">${esc(r.meta)}</span>` : '') +
      (r.price != null ? `<span class="lxr-row-price lxr-num">${typeof r.price === 'number' ? money(r.price) : esc(r.price)}</span>` : '');
    if (r.onclick) b.onclick = r.onclick;
    return b;
  }
  /** In-page toast (for pages that include the kit); resources normally call exports['lxr-nui']:Toast instead. */
  function toast(host, t) {
    const el = document.createElement('div');
    el.className = 'lxr-toast' + (t.type ? ' is-' + t.type : '');
    el.innerHTML = `<div class="t">${esc(t.title || '')}</div>${t.description ? `<div class="d">${esc(t.description)}</div>` : ''}`;
    host.appendChild(el);
    setTimeout(() => { el.classList.add('out'); setTimeout(() => el.remove(), 320); }, t.duration || 4000);
    return el;
  }
  window.LXRNUI = { esc, money, pad, post, row, toast };
})();
