/* LXR-NUI — provider page | © 2026 iBoss21 / LXRCore */
(function () {
  const { esc, row, toast } = window.LXRNUI;
  const $ = (id) => document.getElementById(id);
  const post = (name, body) => fetch(`https://${typeof GetParentResourceName === 'function' ? GetParentResourceName() : 'lxr-nui'}/${name}`, { method: 'POST', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify(body || {}) }).catch(() => {});
  let current = null; // { id, kind, closeOnSelect }

  function showMenu(p) {
    const m = $('menu');
    m.className = 'lxr-panel lxr-hit ' + (p.position || 'left');
    m.style.width = (p.width || 460) + 'px';
    m.innerHTML = `<header class="nui-head lxr-rule-b"><img class="nui-logo" src="img/lxrcore-logo.png" alt=""><div>${p.subtitle ? `<div class="lxr-mono lxr-t-ash">${esc(p.subtitle)}</div>` : ''}<div class="lxr-cut nui-title">${esc(p.title || '')}</div></div></header>
      <div class="nui-rows"></div>
      <footer class="nui-foot lxr-rule"><span class="lxr-mono lxr-t-ash"><span class="lxr-key">Esc</span> close</span><span class="lxr-mono lxr-t-ash">${(p.rows || []).length} items</span></footer>`;
    const host = m.querySelector('.nui-rows');
    (p.rows || []).forEach((r, i) => host.appendChild(row({
      index: i + 1, name: r.name, sub: r.sub, ka: r.ka, meta: r.meta, price: r.price, badge: r.badge, locked: r.disabled, active: r.active, compact: p.compact,
      onclick: () => { post('select', { id: p.id, value: r.id != null ? r.id : i + 1, row: r, closeOnSelect: p.closeOnSelect }); if (p.closeOnSelect !== false) hideMenu(); },
    })));
    current = { id: p.id, kind: 'menu' };
    m.classList.remove('lxr-hidden');
  }

  function showInput(p) {
    const m = $('menu');
    m.className = 'lxr-panel lxr-hit ' + (p.position || 'center');
    m.style.width = (p.width || 460) + 'px';
    const fields = (p.fields || []).map(f => {
      const id = 'f-' + esc(f.id);
      if (f.type === 'select') return `<label><span class="lxr-mono lxr-t-ash">${esc(f.label || f.id)}</span><select class="lxr-input" id="${id}">${(f.options || []).map(o => `<option value="${esc(o.value != null ? o.value : o)}" ${String(o.value != null ? o.value : o) === String(f.value) ? 'selected' : ''}>${esc(o.label || o)}</option>`).join('')}</select></label>`;
      return `<label><span class="lxr-mono lxr-t-ash">${esc(f.label || f.id)}</span><input class="lxr-input" id="${id}" type="${f.type === 'number' ? 'number' : 'text'}" value="${esc(f.value != null ? f.value : '')}" maxlength="${f.max || p.maxLength || 120}" placeholder="${esc(f.placeholder || '')}" ${f.min != null ? `min="${f.min}"` : ''} ${f.step != null ? `step="${f.step}"` : ''}></label>`;
    }).join('');
    m.innerHTML = `<header class="nui-head lxr-rule-b"><img class="nui-logo" src="img/lxrcore-logo.png" alt=""><div>${p.subtitle ? `<div class="lxr-mono lxr-t-ash">${esc(p.subtitle)}</div>` : ''}<div class="lxr-cut nui-title">${esc(p.title || '')}</div></div></header>
      <div class="nui-fields">${fields}</div>
      <div class="nui-actions"><button class="lxr-btn" id="nui-submit">${esc(p.submit || 'Confirm')}</button><button class="lxr-btn-ghost" id="nui-cancel">${esc(p.cancel || 'Cancel')}</button></div>`;
    $('nui-submit').onclick = () => {
      const values = {};
      (p.fields || []).forEach(f => { const el = $('f-' + f.id); values[f.id] = f.type === 'number' ? Number(el.value) : el.value; });
      post('submit', { id: p.id, values }); hideMenu();
    };
    $('nui-cancel').onclick = () => { post('close'); hideMenu(); };
    current = { id: p.id, kind: 'input' };
    m.classList.remove('lxr-hidden');
    const first = m.querySelector('.lxr-input'); if (first) first.focus();
  }

  function hideMenu() { $('menu').classList.add('lxr-hidden'); current = null; }

  let progTimer = null;
  function showProgress(p) {
    const box = $('progress');
    box.className = 'lxr-panel ' + (p.position || 'bottom-center');
    $('progress-label').textContent = p.label || '';
    $('progress-hint').textContent = p.canCancel ? 'X — cancel' : '';
    const fill = $('progress-fill');
    fill.style.transition = 'none'; fill.style.width = '0%';
    box.classList.remove('lxr-hidden');
    requestAnimationFrame(() => { fill.style.transition = `width ${p.duration}ms linear`; fill.style.width = '100%'; });
    clearTimeout(progTimer);
    progTimer = setTimeout(() => box.classList.add('lxr-hidden'), p.duration + 200);
  }

  window.addEventListener('message', (e) => {
    const { action, payload } = e.data || {};
    if (action === 'toast') { const host = $('toasts'); host.className = payload.position || 'top-right'; while (host.children.length >= (payload.max || 5)) host.firstChild.remove(); toast(host, payload); }
    else if (action === 'menu') showMenu(payload);
    else if (action === 'input') showInput(payload);
    else if (action === 'progress') showProgress(payload);
    else if (action === 'progressEnd') { clearTimeout(progTimer); $('progress').classList.add('lxr-hidden'); }
    else if (action === 'close') hideMenu();
  });
  document.addEventListener('keydown', (e) => { if (e.key === 'Escape' && current) { post('close'); hideMenu(); } });
})();
