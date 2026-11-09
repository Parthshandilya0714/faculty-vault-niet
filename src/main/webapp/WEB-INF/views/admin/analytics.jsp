<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html lang="en" data-theme="dark">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dean Research Analytics &amp; Oversight &mdash; Faculty Vault</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Plus+Jakarta+Sans:wght@500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
    <!-- Chart.js for Visual Analytics -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    <style>
        :root {
            --bg-page: #f4f6fb; --bg-surface: #ffffff; --bg-subtle: #f8fafc;
            --border-ui: #e5e9f2; --text-heading: #0f172a; --text-body: #334155;
            --text-muted: #64748b; --brand: #2563eb; --brand-light: #eff6ff;
            --emerald: #10b981; --amber: #f59e0b; --card-radius: 18px;
            --shadow-subtle: 0 4px 20px -2px rgba(15, 23, 42, 0.06);
        }

        [data-theme="dark"] {
            --bg-page: #080c16; --bg-surface: #0f172a; --bg-subtle: #172138;
            --border-ui: rgba(255, 255, 255, 0.12); --text-heading: #ffffff;
            --text-body: #e2e8f0; --text-muted: #94a3b8; --brand: #3b82f6;
            --brand-light: rgba(59, 130, 246, 0.16); --emerald: #34d399;
            --amber: #fbbf24; --shadow-subtle: 0 10px 30px -4px rgba(0, 0, 0, 0.5);
        }

        [data-theme="dark"] body { color: var(--text-body) !important; background-color: var(--bg-page) !important; }
        [data-theme="dark"] .text-muted, [data-theme="dark"] small { color: var(--text-muted) !important; }
        [data-theme="dark"] h1, [data-theme="dark"] h2, [data-theme="dark"] h3, [data-theme="dark"] h4, [data-theme="dark"] h5, [data-theme="dark"] h6, [data-theme="dark"] strong { color: var(--text-heading) !important; }

        * { box-sizing: border-box; margin: 0; padding: 0; transition: background-color 0.2s ease, border-color 0.2s ease, color 0.15s ease; }
        body { font-family: 'Inter', system-ui, -apple-system, sans-serif; background-color: var(--bg-page); color: var(--text-body); min-height: 100vh; padding: 2.5rem; -webkit-font-smoothing: antialiased; }
        h1, h2, h3, h4, h5, h6 { font-family: 'Plus Jakarta Sans', sans-serif; color: var(--text-heading); letter-spacing: -0.02em; }

        .admin-container { max-width: 1400px; margin: 0 auto; }
        .admin-card { background-color: var(--bg-surface); border: 1px solid var(--border-ui); border-radius: var(--card-radius); padding: 1.6rem; box-shadow: var(--shadow-subtle); margin-bottom: 1.5rem; }

        .stat-box { background-color: var(--bg-surface); border: 1px solid var(--border-ui); border-radius: 16px; padding: 1.5rem; display: flex; align-items: center; justify-content: space-between; box-shadow: var(--shadow-subtle); }
        .stat-title { font-size: 0.74rem; font-weight: 700; text-transform: uppercase; letter-spacing: 0.5px; color: var(--text-muted); margin-bottom: 0.35rem; }
        .stat-val { font-size: 2.2rem; font-weight: 800; color: var(--text-heading); line-height: 1; font-family: 'Plus Jakarta Sans', sans-serif; }

        .table-portal { width: 100%; border-collapse: collapse; }
        .table-portal th { font-size: 0.72rem; text-transform: uppercase; letter-spacing: 0.5px; border-bottom: 1px solid var(--border-ui); padding: 1rem; background-color: var(--bg-subtle); color: var(--text-heading); font-weight: 700; white-space: nowrap; }
        .table-portal td { border-bottom: 1px solid var(--border-ui); vertical-align: middle; font-size: 0.88rem; padding: 1.1rem 1rem; color: var(--text-body); }
        .table-portal tbody tr.clickable { cursor: pointer; }
        .table-portal tbody tr.clickable:hover td { background-color: var(--bg-subtle); }

        .form-control, .form-select { background-color: var(--bg-page); border: 1px solid var(--border-ui); color: var(--text-heading); border-radius: 12px; padding: 0.7rem 1rem; font-size: 0.9rem; }
        .form-control:focus, .form-select:focus { background-color: var(--bg-page); color: var(--text-heading); border-color: var(--brand); box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.25); }

        .btn-theme-pill { background-color: var(--bg-surface); border: 1px solid var(--border-ui); color: var(--text-heading); border-radius: 30px; padding: 0.5rem 1rem; font-size: 0.82rem; font-weight: 600; cursor: pointer; display: inline-flex; align-items: center; gap: 7px; }
        .btn-amber { background-color: var(--amber); color: #080c16; font-weight: 700; border: none; border-radius: 12px; padding: 0.7rem 1.5rem; box-shadow: 0 4px 14px rgba(251, 191, 36, 0.25); }
        .btn-amber:hover { background-color: #f59e0b; color: #080c16; }

        .badge-api { background: rgba(245, 158, 11, 0.15); color: var(--amber); padding: 0.35rem 0.75rem; border-radius: 20px; font-weight: 800; font-size: 0.78rem; border: 1px solid rgba(245, 158, 11, 0.3); white-space: nowrap; }
        .chart-container { position: relative; height: 300px; width: 100%; }

        /* ---- Live status ---- */
        .live-pill { display: inline-flex; align-items: center; gap: 8px; padding: 0.35rem 0.85rem; border-radius: 30px; font-size: 0.74rem; font-weight: 700; border: 1px solid var(--border-ui); background: var(--bg-surface); color: var(--text-muted); }
        .live-pill .dot { width: 8px; height: 8px; border-radius: 50%; background: var(--text-muted); }
        .live-pill.live { color: var(--emerald); border-color: rgba(52, 211, 153, 0.35); }
        .live-pill.live .dot { background: var(--emerald); animation: livePulse 1.6s infinite; }
        .live-pill.error { color: var(--amber); border-color: rgba(251, 191, 36, 0.4); }
        .live-pill.error .dot { background: var(--amber); }
        .live-pill.auth { color: #f43f5e; border-color: rgba(244, 63, 94, 0.4); }
        .live-pill.auth .dot { background: #f43f5e; }
        @keyframes livePulse { 0% { box-shadow: 0 0 0 0 rgba(52, 211, 153, 0.6); } 100% { box-shadow: 0 0 0 10px rgba(52, 211, 153, 0); } }

        .row-new td { animation: rowFlash 6s ease-out; }
        @keyframes rowFlash { 0% { background-color: rgba(251, 191, 36, 0.28); } 100% { background-color: transparent; } }

        .toast-stack { position: fixed; right: 20px; bottom: 20px; z-index: 3000; display: flex; flex-direction: column; gap: 10px; }
        .toast-live { background: var(--bg-surface); border: 1px solid var(--border-ui); border-left: 4px solid var(--amber); border-radius: 12px; padding: 0.8rem 1rem; box-shadow: var(--shadow-subtle); max-width: 340px; font-size: 0.84rem; color: var(--text-body); animation: toastIn 0.4s ease; }
        .toast-live b { color: var(--text-heading); }
        @keyframes toastIn { from { opacity: 0; transform: translateX(30px); } to { opacity: 1; transform: none; } }

        .activity-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(340px, 1fr)); column-gap: 2rem; }
        .activity-item { display: flex; gap: 12px; padding: 0.8rem 0; border-bottom: 1px solid var(--border-ui); }
        .avatar { width: 38px; height: 38px; flex: 0 0 38px; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-weight: 800; font-size: 0.78rem; background: var(--brand-light); color: var(--brand); }
        .activity-title { font-weight: 600; font-size: 0.86rem; color: var(--text-heading); }

        @media (max-width: 768px) { body { padding: 1rem; } }
    </style>
</head>
<body>

    <div class="admin-container">
        <!-- Top Header Bar -->
        <div class="d-flex justify-content-between align-items-center mb-4 flex-wrap gap-3">
            <div>
                <h3 class="fw-bold mb-1"><i class="fa-solid fa-chart-line text-warning me-2"></i>Dean Research Analytics &amp; Oversight</h3>
                <p class="text-muted small mb-0">Multi-Faculty Research Aggregation, Live API Scoring &amp; Institutional Audit Command Center</p>
            </div>
            <div class="d-flex align-items-center gap-3 flex-wrap">
                <span class="live-pill" id="livePill" title="Data refreshes automatically from the database"><i class="dot"></i><span id="liveText">Connecting&hellip;</span></span>
                <button class="btn-theme-pill" onclick="toggleTheme()" id="themeToggleBtn">
                    <i class="fa-solid fa-sun text-warning" id="themeIcon"></i>
                    <span id="themeLabel">Light Theme</span>
                </button>
                <button onclick="exportMasterCSV()" class="btn btn-sm btn-outline-success rounded-pill px-4 fw-semibold py-2">
                    <i class="fa-solid fa-file-excel me-1"></i> Export CSV
                </button>
                <a href="${pageContext.request.contextPath}/admin/logout" class="btn btn-sm btn-outline-danger rounded-pill px-4 fw-semibold py-2">
                    <i class="fa-solid fa-right-from-bracket me-1"></i> Sign Out
                </a>
            </div>
        </div>

        <!-- Executive Metrics Cards (live from database) -->
        <div class="row g-4 mb-4">
            <div class="col-md-4">
                <div class="stat-box">
                    <div>
                        <div class="stat-title">Total Faculty Members</div>
                        <div class="stat-val text-primary" id="totalFacultyCount">0</div>
                        <small class="text-muted">Registered faculty accounts</small>
                    </div>
                    <div class="rounded-circle bg-primary bg-opacity-10 text-primary d-flex align-items-center justify-content-center" style="width: 58px; height: 58px; font-size: 1.5rem;">
                        <i class="fa-solid fa-users"></i>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="stat-box">
                    <div>
                        <div class="stat-title">Total Research Publications</div>
                        <div class="stat-val text-success" id="totalResearchCount">0</div>
                        <small class="text-muted">Indexed journals &amp; patents</small>
                    </div>
                    <div class="rounded-circle bg-success bg-opacity-10 text-success d-flex align-items-center justify-content-center" style="width: 58px; height: 58px; font-size: 1.5rem;">
                        <i class="fa-solid fa-award"></i>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="stat-box">
                    <div>
                        <div class="stat-title">Average Faculty API Score</div>
                        <div class="stat-val text-warning" id="avgApiScore">0.0</div>
                        <small class="text-muted">Performance based on UGC metrics</small>
                    </div>
                    <div class="rounded-circle bg-warning bg-opacity-10 text-warning d-flex align-items-center justify-content-center" style="width: 58px; height: 58px; font-size: 1.5rem;">
                        <i class="fa-solid fa-star"></i>
                    </div>
                </div>
            </div>
        </div>

        <!-- Visual Analytics Charts Section -->
        <div class="row g-4 mb-4">
            <div class="col-lg-7">
                <div class="admin-card h-100 mb-0">
                    <h5 class="fw-bold mb-3"><i class="fa-solid fa-chart-column text-warning me-2"></i>Top Faculty by Research Output</h5>
                    <div class="chart-container">
                        <canvas id="facultyBarChart"></canvas>
                    </div>
                </div>
            </div>
            <div class="col-lg-5">
                <div class="admin-card h-100 mb-0">
                    <h5 class="fw-bold mb-3"><i class="fa-solid fa-chart-pie text-primary me-2"></i>Category Distribution</h5>
                    <div class="chart-container">
                        <canvas id="categoryPieChart"></canvas>
                    </div>
                </div>
            </div>
        </div>

        <!-- Live Activity Feed -->
        <div class="admin-card">
            <div class="d-flex justify-content-between align-items-center mb-2">
                <h5 class="fw-bold mb-0"><i class="fa-solid fa-bolt text-warning me-2"></i>Live Activity</h5>
                <small class="text-muted">Latest submissions from all faculty</small>
            </div>
            <div class="activity-grid" id="activityFeed"></div>
        </div>

        <!-- Advanced Filter Toolbar -->
        <div class="admin-card">
            <div class="row g-3 align-items-end">
                <div class="col-lg-3 col-md-6">
                    <label class="form-label small text-muted fw-bold" for="filterFaculty">Faculty Member</label>
                    <select id="filterFaculty" class="form-select" onchange="onFilterChange()">
                        <option value="">&mdash; All Faculty Members &mdash;</option>
                    </select>
                </div>
                <div class="col-lg-2 col-md-6">
                    <label class="form-label small text-muted fw-bold" for="filterDept">Department</label>
                    <select id="filterDept" class="form-select" onchange="onFilterChange()">
                        <option value="">&mdash; All &mdash;</option>
                    </select>
                </div>
                <div class="col-lg-2 col-md-4">
                    <label class="form-label small text-muted fw-bold" for="filterCategory">Category</label>
                    <select id="filterCategory" class="form-select" onchange="onFilterChange()">
                        <option value="">&mdash; All &mdash;</option>
                    </select>
                </div>
                <div class="col-lg-2 col-md-4">
                    <label class="form-label small text-muted fw-bold" for="filterYear">Academic Year</label>
                    <select id="filterYear" class="form-select" onchange="onFilterChange()">
                        <option value="">&mdash; All Years &mdash;</option>
                    </select>
                </div>
                <div class="col-lg-2 col-md-4">
                    <label class="form-label small text-muted fw-bold" for="filterSearch">Search</label>
                    <input id="filterSearch" type="search" class="form-control" placeholder="Title, author, venue&hellip;" oninput="onFilterChange()">
                </div>
                <div class="col-lg-1 col-md-12">
                    <button type="button" class="btn btn-amber w-100 fw-bold" onclick="resetFilters()" title="Reset filters"><i class="fa-solid fa-rotate-right"></i></button>
                </div>
            </div>
        </div>

        <!-- Faculty-Wise API Score Breakdown Table -->
        <div class="admin-card">
            <div class="d-flex justify-content-between align-items-center mb-3 flex-wrap gap-2">
                <h5 class="fw-bold mb-0"><i class="fa-solid fa-id-card-clip text-warning me-2"></i>Faculty-Wise API Score &amp; Performance Breakdown</h5>
                <span class="badge bg-warning bg-opacity-10 text-warning border border-warning border-opacity-25 px-3 py-2 rounded-pill">Live Database Audit &middot; click a row to filter</span>
            </div>
            <div class="table-responsive">
                <table class="table-portal">
                    <thead>
                        <tr>
                            <th>Faculty Name</th>
                            <th>Department</th>
                            <th>Designation</th>
                            <th>Publications</th>
                            <th>Patents</th>
                            <th>Last Submission</th>
                            <th>Calculated API Score</th>
                        </tr>
                    </thead>
                    <tbody id="facultySummaryTableBody"></tbody>
                </table>
            </div>
        </div>

        <!-- Master Records Table -->
        <div class="admin-card">
            <div class="d-flex justify-content-between align-items-center mb-3 flex-wrap gap-2">
                <h5 class="fw-bold mb-0"><i class="fa-solid fa-table-list text-primary me-2"></i>Filtered Research Logs &amp; Live Audit Trail</h5>
                <span class="badge bg-secondary bg-opacity-25 text-secondary border px-3 py-2 rounded-pill" id="totalLogsBadge">Total Logs: 0</span>
            </div>
            <div class="table-responsive">
                <table class="table-portal">
                    <thead>
                        <tr>
                            <th>Faculty Name</th>
                            <th>Department</th>
                            <th>Category</th>
                            <th>Title &amp; Authors</th>
                            <th>Publisher / Venue</th>
                            <th>Date Submitted</th>
                        </tr>
                    </thead>
                    <tbody id="researchLogsTableBody"></tbody>
                </table>
            </div>
        </div>
    </div>

    <div class="toast-stack" id="toastStack"></div>

<script>
    /* =====================================================================
       LIVE DATA: everything below comes from the database through
       GET /admin/api/analytics (see AdminAnalyticsController.java).
       No localStorage is used for data any more.
       ===================================================================== */
    const API_URL   = '${pageContext.request.contextPath}/admin/api/analytics';
    const LOGIN_URL = '${pageContext.request.contextPath}/admin/auth';
    const POLL_MS   = 8000;      // refresh interval
    const MAX_ROWS  = 300;       // rows drawn in the audit table (CSV export always has everything)
    // API score = BASE + publications * PUB + patents * PATENT   (same formula as before; edit here)
    const API_WEIGHTS = { base: 40, publication: 15, patent: 25 };

    let state = { faculty: [], records: [] };
    let lastSig = '', firstLoad = true, pollTimer = null, failCount = 0;
    let knownIds = new Set(), newIds = new Set();
    let barChart = null, pieChart = null;

    const $ = (id) => document.getElementById(id);
    const esc = (s) => String(s == null ? '' : s).replace(/[&<>"']/g, (c) => ({ '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' }[c]));
    const isPatent = (cat) => /patent/i.test(cat || '');
    const tsOf = (r) => Date.parse(r.submittedAt || r.date) || 0;

    function acYear(r) {
        if (r.year) return r.year;
        const d = new Date(r.date);
        if (isNaN(d)) return '';
        const start = (d.getMonth() + 1) >= 7 ? d.getFullYear() : d.getFullYear() - 1;
        return start + '-' + (start + 1);
    }
    function fmtDate(s) {
        const d = new Date(s);
        return isNaN(d) ? (s || 'N/A') : d.toLocaleDateString('en-IN', { day: '2-digit', month: 'short', year: 'numeric' });
    }
    function ago(ts) {
        if (!ts) return '';
        const s = Math.max(0, (Date.now() - ts) / 1000);
        if (s < 60) return 'just now';
        if (s < 3600) return Math.floor(s / 60) + ' min ago';
        if (s < 86400) return Math.floor(s / 3600) + ' hr ago';
        return Math.floor(s / 86400) + ' d ago';
    }
    function initials(name) {
        const p = String(name || '?').replace(/^(Dr|Prof|Mr|Ms|Mrs)\.?\s+/i, '').trim().split(/\s+/);
        return ((p[0] || '?')[0] + (p.length > 1 ? p[p.length - 1][0] : '')).toUpperCase();
    }
    function apiScore(recs) {
        const patents = recs.filter((r) => isPatent(r.category)).length;
        return API_WEIGHTS.base + (recs.length - patents) * API_WEIGHTS.publication + patents * API_WEIGHTS.patent;
    }

    /* ---------------- polling ---------------- */
    function setStatus(kind, text) {
        $('livePill').className = 'live-pill ' + kind;
        $('liveText').textContent = text;
    }
    async function poll() {
        try {
            const res = await fetch(API_URL, { headers: { 'Accept': 'application/json' }, credentials: 'same-origin', cache: 'no-store' });
            if (res.status === 401 || res.status === 403) {
                setStatus('auth', 'Session expired');
                setTimeout(() => { window.location.href = LOGIN_URL; }, 1500);
                return false;
            }
            if (!res.ok) throw new Error('HTTP ' + res.status);
            const data = await res.json();
            failCount = 0;
            setStatus('live', 'LIVE \u00B7 ' + new Date().toLocaleTimeString('en-IN'));
            const faculty = data.faculty || [], records = data.records || [];
            const sig = JSON.stringify([faculty, records]);
            if (sig !== lastSig) {
                lastSig = sig;
                detectNew(records);
                state = { faculty: faculty, records: records };
                enrich();
                renderAll();
            }
            return true;
        } catch (e) {
            failCount++;
            setStatus('error', 'Reconnecting\u2026');
            return false;
        }
    }
    function schedule() {
        clearTimeout(pollTimer);
        const delay = Math.min(POLL_MS * Math.pow(2, Math.min(failCount, 3)), 60000);
        pollTimer = setTimeout(async () => { if (!document.hidden) await poll(); schedule(); }, delay);
    }
    document.addEventListener('visibilitychange', () => { if (!document.hidden) { poll(); schedule(); } });

    function enrich() {
        const byId = {};
        state.faculty.forEach((f) => { byId[f.id] = f; });
        state.records.forEach((r) => {
            const f = byId[r.facultyId];
            if (f) { r.facultyName = r.facultyName || f.name; r.department = r.department || f.department; }
        });
    }

    /* ---------------- new-submission toasts ---------------- */
    function detectNew(records) {
        const fresh = records.filter((r) => !knownIds.has(r.id));
        records.forEach((r) => knownIds.add(r.id));
        if (firstLoad) { firstLoad = false; return; }
        if (!fresh.length) return;
        newIds = new Set(fresh.map((r) => r.id));
        setTimeout(() => { newIds = new Set(); }, 6000);
        if (fresh.length <= 3) {
            fresh.forEach((r) => toast('<b>' + esc(r.facultyName || 'A faculty member') + '</b> submitted<br>' + esc(r.title || r.category)));
        } else {
            toast('<b>' + fresh.length + ' new submissions</b> just arrived');
        }
    }
    function toast(html) {
        const el = document.createElement('div');
        el.className = 'toast-live';
        el.innerHTML = '<i class="fa-solid fa-bolt text-warning me-2"></i>' + html;
        $('toastStack').appendChild(el);
        setTimeout(() => { el.style.opacity = '0'; el.style.transform = 'translateX(30px)'; }, 6500);
        setTimeout(() => el.remove(), 7200);
    }

    /* ---------------- filters ---------------- */
    function filters() {
        return { fac: $('filterFaculty').value, dept: $('filterDept').value, cat: $('filterCategory').value,
                 year: $('filterYear').value, q: $('filterSearch').value.trim().toLowerCase() };
    }
    function scoped() {          // department + category + year (used by charts and per-faculty counts)
        const f = filters();
        return state.records.filter((r) => (!f.dept || r.department === f.dept) && (!f.cat || r.category === f.cat) && (!f.year || acYear(r) === f.year));
    }
    function logsFiltered() {    // + faculty + free-text search (used by the audit table / CSV)
        const f = filters();
        return scoped().filter((r) => {
            if (f.fac && String(r.facultyId) !== f.fac) return false;
            if (!f.q) return true;
            return [r.title, r.authors, r.venue, r.facultyName, r.category].join(' ').toLowerCase().indexOf(f.q) !== -1;
        }).sort((a, b) => tsOf(b) - tsOf(a));
    }
    function fillSelect(id, items, allLabel) {   // items: [{value,label}]
        const el = $(id), prev = el.value;
        el.innerHTML = '<option value="">' + allLabel + '</option>' + items.map((i) => '<option value="' + esc(i.value) + '">' + esc(i.label) + '</option>').join('');
        el.value = items.some((i) => String(i.value) === prev) ? prev : '';
    }
    function uniq(arr) { return Array.from(new Set(arr.filter(Boolean))).sort(); }

    function onFilterChange() { renderViews(); }
    function resetFilters() {
        ['filterFaculty', 'filterDept', 'filterCategory', 'filterYear'].forEach((id) => { $(id).value = ''; });
        $('filterSearch').value = '';
        renderViews();
    }

    /* ---------------- rendering ---------------- */
    function renderAll() {
        fillSelect('filterFaculty', state.faculty.slice().sort((a, b) => String(a.name).localeCompare(String(b.name)))
            .map((f) => ({ value: f.id, label: f.name + (f.department ? ' (' + f.department + ')' : '') })), '\u2014 All Faculty Members \u2014');
        fillSelect('filterDept', uniq(state.faculty.map((f) => f.department).concat(state.records.map((r) => r.department))).map((d) => ({ value: d, label: d })), '\u2014 All \u2014');
        fillSelect('filterCategory', uniq(state.records.map((r) => r.category)).map((c) => ({ value: c, label: c })), '\u2014 All \u2014');
        fillSelect('filterYear', uniq(state.records.map(acYear)).reverse().map((y) => ({ value: y, label: y })), '\u2014 All Years \u2014');

        // global metrics
        const perFac = state.faculty.map((f) => apiScore(state.records.filter((r) => String(r.facultyId) === String(f.id))));
        $('totalFacultyCount').textContent = state.faculty.length;
        $('totalResearchCount').textContent = state.records.length;
        $('avgApiScore').textContent = perFac.length ? (perFac.reduce((a, b) => a + b, 0) / perFac.length).toFixed(1) : '0.0';

        renderActivity();
        renderViews();
    }

    function renderViews() {
        renderSummary();
        renderLogs();
        updateCharts();
    }

    function renderActivity() {
        const latest = state.records.slice().sort((a, b) => tsOf(b) - tsOf(a)).slice(0, 8);
        $('activityFeed').innerHTML = latest.length ? latest.map((r) =>
            '<div class="activity-item"><div class="avatar">' + esc(initials(r.facultyName)) + '</div><div class="flex-grow-1">' +
            '<div class="activity-title">' + esc(r.title || '(untitled)') + '</div>' +
            '<small class="text-muted">' + esc(r.facultyName || 'Unknown') + ' &middot; ' + esc(r.category || '') + ' &middot; ' + esc(ago(tsOf(r))) + '</small></div></div>'
        ).join('') : '<div class="text-muted small py-3">No submissions yet. They will appear here the moment a faculty member submits.</div>';
    }

    function renderSummary() {
        const f = filters(), recs = scoped(), body = $('facultySummaryTableBody');
        let list = state.faculty.filter((x) => (!f.dept || x.department === f.dept) && (!f.fac || String(x.id) === f.fac));
        if (!list.length) {
            body.innerHTML = '<tr><td colspan="7" class="text-center text-muted py-4">No faculty records available yet. Data appears here when faculty members register and submit their research.</td></tr>';
            return;
        }
        const rows = list.map((x) => {
            const mine = recs.filter((r) => String(r.facultyId) === String(x.id));
            const patents = mine.filter((r) => isPatent(r.category)).length;
            const last = mine.reduce((m, r) => Math.max(m, tsOf(r)), 0);
            return { x: x, pubs: mine.length - patents, patents: patents, last: last, score: apiScore(mine) };
        }).sort((a, b) => b.score - a.score);
        body.innerHTML = rows.map((r) =>
            '<tr class="clickable" data-fid="' + esc(r.x.id) + '"><td class="fw-bold">' + esc(r.x.name) + '</td>' +
            '<td class="text-muted">' + esc(r.x.department || 'N/A') + '</td>' +
            '<td><span class="badge bg-secondary bg-opacity-25">' + esc(r.x.designation || 'Faculty Member') + '</span></td>' +
            '<td>' + r.pubs + '</td><td>' + r.patents + '</td>' +
            '<td class="text-muted">' + (r.last ? esc(ago(r.last)) : '&mdash;') + '</td>' +
            '<td><span class="badge-api">' + r.score + ' API Pts</span></td></tr>'
        ).join('');
    }

    function renderLogs() {
        const logs = logsFiltered(), body = $('researchLogsTableBody');
        $('totalLogsBadge').textContent = 'Total Logs: ' + logs.length;
        if (!logs.length) {
            body.innerHTML = '<tr><td colspan="6" class="text-center text-muted py-5"><i class="fa-solid fa-folder-open fa-2x mb-2 opacity-50"></i><div>No research records match the current filters.</div></td></tr>';
            return;
        }
        body.innerHTML = logs.slice(0, MAX_ROWS).map((r) =>
            '<tr class="' + (newIds.has(r.id) ? 'row-new' : '') + '"><td class="fw-bold">' + esc(r.facultyName || 'N/A') + '</td>' +
            '<td class="text-muted">' + esc(r.department || 'N/A') + '</td>' +
            '<td><span class="badge bg-primary bg-opacity-15 text-primary border border-primary border-opacity-25">' + esc(r.category || 'N/A') + '</span></td>' +
            '<td><div class="fw-bold">' + esc(r.title) + '</div>' + (r.authors ? '<div class="small text-muted">' + esc(r.authors) + '</div>' : '') + '</td>' +
            '<td>' + (r.indexing ? '<span class="badge bg-info bg-opacity-10 text-info fw-bold">' + esc(r.indexing) + '</span>' : '') +
            '<div class="small text-muted mt-1">' + esc(r.venue || '') + '</div></td>' +
            '<td>' + esc(fmtDate(r.submittedAt || r.date)) + (r.status ? '<div class="small text-muted">' + esc(r.status) + '</div>' : '') + '</td></tr>'
        ).join('') + (logs.length > MAX_ROWS ? '<tr><td colspan="6" class="text-center text-muted small py-3">Showing latest ' + MAX_ROWS + ' of ' + logs.length + '. Use Export CSV for the full list.</td></tr>' : '');
    }

    function updateCharts() {
        if (typeof Chart === 'undefined') return;
        const dark = document.documentElement.getAttribute('data-theme') === 'dark';
        const tc = dark ? '#e2e8f0' : '#334155', gc = dark ? 'rgba(255,255,255,0.08)' : 'rgba(15,23,42,0.08)';
        const recs = scoped();

        const counts = {};
        recs.forEach((r) => { const k = String(r.facultyId); counts[k] = (counts[k] || 0) + 1; });
        const top = state.faculty.map((f) => ({ n: String(f.name || '').replace(/^(Dr|Prof|Mr|Ms|Mrs)\.?\s+/i, ''), c: counts[String(f.id)] || 0 }))
            .filter((x) => x.c > 0).sort((a, b) => b.c - a.c).slice(0, 10);
        const barLabels = top.map((x) => x.n.length > 16 ? x.n.slice(0, 15) + '\u2026' : x.n), barData = top.map((x) => x.c);

        const catMap = {};
        recs.forEach((r) => { const k = r.category || 'Other'; catMap[k] = (catMap[k] || 0) + 1; });
        const catLabels = Object.keys(catMap), catData = catLabels.map((k) => catMap[k]);
        const palette = ['#3b82f6', '#10b981', '#f59e0b', '#8b5cf6', '#ef4444', '#06b6d4', '#ec4899'];

        if (!barChart) {
            barChart = new Chart($('facultyBarChart').getContext('2d'), {
                type: 'bar',
                data: { labels: barLabels, datasets: [{ label: 'Research Outputs', data: barData, backgroundColor: '#f59e0b', borderRadius: 8 }] },
                options: { responsive: true, maintainAspectRatio: false, plugins: { legend: { display: false } },
                    scales: { y: { beginAtZero: true, ticks: { color: tc, precision: 0 }, grid: { color: gc } }, x: { ticks: { color: tc }, grid: { display: false } } } }
            });
        } else {
            barChart.data.labels = barLabels; barChart.data.datasets[0].data = barData;
            barChart.options.scales.y.ticks.color = tc; barChart.options.scales.y.grid.color = gc; barChart.options.scales.x.ticks.color = tc;
            barChart.update();
        }
        if (!pieChart) {
            pieChart = new Chart($('categoryPieChart').getContext('2d'), {
                type: 'doughnut',
                data: { labels: catLabels, datasets: [{ data: catData, backgroundColor: palette, borderWidth: 0 }] },
                options: { responsive: true, maintainAspectRatio: false, plugins: { legend: { position: 'bottom', labels: { color: tc, font: { family: 'Inter', size: 12 } } } } }
            });
        } else {
            pieChart.data.labels = catLabels; pieChart.data.datasets[0].data = catData;
            pieChart.options.plugins.legend.labels.color = tc;
            pieChart.update();
        }
    }

    /* ---------------- export ---------------- */
    function csvCell(v) {
        let s = String(v == null ? '' : v);
        if (/^[=+\-@\t\r]/.test(s)) s = "'" + s;      // stop spreadsheet formula injection
        return '"' + s.replace(/"/g, '""') + '"';
    }
    function exportMasterCSV() {
        const rows = logsFiltered();
        const head = ['Faculty Name', 'Department', 'Category', 'Title', 'Authors', 'Publisher/Venue', 'Indexing', 'Academic Year', 'Date'];
        const lines = [head.map(csvCell).join(',')];
        rows.forEach((r) => lines.push([r.facultyName, r.department, r.category, r.title, r.authors, r.venue, r.indexing, acYear(r), r.submittedAt || r.date].map(csvCell).join(',')));
        const blob = new Blob(['\uFEFF' + lines.join('\r\n')], { type: 'text/csv;charset=utf-8' });
        const a = document.createElement('a');
        a.href = URL.createObjectURL(blob);
        a.download = 'NIET_Faculty_Research_' + new Date().toISOString().slice(0, 10) + '.csv';
        document.body.appendChild(a); a.click(); a.remove();
        setTimeout(() => URL.revokeObjectURL(a.href), 2000);
    }

    /* ---------------- theme ---------------- */
    function applyTheme(theme) {
        document.documentElement.setAttribute('data-theme', theme);
        try { localStorage.setItem('facultyVaultAdminTheme', theme); } catch (e) {}
        const icon = $('themeIcon'), label = $('themeLabel');
        if (theme === 'dark') { icon.className = 'fa-solid fa-moon text-warning'; label.innerText = 'Dark Theme'; }
        else { icon.className = 'fa-solid fa-sun text-warning'; label.innerText = 'Light Theme'; }
        updateCharts();
    }
    function toggleTheme() {
        applyTheme((document.documentElement.getAttribute('data-theme') || 'dark') === 'dark' ? 'light' : 'dark');
    }

    document.addEventListener('DOMContentLoaded', () => {
        let saved = 'dark';
        try { saved = localStorage.getItem('facultyVaultAdminTheme') || 'dark'; } catch (e) {}
        applyTheme(saved);
        $('facultySummaryTableBody').addEventListener('click', (e) => {
            const tr = e.target.closest('tr[data-fid]');
            if (!tr) return;
            const sel = $('filterFaculty');
            sel.value = sel.value === tr.dataset.fid ? '' : tr.dataset.fid;
            renderViews();
            $('researchLogsTableBody').scrollIntoView({ behavior: 'smooth', block: 'start' });
        });
        poll().then(schedule);
    });
</script>
</body>
</html>
