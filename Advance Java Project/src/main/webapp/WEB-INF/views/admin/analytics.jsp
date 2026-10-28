<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html lang="en" data-theme="dark">
<head>
    <meta charset="UTF-8">
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
        .table-portal th { font-size: 0.72rem; text-transform: uppercase; letter-spacing: 0.5px; border-bottom: 1px solid var(--border-ui); padding: 1rem; background-color: var(--bg-subtle); color: var(--text-heading); font-weight: 700; }
        .table-portal td { border-bottom: 1px solid var(--border-ui); vertical-align: middle; font-size: 0.88rem; padding: 1.1rem 1rem; color: var(--text-body); }

        .form-control, .form-select { background-color: var(--bg-page); border: 1px solid var(--border-ui); color: var(--text-heading); border-radius: 12px; padding: 0.7rem 1rem; font-size: 0.9rem; }
        .form-control:focus, .form-select:focus { background-color: var(--bg-page); color: var(--text-heading); border-color: var(--brand); box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.25); }

        .btn-theme-pill { background-color: var(--bg-surface); border: 1px solid var(--border-ui); color: var(--text-heading); border-radius: 30px; padding: 0.5rem 1rem; font-size: 0.82rem; font-weight: 600; cursor: pointer; display: inline-flex; align-items: center; gap: 7px; }
        .btn-amber { background-color: var(--amber); color: #080c16; font-weight: 700; border: none; border-radius: 12px; padding: 0.7rem 1.5rem; box-shadow: 0 4px 14px rgba(251, 191, 36, 0.25); }
        .btn-amber:hover { background-color: #f59e0b; color: #080c16; }
        
        .badge-api { background: rgba(245, 158, 11, 0.15); color: var(--amber); padding: 0.35rem 0.75rem; border-radius: 20px; font-weight: 800; font-size: 0.78rem; border: 1px solid rgba(245, 158, 11, 0.3); }
        .chart-container { position: relative; height: 300px; width: 100%; }
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
            <div class="d-flex align-items-center gap-3">
                <button class="btn-theme-pill" onclick="toggleTheme()" id="themeToggleBtn">
                    <i class="fa-solid fa-sun text-warning" id="themeIcon"></i>
                    <span id="themeLabel">Light Theme</span>
                </button>
                <button onclick="exportMasterCSV()" class="btn btn-sm btn-outline-success rounded-pill px-4 fw-semibold py-2">
                    <i class="fa-solid fa-file-excel me-1"></i> Export Master CSV
                </button>
                <a href="${pageContext.request.contextPath}/admin/logout" class="btn btn-sm btn-outline-danger rounded-pill px-4 fw-semibold py-2">
                    <i class="fa-solid fa-right-from-bracket me-1"></i> Sign Out
                </a>
            </div>
        </div>

        <!-- Executive Metrics Cards (Real DB / Live Sync) -->
        <div class="row g-4 mb-4">
            <div class="col-md-4">
                <div class="stat-box">
                    <div>
                        <div class="stat-title">Total Faculty Members</div>
                        <div class="stat-val text-primary" id="totalFacultyCount">0</div>
                        <small class="text-muted">Active registered staff members</small>
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
                    <h5 class="fw-bold mb-3"><i class="fa-solid fa-chart-column text-warning me-2"></i>Faculty Research Outputs (Bar Chart)</h5>
                    <div class="chart-container">
                        <canvas id="facultyBarChart"></canvas>
                    </div>
                </div>
            </div>
            <div class="col-lg-5">
                <div class="admin-card h-100 mb-0">
                    <h5 class="fw-bold mb-3"><i class="fa-solid fa-chart-pie text-primary me-2"></i>Category Distribution (Doughnut)</h5>
                    <div class="chart-container">
                        <canvas id="categoryPieChart"></canvas>
                    </div>
                </div>
            </div>
        </div>

        <!-- Advanced Filter Toolbar -->
        <div class="admin-card">
            <div class="row g-3 align-items-end">
                <div class="col-md-4">
                    <label class="form-label small text-muted fw-bold">Filter by Faculty Member</label>
                    <select id="filterFaculty" class="form-select" onchange="applyFilters()">
                        <option value="">&mdash; All Faculty Members &mdash;</option>
                    </select>
                </div>
                <div class="col-md-3">
                    <label class="form-label small text-muted fw-bold">Filter by Category</label>
                    <select id="filterCategory" class="form-select" onchange="applyFilters()">
                        <option value="">&mdash; All Categories &mdash;</option>
                        <option value="SCI / Scopus Journal">SCI / Scopus Journal</option>
                        <option value="Patent Granted / Filed">Patent Granted / Filed</option>
                        <option value="International Conference">International Conference</option>
                        <option value="Book Chapter">Book Chapter</option>
                    </select>
                </div>
                <div class="col-md-3">
                    <label class="form-label small text-muted fw-bold">Academic Year</label>
                    <select id="filterYear" class="form-select" onchange="applyFilters()">
                        <option value="2026-2027">2026-2027</option>
                        <option value="2025-2026">2025-2026</option>
                    </select>
                </div>
                <div class="col-md-2 d-flex gap-2">
                    <button type="button" class="btn btn-amber w-100 fw-bold" onclick="resetFilters()"><i class="fa-solid fa-rotate-right me-1"></i> Reset</button>
                </div>
            </div>
        </div>

        <!-- Faculty-Wise API Score Breakdown Table -->
        <div class="admin-card">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <h5 class="fw-bold mb-0"><i class="fa-solid fa-id-card-clip text-warning me-2"></i>Faculty-Wise API Score &amp; Performance Breakdown</h5>
                <span class="badge bg-warning bg-opacity-10 text-warning border border-warning border-opacity-25 px-3 py-2 rounded-pill">Live Database Audit</span>
            </div>
            <div class="table-responsive">
                <table class="table-portal">
                    <thead>
                        <tr>
                            <th>Faculty Name</th>
                            <th>Department</th>
                            <th>Designation</th>
                            <th>Total Publications</th>
                            <th>Patents</th>
                            <th>Calculated API Score</th>
                        </tr>
                    </thead>
                    <tbody id="facultySummaryTableBody">
                        <!-- Populated dynamically from real DB / live submissions -->
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Master Records Table -->
        <div class="admin-card">
            <div class="d-flex justify-content-between align-items-center mb-3">
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
                    <tbody id="researchLogsTableBody">
                        <!-- Populated dynamically from real DB / live submissions -->
                    </tbody>
                </table>
            </div>
        </div>
    </div>

<script>
    // Empty registry by default — populated strictly from real backend / local storage live submissions
    let registeredFacultyList = [];

    function getResearchLogs() {
        let logs = localStorage.getItem('nietFacultyResearchLogs');
        if (!logs) {
            logs = JSON.stringify([]);
            localStorage.setItem('nietFacultyResearchLogs', logs);
        }
        return JSON.parse(logs);
    }

    function getRegisteredFaculty(logs) {
        // Extract unique faculty members from actual submissions or keep empty if none submitted
        let map = new Map();
        logs.forEach(l => {
            if (!map.has(l.facultyName)) {
                map.set(l.facultyName, { name: l.facultyName, dept: l.department || 'General Department', designation: 'Faculty Member' });
            }
        });
        return Array.from(map.values());
    }

    let barChartInstance = null;
    let pieChartInstance = null;

    function renderDashboard() {
        const logs = getResearchLogs();
        const facultyList = getRegisteredFaculty(logs);
        
        // Populate Faculty dropdown filter
        const facultySelect = document.getElementById('filterFaculty');
        const currentSelected = facultySelect.value;
        facultySelect.innerHTML = '<option value="">&mdash; All Faculty Members &mdash;</option>';
        facultyList.forEach(f => {
            facultySelect.innerHTML += `<option value="\${f.name}">\${f.name} (\${f.dept})</option>`;
        });
        facultySelect.value = currentSelected;

        // Update top metrics
        document.getElementById('totalFacultyCount').innerText = facultyList.length;
        document.getElementById('totalResearchCount').innerText = logs.length;

        // Faculty summary table
        let totalApiSum = 0;
        const facultySummaryBody = document.getElementById('facultySummaryTableBody');
        facultySummaryBody.innerHTML = '';

        if (facultyList.length === 0) {
            facultySummaryBody.innerHTML = `<tr><td colspan="6" class="text-center text-muted py-4">No faculty records available yet. Data will appear when faculty members submit their credentials or research outputs.</td></tr>`;
            document.getElementById('avgApiScore').innerText = '0.0';
        } else {
            facultyList.forEach(fac => {
                const facLogs = logs.filter(l => l.facultyName === fac.name);
                const pubs = facLogs.filter(l => l.category !== 'Patent Granted / Filed').length;
                const patents = facLogs.filter(l => l.category === 'Patent Granted / Filed').length;
                
                const apiScore = (pubs * 15) + (patents * 25) + 40;
                totalApiSum += apiScore;

                facultySummaryBody.innerHTML += `
                    <tr>
                        <td class="fw-bold">\${fac.name}</td>
                        <td class="text-muted">\${fac.dept}</td>
                        <td><span class="badge bg-secondary bg-opacity-25 text-light">\${fac.designation}</span></td>
                        <td>\${pubs}</td>
                        <td>\${patents}</td>
                        <td><span class="badge-api">\${apiScore} API Pts</span></td>
                    </tr>
                `;
            });
            const avgApi = (totalApiSum / facultyList.length).toFixed(1);
            document.getElementById('avgApiScore').innerText = avgApi;
        }

        applyFilters();
        updateCharts(logs, facultyList);
    }

    function applyFilters() {
        const facultyFilter = document.getElementById('filterFaculty').value;
        const categoryFilter = document.getElementById('filterCategory').value;
        const yearFilter = document.getElementById('filterYear').value;
        const logs = getResearchLogs();

        const filtered = logs.filter(l => {
            let matchFac = !facultyFilter || l.facultyName === facultyFilter;
            let matchCat = !categoryFilter || l.category === categoryFilter;
            let matchYear = !yearFilter || (l.year && l.year === yearFilter) || (!l.year && yearFilter === '2026-2027');
            return matchFac && matchCat && matchYear;
        });

        renderLogsTable(filtered);
    }

    function renderLogsTable(logs) {
        const tbody = document.getElementById('researchLogsTableBody');
        tbody.innerHTML = '';
        document.getElementById('totalLogsBadge').innerText = `Total Logs: \${logs.length}`;

        if (logs.length === 0) {
            tbody.innerHTML = `<tr><td colspan="6" class="text-center text-muted py-5"><i class="fa-solid fa-folder-open fa-2x mb-2 opacity-50"></i><div>No research records have been submitted yet. Submissions from faculty portals will appear here live.</div></td></tr>`;
            return;
        }

        logs.forEach(log => {
            tbody.innerHTML += `
                <tr>
                    <td class="fw-bold">\${log.facultyName}</td>
                    <td class="text-muted">\${log.department || 'N/A'}</td>
                    <td><span class="badge bg-primary bg-opacity-15 text-primary border border-primary border-opacity-25">\${log.category}</span></td>
                    <td><div class="fw-bold">\${log.title}</div></td>
                    <td>
                        <span class="badge bg-info bg-opacity-10 text-info fw-bold">SCOPUS</span>
                        <div class="small text-muted mt-1">\${log.venue}</div>
                    </td>
                    <td>\${log.date}</td>
                </tr>
            `;
        });
    }

    function updateCharts(logs, facultyList) {
        const isDark = document.documentElement.getAttribute('data-theme') === 'dark';
        const textColor = isDark ? '#e2e8f0' : '#334155';
        const gridColor = isDark ? 'rgba(255, 255, 255, 0.08)' : 'rgba(15, 23, 42, 0.08)';

        // 1. Bar Chart: Faculty Publications count
        const facultyNames = facultyList.map(f => f.name.split(' ').pop());
        const pubCounts = facultyList.map(f => logs.filter(l => l.facultyName === f.name).length);

        if (barChartInstance) barChartInstance.destroy();
        const barCtx = document.getElementById('facultyBarChart').getContext('2d');
        barChartInstance = new Chart(barCtx, {
            type: 'bar',
            data: {
                labels: facultyNames,
                datasets: [{
                    label: 'Research Outputs',
                    data: pubCounts,
                    backgroundColor: '#f59e0b',
                    borderRadius: 8
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: { legend: { display: false } },
                scales: {
                    y: { ticks: { color: textColor, precision: 0 }, grid: { color: gridColor } },
                    x: { ticks: { color: textColor }, grid: { display: false } }
                }
            }
        });

        // 2. Doughnut Chart: Categories Distribution
        const categories = ['SCI / Scopus Journal', 'Patent Granted / Filed', 'International Conference', 'Book Chapter'];
        const catCounts = categories.map(cat => logs.filter(l => l.category === cat).length);

        if (pieChartInstance) pieChartInstance.destroy();
        const pieCtx = document.getElementById('categoryPieChart').getContext('2d');
        pieChartInstance = new Chart(pieCtx, {
            type: 'doughnut',
            data: {
                labels: ['Journals', 'Patents', 'Conferences', 'Books'],
                datasets: [{
                    data: catCounts,
                    backgroundColor: ['#3b82f6', '#10b981', '#f59e0b', '#8b5cf6'],
                    borderWidth: 0
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: { position: 'bottom', labels: { color: textColor, font: { family: 'Inter', size: 12 } } }
                }
            }
        });
    }

    function resetFilters() {
        document.getElementById('filterFaculty').value = '';
        document.getElementById('filterCategory').value = '';
        document.getElementById('filterYear').value = '2026-2027';
        renderDashboard();
    }

    function exportMasterCSV() {
        const logs = getResearchLogs();
        let csv = 'Faculty Name,Department,Category,Title,Publisher/Venue,Date\n';
        logs.forEach(l => {
            csv += `"\${l.facultyName}","\${l.department}","\${l.category}","\${l.title}","\${l.venue}","\${l.date}"\n`;
        });
        const blob = new Blob([csv], { type: 'text/csv' });
        const url = window.URL.createObjectURL(blob);
        const a = document.createElement('a');
        a.setAttribute('href', url);
        a.setAttribute('download', 'NIET_Faculty_Research_Master.csv');
        a.click();
    }

    function applyTheme(theme) {
        document.documentElement.setAttribute('data-theme', theme);
        localStorage.setItem('facultyVaultAdminTheme', theme);
        const icon = document.getElementById('themeIcon');
        const label = document.getElementById('themeLabel');
        if (theme === 'dark') {
            if (icon) icon.className = 'fa-solid fa-moon text-warning';
            if (label) label.innerText = 'Dark Theme';
        } else {
            if (icon) icon.className = 'fa-solid fa-sun text-warning';
            if (label) label.innerText = 'Light Theme';
        }
        renderDashboard();
    }

    function toggleTheme() {
        const current = document.documentElement.getAttribute('data-theme') || 'dark';
        applyTheme(current === 'dark' ? 'light' : 'dark');
    }

    window.addEventListener('storage', (e) => {
        if (e.key === 'nietFacultyResearchLogs') {
            renderDashboard();
        }
    });

    document.addEventListener('DOMContentLoaded', () => {
        applyTheme(localStorage.getItem('facultyVaultAdminTheme') || 'dark');
    });
</script>
</body>
</html>