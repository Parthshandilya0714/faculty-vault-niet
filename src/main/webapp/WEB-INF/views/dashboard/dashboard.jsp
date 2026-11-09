<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html lang="en" data-theme="dark">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Faculty Vault &mdash; Academic Operations Dossier</title>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Plus+Jakarta+Sans:wght@500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.1/dist/chart.umd.min.js"></script>

    <style>
        :root {
            --bg-page: #f4f6fb; --bg-surface: #ffffff; --bg-subtle: #f8fafc;
            --border-ui: #e5e9f2; --text-heading: #0f172a; --text-body: #334155;
            --text-muted: #64748b; --brand: #2563eb; --brand-deep: #1d4ed8;
            --brand-light: #eff6ff; --emerald: #10b981; --emerald-light: #ecfdf5;
            --purple: #8b5cf6; --purple-light: #f5f3ff; --amber: #f59e0b;
            --amber-light: #fffbeb; --sidebar-w: 250px; --card-radius: 18px;
            --shadow-subtle: 0 4px 20px -2px rgba(15, 23, 42, 0.04);
        }

        [data-theme="dark"] {
            --bg-page: #080c16; --bg-surface: #0f172a; --bg-subtle: #172138;
            --border-ui: rgba(255, 255, 255, 0.12); --text-heading: #ffffff;
            --text-body: #e2e8f0; --text-muted: #94a3b8; --brand: #3b82f6;
            --brand-deep: #2563eb; --brand-light: rgba(59, 130, 246, 0.16);
            --emerald: #34d399; --emerald-light: rgba(16, 185, 129, 0.16);
            --purple: #a78bfa; --purple-light: rgba(139, 92, 246, 0.16);
            --amber: #fbbf24; --amber-light: rgba(251, 191, 36, 0.16);
            --shadow-subtle: 0 10px 30px -4px rgba(0, 0, 0, 0.45);
        }

        [data-theme="dark"] body { color: #e2e8f0 !important; background-color: var(--bg-page) !important; }
        [data-theme="dark"] .text-muted, [data-theme="dark"] small, [data-theme="dark"] .small { color: #94a3b8 !important; }
        [data-theme="dark"] .text-secondary { color: #cbd5e1 !important; }
        [data-theme="dark"] h1, [data-theme="dark"] h2, [data-theme="dark"] h3, [data-theme="dark"] h4, [data-theme="dark"] h5, [data-theme="dark"] h6, [data-theme="dark"] strong, [data-theme="dark"] b { color: #ffffff !important; }
        [data-theme="dark"] .card-portal, [data-theme="dark"] .stat-widget, [data-theme="dark"] .action-card, [data-theme="dark"] .rail-card, [data-theme="dark"] .spec-tile { background-color: var(--bg-surface) !important; border-color: var(--border-ui) !important; }
        [data-theme="dark"] .table-portal th { background-color: #0c1424 !important; color: #cbd5e1 !important; border-color: var(--border-ui) !important; }
        [data-theme="dark"] .table-portal td { color: #e2e8f0 !important; border-color: var(--border-ui) !important; }

        * { box-sizing: border-box; margin: 0; padding: 0; transition: background-color 0.2s ease, border-color 0.2s ease, color 0.15s ease; }
        body { font-family: 'Inter', system-ui, -apple-system, sans-serif; background-color: var(--bg-page); color: var(--text-body); min-height: 100vh; display: flex; -webkit-font-smoothing: antialiased; }
        h1, h2, h3, h4, h5, h6, .font-heading { font-family: 'Plus Jakarta Sans', sans-serif; color: var(--text-heading); letter-spacing: -0.02em; }

        .portal-sidebar { width: var(--sidebar-w); background-color: var(--bg-surface); border-right: 1px solid var(--border-ui); height: 100vh; position: fixed; top: 0; left: 0; display: flex; flex-direction: column; justify-content: space-between; padding: 1.5rem 1.15rem; z-index: 1000; }
        .brand-box { display: flex; align-items: center; gap: 12px; padding-bottom: 1.25rem; border-bottom: 1px solid var(--border-ui); margin-bottom: 1.5rem; }
        .brand-icon { width: 42px; height: 42px; background: linear-gradient(135deg, #1d4ed8, #2563eb); color: #ffffff; border-radius: 12px; display: flex; align-items: center; justify-content: center; font-size: 1.2rem; box-shadow: 0 4px 14px rgba(37, 99, 235, 0.35); }
        .brand-title { font-size: 0.95rem; font-weight: 800; color: var(--text-heading); line-height: 1.15; }
        .brand-sub { font-size: 0.65rem; color: var(--amber); font-weight: 700; letter-spacing: 0.5px; text-transform: uppercase; }
        .nav-link-btn { color: var(--text-muted); padding: 0.72rem 0.95rem; border-radius: 10px; display: flex; align-items: center; gap: 12px; font-weight: 600; font-size: 0.88rem; text-decoration: none; cursor: pointer; margin-bottom: 4px; border: none; background: transparent; width: 100%; text-align: left; }
        .nav-link-btn:hover { color: var(--text-heading); background-color: var(--bg-subtle); }
        .nav-link-btn.active { color: #ffffff !important; background-color: var(--brand) !important; box-shadow: 0 3px 12px rgba(37, 99, 235, 0.35); }

        .portal-workspace { margin-left: var(--sidebar-w); flex-grow: 1; padding: 1.8rem 2.4rem; min-height: 100vh; width: calc(100% - var(--sidebar-w)); }
        .workspace-topbar { display: flex; align-items: center; justify-content: space-between; margin-bottom: 1.8rem; flex-wrap: wrap; gap: 14px; }
        .top-search-wrap { position: relative; min-width: 320px; }
        .top-search-input { width: 100%; background-color: var(--bg-surface); border: 1px solid var(--border-ui); border-radius: 30px; padding: 0.55rem 1rem 0.55rem 2.5rem; font-size: 0.85rem; color: var(--text-heading); outline: none; }
        .card-portal { background-color: var(--bg-surface); border: 1px solid var(--border-ui); border-radius: var(--card-radius); padding: 1.5rem; box-shadow: var(--shadow-subtle); }
        .action-card { background: var(--bg-surface); border: 1px solid var(--border-ui); border-radius: 16px; padding: 1.2rem; display: flex; align-items: center; justify-content: space-between; cursor: pointer; text-decoration: none; transition: all 0.25s ease; box-shadow: 0 2px 10px rgba(0, 0, 0, 0.02); }
        .action-card:hover { transform: translateY(-3px); border-color: var(--brand); box-shadow: 0 8px 24px rgba(0, 0, 0, 0.07); }
        .action-icon-pill { width: 46px; height: 46px; border-radius: 12px; display: flex; align-items: center; justify-content: center; font-size: 1.3rem; margin-bottom: 0.8rem; }
        .action-arrow { width: 30px; height: 30px; border-radius: 50%; display: flex; align-items: center; justify-content: center; background: var(--bg-subtle); color: var(--text-muted); font-size: 0.78rem; }
        .stat-widget { background-color: var(--bg-surface); border: 1px solid var(--border-ui); border-radius: 16px; padding: 1.35rem 1.4rem; box-shadow: var(--shadow-subtle); }
        .stat-title { font-size: 0.74rem; font-weight: 700; text-transform: uppercase; letter-spacing: 0.5px; color: var(--text-muted); margin-bottom: 0.35rem; }
        .stat-val { font-size: 2rem; font-weight: 800; color: var(--text-heading); line-height: 1; margin-bottom: 0.4rem; font-family: 'Plus Jakarta Sans', sans-serif; }
        .stat-trend-tag { font-size: 0.7rem; font-weight: 600; padding: 0.22rem 0.6rem; border-radius: 20px; display: inline-flex; align-items: center; gap: 5px; }
        .rail-card { background-color: var(--bg-surface); border: 1px solid var(--border-ui); border-radius: var(--card-radius); padding: 1.4rem; box-shadow: var(--shadow-subtle); margin-bottom: 1.5rem; }
        .researcher-badge-box { display: flex; align-items: center; gap: 14px; padding-bottom: 1.2rem; border-bottom: 1px solid var(--border-ui); margin-bottom: 1.2rem; }
        .researcher-avatar { width: 54px; height: 54px; border-radius: 14px; background: linear-gradient(135deg, #1e40af, #2563eb); color: #ffffff; display: flex; align-items: center; justify-content: center; font-weight: 800; font-size: 1.4rem; flex-shrink: 0; box-shadow: 0 4px 14px rgba(37, 99, 235, 0.3); }
        .appraisal-meter-box { display: flex; align-items: center; justify-content: space-between; gap: 12px; margin-bottom: 1.2rem; padding: 1.1rem; background-color: var(--bg-subtle); border: 1px solid var(--border-ui); border-radius: 14px; }
        .meter-ring { width: 58px; height: 58px; border-radius: 50%; background: conic-gradient(var(--brand) 0% var(--pct, 0%), var(--border-ui) var(--pct, 0%) 100%); display: flex; align-items: center; justify-content: center; position: relative; flex-shrink: 0; }
        .meter-ring::before { content: ''; position: absolute; width: 44px; height: 44px; border-radius: 50%; background: var(--bg-surface); }
        .meter-ring span { position: relative; font-size: 0.74rem; font-weight: 800; color: var(--text-heading); }
        .table-portal { width: 100%; border-collapse: collapse; }
        .table-portal th { font-size: 0.72rem; text-transform: uppercase; letter-spacing: 0.5px; border-bottom: 1px solid var(--border-ui); padding: 0.85rem 1rem; background-color: var(--bg-subtle); color: var(--text-muted); font-weight: 700; }
        .table-portal td { border-bottom: 1px solid var(--border-ui); vertical-align: middle; font-size: 0.88rem; padding: 1rem; }
        .view-pane-section { display: none; }
        .view-pane-section.active-pane { display: block; animation: fadeIn 0.25s ease-out; }
        @keyframes fadeIn { from { opacity: 0; transform: translateY(4px); } to { opacity: 1; transform: translateY(0); } }
        .btn-theme-pill { background-color: var(--bg-surface); border: 1px solid var(--border-ui); color: var(--text-heading); border-radius: 30px; padding: 0.5rem 1rem; font-size: 0.82rem; font-weight: 600; cursor: pointer; display: inline-flex; align-items: center; gap: 7px; }
        .btn-brand-cta { background-color: var(--brand); color: #ffffff !important; border: none; padding: 0.55rem 1.25rem; border-radius: 30px; font-size: 0.84rem; font-weight: 600; display: inline-flex; align-items: center; gap: 8px; cursor: pointer; box-shadow: 0 4px 12px rgba(37, 99, 235, 0.3); }
        .modal-content { background-color: var(--bg-surface); color: var(--text-body); border: 1px solid var(--border-ui); border-radius: 18px; }
        .form-control, .form-select { background-color: var(--bg-page); border: 1px solid var(--border-ui); color: var(--text-heading); border-radius: 10px; padding: 0.65rem 0.9rem; font-size: 0.9rem; }
        @media (max-width: 992px) { .portal-sidebar { display: none; } .portal-workspace { margin-left: 0; width: 100%; padding: 1.25rem; } }

        /* ================= Portal additions ================= */
        .fv-logo-tile { background: #ffffff; border: 1px solid var(--border-ui); border-radius: 10px; padding: 8px 12px; width: 100%; display: flex; align-items: center; justify-content: center; min-height: 56px; }
        .fv-logo-tile img { max-width: 100%; max-height: 52px; object-fit: contain; display: block; }
        .fv-logo-fallback { font-family: 'Plus Jakarta Sans', sans-serif; font-weight: 800; font-size: 1.25rem; color: #b91c1c; line-height: 1; }
        .fv-logo-fallback small { display: block; font-size: .6rem; color: #475569; font-weight: 600; letter-spacing: .3px; margin-top: 2px; }
        .brand-box { flex-direction: column; align-items: flex-start !important; gap: 12px !important; }
        .brand-title { font-size: .95rem; letter-spacing: 0; }
        .brand-sub { text-transform: none; letter-spacing: 0; font-weight: 500; font-size: .72rem; color: var(--text-muted); }

        .fv-icon-btn { position: relative; width: 40px; height: 40px; border-radius: 50%; background: var(--bg-surface); border: 1px solid var(--border-ui); color: var(--text-heading); display: inline-flex; align-items: center; justify-content: center; cursor: pointer; }
        .fv-icon-btn:hover { border-color: var(--brand); }
        .fv-badge { position: absolute; top: -3px; right: -3px; min-width: 17px; height: 17px; padding: 0 4px; border-radius: 9px; background: #dc2626; color: #fff; font-size: .64rem; font-weight: 700; display: none; align-items: center; justify-content: center; }
        .fv-badge.show { display: inline-flex; }

        .fv-notif-panel { position: absolute; right: 0; top: calc(100% + 10px); width: 360px; max-width: 92vw; background: var(--bg-surface); border: 1px solid var(--border-ui); border-radius: 12px; box-shadow: 0 16px 40px rgba(0,0,0,.25); z-index: 2500; display: none; overflow: hidden; }
        .fv-notif-panel.open { display: block; }
        .fv-notif-head { display: flex; align-items: center; justify-content: space-between; padding: .8rem 1rem; border-bottom: 1px solid var(--border-ui); font-size: .88rem; }
        .fv-notif-list { max-height: 360px; overflow-y: auto; }
        .fv-notif-item { padding: .75rem 1rem; border-bottom: 1px solid var(--border-ui); font-size: .82rem; border-left: 3px solid transparent; }
        .fv-notif-item.unread { border-left-color: var(--brand); background: var(--bg-subtle); }
        .fv-empty { padding: 2rem 1rem; text-align: center; color: var(--text-muted); font-size: .85rem; }

        .fv-toast-wrap { position: fixed; top: 16px; right: 16px; z-index: 3000; display: flex; flex-direction: column; gap: 8px; width: 340px; max-width: calc(100vw - 32px); }
        .fv-toast { background: var(--bg-surface); border: 1px solid var(--border-ui); border-left: 3px solid var(--brand); border-radius: 8px; padding: .75rem .9rem; box-shadow: 0 8px 24px rgba(0,0,0,.22); font-size: .84rem; animation: fvIn .25s ease-out; }
        .fv-toast.out { opacity: 0; transform: translateY(-6px); transition: all .25s; }
        @keyframes fvIn { from { opacity: 0; transform: translateY(-8px); } to { opacity: 1; transform: none; } }
        .fv-toast .t-title { font-weight: 600; color: var(--text-heading); }
        .fv-toast .t-sub { color: var(--text-muted); font-size: .79rem; margin-top: 2px; }
        .fv-link-btn { background: none; border: none; padding: 0; color: var(--brand); font-size: .8rem; font-weight: 600; cursor: pointer; }
        .fv-link-btn:hover { text-decoration: underline; }
        .fv-link-btn[disabled] { color: var(--text-muted); cursor: default; text-decoration: none; }

        .fv-dialog { position: fixed; inset: 0; z-index: 3500; background: rgba(8,12,22,.55); display: none; align-items: center; justify-content: center; padding: 1rem; }
        .fv-dialog.open { display: flex; }
        .fv-dialog-card { width: 420px; max-width: 100%; background: var(--bg-surface); border: 1px solid var(--border-ui); border-radius: 12px; padding: 1.6rem 1.6rem 1.3rem; box-shadow: 0 20px 50px rgba(0,0,0,.35); animation: fvIn .2s ease-out; }

        .fv-cmd { position: fixed; inset: 0; z-index: 3800; background: rgba(8,12,22,.5); display: none; align-items: flex-start; justify-content: center; padding-top: 14vh; }
        .fv-cmd.open { display: flex; }
        .fv-cmd-box { width: 520px; max-width: 94vw; background: var(--bg-surface); border: 1px solid var(--border-ui); border-radius: 12px; box-shadow: 0 20px 50px rgba(0,0,0,.4); overflow: hidden; }
        .fv-cmd-input { width: 100%; background: transparent; border: none; border-bottom: 1px solid var(--border-ui); padding: .9rem 1.1rem; color: var(--text-heading); font-size: .95rem; outline: none; }
        .fv-cmd-list { max-height: 320px; overflow-y: auto; padding: 6px; }
        .fv-cmd-row { display: flex; align-items: center; gap: 12px; padding: .6rem .8rem; border-radius: 8px; cursor: pointer; font-size: .86rem; }
        .fv-cmd-row i { width: 16px; text-align: center; color: var(--text-muted); }
        .fv-cmd-row.sel, .fv-cmd-row:hover { background: var(--bg-subtle); color: var(--text-heading); }

        .fv-check { display: flex; align-items: flex-start; gap: 12px; padding: .85rem 0; border-bottom: 1px solid var(--border-ui); font-size: .88rem; }
        .fv-check:last-child { border-bottom: none; }
        .fv-check i { margin-top: 3px; width: 16px; text-align: center; }
        .fv-check .ok { color: var(--emerald); } .fv-check .pending { color: var(--amber); } .fv-check .info { color: var(--text-muted); }
        .fv-bar { height: 8px; border-radius: 4px; background: var(--border-ui); overflow: hidden; }
        .fv-bar > div { height: 100%; background: var(--brand); }
        .fv-rank-row { display: flex; align-items: center; gap: 12px; padding: .6rem 0; border-bottom: 1px solid var(--border-ui); font-size: .85rem; }
        .fv-rank-row:last-child { border-bottom: none; }
        .fv-rank-no { width: 22px; color: var(--text-muted); font-weight: 700; }

        .fv-feed-row { display: grid; grid-template-columns: 62px 1fr auto; gap: 14px; padding: .9rem 0; border-bottom: 1px solid var(--border-ui); align-items: start; }
        .fv-feed-row:last-child { border-bottom: none; }
        .fv-feed-date { font-size: .75rem; color: var(--text-muted); line-height: 1.25; padding-top: 2px; }
        .fv-feed-date b { display: block; font-size: 1.05rem; color: var(--text-heading); }
        .fv-feed-title { font-style: italic; color: var(--text-muted); font-size: .84rem; margin-top: 2px; }
        .fv-chip { border: 1px solid var(--border-ui); background: var(--bg-surface); color: var(--text-muted); border-radius: 6px; padding: 4px 12px; font-size: .78rem; font-weight: 600; cursor: pointer; }
        .fv-chip.active { background: var(--brand); border-color: var(--brand); color: #fff; }
        .fv-pending-tag { display: inline-block; margin-top: 4px; font-size: .68rem; font-weight: 700; color: #b45309; background: var(--amber-light); border-radius: 4px; padding: 1px 7px; }
        .fv-dup-warn { display: none; margin-top: 6px; font-size: .78rem; color: #92400e; background: var(--amber-light); border: 1px solid var(--amber); border-radius: 6px; padding: 6px 10px; }
        @media (max-width: 992px) { .fv-notif-panel { position: fixed; top: 70px; right: 10px; left: 10px; width: auto; } .fv-feed-row { grid-template-columns: 50px 1fr; } .fv-feed-row > :last-child { grid-column: 2; } }

        @media print {
            .portal-sidebar, .workspace-topbar, .fv-toast-wrap, .fv-dialog, .fv-cmd, .no-print { display: none !important; }
            .view-pane-section { display: none !important; }
            #pane-hub.active-pane { display: block !important; }
            .portal-workspace { margin: 0 !important; width: 100% !important; padding: 0 !important; }
            :root, [data-theme="dark"] { --bg-page: #fff; --bg-surface: #fff; --bg-subtle: #f8fafc; --text-heading: #000; --text-body: #111; --text-muted: #555; --border-ui: #ccc; }
            [data-theme="dark"] body { background: #fff !important; color: #111 !important; }
            [data-theme="dark"] h1, [data-theme="dark"] h2, [data-theme="dark"] h3, [data-theme="dark"] h4, [data-theme="dark"] h5, [data-theme="dark"] h6, [data-theme="dark"] strong { color: #000 !important; }
            .card-portal, .rail-card { box-shadow: none !important; }
            .print-head { display: block !important; }
        }
        .print-head { display: none; border-bottom: 2px solid #000; padding-bottom: 8px; margin-bottom: 16px; }

        /* ================= v3 polish ================= */
        .table-portal tbody tr:hover td { background: var(--bg-subtle); }
        .fv-state { text-align: center; padding: 3rem 1rem; }
        .fv-state-ico { width: 56px; height: 56px; border-radius: 16px; background: var(--bg-subtle); border: 1px solid var(--border-ui); color: var(--text-muted); display: inline-flex; align-items: center; justify-content: center; font-size: 1.4rem; margin-bottom: .9rem; }
        .fv-skel { height: 62px; border-radius: 10px; margin: .6rem 0; background: linear-gradient(90deg, var(--bg-subtle) 25%, var(--border-ui) 37%, var(--bg-subtle) 63%); background-size: 400% 100%; animation: fvShimmer 1.4s ease infinite; }
        @keyframes fvShimmer { 0% { background-position: 100% 50%; } 100% { background-position: 0 50%; } }
        .btn-act { border-radius: 30px; font-weight: 600; font-size: .78rem; padding: .3rem .85rem; display: inline-flex; align-items: center; gap: 6px; }

        /* ================= v2 additions ================= */
        .fv-top-logo { background: #fff; border: 1px solid var(--border-ui); border-radius: 10px; height: 40px; min-width: 84px; padding: 4px 10px; display: flex; align-items: center; justify-content: center; }
        .fv-top-logo img { max-height: 30px; max-width: 120px; object-fit: contain; display: block; }
        .fv-top-logo .fv-logo-fallback { font-size: 1.05rem; }
        .fv-top-logo .fv-logo-fallback small { display: none; }

        .fv-search-drop { position: absolute; left: 0; right: 0; top: calc(100% + 8px); background: var(--bg-surface); border: 1px solid var(--border-ui); border-radius: 12px; box-shadow: 0 16px 40px rgba(0,0,0,.22); z-index: 2400; display: none; overflow: hidden; }
        .fv-search-drop.open { display: block; }
        .fv-sr { display: flex; gap: 10px; align-items: flex-start; padding: .6rem .85rem; cursor: pointer; border-bottom: 1px solid var(--border-ui); font-size: .82rem; }
        .fv-sr:hover, .fv-sr.sel { background: var(--bg-subtle); }
        .fv-sr .t { font-weight: 600; color: var(--text-heading); }
        .fv-sr .m { color: var(--text-muted); font-size: .74rem; }
        .fv-sr-tag { font-size: .62rem; font-weight: 700; padding: 2px 7px; border-radius: 4px; background: var(--brand-light); color: var(--brand); white-space: nowrap; margin-top: 2px; }
        .fv-sr-foot { padding: .5rem .85rem; font-size: .74rem; color: var(--text-muted); }
        tr.fv-flash td { animation: fvFlash 1.8s ease-out; }
        @keyframes fvFlash { from { background: rgba(245,158,11,.35); } to { background: transparent; } }
        .min-w-0 { min-width: 0; }

        /* profile */
        .fv-hero { border-radius: 20px; overflow: hidden; border: 1px solid var(--border-ui); background: var(--bg-surface); box-shadow: var(--shadow-subtle); }
        .fv-hero-banner { height: 112px; background: linear-gradient(120deg, #1e3a8a, #2563eb 55%, #0ea5e9); position: relative; }
        .fv-hero-banner::after { content: ''; position: absolute; inset: 0; background: radial-gradient(circle at 85% 20%, rgba(255,255,255,.22), transparent 45%), radial-gradient(circle at 8% 120%, rgba(255,255,255,.16), transparent 40%); }
        .fv-hero-body { display: flex; gap: 1.2rem; flex-wrap: wrap; padding: 0 1.6rem 1.3rem; }
        .fv-hero-av { width: 96px; height: 96px; margin-top: -48px; border-radius: 24px; background: linear-gradient(135deg, #1e40af, #2563eb); color: #fff; font-family: 'Plus Jakarta Sans', sans-serif; font-weight: 800; font-size: 2.4rem; display: flex; align-items: center; justify-content: center; border: 4px solid var(--bg-surface); box-shadow: 0 8px 20px rgba(37,99,235,.35); position: relative; flex-shrink: 0; }
        .fv-pill { display: inline-flex; align-items: center; gap: 6px; font-size: .72rem; font-weight: 600; padding: .25rem .7rem; border-radius: 20px; background: var(--bg-subtle); border: 1px solid var(--border-ui); color: var(--text-body); }
        .fv-hero-stats { display: grid; grid-template-columns: repeat(4, 1fr); border-top: 1px solid var(--border-ui); }
        .fv-hs { padding: 1rem 1.4rem; border-right: 1px solid var(--border-ui); }
        .fv-hs:last-child { border-right: none; }
        .fv-hs .l { font-size: .68rem; text-transform: uppercase; letter-spacing: .5px; font-weight: 700; color: var(--text-muted); }
        .fv-hs .v { font-family: 'Plus Jakarta Sans', sans-serif; font-weight: 800; font-size: 1.55rem; color: var(--text-heading); line-height: 1.2; }
        .fv-ring { width: 84px; height: 84px; border-radius: 50%; display: flex; align-items: center; justify-content: center; position: relative; flex-shrink: 0; background: conic-gradient(var(--brand) 0% var(--pct, 0%), var(--border-ui) var(--pct, 0%) 100%); }
        .fv-ring::before { content: ''; position: absolute; inset: 8px; border-radius: 50%; background: var(--bg-surface); }
        .fv-ring span { position: relative; font-weight: 800; color: var(--text-heading); }
        .fv-id-tile { border: 1px solid var(--border-ui); border-radius: 12px; padding: .85rem 1rem; background: var(--bg-surface); height: 100%; display: flex; align-items: center; justify-content: space-between; gap: 8px; }
        .fv-id-label { font-size: .68rem; text-transform: uppercase; letter-spacing: .5px; font-weight: 700; color: var(--text-muted); }
        .fv-id-val { font-weight: 600; word-break: break-all; font-size: .9rem; }
        .fv-icon-mini { border: none; background: var(--bg-subtle); color: var(--text-muted); width: 30px; height: 30px; border-radius: 8px; cursor: pointer; display: inline-flex; align-items: center; justify-content: center; text-decoration: none; font-size: .8rem; }
        .fv-icon-mini:hover { color: var(--brand); }
        .fv-badges { display: grid; grid-template-columns: repeat(3, 1fr); gap: 10px; }
        .fv-badge-card { text-align: center; padding: .8rem .35rem; border: 1px solid var(--border-ui); border-radius: 12px; background: var(--bg-subtle); }
        .fv-badge-card i { font-size: 1.3rem; margin-bottom: .35rem; display: block; color: var(--amber); }
        .fv-badge-card .n { font-size: .7rem; font-weight: 700; color: var(--text-heading); line-height: 1.2; }
        .fv-badge-card.locked { opacity: .42; filter: grayscale(1); }
        .fv-tl-year { font-weight: 800; font-size: .8rem; color: var(--text-muted); margin: .9rem 0 .3rem; }
        .fv-tl-item { position: relative; border-left: 2px solid var(--border-ui); margin-left: 5px; padding: .45rem 0 .45rem 16px; }
        .fv-tl-dot { position: absolute; left: -6px; top: .8rem; width: 10px; height: 10px; border-radius: 50%; }
        .fv-ach { display: flex; gap: 12px; align-items: flex-start; padding: .7rem 0; border-bottom: 1px solid var(--border-ui); list-style: none; }
        .fv-ach:last-child { border-bottom: none; }
        .fv-ach > i { color: var(--amber); margin-top: 3px; }

        /* appraisal report */
        .fv-kpi { border: 1px solid var(--border-ui); border-radius: 14px; padding: 1rem 1.15rem; background: var(--bg-surface); height: 100%; }
        .fv-kpi .l { font-size: .7rem; text-transform: uppercase; letter-spacing: .5px; color: var(--text-muted); font-weight: 700; }
        .fv-kpi .v { font-family: 'Plus Jakarta Sans', sans-serif; font-weight: 800; font-size: 1.7rem; color: var(--text-heading); line-height: 1.15; margin-top: .25rem; }
        .fv-kpi .s { font-size: .76rem; color: var(--text-muted); }
        .fv-bar.sm { height: 5px; margin-top: 6px; }
        .fv-idg { display: grid; grid-template-columns: repeat(4, 1fr); gap: 1rem 1.5rem; }
        .fv-idg .l { font-size: .68rem; text-transform: uppercase; letter-spacing: .5px; font-weight: 700; color: var(--text-muted); }
        .fv-idg .v { font-weight: 600; font-size: .88rem; word-break: break-word; }
        .fv-sign { border-top: 1px solid var(--text-muted); padding-top: 6px; margin-top: 52px; font-size: .78rem; color: var(--text-muted); text-align: center; }
        .print-head .ph-inst { font-family: 'Plus Jakarta Sans', sans-serif; font-weight: 700; font-size: .78rem; letter-spacing: .5px; text-transform: uppercase; }
        .print-head .ph-title { font-family: 'Plus Jakarta Sans', sans-serif; font-weight: 800; font-size: 1.25rem; }

        /* live feed + ranking */
        .fv-live { display: inline-flex; align-items: center; gap: 8px; font-size: .8rem; color: var(--text-muted); }
        .fv-live-dot { width: 9px; height: 9px; border-radius: 50%; background: #9ca3af; }
        .fv-live-dot.live { background: #10b981; animation: fvPulse 1.8s infinite; }
        .fv-live-dot.demo { background: #8b5cf6; }
        .fv-live-dot.retry { background: #f59e0b; }
        .fv-live-dot.down { background: #dc2626; }
        @keyframes fvPulse { 0% { box-shadow: 0 0 0 0 rgba(16,185,129,.6); } 70% { box-shadow: 0 0 0 8px rgba(16,185,129,0); } 100% { box-shadow: 0 0 0 0 rgba(16,185,129,0); } }
        .fv-feed-item { display: flex; gap: 12px; padding: .85rem .6rem; border-bottom: 1px solid var(--border-ui); border-radius: 8px; align-items: flex-start; }
        .fv-feed-item:last-child { border-bottom: none; }
        .fv-feed-item.is-new { background: var(--brand-light); }
        .fv-feed-ico { width: 38px; height: 38px; border-radius: 10px; display: flex; align-items: center; justify-content: center; flex-shrink: 0; }
        .fv-you { font-size: .65rem; font-weight: 700; background: var(--brand-light); color: var(--brand); border-radius: 4px; padding: 1px 6px; }
        .fv-seg { display: inline-flex; border: 1px solid var(--border-ui); border-radius: 8px; overflow: hidden; }
        .fv-seg button { border: none; background: transparent; padding: .3rem .85rem; font-size: .76rem; font-weight: 600; color: var(--text-muted); cursor: pointer; }
        .fv-seg button.active { background: var(--brand); color: #fff; }
        .fv-podium { display: grid; grid-template-columns: 1fr 1fr 1fr; gap: 10px; align-items: end; margin: 1.1rem 0 .6rem; }
        .fv-pod { text-align: center; border: 1px solid var(--border-ui); border-radius: 12px 12px 0 0; padding: .8rem .4rem 0; background: var(--bg-subtle); overflow: hidden; }
        .fv-pod.p1 { padding-top: 1.2rem; border-color: #f59e0b; background: linear-gradient(180deg, rgba(245,158,11,.16), var(--bg-subtle)); }
        .fv-pod.me { box-shadow: 0 0 0 2px var(--brand); }
        .fv-pod-av { width: 42px; height: 42px; border-radius: 50%; margin: 0 auto 6px; display: flex; align-items: center; justify-content: center; font-weight: 800; color: #fff; background: #64748b; }
        .fv-pod.p1 .fv-pod-av { background: #f59e0b; } .fv-pod.p2 .fv-pod-av { background: #94a3b8; } .fv-pod.p3 .fv-pod-av { background: #b45309; }
        .fv-pod-name { font-size: .76rem; font-weight: 700; color: var(--text-heading); line-height: 1.2; }
        .fv-pod-dept { font-size: .66rem; color: var(--text-muted); }
        .fv-pod-score { font-family: 'Plus Jakarta Sans', sans-serif; font-weight: 800; font-size: 1.1rem; color: var(--text-heading); margin: .3rem 0; }
        .fv-pod-step { padding: .35rem 0; font-weight: 800; font-size: .8rem; background: var(--border-ui); color: var(--text-heading); }
        .fv-rk { display: flex; align-items: center; gap: 12px; padding: .6rem .5rem; border-bottom: 1px solid var(--border-ui); border-radius: 8px; }
        .fv-rk.me { background: var(--brand-light); }
        .fv-rk-no { width: 28px; font-weight: 800; color: var(--text-muted); text-align: center; }
        .fv-rk-av { width: 32px; height: 32px; border-radius: 50%; background: var(--bg-subtle); border: 1px solid var(--border-ui); display: flex; align-items: center; justify-content: center; font-size: .78rem; font-weight: 700; flex-shrink: 0; }
        .fv-mv { font-size: .68rem; font-weight: 700; display: block; }
        .fv-mv.up { color: #059669; } .fv-mv.dn { color: #dc2626; }

        @media (max-width: 992px) { .fv-hero-stats { grid-template-columns: repeat(2, 1fr); } .fv-idg { grid-template-columns: repeat(2, 1fr); } }
        @media print {
            .fv-kpi, .fv-idg, .card-portal, .rail-card { break-inside: avoid; box-shadow: none !important; }
            #pane-hub .fv-bar, #pane-hub .fv-bar > div { -webkit-print-color-adjust: exact; print-color-adjust: exact; }
            .fv-kpi .v, .fv-kpi .l, .fv-kpi .s, .fv-idg .l, .fv-idg .v { color: #000 !important; }
        }
    </style>
    <script>
        var FV_CTX = '${pageContext.request.contextPath}';
        var FV_LOGOS = ['/images/niet_logo_hd.png', '/images/niet_logo.png', '/images/niet-logo.png', '/images/logo.png', '/static/images/niet_logo_hd.png', '/assets/images/niet_logo_hd.png'];
        function fvLogoNext(img) {
            var i = (parseInt(img.getAttribute('data-i') || '0', 10)) + 1;
            if (i < FV_LOGOS.length) { img.setAttribute('data-i', i); img.src = FV_CTX + FV_LOGOS[i]; return; }
            img.onerror = null; img.style.display = 'none';
            var f = img.nextElementSibling; if (f) f.style.display = 'block';
        }
    </script>
</head>
<body>

<c:set var="rawName" value="${not empty faculty.fullName ? faculty.fullName.trim() : 'Faculty Member'}" />
<c:set var="upperName" value="${fn:toUpperCase(rawName)}" />
<c:choose>
    <c:when test="${fn:startsWith(upperName, 'DR.') || fn:startsWith(upperName, 'PROF.') || fn:startsWith(upperName, 'MR.')}">
        <c:set var="cleanSalutation" value="${rawName}" />
    </c:when>
    <c:otherwise>
        <c:set var="cleanSalutation" value="Dr. ${rawName}" />
    </c:otherwise>
</c:choose>

<c:set var="jCount" value="${not empty journalCount ? journalCount : 0}" />
<c:set var="cCount" value="${not empty conferenceCount ? conferenceCount : 0}" />
<c:set var="pCount" value="${not empty patentCount ? patentCount : 0}" />
<c:set var="dCount" value="${not empty dissertationCount ? dissertationCount : 0}" />
<c:set var="totalWorks" value="${jCount + cCount + pCount + dCount}" />

<c:set var="totalApiScore" value="${(jCount * 10) + (cCount * 5) + (pCount * 15) + (dCount * 3)}" />
<c:set var="targetTotal" value="${jCount + cCount + pCount}" />
<c:set var="milestonePct" value="${(targetTotal * 10) > 100 ? 100 : (targetTotal * 10)}" />

<aside class="portal-sidebar">
    <div>
        <div class="brand-box">
            <div class="fv-logo-tile">
                <img src="${pageContext.request.contextPath}/images/niet_logo_hd.png" alt="NIET, Greater Noida"
                     onerror="fvLogoNext(this)">
                <span class="fv-logo-fallback" style="display:none;">NIET<small>Greater Noida</small></span>
            </div>
            <div>
                <div class="brand-title">Faculty Vault</div>
                <div class="brand-sub">Research &amp; Academic Records</div>
            </div>
        </div>

        <div class="px-2 mb-2 text-uppercase text-muted" style="font-size: 0.68rem; font-weight: 700; letter-spacing: 0.6px;">Main Menu</div>
        <nav class="nav flex-column">
            <button onclick="switchPortalPane('dashboard')" id="nav-dashboard" class="nav-link-btn active">
                <i class="fa-solid fa-chart-pie"></i><span>Operations Desk</span>
            </button>
            <button onclick="switchPortalPane('publications')" id="nav-publications" class="nav-link-btn">
                <i class="fa-solid fa-book-bookmark"></i><span>Publications Vault</span>
            </button>
            <button onclick="switchPortalPane('apiScore')" id="nav-apiScore" class="nav-link-btn">
                <i class="fa-solid fa-calculator"></i><span>API Performance</span>
            </button>
            <button onclick="switchPortalPane('hub')" id="nav-hub" class="nav-link-btn">
                <i class="fa-solid fa-clipboard-check"></i><span>Appraisal Summary</span>
            </button>
            <button onclick="switchPortalPane('feed')" id="nav-feed" class="nav-link-btn">
                <i class="fa-solid fa-newspaper"></i><span>Department Updates</span>
                <span class="badge rounded-pill bg-danger ms-auto" id="fvFeedNavBadge" style="display:none;">0</span>
            </button>
            <button onclick="switchPortalPane('profile')" id="nav-profile" class="nav-link-btn">
                <i class="fa-solid fa-user-gear"></i><span>Faculty Profile</span>
            </button>
        </nav>
    </div>

    <div>
        <!-- Clean Non-Congested Custom Reports Trigger Box -->
        <div class="p-3 rounded-3 mb-3 border text-center" style="background-color: var(--bg-subtle);">
            <div class="small fw-bold mb-1" style="color: var(--emerald);">
                <i class="fa-solid fa-file-excel me-1"></i> Excel / CSV Reports
            </div>
            <p class="text-muted small mb-2" style="font-size: 0.7rem;">Weekly, monthly or all records.</p>
            <button class="btn btn-sm btn-outline-success w-100 rounded-pill fw-semibold" data-bs-toggle="modal" data-bs-target="#reportExportModal" style="font-size: 0.75rem;">
                <i class="fa-solid fa-download me-1"></i> Export Center
            </button>
        </div>

        <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline-danger w-100 rounded-3 py-2 fw-semibold d-flex align-items-center justify-content-center gap-2" style="font-size: 0.84rem; text-decoration: none;">
            <i class="fa-solid fa-arrow-right-from-bracket"></i><span>Sign Out</span>
        </a>
    </div>
</aside>

<main class="portal-workspace">
    <div class="workspace-topbar">
        <div>
            <h4 class="fw-bold mb-0">${cleanSalutation}</h4>
            <p class="text-muted mb-0 small">${faculty.designation} &bull; Dept. of ${faculty.department} &bull; ERP: <strong class="text-primary font-monospace">${faculty.erpId}</strong></p>
        </div>

        <div class="d-flex align-items-center gap-3">
            <div class="top-search-wrap d-none d-md-block">
                <i class="fa-solid fa-magnifying-glass position-absolute top-50 start-0 translate-middle-y ms-3 text-muted"></i>
                <input type="text" id="liveSearchInput" class="top-search-input" placeholder="Search papers, patents, journals..." autocomplete="off">
                <div class="fv-search-drop" id="fvSearchDrop"></div>
            </div>

            <div class="position-relative">
                <button class="fv-icon-btn" id="fvBellBtn" onclick="fvNotif.toggle()" title="Notifications">
                    <i class="fa-solid fa-bell"></i>
                    <span class="fv-badge" id="fvBellBadge">0</span>
                </button>
                <div class="fv-notif-panel" id="fvNotifPanel">
                    <div class="fv-notif-head">
                        <strong>Notifications</strong>
                        <span>
                            <a href="#" class="small text-decoration-none me-3" onclick="fvNotif.readAll();return false;">Mark all read</a>
                            <a href="#" class="small text-decoration-none text-danger" onclick="fvNotif.clear();return false;">Clear</a>
                        </span>
                    </div>
                    <div class="fv-notif-list" id="fvNotifList"></div>
                </div>
            </div>

            <button class="btn-theme-pill" onclick="toggleTheme()" id="themeToggleBtn">
                <i class="fa-solid fa-sun text-warning" id="themeIcon"></i>
                <span id="themeLabel">Light Theme</span>
            </button>

            <button class="btn-brand-cta" data-bs-toggle="modal" data-bs-target="#addResearchModal">
                <i class="fa-solid fa-plus"></i><span>Add Record</span>
            </button>

            <div class="fv-top-logo d-none d-md-flex" title="NIET, Greater Noida">
                <img src="${pageContext.request.contextPath}/images/niet_logo_hd.png" alt="NIET" onerror="fvLogoNext(this)">
                <span class="fv-logo-fallback" style="display:none;">NIET<small>Greater Noida</small></span>
            </div>
        </div>
    </div>

    <!-- Operations Desk Tab -->
    <div id="pane-dashboard" class="view-pane-section active-pane">
        <div class="row g-4">
            <div class="col-xl-9 col-lg-8">
                <div class="mb-4">
                    <div class="d-flex align-items-center justify-content-between mb-3">
                        <span class="small fw-bold text-muted text-uppercase" style="letter-spacing: 0.5px;">Quick Actions</span>
                        <span class="small text-muted">Direct Submission Shortcuts</span>
                    </div>

                    <!-- Professional 5-Column Quick Actions Grid -->
                    <div class="row g-3">
                        <div class="col">
                            <div class="action-card h-100" onclick="openAddModalWithCategory('JOURNAL')">
                                <div>
                                    <div class="action-icon-pill" style="background: var(--brand-light); color: var(--brand);">
                                        <i class="fa-solid fa-book-open"></i>
                                    </div>
                                    <div class="fw-bold small text-heading">Journal</div>
                                    <small class="text-muted" style="font-size: 0.7rem;">SCOPUS / SCI</small>
                                </div>
                                <div class="action-arrow"><i class="fa-solid fa-arrow-right"></i></div>
                            </div>
                        </div>

                        <div class="col">
                            <div class="action-card h-100" onclick="openAddModalWithCategory('PATENT')">
                                <div>
                                    <div class="action-icon-pill" style="background: var(--emerald-light); color: var(--emerald);">
                                        <i class="fa-solid fa-award"></i>
                                    </div>
                                    <div class="fw-bold small text-heading">Patent</div>
                                    <small class="text-muted" style="font-size: 0.7rem;">IPO / Global</small>
                                </div>
                                <div class="action-arrow"><i class="fa-solid fa-arrow-right"></i></div>
                            </div>
                        </div>

                        <div class="col">
                            <div class="action-card h-100" onclick="openAddModalWithCategory('CONFERENCE')">
                                <div>
                                    <div class="action-icon-pill" style="background: var(--purple-light); color: var(--purple);">
                                        <i class="fa-solid fa-users"></i>
                                    </div>
                                    <div class="fw-bold small text-heading">Conference</div>
                                    <small class="text-muted" style="font-size: 0.7rem;">IEEE / ACM</small>
                                </div>
                                <div class="action-arrow"><i class="fa-solid fa-arrow-right"></i></div>
                            </div>
                        </div>

                        <div class="col">
                            <div class="action-card h-100" onclick="openAddModalWithCategory('BOOK_CHAPTER')">
                                <div>
                                    <div class="action-icon-pill" style="background: var(--amber-light); color: var(--amber);">
                                        <i class="fa-solid fa-book"></i>
                                    </div>
                                    <div class="fw-bold small text-heading">Book / Chapter</div>
                                    <small class="text-muted" style="font-size: 0.7rem;">Editor & Author</small>
                                </div>
                                <div class="action-arrow"><i class="fa-solid fa-arrow-right"></i></div>
                            </div>
                        </div>

                        <div class="col">
                            <div class="action-card h-100" onclick="openAddModalWithCategory('FDP_STTP')">
                                <div>
                                    <div class="action-icon-pill" style="background: rgba(6, 182, 212, 0.12); color: #06b6d4;">
                                        <i class="fa-solid fa-chalkboard-user"></i>
                                    </div>
                                    <div class="fw-bold small text-heading">Workshop</div>
                                    <small class="text-muted" style="font-size: 0.7rem;">FDP / STTP</small>
                                </div>
                                <div class="action-arrow"><i class="fa-solid fa-arrow-right"></i></div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="mb-4">
                    <div class="d-flex align-items-center justify-content-between mb-3">
                        <span class="small fw-bold text-muted text-uppercase" style="letter-spacing: 0.5px;">Platform Overview</span>
                        <span class="badge bg-primary bg-opacity-10 text-primary small fw-semibold">Session 2026&ndash;27</span>
                    </div>

                    <div class="row g-3">
                        <div class="col-md-3 col-6">
                            <div class="stat-widget">
                                <div>
                                    <div class="stat-title">Journal Papers</div>
                                    <div class="stat-val">${jCount}</div>
                                    <span class="stat-trend-tag text-primary" style="background: var(--brand-light);">
                                        <i class="fa-solid fa-circle-check"></i> Scopus Verified
                                    </span>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-3 col-6">
                            <div class="stat-widget">
                                <div>
                                    <div class="stat-title">Conferences</div>
                                    <div class="stat-val">${cCount}</div>
                                    <span class="stat-trend-tag text-info" style="background: rgba(6, 182, 212, 0.12);">
                                        <i class="fa-solid fa-file-lines"></i> Proceedings
                                    </span>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-3 col-6">
                            <div class="stat-widget">
                                <div>
                                    <div class="stat-title">Patents Granted</div>
                                    <div class="stat-val">${pCount}</div>
                                    <span class="stat-trend-tag text-success" style="background: var(--emerald-light);">
                                        <i class="fa-solid fa-shield"></i> IPO Issued
                                    </span>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-3 col-6">
                            <div class="stat-widget">
                                <div>
                                    <div class="stat-title">FDPs & Outreach</div>
                                    <div class="stat-val">${dCount}</div>
                                    <span class="stat-trend-tag text-warning" style="background: var(--amber-light);">
                                        <i class="fa-solid fa-certificate"></i> Certified
                                    </span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Monthly Research Trajectory Chart -->
                <div class="card-portal mb-4">
                    <div class="d-flex align-items-center justify-content-between mb-3">
                        <div>
                            <h6 class="fw-bold mb-0">Monthly Research Trajectory & Histograph</h6>
                            <small class="text-muted">Real-time ranking & outputs committed per month</small>
                        </div>
                        <div>
                            <span class="badge bg-light text-dark border">Year 2026</span>
                        </div>
                    </div>
                    <div style="height: 260px; position: relative;">
                        <canvas id="barChart"></canvas>
                    </div>
                </div>

                <div class="card-portal">
                    <div class="d-flex align-items-center justify-content-between mb-3 flex-wrap gap-2">
                        <div>
                            <h6 class="fw-bold mb-0">Recent Research Output</h6>
                            <small class="text-muted">Verified publications and patents with digital proofs</small>
                        </div>
                    </div>
                    <div class="table-responsive">
                        <table class="table-portal">
                            <thead>
                                <tr>
                                    <th>Category</th>
                                    <th>Title & Authors</th>
                                    <th>Venue / Indexing</th>
                                    <th>Date</th>
                                    <th>Proof Document</th>
                                </tr>
                            </thead>
                            <tbody id="recentPubsTableBody">
                                <c:choose>
                                    <c:when test="${not empty recentPublications}">
                                        <c:forEach var="pub" items="${recentPublications}">
                                            <tr class="pub-row" data-cat="<c:out value='${pub.category}'/>" data-title="<c:out value='${pub.title}'/>">
                                                <td><span class="badge bg-primary bg-opacity-10 text-primary border border-primary border-opacity-20"><c:out value="${pub.category}"/></span></td>
                                                <td>
                                                    <div class="fw-bold"><c:out value="${pub.title}"/></div>
                                                    <div class="small text-muted"><c:out value="${pub.authors}"/></div>
                                                </td>
                                                <td>
                                                    <span class="badge bg-info bg-opacity-10 text-info fw-bold">${pub.indexingStatus != null ? pub.indexingStatus : 'SCOPUS'}</span>
                                                    <div class="small text-muted mt-1"><c:out value="${pub.venueOrPublisher}"/></div>
                                                </td>
                                                <td><c:out value="${pub.eventOrPublishDate}"/></td>
                                                <td>
                                                    <c:if test="${not empty pub.proofDocumentPath && pub.proofDocumentPath ne 'default_proof.pdf'}">
                                                        <c:forTokens items="${pub.proofDocumentPath}" delims="," var="pfile">
                                                            <a href="${pageContext.request.contextPath}/uploads/proofs/${pfile}" target="_blank" class="btn btn-sm btn-outline-primary rounded-pill px-2 mb-1" style="font-size: 0.72rem;">
                                                                <i class="fa-solid fa-eye me-1"></i> View
                                                            </a>
                                                        </c:forTokens>
                                                    </c:if>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <tr id="noRecordsRow">
                                            <td colspan="5" class="text-center text-muted py-4">
                                                No research records indexed yet. Click <strong>"Submit Journal"</strong> or <strong>"File Patent"</strong> above to commit your first record.
                                            </td>
                                        </tr>
                                    </c:otherwise>
                                </c:choose>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <!-- Right Telemetry Column -->
            <div class="col-xl-3 col-lg-4">
                <div class="rail-card">
                    <div class="researcher-badge-box">
                        <div class="researcher-avatar">${fn:substring(faculty.fullName, 0, 1)}</div>
                        <div>
                            <div class="fw-bold">${cleanSalutation}</div>
                            <div class="small text-muted font-monospace">${faculty.erpId}</div>
                            <span class="badge bg-success bg-opacity-10 text-success rounded-pill px-2 py-1 small mt-1">
                                <i class="fa-solid fa-circle-check me-1"></i> Verified Staff
                            </span>
                        </div>
                    </div>

                    <div class="appraisal-meter-box">
                        <div>
                            <div class="small text-muted fw-bold text-uppercase" style="font-size: 0.68rem;">Annual Milestone</div>
                            <div class="fw-bold text-heading mt-1">${targetTotal} of 10 Output</div>
                            <small class="text-muted" style="font-size: 0.72rem;">Category 'A' Autonomous Target</small>
                        </div>
                        <div class="meter-ring" style="--pct:${milestonePct}%;">
                            <span>${milestonePct}%</span>
                        </div>
                    </div>

                    <div class="p-3 border rounded-3 text-center mb-3" style="background: var(--bg-subtle);">
                        <div class="small text-muted text-uppercase fw-bold" style="font-size: 0.68rem;">Cumulative API Score</div>
                        <div class="h2 fw-bold text-heading mt-1 mb-0" style="color: var(--amber);">${totalApiScore}</div>
                        <small class="text-muted">UGC & AICTE Performance Score</small>
                    </div>

                    <div class="d-flex flex-column gap-2 mb-3">
                        <div class="d-flex justify-content-between align-items-center p-2 rounded-2 border" style="background: var(--bg-subtle); font-size: 0.78rem;">
                            <span class="text-muted"><i class="fa-solid fa-passport text-info me-1"></i> ORCID</span>
                            <span class="fw-bold font-monospace">${not empty faculty.orcidId ? faculty.orcidId : 'Not Linked'}</span>
                        </div>
                        <div class="d-flex justify-content-between align-items-center p-2 rounded-2 border" style="background: var(--bg-subtle); font-size: 0.78rem;">
                            <span class="text-muted"><i class="fa-solid fa-shield-halved text-success me-1"></i> Scopus ID</span>
                            <span class="fw-bold font-monospace">${not empty faculty.scopusId ? faculty.scopusId : 'Not Linked'}</span>
                        </div>
                    </div>

                    <button onclick="switchPortalPane('profile')" class="btn btn-outline-primary btn-sm w-100 rounded-pill fw-semibold">
                        View Full Faculty Dossier <i class="fa-solid fa-arrow-right ms-1"></i>
                    </button>
                </div>

                        <div class="rail-card">
            <h6 class="fw-bold mb-3">Your ranking</h6>
            <div class="row g-2">
                <div class="col-6"><div class="fv-kpi" style="padding:.8rem"><div class="l">Department</div><div class="v" id="fvMiniDept">-</div><div class="s" id="fvMiniDeptOf"></div></div></div>
                <div class="col-6"><div class="fv-kpi" style="padding:.8rem"><div class="l">College</div><div class="v" id="fvMiniCol">-</div><div class="s" id="fvMiniColOf"></div></div></div>
            </div>
            <div class="small text-muted mt-2" id="fvMiniGap"></div>
            <button onclick="switchPortalPane('feed')" class="btn btn-outline-primary btn-sm w-100 rounded-pill fw-semibold mt-3">Open full ranking <i class="fa-solid fa-arrow-right ms-1"></i></button>
        </div>

        <!-- Output Breakdown Doughnut Chart -->
                <div class="rail-card">
                    <div class="d-flex align-items-center justify-content-between mb-3">
                        <h6 class="fw-bold mb-0">Output Breakdown</h6>
                        <small class="text-muted">Total: ${totalWorks}</small>
                    </div>
                    <div style="height: 220px; position: relative;">
                        <canvas id="analyticsChart"></canvas>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Publications Vault Tab with Full View & Edit Support -->
    <div id="pane-publications" class="view-pane-section">
        <div class="card-portal mb-4">
            <div class="d-flex align-items-center justify-content-between mb-2">
                <h5 class="fw-bold mb-0"><i class="fa-solid fa-book-bookmark text-primary me-2"></i>Publications, Books & Patents Archive</h5>
                <span class="badge bg-primary bg-opacity-10 text-primary px-3 py-2">Editable Records Matrix</span>
            </div>
            <p class="text-muted small">Complete catalog of verified journal papers, conference proceedings, books/chapters, and patents.</p>
            <hr class="border-secondary opacity-25">
            <div class="table-responsive">
                <table class="table-portal">
                    <thead>
                        <tr>
                            <th>Category</th>
                            <th>Title & Authors</th>
                            <th>Publisher / Venue / Editor</th>
                            <th>Date</th>
                            <th>Proof Documents</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${not empty recentPublications}">
                                <c:forEach var="pub" items="${recentPublications}">
                                    <tr class="pub-row" data-cat="<c:out value='${pub.category}'/>" data-title="<c:out value='${pub.title}'/>">
                                        <td><span class="badge bg-primary bg-opacity-10 text-primary border border-primary border-opacity-25"><c:out value="${pub.category}"/></span></td>
                                        <td>
                                            <div class="fw-bold"><c:out value="${pub.title}"/></div>
                                            <div class="small text-muted"><c:out value="${pub.authors}"/></div>
                                        </td>
                                        <td>
                                            <div class="fw-semibold"><c:out value="${pub.venueOrPublisher}"/></div>
                                            <div class="small text-muted font-monospace">${pub.indexingStatus}</div>
                                        </td>
                                        <td><c:out value="${pub.eventOrPublishDate}"/></td>
                                        <td>
                                            <c:if test="${not empty pub.proofDocumentPath && pub.proofDocumentPath ne 'default_proof.pdf'}">
                                                <c:forTokens items="${pub.proofDocumentPath}" delims="," var="pfile" varStatus="pst">
                                                    <a href="${pageContext.request.contextPath}/uploads/proofs/<c:out value='${pfile}'/>" target="_blank" rel="noopener" class="btn btn-sm btn-outline-primary rounded-pill px-3 mb-1 me-1 fw-semibold" style="font-size: 0.74rem;">
                                                        <i class="fa-solid fa-eye me-1"></i> View<c:if test="${pst.count > 1}"> ${pst.count}</c:if>
                                                    </a>
                                                </c:forTokens>
                                            </c:if>
                                        </td>
                                        <td>
                                            <div class="d-flex gap-2">
                                                <button class="btn btn-sm btn-outline-primary btn-act" onclick="openEditFromBtn(this)"
                                                        data-id="<c:out value='${pub.publicationId}'/>" data-cat="<c:out value='${pub.category}'/>" data-title="<c:out value='${pub.title}'/>"
                                                        data-authors="<c:out value='${pub.authors}'/>" data-venue="<c:out value='${pub.venueOrPublisher}'/>"
                                                        data-indexing="<c:out value='${pub.indexingStatus}'/>" data-date="<c:out value='${pub.eventOrPublishDate}'/>">
                                                    <i class="fa-solid fa-pen-to-square me-1"></i> Edit
                                                </button>
                                                <button type="button" class="btn btn-sm btn-outline-danger btn-act" onclick="openDeleteFromBtn(this)"
                                                        data-id="<c:out value='${pub.publicationId}'/>" data-title="<c:out value='${pub.title}'/>">
                                                    <i class="fa-solid fa-trash-can me-1"></i> Delete
                                                </button>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr>
                                    <td colspan="6" class="text-center text-muted py-4">No records found in the archive.</td>
                                </tr>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- API Performance Tab -->
    <div id="pane-apiScore" class="view-pane-section">
        <div class="card-portal mb-4">
            <h5 class="fw-bold mb-1"><i class="fa-solid fa-calculator text-primary me-2"></i>API Performance Indicator Matrix</h5>
            <p class="text-muted small mb-4">UGC & AICTE appraisal scoring metrics based on verified research output.</p>
            
            <div class="row g-3 mb-4">
                <div class="col-md-3">
                    <div class="p-3 border rounded-3 bg-subtle">
                        <div class="small text-muted fw-bold">Journal Papers (${jCount} &times; 10 pts)</div>
                        <div class="h3 fw-bold text-primary mt-1">${jCount * 10} Points</div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="p-3 border rounded-3 bg-subtle">
                        <div class="small text-muted fw-bold">Conferences (${cCount} &times; 5 pts)</div>
                        <div class="h3 fw-bold text-info mt-1">${cCount * 5} Points</div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="p-3 border rounded-3 bg-subtle">
                        <div class="small text-muted fw-bold">Patents (${pCount} &times; 15 pts)</div>
                        <div class="h3 fw-bold text-success mt-1">${pCount * 15} Points</div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="p-3 border rounded-3 bg-subtle">
                        <div class="small text-muted fw-bold">FDP / Workshops (${dCount} &times; 3 pts)</div>
                        <div class="h3 fw-bold text-warning mt-1">${dCount * 3} Points</div>
                    </div>
                </div>
            </div>

            <div class="p-4 border rounded-3 text-center" style="background: linear-gradient(135deg, rgba(37,99,235,0.08), rgba(16,185,129,0.08));">
                <div class="text-uppercase fw-bold text-muted small mb-1">Total Accumulated API Score</div>
                <div class="display-5 fw-bold text-amber mb-0" style="color: var(--amber);">${totalApiScore} Points</div>
                <p class="text-muted small mt-2 mb-0">
                    <c:choose>
                        <c:when test="${targetTotal >= 10}">Category 'A' target met (${targetTotal} of 10 outputs).</c:when>
                        <c:otherwise>${10 - targetTotal} more journal, conference or patent record(s) needed to meet the Category 'A' target of 10.</c:otherwise>
                    </c:choose></p>
            </div>
        </div>
    </div>

        <!-- Faculty Profile Tab -->
    <div id="pane-profile" class="view-pane-section">
        <div class="fv-hero mb-4">
            <div class="fv-hero-banner"></div>
            <div class="fv-hero-body">
                <div class="fv-hero-av"><c:out value="${fn:substring(faculty.fullName, 0, 1)}"/></div>
                <div class="flex-grow-1 pt-3" style="min-width:240px;">
                    <h4 class="fw-bold mb-1"><c:out value="${cleanSalutation}"/></h4>
                    <div class="text-muted"><c:out value="${faculty.designation}"/> &bull; Dept. of <c:out value="${faculty.department}"/></div>
                    <div class="d-flex flex-wrap gap-2 mt-2">
                        <span class="fv-pill"><i class="fa-solid fa-id-badge"></i> ERP <c:out value="${faculty.erpId}"/></span>
                        <span class="fv-pill"><i class="fa-solid fa-circle-check text-success"></i> Verified Staff</span>
                        <span class="fv-pill"><i class="fa-solid fa-building-columns"></i> NIET, Greater Noida</span>
                    </div>
                </div>
                <div class="d-flex gap-2 align-items-start pt-3 no-print flex-wrap">
                    <button class="btn btn-outline-secondary rounded-pill px-3 fw-semibold btn-sm" onclick="fvProfile.copySummary()"><i class="fa-regular fa-copy me-1"></i> Copy profile summary</button>
                    <button class="btn btn-primary rounded-pill px-3 fw-semibold btn-sm" data-bs-toggle="modal" data-bs-target="#editProfileModal"><i class="fa-solid fa-user-pen me-1"></i> Edit Academic Profile</button>
                </div>
            </div>
            <div class="fv-hero-stats">
                <div class="fv-hs"><div class="l">Research works</div><div class="v">${totalWorks}</div></div>
                <div class="fv-hs"><div class="l">API score</div><div class="v">${totalApiScore}</div></div>
                <div class="fv-hs"><div class="l">Annual target</div><div class="v">${milestonePct}%</div></div>
                <div class="fv-hs"><div class="l">Badges earned</div><div class="v" id="fvHeroBadges">0</div></div>
            </div>
        </div>

        <div class="row g-4">
            <div class="col-xl-8">
                <div class="card-portal mb-4">
                    <h6 class="fw-bold mb-3">Contact &amp; research identity</h6>
                    <div class="row g-3">
                        <div class="col-md-6"><div class="fv-id-tile"><div class="min-w-0"><div class="fv-id-label">Official email</div><div class="fv-id-val"><c:out value="${faculty.officialEmail}"/></div></div>
                            <div class="d-flex gap-1"><button class="fv-icon-mini" title="Copy" data-v="<c:out value='${faculty.officialEmail}'/>" onclick="fvCopy(this.dataset.v,'Email')"><i class="fa-regular fa-copy"></i></button>
                            <a class="fv-icon-mini" title="Send mail" href="mailto:<c:out value='${faculty.officialEmail}'/>"><i class="fa-regular fa-envelope"></i></a></div></div></div>
                        <div class="col-md-6"><div class="fv-id-tile"><div class="min-w-0"><div class="fv-id-label">Mobile number</div><div class="fv-id-val"><c:out value="${not empty faculty.mobileNumber ? faculty.mobileNumber : 'Not provided'}"/></div></div>
                            <c:if test="${not empty faculty.mobileNumber}"><div class="d-flex gap-1"><button class="fv-icon-mini" title="Copy" data-v="<c:out value='${faculty.mobileNumber}'/>" onclick="fvCopy(this.dataset.v,'Mobile number')"><i class="fa-regular fa-copy"></i></button>
                            <a class="fv-icon-mini" title="Call" href="tel:<c:out value='${faculty.mobileNumber}'/>"><i class="fa-solid fa-phone"></i></a></div></c:if></div></div>
                        <div class="col-md-6"><div class="fv-id-tile"><div class="min-w-0"><div class="fv-id-label">ORCID iD</div><div class="fv-id-val font-monospace"><c:out value="${not empty faculty.orcidId ? faculty.orcidId : 'Not linked'}"/></div></div>
                            <c:if test="${not empty faculty.orcidId}"><div class="d-flex gap-1"><button class="fv-icon-mini" title="Copy" data-v="<c:out value='${faculty.orcidId}'/>" onclick="fvCopy(this.dataset.v,'ORCID iD')"><i class="fa-regular fa-copy"></i></button>
                            <a class="fv-icon-mini" title="Open ORCID profile" target="_blank" rel="noopener" href="https://orcid.org/<c:out value='${faculty.orcidId}'/>"><i class="fa-solid fa-arrow-up-right-from-square"></i></a></div></c:if></div></div>
                        <div class="col-md-6"><div class="fv-id-tile"><div class="min-w-0"><div class="fv-id-label">Scopus Author ID</div><div class="fv-id-val font-monospace"><c:out value="${not empty faculty.scopusId ? faculty.scopusId : 'Not linked'}"/></div></div>
                            <c:if test="${not empty faculty.scopusId}"><div class="d-flex gap-1"><button class="fv-icon-mini" title="Copy" data-v="<c:out value='${faculty.scopusId}'/>" onclick="fvCopy(this.dataset.v,'Scopus ID')"><i class="fa-regular fa-copy"></i></button>
                            <a class="fv-icon-mini" title="Open Scopus profile" target="_blank" rel="noopener" href="https://www.scopus.com/authid/detail.uri?authorId=<c:out value='${faculty.scopusId}'/>"><i class="fa-solid fa-arrow-up-right-from-square"></i></a></div></c:if></div></div>
                    </div>
                </div>

                <div class="card-portal mb-4">
                    <div class="d-flex justify-content-between align-items-center mb-1">
                        <h6 class="fw-bold mb-0">Research timeline</h6>
                        <small class="text-muted">Built from your Vault records</small>
                    </div>
                    <div id="fvTimeline" style="max-height:340px; overflow-y:auto;"></div>
                </div>

                <div class="card-portal">
                    <div class="d-flex justify-content-between align-items-center mb-2">
                        <h6 class="fw-bold mb-0"><i class="fa-solid fa-medal text-warning me-2"></i>Fellowships, awards &amp; keynote honours</h6>
                        <button class="btn btn-sm btn-outline-success rounded-pill px-3 fw-semibold no-print" data-bs-toggle="modal" data-bs-target="#addAchievementModal"><i class="fa-solid fa-plus me-1"></i> Add Achievement</button>
                    </div>
                    <ul class="mb-0 ps-0" id="achievementsList">
                        <c:choose>
                            <c:when test="${not empty achievements}">
                                <c:forEach var="ach" items="${achievements}">
                                    <li class="fv-ach"><i class="fa-solid fa-award"></i>
                                        <div class="flex-grow-1">
                                            <div class="fw-semibold"><c:out value="${ach.title}"/></div>
                                            <c:if test="${not empty ach.proofUrl}"><a href="<c:out value='${ach.proofUrl}'/>" target="_blank" rel="noopener" class="me-2 badge bg-primary bg-opacity-10 text-primary text-decoration-none"><i class="fa-solid fa-link me-1"></i> Proof link</a></c:if>
                                            <c:if test="${not empty ach.proofFile}"><a href="${pageContext.request.contextPath}/uploads/proofs/<c:out value='${ach.proofFile}'/>" target="_blank" rel="noopener" class="badge bg-success bg-opacity-10 text-success text-decoration-none"><i class="fa-solid fa-file-pdf me-1"></i> Proof PDF</a></c:if>
                                        </div></li>
                                </c:forEach>
                            </c:when>
                            <c:otherwise><li class="text-muted fst-italic small" style="list-style:none;">No achievements added yet. Use &ldquo;Add Achievement&rdquo; to record awards, fellowships or keynotes.</li></c:otherwise>
                        </c:choose>
                    </ul>
                </div>
            </div>

            <div class="col-xl-4">
                <div class="rail-card">
                    <div class="d-flex align-items-center gap-3 mb-3">
                        <div class="fv-ring" id="fvCompRing"><span id="fvCompPct">0%</span></div>
                        <div><h6 class="fw-bold mb-0">Profile completeness</h6><small class="text-muted">Complete profiles make appraisal smoother.</small></div>
                    </div>
                    <div id="fvComplete"></div>
                </div>
                <div class="rail-card">
                    <div class="d-flex justify-content-between align-items-center mb-3"><h6 class="fw-bold mb-0">Badges</h6><small class="text-muted" id="fvBadgeCount"></small></div>
                    <div class="fv-badges" id="fvBadges"></div>
                </div>
                <div class="rail-card">
                    <h6 class="fw-bold mb-2">Research mix</h6>
                    <div style="height:230px; position:relative;"><canvas id="profileRadar"></canvas></div>
                </div>
            </div>
        </div>
    </div>

    <!-- Appraisal Summary -->
    <div id="pane-hub" class="view-pane-section">
        <div class="print-head">
            <div class="d-flex justify-content-between align-items-end">
                <div>
                    <div class="ph-inst">Noida Institute of Engineering &amp; Technology, Greater Noida</div>
                    <div class="ph-title">Faculty Research Appraisal Summary &mdash; Session 2026&ndash;27</div>
                </div>
                <div style="font-size:.8rem;">Generated on <span class="fv-gen-date"></span></div>
            </div>
        </div>

        <div class="d-flex justify-content-between align-items-start flex-wrap gap-2 mb-3">
            <div>
                <h5 class="fw-bold mb-0">Appraisal Summary</h5>
                <small class="text-muted">Session 2026&ndash;27 &bull; prepared from the records in your Vault &bull; <span class="fv-gen-date"></span></small>
            </div>
            <div class="d-flex gap-2 no-print">
                <button class="btn btn-outline-secondary btn-sm px-3 fw-semibold" onclick="fvDownloadSummary()"><i class="fa-solid fa-file-csv me-1"></i> Download CSV</button>
                <button class="btn btn-primary btn-sm px-3 fw-semibold" onclick="window.print()"><i class="fa-solid fa-print me-1"></i> Print / Save as PDF</button>
            </div>
        </div>

        <div class="card-portal mb-4">
            <div class="fv-idg">
                <div><div class="l">Name</div><div class="v"><c:out value="${cleanSalutation}"/></div></div>
                <div><div class="l">Designation</div><div class="v"><c:out value="${faculty.designation}"/></div></div>
                <div><div class="l">Department</div><div class="v"><c:out value="${faculty.department}"/></div></div>
                <div><div class="l">ERP ID</div><div class="v font-monospace"><c:out value="${faculty.erpId}"/></div></div>
                <div><div class="l">ORCID iD</div><div class="v font-monospace"><c:out value="${not empty faculty.orcidId ? faculty.orcidId : 'Not linked'}"/></div></div>
                <div><div class="l">Scopus Author ID</div><div class="v font-monospace"><c:out value="${not empty faculty.scopusId ? faculty.scopusId : 'Not linked'}"/></div></div>
                <div><div class="l">Official email</div><div class="v"><c:out value="${faculty.officialEmail}"/></div></div>
                <div><div class="l">Appraisal session</div><div class="v">2026&ndash;27</div></div>
            </div>
        </div>

        <div class="row g-3 mb-4">
            <div class="col-md-3 col-6"><div class="fv-kpi"><div class="l">Total API score</div><div class="v" id="fvKpiScore">0</div><div class="s">UGC &amp; AICTE points</div></div></div>
            <div class="col-md-3 col-6"><div class="fv-kpi"><div class="l">Category &lsquo;A&rsquo; target</div><div class="v" id="fvKpiTarget">0 / 10</div><div class="s">Journals, conferences, patents</div></div></div>
            <div class="col-md-3 col-6"><div class="fv-kpi"><div class="l">Proof coverage</div><div class="v" id="fvKpiProof">0 / 0</div><div class="s">Records with a proof file</div></div></div>
            <div class="col-md-3 col-6"><div class="fv-kpi"><div class="l">Department rank</div><div class="v" id="fvKpiRank">-</div><div class="s" id="fvKpiRankSub">Live ranking not connected</div></div></div>
        </div>

        <div class="row g-4">
            <div class="col-xl-8">
                <div class="card-portal mb-4">
                    <h6 class="fw-bold mb-3">Score breakdown</h6>
                    <div class="table-responsive">
                        <table class="table-portal">
                            <thead><tr><th>Category</th><th class="text-end">Records</th><th class="text-end">Points each</th><th class="text-end">Points</th><th class="text-end">Share</th></tr></thead>
                            <tbody id="fvScoreBody"></tbody>
                        </table>
                    </div>
                </div>

                <div class="card-portal mb-4">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h6 class="fw-bold mb-0">Records included in this appraisal</h6>
                        <small class="text-muted" id="fvRecCount"></small>
                    </div>
                    <div class="table-responsive">
                        <table class="table-portal">
                            <thead><tr><th>#</th><th>Title</th><th>Type</th><th>Date</th><th class="text-end">Points</th><th>Proof</th></tr></thead>
                            <tbody id="fvRecBody"></tbody>
                        </table>
                    </div>
                </div>
                </div>

            <div class="col-xl-4">
                <div class="rail-card">
                    <div class="d-flex justify-content-between mb-2">
                        <h6 class="fw-bold mb-0">Annual target</h6>
                        <small class="text-muted" id="fvTargetText"></small>
                    </div>
                    <div class="fv-bar"><div id="fvTargetBar" style="width:0%"></div></div>
                    <small class="text-muted d-block mt-2" id="fvTargetNote"></small>
                </div>
                <div class="rail-card">
                    <div class="d-flex justify-content-between align-items-center">
                        <h6 class="fw-bold mb-0">Submission checklist</h6>
                        <small class="text-muted" id="fvReadyCount"></small>
                    </div>
                    <small class="text-muted">Checked automatically against your profile and records.</small>
                    <div class="mt-2" id="fvChecklist"></div>
                </div>
            </div>
        </div>
    </div>

    <!-- Department Updates -->
    <div id="pane-feed" class="view-pane-section">
        <div class="d-flex justify-content-between align-items-start flex-wrap gap-2 mb-3">
            <div>
                <h5 class="fw-bold mb-0">Department Updates &amp; Ranking</h5>
                <small class="text-muted">What your colleagues are adding, and where you stand.</small>
            </div>
            <div class="fv-live"><span class="fv-live-dot" id="fvLiveDot"></span><span id="fvLiveText">Connecting...</span></div>
        </div>
        <div class="row g-3 mb-4">
            <div class="col-md-3 col-6"><div class="fv-kpi"><div class="l">Department rank</div><div class="v" id="fvFsDept">-</div><div class="s" id="fvFsDeptOf">Waiting for live data</div></div></div>
            <div class="col-md-3 col-6"><div class="fv-kpi"><div class="l">College rank</div><div class="v" id="fvFsCol">-</div><div class="s" id="fvFsColOf">Waiting for live data</div></div></div>
            <div class="col-md-3 col-6"><div class="fv-kpi"><div class="l">Your API score</div><div class="v">${totalApiScore}</div><div class="s">Session 2026&ndash;27</div></div></div>
            <div class="col-md-3 col-6"><div class="fv-kpi"><div class="l">Colleague updates</div><div class="v" id="fvFsAct">0</div><div class="s">Latest records in the college</div></div></div>
        </div>
        <div class="row g-4">
            <div class="col-xl-7">
                <div class="card-portal">
                    <div class="d-flex flex-wrap gap-2 mb-2" id="fvFeedChips">
                        <button type="button" class="fv-chip active" data-f="ALL">All</button>
                        <button type="button" class="fv-chip" data-f="DEPT">My department</button>
                        <button type="button" class="fv-chip" data-f="JOURNAL">Journals</button>
                        <button type="button" class="fv-chip" data-f="PATENT">Patents</button>
                        <button type="button" class="fv-chip" data-f="CONFERENCE">Conferences</button>
                        <button type="button" class="fv-chip" data-f="BOOK_CHAPTER">Books</button>
                        <button type="button" class="fv-chip" data-f="FDP_STTP">FDP / Workshops</button>
                    </div>
                    <div id="fvFeedList"></div>
                </div>
            </div>
            <div class="col-xl-5">
                <div class="card-portal">
                    <div class="d-flex justify-content-between align-items-center flex-wrap gap-2">
                        <h6 class="fw-bold mb-0">Research ranking</h6>
                        <div class="fv-seg" id="fvRankSeg"><button type="button" class="active" data-scope="dept">My department</button><button type="button" data-scope="college">College</button></div>
                    </div>
                    <div id="fvRankSummary" class="mt-3"></div>
                    <div id="fvPodium"></div>
                    <div id="fvLeaderboard"></div>
                    <small class="text-muted d-block mt-2">Ranking uses the same API points as your appraisal (journal 10, conference 5, patent 15, FDP / book 3).</small>
                </div>
            </div>
        </div>
    </div>
</main>

<!-- Add Advanced Research Modal with Professional Corporate Look -->
<div class="modal fade" id="addResearchModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-xl modal-dialog-centered">
        <div class="modal-content shadow-lg">
            <div class="modal-header border-bottom px-4 py-3 bg-primary text-white">
                <h6 class="modal-title fw-bold mb-0"><i class="fa-solid fa-folder-plus me-2"></i>Academic Record Submission Portal</h6>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body p-4">
                <!-- Professional API Metadata Resolver Box -->
                <div id="autoFetchBox" class="mb-4 p-3 border rounded-3 bg-subtle">
                    <label class="form-label small text-uppercase fw-bold text-primary"><i class="fa-solid fa-cloud-arrow-down me-1"></i> External Repository Metadata Resolver</label>
                    <div class="input-group">
                        <input type="text" id="externalLinkInput" class="form-control" placeholder="Enter DOI, IEEE, Springer, or Google Patent URL...">
                        <button type="button" class="btn btn-outline-primary fw-semibold px-4" onclick="fetchMetadataFromSource()"><i class="fa-solid fa-sync me-1"></i> Fetch Details</button>
                    </div>
                </div>

                <form action="${pageContext.request.contextPath}/publications/add" method="POST" enctype="multipart/form-data">
                    <div class="mb-3">
                        <label class="form-label small fw-bold text-muted">Activity Category *</label>
                        <select name="category" id="modalActivityCategory" class="form-select" onchange="toggleCategoryFields(this.value)" required>
                            <option value="JOURNAL">Research Paper (Journal)</option>
                            <option value="CONFERENCE">Conference Paper</option>
                            <option value="PATENT">Patent / Innovation</option>
                            <option value="BOOK_CHAPTER">Book / Book Chapter (Editor & Chapter Author)</option>
                            <option value="FDP_STTP">FDP / Workshop / Achievement</option>
                        </select>
                    </div>

                    <div class="row g-3 mb-3">
                        <div class="col-md-6">
                            <label class="form-label small fw-bold text-muted">Record Title *</label>
                            <input type="text" id="recordTitle" name="title" class="form-control" required placeholder="Enter complete paper or patent title">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label small fw-bold text-muted">Primary Author *</label>
                            <input type="text" id="recordAuthors" name="authors" class="form-control" placeholder="e.g. Dr. Rajesh Sharma" required>
                        </div>
                    </div>

                    <!-- Corresponding Author & Department Fields -->
                    <div class="row g-3 mb-3">
                        <div class="col-md-4">
                            <label class="form-label small fw-bold text-muted">Corresponding Author Name (Optional)</label>
                            <input type="text" name="correspondingAuthor" class="form-control" placeholder="e.g. Dr. Rajesh Sharma">
                        </div>
                        <div class="col-md-4">
                            <label class="form-label small fw-bold text-muted">Corresponding Author Category (Optional)</label>
                            <select name="correspondingAuthorCategory" class="form-select">
                                <option value="">Select Category</option>
                                <option value="Faculty">Faculty</option>
                                <option value="Student">Student</option>
                                <option value="External">External</option>
                            </select>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label small fw-bold text-muted">Co-Authors & Department (Optional)</label>
                            <select name="coAuthorsWithDept" class="form-select">
                                <option value="">Select Department / Branch</option>
                                <option value="CSE Branch">Dept. of Computer Science & Engineering (CSE)</option>
                                <option value="IT Branch">Dept. of Information Technology (IT)</option>
                                <option value="ECE Branch">Dept. of Electronics & Communication (ECE)</option>
                                <option value="ME Branch">Dept. of Mechanical Engineering (ME)</option>
                                <option value="CE Branch">Dept. of Civil Engineering (CE)</option>
                                <option value="AIML Branch">Dept. of AI & Machine Learning (AIML)</option>
                            </select>
                        </div>
                    </div>

                    <!-- 1. JOURNAL FIELDS -->
                    <div id="journalFields" class="row g-3 mb-3 category-specific-fields">
                        <div class="col-md-4">
                            <label class="form-label small fw-bold text-muted">Journal Name *</label>
                            <input type="text" id="recordJournalName" name="journalName" class="form-control" placeholder="e.g. IEEE Transactions">
                        </div>
                        <div class="col-md-4">
                            <label class="form-label small fw-bold text-muted">Publisher *</label>
                            <input type="text" id="recordPublisher" name="venueOrPublisher" class="form-control" placeholder="e.g. Springer Nature">
                        </div>
                        <div class="col-md-4">
                            <label class="form-label small fw-bold text-muted">DOI & Volume *</label>
                            <input type="text" id="recordDoi" name="doiAndVolume" class="form-control font-monospace" placeholder="10.1109/... | Vol. 12">
                        </div>
                    </div>

                    <!-- 2. CONFERENCE FIELDS -->
                    <div id="conferenceFields" class="row g-3 mb-3 category-specific-fields" style="display: none;">
                        <div class="col-md-3">
                            <label class="form-label small fw-bold text-muted">Conference Title *</label>
                            <input type="text" id="recordConfName" name="conferenceName" class="form-control" placeholder="e.g. International AI Summit">
                        </div>
                        <div class="col-md-3">
                            <label class="form-label small fw-bold text-muted">Presentation Mode *</label>
                            <select name="presentationMode" class="form-select">
                                <option value="OFFLINE">Offline Mode</option>
                                <option value="ONLINE">Online Mode</option>
                            </select>
                        </div>
                        <div class="col-md-3">
                            <label class="form-label small fw-bold text-muted">Conference Venue *</label>
                            <input type="text" name="conferenceVenue" class="form-control" placeholder="e.g. New Delhi, India">
                        </div>
                        <div class="col-md-3">
                            <label class="form-label small fw-bold text-muted">Hosting Organization *</label>
                            <input type="text" name="organization" class="form-control" placeholder="e.g. ACM / IEEE Chapter">
                        </div>
                    </div>

                    <!-- 3. PATENT FIELDS -->
                    <div id="patentFields" class="row g-3 mb-3 category-specific-fields" style="display: none;">
                        <div class="col-md-6">
                            <label class="form-label small fw-bold text-muted">Patent Application / Grant No. *</label>
                            <input type="text" name="patentNumber" class="form-control font-monospace" placeholder="e.g. US11296781B2">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label small fw-bold text-muted">IP Authority / Office *</label>
                            <input type="text" name="ipAuthority" class="form-control" placeholder="e.g. Intellectual Property India / USPTO">
                        </div>
                    </div>

                    <!-- 4. BOOK & CHAPTER FIELDS -->
                    <div id="bookFields" class="row g-3 mb-3 category-specific-fields" style="display: none;">
                        <div class="col-md-6">
                            <label class="form-label small fw-bold text-muted">Book Editor Name *</label>
                            <input type="text" name="bookEditor" class="form-control" placeholder="e.g. Dr. A. K. Verma">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label small fw-bold text-muted">Chapter Author Name(s) *</label>
                            <input type="text" name="chapterAuthor" class="form-control" placeholder="e.g. Dr. Aditee Matoo, et al.">
                        </div>
                    </div>

                    <!-- 5. FDP / WORKSHOP FIELDS -->
                    <div id="fdpFields" class="row g-3 mb-3 category-specific-fields" style="display: none;">
                        <div class="col-md-6">
                            <label class="form-label small fw-bold text-muted">Program / Event Name *</label>
                            <input type="text" name="fdpName" class="form-control" placeholder="e.g. AI & ML Faculty Development Program">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label small fw-bold text-muted">Organizing Institution *</label>
                            <input type="text" name="organizer" class="form-control" placeholder="e.g. AICTE / IIT Delhi">
                        </div>
                    </div>

                    <!-- Professional Citation Data & Official Reference Link -->
                    <div class="row g-3 mb-3">
                        <div class="col-md-6">
                            <label class="form-label small fw-bold text-muted">Citation Data (Optional)</label>
                            <input type="text" name="citationData" class="form-control" placeholder="e.g. IEEE, 2026, Vol 4, pp. 12-18">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label small fw-bold text-primary"><i class="fa-solid fa-link me-1"></i> Source URL / Official Reference Link *</label>
                            <input type="url" name="sourceUrl" class="form-control" placeholder="https://doi.org/... or https://...">
                        </div>
                    </div>

                    <div class="row g-3 mb-3">
                        <div class="col-md-6">
                            <label class="form-label small fw-bold text-muted">Date of Publishing / Event *</label>
                            <input type="date" name="date" class="form-control" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label small fw-bold text-muted">Upload Proof Documents / Certificate (Up to 10 GB) *</label>
                            <input type="file" name="proofFiles" class="form-control" accept=".pdf,.png,.jpg,.jpeg" multiple required>
                            <small class="text-muted" style="font-size: 0.72rem;">Supports bulk upload (Hold Ctrl/Cmd to select multiple).</small>
                        </div>
                    </div>

                    <button type="submit" class="btn btn-primary w-100 rounded-pill fw-bold py-2">Commit to Faculty Vault</button>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Edit Research Record Modal -->
<div class="modal fade" id="editRecordModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-xl modal-dialog-centered">
        <div class="modal-content shadow-lg">
            <form action="${pageContext.request.contextPath}/publications/update" method="POST" enctype="multipart/form-data">
                <div class="modal-header border-bottom px-4 py-3 bg-warning text-dark">
                    <h6 class="modal-title fw-bold mb-0"><i class="fa-solid fa-pen-to-square me-2"></i>Edit Academic Record & Proofs</h6>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body p-4">
                    <input type="hidden" id="editPubId" name="publicationId">
                    
                    <div class="mb-3">
                        <label class="form-label small fw-bold text-muted">Activity Category *</label>
                        <select name="category" id="editModalActivityCategory" class="form-select" onchange="toggleEditCategoryFields(this.value)" required>
                            <option value="JOURNAL">Research Paper (Journal)</option>
                            <option value="CONFERENCE">Conference Paper</option>
                            <option value="PATENT">Patent / Innovation</option>
                            <option value="BOOK_CHAPTER">Book / Book Chapter (Editor & Chapter Author)</option>
                            <option value="FDP_STTP">FDP / Workshop / Achievement</option>
                        </select>
                    </div>

                    <div class="row g-3 mb-3">
                        <div class="col-md-6">
                            <label class="form-label small fw-bold text-muted">Record Title *</label>
                            <input type="text" id="editTitle" name="title" class="form-control" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label small fw-bold text-muted">Primary Author *</label>
                            <input type="text" id="editAuthors" name="authors" class="form-control" required>
                        </div>
                    </div>

                    <div class="row g-3 mb-3">
                        <div class="col-md-4">
                            <label class="form-label small fw-bold text-muted">Corresponding Author Name (Optional)</label>
                            <input type="text" id="editCorrespondingAuthor" name="correspondingAuthor" class="form-control">
                        </div>
                        <div class="col-md-4">
                            <label class="form-label small fw-bold text-muted">Corresponding Author Category (Optional)</label>
                            <select name="correspondingAuthorCategory" id="editCorrespondingAuthorCategory" class="form-select">
                                <option value="">Select Category</option>
                                <option value="Faculty">Faculty</option>
                                <option value="Student">Student</option>
                                <option value="External">External</option>
                            </select>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label small fw-bold text-muted">Co-Authors & Department (Optional)</label>
                            <select name="coAuthorsWithDept" id="editCoAuthorsWithDept" class="form-select">
                                <option value="">Select Branch / Department</option>
                                <option value="CSE Branch">Dept. of Computer Science & Engineering (CSE)</option>
                                <option value="IT Branch">Dept. of Information Technology (IT)</option>
                                <option value="ECE Branch">Dept. of Electronics & Communication (ECE)</option>
                                <option value="ME Branch">Dept. of Mechanical Engineering (ME)</option>
                                <option value="CE Branch">Dept. of Civil Engineering (CE)</option>
                                <option value="AIML Branch">Dept. of AI & Machine Learning (AIML)</option>
                            </select>
                        </div>
                    </div>

                    <!-- 1. Edit Journal Fields -->
                    <div id="editJournalFields" class="row g-3 mb-3 edit-category-specific-fields">
                        <div class="col-md-4">
                            <label class="form-label small fw-bold text-muted">Journal Name *</label>
                            <input type="text" id="editJournalName" name="journalName" class="form-control">
                        </div>
                        <div class="col-md-4">
                            <label class="form-label small fw-bold text-muted">Publisher *</label>
                            <input type="text" id="editPublisher" name="venueOrPublisher" class="form-control">
                        </div>
                        <div class="col-md-4">
                            <label class="form-label small fw-bold text-muted">DOI & Volume *</label>
                            <input type="text" id="editDoi" name="doiAndVolume" class="form-control font-monospace">
                        </div>
                    </div>

                    <!-- 2. Edit Conference Fields -->
                    <div id="editConferenceFields" class="row g-3 mb-3 edit-category-specific-fields" style="display: none;">
                        <div class="col-md-3">
                            <label class="form-label small fw-bold text-muted">Conference Title *</label>
                            <input type="text" id="editConfName" name="conferenceName" class="form-control">
                        </div>
                        <div class="col-md-3">
                            <label class="form-label small fw-bold text-muted">Presentation Mode *</label>
                            <select name="presentationMode" id="editPresentationMode" class="form-select">
                                <option value="OFFLINE">Offline Mode</option>
                                <option value="ONLINE">Online Mode</option>
                            </select>
                        </div>
                        <div class="col-md-3">
                            <label class="form-label small fw-bold text-muted">Conference Venue *</label>
                            <input type="text" id="editConfVenue" name="conferenceVenue" class="form-control">
                        </div>
                        <div class="col-md-3">
                            <label class="form-label small fw-bold text-muted">Hosting Organization *</label>
                            <input type="text" id="editOrganization" name="organization" class="form-control">
                        </div>
                    </div>

                    <!-- 3. Edit Patent Fields -->
                    <div id="editPatentFields" class="row g-3 mb-3 edit-category-specific-fields" style="display: none;">
                        <div class="col-md-6">
                            <label class="form-label small fw-bold text-muted">Patent Application No. *</label>
                            <input type="text" id="editPatentNumber" name="patentNumber" class="form-control font-monospace">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label small fw-bold text-muted">IP Authority / Office *</label>
                            <input type="text" id="editIpAuthority" name="ipAuthority" class="form-control">
                        </div>
                    </div>

                    <!-- 4. Edit Book Fields -->
                    <div id="editBookFields" class="row g-3 mb-3 edit-category-specific-fields" style="display: none;">
                        <div class="col-md-6">
                            <label class="form-label small fw-bold text-muted">Book Editor Name *</label>
                            <input type="text" id="editBookEditor" name="bookEditor" class="form-control">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label small fw-bold text-muted">Chapter Author Name(s) *</label>
                            <input type="text" id="editChapterAuthor" name="chapterAuthor" class="form-control">
                        </div>
                    </div>

                    <!-- 5. Edit FDP / Workshop Fields -->
                    <div id="editFdpFields" class="row g-3 mb-3 edit-category-specific-fields" style="display: none;">
                        <div class="col-md-6">
                            <label class="form-label small fw-bold text-muted">Program / Event Name *</label>
                            <input type="text" id="editFdpName" name="fdpName" class="form-control">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label small fw-bold text-muted">Organizing Institution *</label>
                            <input type="text" id="editOrganizer" name="organizer" class="form-control">
                        </div>
                    </div>

                    <div class="row g-3 mb-3">
                        <div class="col-md-6">
                            <label class="form-label small fw-bold text-muted">Publish / Event Date *</label>
                            <input type="date" id="editDate" name="date" class="form-control" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label small fw-bold text-muted">Update Proof Documents (Optional)</label>
                            <input type="file" name="proofFiles" class="form-control" accept=".pdf,.png,.jpg,.jpeg" multiple>
                        </div>
                    </div>

                    <button type="submit" class="btn btn-warning w-100 rounded-pill fw-bold text-dark py-2">Update Record Details</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Professional Report Export Modal with Start & End Date -->
<div class="modal fade" id="reportExportModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content shadow-lg">
            <div class="modal-header border-bottom px-4 py-3 bg-success text-white">
                <h6 class="modal-title fw-bold mb-0"><i class="fa-solid fa-file-excel me-2"></i>Advanced Excel / CSV Report Generator</h6>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body p-4">
                <form action="${pageContext.request.contextPath}/dashboard/export-report" method="GET">
                    <div class="mb-3">
                        <label class="form-label small fw-bold text-muted">Select Report Duration *</label>
                        <select name="filterType" id="reportFilterType" class="form-select" onchange="toggleReportDateInputs(this.value)" required>
                            <option value="all">Complete Archive (Download All)</option>
                            <option value="weekly">Custom Date Range (Start & End Date)</option>
                            <option value="monthly">Specific Month (Choose Month)</option>
                        </select>
                    </div>

                    <div id="weeklyInputBox" class="row g-2 mb-3" style="display: none;">
                        <div class="col-6">
                            <label class="form-label small fw-bold text-muted">Start Date *</label>
                            <input type="date" name="startDate" class="form-control">
                        </div>
                        <div class="col-6">
                            <label class="form-label small fw-bold text-muted">End Date *</label>
                            <input type="date" name="endDate" class="form-control">
                        </div>
                    </div>

                    <div id="monthlyInputBox" class="mb-3" style="display: none;">
                        <label class="form-label small fw-bold text-muted">Select Month *</label>
                        <input type="month" name="monthPicker" class="form-control">
                    </div>

                    <button type="submit" class="btn btn-success w-100 rounded-pill fw-bold py-2">
                        <i class="fa-solid fa-download me-1"></i> Download Generated Report
                    </button>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Add Achievement Modal -->
<div class="modal fade" id="addAchievementModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content shadow-lg">
            <form action="${pageContext.request.contextPath}/achievement/add" method="POST" enctype="multipart/form-data">
                <div class="modal-header border-bottom px-4 py-3 bg-success text-white">
                    <h6 class="modal-title fw-bold mb-0"><i class="fa-solid fa-award me-2"></i>Add Achievement</h6>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body p-4">
                    <div class="mb-3">
                        <label class="form-label small fw-bold text-muted">Achievement Title / Award Description *</label>
                        <input type="text" name="title" class="form-control" placeholder="e.g. Best Researcher Award" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label small fw-bold text-muted">Verification Link (URL)</label>
                        <input type="url" name="proofUrl" class="form-control" placeholder="https://...">
                    </div>
                    <div class="mb-3">
                        <label class="form-label small fw-bold text-muted">Or Upload PDF Certificate</label>
                        <input type="file" name="proofFile" class="form-control" accept=".pdf">
                    </div>
                    <button type="submit" class="btn btn-success w-100 rounded-pill fw-bold">Save Achievement</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Edit Profile Modal -->
<div class="modal fade" id="editProfileModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content shadow-lg">
            <form action="${pageContext.request.contextPath}/profile/update" method="POST">
                <div class="modal-header border-bottom px-4 py-3 bg-primary text-white">
                    <h6 class="modal-title fw-bold mb-0"><i class="fa-solid fa-user-pen me-2"></i>Update Academic Profile Information</h6>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body p-4">
                    <div class="row g-3 mb-3">
                        <div class="col-md-6">
                            <label class="form-label small fw-bold text-muted">Full Name *</label>
                            <input type="text" name="fullName" class="form-control" value="${faculty.fullName}" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label small fw-bold text-muted">ERP ID</label>
                            <input type="text" class="form-control font-monospace" value="${faculty.erpId}" readonly style="opacity: 0.65;">
                        </div>
                    </div>

                    <div class="row g-3 mb-3">
                        <div class="col-md-6">
                            <label class="form-label small fw-bold text-muted">Designation *</label>
                            <input type="text" name="designation" class="form-control" value="${faculty.designation}" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label small fw-bold text-muted">Department *</label>
                            <input type="text" name="department" class="form-control" value="${faculty.department}" required>
                        </div>
                    </div>

                    <div class="row g-3 mb-3">
                        <div class="col-md-6">
                            <label class="form-label small fw-bold text-muted">ORCID Identifier</label>
                            <input type="text" name="orcidId" class="form-control font-monospace" placeholder="0000-0002-1825-0097" value="${faculty.orcidId}">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label small fw-bold text-muted">Scopus Author ID</label>
                            <input type="text" name="scopusId" class="form-control font-monospace" placeholder="57200293810" value="${faculty.scopusId}">
                        </div>
                    </div>

                    <div class="row g-3 mb-3">
                        <div class="col-md-6">
                            <label class="form-label small fw-bold text-muted">Official Email *</label>
                            <input type="email" name="officialEmail" class="form-control" value="${faculty.officialEmail}" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label small fw-bold text-muted">Mobile Number</label>
                            <input type="text" name="mobileNumber" class="form-control" value="${faculty.mobileNumber}">
                        </div>
                    </div>

                    <div class="d-flex justify-content-end gap-2 pt-2 border-top">
                        <button type="button" class="btn btn-outline-secondary rounded-pill px-4" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-primary rounded-pill px-4 fw-bold">Save Academic Profile</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>


<!-- Delete confirmation -->
<div class="modal fade" id="deleteRecordModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" style="max-width:440px;">
        <div class="modal-content shadow-lg">
            <form action="${pageContext.request.contextPath}/publications/delete" method="POST">
                <input type="hidden" name="publicationId" id="deletePubId">
                <div class="modal-body p-4">
                    <div class="d-flex gap-3">
                        <div style="width:44px;height:44px;border-radius:12px;background:rgba(220,38,38,.12);color:#dc2626;display:flex;align-items:center;justify-content:center;flex-shrink:0;"><i class="fa-solid fa-trash-can"></i></div>
                        <div class="min-w-0">
                            <h6 class="fw-bold mb-1">Delete this record?</h6>
                            <div class="fw-semibold small mb-2" id="deleteRecordTitle" style="word-break:break-word;"></div>
                            <p class="text-muted small mb-0">It will be removed from your Vault, API score and appraisal summary. This cannot be undone.</p>
                        </div>
                    </div>
                    <div class="d-flex justify-content-end gap-2 mt-4">
                        <button type="button" class="btn btn-outline-secondary btn-sm px-3 rounded-pill" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-danger btn-sm px-3 rounded-pill fw-semibold">Delete record</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>

<div class="fv-toast-wrap" id="fvToastWrap"></div>

<div class="fv-dialog" id="fvCelebrate" onclick="if(event.target===this)fvCelebrate.close()">
    <div class="fv-dialog-card">
        <div class="small text-uppercase fw-bold text-muted mb-1" id="fvCelKicker" style="letter-spacing:.5px;"></div>
        <h5 class="fw-bold mb-2" id="fvCelTitle"></h5>
        <p class="text-muted mb-4" id="fvCelSub" style="font-size:.9rem;"></p>
        <div class="d-flex gap-2 justify-content-end">
            <button class="btn btn-outline-secondary btn-sm px-3" onclick="fvCelebrate.close()">Close</button>
            <button class="btn btn-primary btn-sm px-3 fw-semibold" id="fvCelAction" style="display:none;"></button>
        </div>
    </div>
</div>

<div class="fv-cmd" id="fvCmd" onclick="if(event.target===this)fvCmd.close()">
    <div class="fv-cmd-box">
        <input class="fv-cmd-input" id="fvCmdInput" placeholder="Jump to&hellip; (e.g. add patent, export, appraisal)" autocomplete="off">
        <div class="fv-cmd-list" id="fvCmdList"></div>
    </div>
</div>

<div id="fvMe" style="display:none"
     data-name="<c:out value='${cleanSalutation}'/>"
     data-fullname="<c:out value='${faculty.fullName}'/>" data-desig="<c:out value='${faculty.designation}'/>"
     data-ach="${not empty achievements ? fn:length(achievements) : 0}"
     data-dept="<c:out value='${faculty.department}'/>"
     data-erp="<c:out value='${faculty.erpId}'/>"
     data-orcid="<c:out value='${faculty.orcidId}'/>"
     data-scopus="<c:out value='${faculty.scopusId}'/>"
     data-email="<c:out value='${faculty.officialEmail}'/>"
     data-mobile="<c:out value='${faculty.mobileNumber}'/>"
     data-j="${jCount}" data-c="${cCount}" data-p="${pCount}" data-d="${dCount}"
     data-score="${totalApiScore}" data-target="${targetTotal}"></div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function applyTheme(theme) {
        document.documentElement.setAttribute('data-theme', theme);
        localStorage.setItem('facultyVaultTheme', theme);
        const icon = document.getElementById('themeIcon');
        const label = document.getElementById('themeLabel');
        if (theme === 'dark') {
            if (icon) icon.className = 'fa-solid fa-moon text-warning';
            if (label) label.innerText = 'Dark Theme';
        } else {
            if (icon) icon.className = 'fa-solid fa-sun text-warning';
            if (label) label.innerText = 'Light Theme';
        }
    }
    function toggleTheme() {
        const current = document.documentElement.getAttribute('data-theme') || 'dark';
        applyTheme(current === 'dark' ? 'light' : 'dark');
    }

    function switchPortalPane(paneId) {
        document.querySelectorAll('.nav-link-btn').forEach(el => el.classList.remove('active'));
        document.querySelectorAll('.view-pane-section').forEach(el => el.classList.remove('active-pane'));
        document.getElementById('nav-' + paneId)?.classList.add('active');
        document.getElementById('pane-' + paneId)?.classList.add('active-pane');
    }

    function openAddModalWithCategory(category) {
        document.getElementById('modalActivityCategory').value = category;
        toggleCategoryFields(category);
        new bootstrap.Modal(document.getElementById('addResearchModal')).show();
    }

    function openEditRecordModal(id, category, title, authors, venue, indexing, date) {
        document.getElementById('editPubId').value = id;
        document.getElementById('editModalActivityCategory').value = category || 'JOURNAL';
        document.getElementById('editTitle').value = title || '';
        document.getElementById('editAuthors').value = authors || '';
        document.getElementById('editDate').value = date || '';
        
        if (category === 'JOURNAL') {
            document.getElementById('editJournalName').value = venue || '';
            document.getElementById('editPublisher').value = venue || '';
            document.getElementById('editDoi').value = indexing || '';
        } else if (category === 'CONFERENCE') {
            document.getElementById('editConfName').value = venue || '';
        } else if (category === 'PATENT') {
            document.getElementById('editPatentNumber').value = indexing || '';
            document.getElementById('editIpAuthority').value = venue || '';
        } else if (category === 'BOOK_CHAPTER') {
            document.getElementById('editBookEditor').value = venue || '';
        } else if (category === 'FDP_STTP') {
            document.getElementById('editFdpName').value = venue || '';
        }

        toggleEditCategoryFields(category || 'JOURNAL');
        new bootstrap.Modal(document.getElementById('editRecordModal')).show();
    }

    function toggleCategoryFields(cat) {
        document.querySelectorAll('.category-specific-fields').forEach(el => {
            el.style.display = 'none';
            el.querySelectorAll('input, select').forEach(input => input.removeAttribute('required'));
        });
        
        const autoFetchBox = document.getElementById('autoFetchBox');
        const bookAuthorFields = document.getElementById('bookAuthorFields');
        let activeRow = null;

        if (cat === 'JOURNAL') {
            activeRow = document.getElementById('journalFields');
            if (autoFetchBox) autoFetchBox.style.display = 'block';
            if (bookAuthorFields) bookAuthorFields.style.display = 'none';
        } else if (cat === 'CONFERENCE') {
            activeRow = document.getElementById('conferenceFields');
            if (autoFetchBox) autoFetchBox.style.display = 'block';
            if (bookAuthorFields) bookAuthorFields.style.display = 'none';
        } else if (cat === 'PATENT') {
            activeRow = document.getElementById('patentFields');
            if (autoFetchBox) autoFetchBox.style.display = 'block';
            if (bookAuthorFields) bookAuthorFields.style.display = 'none';
        } else if (cat === 'BOOK_CHAPTER') {
            activeRow = document.getElementById('bookFields');
            if (autoFetchBox) autoFetchBox.style.display = 'none';
            if (bookAuthorFields) bookAuthorFields.style.display = 'flex';
        } else if (cat === 'FDP_STTP' || cat === 'OUTREACH') {
            activeRow = document.getElementById('fdpFields');
            if (autoFetchBox) autoFetchBox.style.display = 'none';
            if (bookAuthorFields) bookAuthorFields.style.display = 'none';
        }

        if (activeRow) {
            activeRow.style.display = 'flex';
            activeRow.querySelectorAll('input, select').forEach(input => {
                if(!input.name.includes('doi') && !input.name.includes('venue')) {
                    input.setAttribute('required', 'true');
                }
            });
        }
    }

    function toggleEditCategoryFields(cat) {
        document.querySelectorAll('.edit-category-specific-fields').forEach(el => {
            el.style.display = 'none';
            el.querySelectorAll('input, select').forEach(input => input.removeAttribute('required'));
        });

        const bookAuthorFields = document.getElementById('editBookAuthorFields');
        if (bookAuthorFields) bookAuthorFields.style.display = (cat === 'BOOK_CHAPTER') ? 'flex' : 'none';

        let activeRow = null;
        if (cat === 'JOURNAL') {
            activeRow = document.getElementById('editJournalFields');
        } else if (cat === 'CONFERENCE') {
            activeRow = document.getElementById('editConferenceFields');
        } else if (cat === 'PATENT') {
            activeRow = document.getElementById('editPatentFields');
        } else if (cat === 'BOOK_CHAPTER') {
            activeRow = document.getElementById('editBookFields');
        } else if (cat === 'FDP_STTP' || cat === 'OUTREACH') {
            activeRow = document.getElementById('editFdpFields');
        }

        if (activeRow) {
            activeRow.style.display = 'flex';
        }
    }

    function toggleReportDateInputs(type) {
        document.getElementById('weeklyInputBox').style.display = (type === 'weekly') ? 'flex' : 'none';
        document.getElementById('monthlyInputBox').style.display = (type === 'monthly') ? 'block' : 'none';
    }

    function fetchMetadataFromSource() {
        const link = document.getElementById('externalLinkInput').value.trim();
        if (!link) { alert('Please enter a valid DOI, Conference URL, or Google Patent link.'); return; }
        
        const btn = event.target;
        const originalText = btn.innerText;
        btn.innerText = 'Fetching Live...';
        btn.disabled = true;

        fetch('${pageContext.request.contextPath}/dashboard/fetch-external-metadata?sourceUrl=' + encodeURIComponent(link))
            .then(res => res.json())
            .then(data => {
                btn.innerText = originalText;
                btn.disabled = false;
                if (data.success) {
                    if(document.getElementById('recordTitle')) document.getElementById('recordTitle').value = data.title || '';
                    if(document.getElementById('recordAuthors')) document.getElementById('recordAuthors').value = data.authors || '';
                    if(document.getElementById('recordPublisher')) document.getElementById('recordPublisher').value = data.publisher || '';
                    if(document.getElementById('recordJournalName')) document.getElementById('recordJournalName').value = data.journalName || '';
                    if(document.getElementById('recordDoi')) document.getElementById('recordDoi').value = data.doiAndVolume || '';
                    
                    if (link.includes('patents.google.com') || link.includes('patent')) {
                        document.getElementById('modalActivityCategory').value = 'PATENT';
                        toggleCategoryFields('PATENT');
                    } else if (link.includes('ieee.org') || link.includes('springer.com') || link.includes('acm.org') || link.includes('conference')) {
                        document.getElementById('modalActivityCategory').value = 'CONFERENCE';
                        toggleCategoryFields('CONFERENCE');
                    }
                    fvToast({cat:'JOURNAL', title:'Metadata auto-filled', sub:(data.message || 'Details fetched from the source.'), ms:4000});
                } else {
                    fvToast({cat:'PATENT', title:'Could not fetch details', sub:(data.message || 'Unable to read this link.'), ms:5000});
                }
            })
            .catch(err => {
                btn.innerText = originalText;
                btn.disabled = false;
                fvToast({cat:'PATENT', title:'Network error', sub:'Metadata resolver is not reachable.', ms:5000});
            });
    }

    document.addEventListener('DOMContentLoaded', () => {
        applyTheme(localStorage.getItem('facultyVaultTheme') || 'dark');
        toggleCategoryFields(document.getElementById('modalActivityCategory').value);

        const barCtx = document.getElementById('barChart');
        if (barCtx) {
            const monthlyData = ${not empty monthlyActivityJson ? monthlyActivityJson : '[0,0,0,0,0,0,0,0,0,0,0,0]'};
            new Chart(barCtx, {
                type: 'bar',
                data: {
                    labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
                    datasets: [{
                        label: 'Publications & Monthly Output',
                        data: monthlyData,
                        backgroundColor: '#3b82f6',
                        borderRadius: 6
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: { legend: { display: false } },
                    scales: { y: { beginAtZero: true, ticks: { stepSize: 1 } } }
                }
            });
        }

        const doughnutCtx = document.getElementById('analyticsChart');
        if (doughnutCtx) {
            new Chart(doughnutCtx, {
                type: 'doughnut',
                data: {
                    labels: ['Journals', 'Conferences', 'Patents', 'FDP/Workshops'],
                    datasets: [{
                        data: [${jCount},${cCount}, ${pCount},${dCount}],
                        backgroundColor: ['#3b82f6', '#06b6d4', '#10b981', '#f59e0b']
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: { legend: { position: 'bottom', labels: { boxWidth: 12 } } }
                }
            });
        }
    });

    const CTX = '${pageContext.request.contextPath}';
    const FV = (function () {
        const d = document.getElementById('fvMe').dataset;
        return { name: d.name, dept: d.dept, erp: d.erp, orcid: d.orcid, scopus: d.scopus, email: d.email, mobile: d.mobile, desig: d.desig, fullName: d.fullname, ach: +d.ach || 0,
                 j: +d.j || 0, c: +d.c || 0, p: +d.p || 0, d: +d.d || 0, score: +d.score || 0, target: +d.target || 0 };
    })();
    const CAT = { JOURNAL: 'journal paper', PATENT: 'patent', CONFERENCE: 'conference paper', BOOK_CHAPTER: 'book / chapter', FDP_STTP: 'FDP / workshop' };
    const CAT_COLOR = { JOURNAL: '#2563eb', PATENT: '#059669', CONFERENCE: '#7c3aed', BOOK_CHAPTER: '#d97706', FDP_STTP: '#0891b2' };
    function esc(s) { return String(s == null ? '' : s).replace(/[&<>"']/g, m => ({ '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' }[m])); }
    const MON = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
    function ago(ts) {
        const s = Math.max(1, Math.floor((Date.now() - ts) / 1000));
        if (s < 60) return 'just now'; if (s < 3600) return Math.floor(s / 60) + ' min ago';
        if (s < 86400) return Math.floor(s / 3600) + ' hr ago'; return Math.floor(s / 86400) + ' d ago';
    }
    const store = {
        get(k, f) { try { const v = localStorage.getItem(k); return v ? JSON.parse(v) : f; } catch (e) { return f; } },
        set(k, v) { try { localStorage.setItem(k, JSON.stringify(v)); } catch (e) {} }
    };

    const fvCelebrate = {
        show(o) {
            document.getElementById('fvCelKicker').textContent = o.kicker || '';
            document.getElementById('fvCelTitle').textContent = o.title || '';
            document.getElementById('fvCelSub').textContent = o.sub || '';
            const a = document.getElementById('fvCelAction');
            if (o.action) { a.style.display = ''; a.textContent = o.action.label; a.onclick = () => { fvCelebrate.close(); o.action.fn(); }; } else a.style.display = 'none';
            document.getElementById('fvCelebrate').classList.add('open');
        },
        close() { document.getElementById('fvCelebrate').classList.remove('open'); }
    };

    const fvNotif = {
        key: 'fvNotifs_' + FV.erp, list: [],
        init() { this.list = store.get(this.key, []); this.render(); },
        push(n) {
            n.id = n.id || ('n' + Date.now() + Math.random().toString(16).slice(2, 6)); n.ts = n.ts || Date.now(); n.read = false;
            if (this.list.some(x => x.id === n.id)) return false;
            this.list.unshift(n); this.list = this.list.slice(0, 40); store.set(this.key, this.list); this.render(); return true;
        },
        render() {
            const unread = this.list.filter(x => !x.read).length, bd = document.getElementById('fvBellBadge');
            bd.textContent = unread > 9 ? '9+' : unread; bd.classList.toggle('show', unread > 0);
            const el = document.getElementById('fvNotifList');
            el.innerHTML = this.list.length ? this.list.map(n => '<div class="fv-notif-item ' + (n.read ? '' : 'unread') + '"><div class="fw-semibold" style="color:var(--text-heading)">' + esc(n.title) + '</div>' +
                (n.sub ? '<div class="text-muted">' + esc(n.sub) + '</div>' : '') + '<div class="text-muted" style="font-size:.7rem">' + ago(n.ts) + '</div></div>').join('') : '<div class="fv-empty">No notifications.</div>';
        },
        toggle() { const p = document.getElementById('fvNotifPanel'); p.classList.toggle('open'); if (p.classList.contains('open')) setTimeout(() => this.readAll(), 1500); },
        readAll() { this.list.forEach(n => n.read = true); store.set(this.key, this.list); this.render(); },
        clear() { this.list = []; store.set(this.key, this.list); this.render(); }
    };
    document.addEventListener('click', e => { if (!e.target.closest('#fvNotifPanel') && !e.target.closest('#fvBellBtn')) document.getElementById('fvNotifPanel').classList.remove('open'); });

    function fvToast(o) {
        const t = document.createElement('div'); t.className = 'fv-toast'; t.style.borderLeftColor = CAT_COLOR[o.cat] || 'var(--brand)';
        t.innerHTML = '<div class="t-title">' + esc(o.title) + '</div>' + (o.sub ? '<div class="t-sub">' + esc(o.sub) + '</div>' : '') +
            (o.feedId ? '<button class="fv-link-btn mt-1">Congratulate</button>' : '');
        const b = t.querySelector('button');
        if (b) b.onclick = () => { fvFeed.congratulate(o.feedId); b.textContent = 'Sent'; b.disabled = true; };
        document.getElementById('fvToastWrap').appendChild(t);
        setTimeout(() => { t.classList.add('out'); setTimeout(() => t.remove(), 300); }, o.ms || 8000);
    }

    const FV_PTS = { JOURNAL: 10, CONFERENCE: 5, PATENT: 15, BOOK_CHAPTER: 3, FDP_STTP: 3 };
    const FV_LABEL = { JOURNAL: 'Journal', CONFERENCE: 'Conference', PATENT: 'Patent', BOOK_CHAPTER: 'Book / Chapter', FDP_STTP: 'FDP / Workshop' };
    function fvDate(d) { const x = new Date(d); return isNaN(x) ? d : x.toLocaleDateString('en-IN', { day: 'numeric', month: 'short', year: 'numeric' }); }
    const FV_ICON = { JOURNAL: 'fa-book-open', PATENT: 'fa-award', CONFERENCE: 'fa-users', BOOK_CHAPTER: 'fa-book', FDP_STTP: 'fa-chalkboard-user' };
    function fvNorm(s) { return String(s || '').toLowerCase().replace(/^(dr|prof|mr|mrs|ms)\.?\s+/, '').replace(/\s+/g, ' ').trim(); }
    function fvSameDept(a, b) { a = fvNorm(a); b = fvNorm(b); return !!a && !!b && (a === b || a.includes(b) || b.includes(a)); }
    function fvInit(n) { return esc(fvNorm(n).charAt(0).toUpperCase() || '?'); }
    function fvOpenModal(id) { bootstrap.Modal.getOrCreateInstance(document.getElementById(id)).show(); }
    function fvCopy(text, label) {
        if (!text) return;
        const ok = () => fvToast({ title: label + ' copied', ms: 2200 });
        if (navigator.clipboard && window.isSecureContext) navigator.clipboard.writeText(text).then(ok).catch(() => {});
        else { const t = document.createElement('textarea'); t.value = text; document.body.appendChild(t); t.select(); try { document.execCommand('copy'); ok(); } catch (e) {} t.remove(); }
    }
    function fvPubRecords() {
        return Array.from(document.querySelectorAll('#pane-publications tr.pub-row')).map(r => {
            const cat = r.dataset.cat;
            const venue = r.children[2] ? ((r.children[2].querySelector('.fw-semibold') || {}).textContent || '') : '';
            const authors = r.children[1] ? ((r.children[1].querySelector('.small') || {}).textContent || '') : '';
            return { cat: cat, title: r.dataset.title || '', authors: authors.trim(), venue: venue.trim(), date: (r.children[3] ? r.children[3].textContent : '').trim(), proof: r.dataset.proof === '1', pts: FV_PTS[cat] || 0 };
        });
    }

    const fvFeed = {
        items: [], maxId: 0, seen: store.get('fvLastFeedId_' + FV.erp, 0), fails: 0, busy: false, loaded: false, status: '', filter: 'ALL', unseen: 0,
        demo: /[?&]demo=1/.test(location.search),
        start() {
            document.querySelectorAll('#fvFeedChips .fv-chip').forEach(b => b.onclick = () => {
                document.querySelectorAll('#fvFeedChips .fv-chip').forEach(x => x.classList.remove('active')); b.classList.add('active'); this.filter = b.dataset.f; this.render();
            });
            this.poll();
            setInterval(() => { if (!document.hidden) this.poll(); }, this.demo ? 7000 : 8000);
            document.addEventListener('visibilitychange', () => { if (!document.hidden) this.poll(); });
            setInterval(() => this.render(), 30000);
        },
        setStatus(s) {
            this.status = s;
            const t = new Date().toLocaleTimeString('en-IN', { hour: '2-digit', minute: '2-digit', second: '2-digit' });
            document.getElementById('fvLiveDot').className = 'fv-live-dot ' + s;
            document.getElementById('fvLiveText').textContent = s === 'live' ? 'Live - updated ' + t : s === 'demo' ? 'Demo data - ' + t : s === 'retry' ? 'Reconnecting...' : 'Live feed unavailable';
        },
        poll() {
            if (this.busy) return; this.busy = true;
            if (this.demo) { this.simulate(); this.busy = false; return; }
            fetch(CTX + '/dashboard/feed-api?since=' + this.maxId, { credentials: 'same-origin', headers: { 'Accept': 'application/json' } })
                .then(r => { if (!r.ok) throw new Error(r.status); return r.json(); })
                .then(d => { this.fails = 0; this.setStatus('live'); this.ingest(d); })
                .catch(() => { this.fails++; this.setStatus(this.items.length ? 'retry' : 'down'); this.render(); if (!fvRank.rows.length) fvRank.render([]); })
                .finally(() => { this.busy = false; });
        },
        ingest(d) {
            const first = !this.loaded; this.loaded = true;
            const incoming = (d.feed || []).filter(it => !this.items.some(x => x.id === it.id));
            incoming.forEach(it => { it._new = !first; this.items.push(it); this.maxId = Math.max(this.maxId, it.id); });
            const counts = d.counts || {};
            this.items.forEach(it => { if (counts[it.id] != null) it.congratsCount = counts[it.id]; });
            this.items.sort((a, b) => b.id - a.id); this.items = this.items.slice(0, 80);
            if (first) {
                const fresh = incoming.filter(it => !it.mine && it.id > this.seen);
                if (fresh.length) { fvNotif.push({ id: 'sum' + this.maxId, title: fresh.length + ' new update' + (fresh.length > 1 ? 's' : '') + ' since your last visit', sub: 'Open Department Updates to see them.' }); this.bump(fresh.length); }
            } else incoming.filter(it => !it.mine).forEach(it => this.announce(it));
            this.seen = Math.max(this.seen, this.maxId); store.set('fvLastFeedId_' + FV.erp, this.seen);
            (d.inbox || []).forEach(n => { if (fvNotif.push({ id: 'in' + n.id, title: n.title, sub: n.sub })) fvToast({ title: n.title, sub: n.sub }); });
            this.render();
            if (d.leaderboard) fvRank.render(d.leaderboard);
        },
        bump(n) {
            if (document.getElementById('pane-feed').classList.contains('active-pane')) return;
            this.unseen += n; const b = document.getElementById('fvFeedNavBadge'); b.textContent = this.unseen; b.style.display = '';
        },
        announce(it) {
            const title = it.facultyName + ' added a ' + (CAT[it.category] || 'record');
            fvNotif.push({ id: 'f' + it.id, title: title, sub: it.title });
            fvToast({ cat: it.category, title: title, sub: it.title, feedId: it.id });
            if (it.category === 'PATENT' || it.category === 'BOOK_CHAPTER') {
                fvCelebrate.show({ kicker: 'Department update', title: 'Congratulations to ' + it.facultyName,
                    sub: (it.category === 'PATENT' ? 'Has filed a new patent: ' : 'Has added a new book / chapter: ') + it.title,
                    action: { label: 'Send congratulations', fn: () => fvFeed.congratulate(it.id) } });
            }
            this.bump(1);
        },
        congratulate(id) {
            const it = this.items.find(x => x.id === id);
            if (it && !it.congratulatedByMe) { it.congratulatedByMe = true; it.congratsCount = (it.congratsCount || 0) + 1; this.render(); }
            if (this.demo) return;
            fetch(CTX + '/dashboard/congratulate', { method: 'POST', credentials: 'same-origin', headers: { 'Content-Type': 'application/x-www-form-urlencoded' }, body: 'feedId=' + encodeURIComponent(id) }).catch(() => {});
        },
        render() {
            const el = document.getElementById('fvFeedList'); if (!el) return;
            const f = this.filter; const ea = document.getElementById('fvFsAct'); if (ea) ea.textContent = this.items.filter(x => !x.mine).length;
            const list = this.items.filter(it => f === 'ALL' || (f === 'DEPT' ? fvSameDept(it.department, FV.dept) : it.category === f));
            if (!list.length) {
                const down = !this.items.length && this.status === 'down';
                if (!this.status) { el.innerHTML = '<div class="fv-skel"></div><div class="fv-skel"></div><div class="fv-skel"></div>'; return; }
                el.innerHTML = '<div class="fv-state"><div class="fv-state-ico"><i class="fa-solid ' + (down ? 'fa-plug-circle-exclamation' : 'fa-inbox') + '"></i></div>' +
                    '<div class="fw-semibold" style="color:var(--text-heading)">' + (down ? 'Could not load live updates' : this.items.length ? 'No updates match this filter' : 'No updates yet') + '</div>' +
                    '<div class="text-muted small mt-1">' + (down ? 'This page keeps retrying automatically. Your own records and score are not affected.' : this.items.length ? 'Try a different filter.' : 'When a colleague adds a record, it appears here within seconds.') + '</div></div>';
                return;
            }
            el.innerHTML = list.map(it => {
                const col = CAT_COLOR[it.category] || '#2563eb', ic = FV_ICON[it.category] || 'fa-file';
                return '<div class="fv-feed-item' + (it._new ? ' is-new' : '') + '">' +
                    '<div class="fv-feed-ico" style="background:' + col + '22;color:' + col + '"><i class="fa-solid ' + ic + '"></i></div>' +
                    '<div class="flex-grow-1 min-w-0"><div><strong>' + esc(it.facultyName) + '</strong>' + (it.mine ? ' <span class="fv-you">You</span>' : '') + ' <span class="text-muted small">' + esc(it.department || '') + '</span></div>' +
                    '<div class="text-muted small">added a ' + (CAT[it.category] || 'record') + (it.createdAt ? ' - ' + ago(it.createdAt) : (it.eventDate ? ' - dated ' + fvDate(it.eventDate) : '')) + '</div>' +
                    '<div class="fv-feed-title">' + esc(it.title) + '</div></div>' +
                    '<div class="text-end small">' + (it.mine ? '' : '<button class="fv-link-btn" ' + (it.congratulatedByMe ? 'disabled' : '') + ' onclick="fvFeed.congratulate(' + it.id + ')">' + (it.congratulatedByMe ? 'Congratulated' : 'Congratulate') + '</button>') +
                    (it.congratsCount ? '<div class="text-muted">' + it.congratsCount + ' <i class="fa-solid fa-hands-clapping"></i></div>' : '') + '</div></div>';
            }).join('');
        },
        simulate() {
            const D = FV.dept, ppl = [['Dr. Anjali Verma', D, 215], ['Prof. Rohit Mehra', D, 180], ['Dr. Neha Gupta', D, 120], ['Dr. Sneha Kapoor', 'Electronics & Communication', 160], ['Dr. Karan Singh', 'Mechanical Engineering', 140], ['Dr. Pooja Arora', 'Information Technology', 130], ['Prof. Vivek Rai', 'Civil Engineering', 70]];
            const kinds = [['PATENT', 'IoT-based fault detection for smart grids'], ['JOURNAL', 'Low-power VLSI design for edge accelerators'], ['CONFERENCE', 'Federated learning for rural healthcare'], ['BOOK_CHAPTER', 'Additive manufacturing in sustainable design']];
            this.demoScores = this.demoScores || ppl.map(p => p[2]);
            const i = (Math.random() * ppl.length) | 0, k = kinds[(Math.random() * kinds.length) | 0];
            this.demoScores[i] += FV_PTS[k[0]]; this.setStatus('demo');
            const lb = ppl.map((p, n) => ({ name: p[0], dept: p[1], score: this.demoScores[n] })); lb.push({ name: FV.name, dept: FV.dept, score: FV.score, mine: true });
            this.ingest({ feed: [{ id: this.maxId + 1, facultyName: ppl[i][0], department: ppl[i][1], category: k[0], title: k[1], createdAt: Date.now() }], leaderboard: lb });
        }
    };

    const fvRank = {
        rows: [], scope: 'dept', base: null, cur: null,
        isMe(r) { return !!r.mine || (r.erp && FV.erp && String(r.erp) === String(FV.erp)) || fvNorm(r.name) === fvNorm(FV.fullName || FV.name); },
        ranked(rows) {
            const s = rows.map(r => Object.assign({}, r)).sort((a, b) => b.score - a.score || String(a.name).localeCompare(String(b.name)));
            let last = null, rk = 0; s.forEach((r, i) => { if (r.score !== last) { rk = i + 1; last = r.score; } r.rank = rk; }); return s;
        },
        key(r) { return r.erp || fvNorm(r.name); },
        map(list) { const m = {}; list.forEach(r => m[this.key(r)] = r.rank); return m; },
        setScope(s) { this.scope = s; document.querySelectorAll('#fvRankSeg button').forEach(b => b.classList.toggle('active', b.dataset.scope === s)); this.drawPanel(); },
        render(rows) {
            rows = (rows || []).map(r => ({ name: r.name, dept: r.dept, erp: r.erp, mine: r.mine, score: +r.score || 0 }));
            if (rows.length && !rows.some(r => this.isMe(r))) rows.push({ name: FV.name, dept: FV.dept, erp: FV.erp, mine: true, score: FV.score });
            this.rows = rows; this.draw();
        },
        draw() {
            const live = this.rows.length > 0;
            const all = live ? this.rows : [{ name: FV.name, dept: FV.dept, erp: FV.erp, mine: true, score: FV.score }];
            const college = this.ranked(all), dept = this.ranked(all.filter(r => fvSameDept(r.dept, FV.dept) || this.isMe(r)));
            if (live && !this.base) this.base = { college: this.map(college), dept: this.map(dept) };
            this.cur = { college: college, dept: dept, meC: college.find(r => this.isMe(r)), meD: dept.find(r => this.isMe(r)), live: live };
            this.drawMini(); this.drawStrip(); this.drawPanel(); this.drawAppraisal();
            if (window.fvProfile) fvProfile.drawBadges();
        },
        move(r, scope) {
            if (!this.base) return ''; const b = this.base[scope][this.key(r)]; if (!b || b === r.rank) return '';
            return b > r.rank ? '<span class="fv-mv up">&#9650; ' + (b - r.rank) + '</span>' : '<span class="fv-mv dn">&#9660; ' + (r.rank - b) + '</span>';
        },
        drawMini() {
            const c = this.cur, set = (id, t) => { const e = document.getElementById(id); if (e) e.textContent = t; };
            if (!c.live) { set('fvMiniDept', '-'); set('fvMiniCol', '-'); set('fvMiniDeptOf', 'Not available'); set('fvMiniColOf', 'Not available'); set('fvMiniGap', 'Ranking appears once the live feed is connected.'); return; }
            set('fvMiniDept', '#' + c.meD.rank); set('fvMiniDeptOf', 'of ' + c.dept.length + ' in department');
            set('fvMiniCol', '#' + c.meC.rank); set('fvMiniColOf', 'of ' + c.college.length + ' in college');
            const above = c.dept.filter(r => r.score > c.meD.score).pop();
            set('fvMiniGap', above ? (above.score - c.meD.score) + ' points behind ' + above.name + ' in your department.' : 'You are leading your department.');
        },
        drawStrip() {
            const c = this.cur, set = (id, t) => { const e = document.getElementById(id); if (e) e.textContent = t; };
            if (!c.live) { set('fvFsDept', '-'); set('fvFsCol', '-'); set('fvFsDeptOf', 'Waiting for live data'); set('fvFsColOf', 'Waiting for live data'); return; }
            set('fvFsDept', '#' + c.meD.rank); set('fvFsDeptOf', 'of ' + c.dept.length + ' in department');
            set('fvFsCol', '#' + c.meC.rank); set('fvFsColOf', 'of ' + c.college.length + ' in college');
        },
        drawPanel() {
            const sum = document.getElementById('fvRankSummary'); if (!sum) return;
            const c = this.cur, pod = document.getElementById('fvPodium'), lb = document.getElementById('fvLeaderboard');
            if (!c.live) { sum.innerHTML = ''; pod.innerHTML = ''; lb.innerHTML = '<div class="fv-state" style="padding:1.5rem 1rem"><div class="fv-state-ico"><i class="fa-solid fa-ranking-star"></i></div><div class="text-muted small">Ranking will appear once live data loads.<br>Your own score is <strong>' + FV.score + '</strong>.</div></div>'; return; }
            const col = this.scope === 'college', list = col ? c.college : c.dept, me = col ? c.meC : c.meD, sc = col ? 'college' : 'dept';
            sum.innerHTML = '<span class="h4 fw-bold">#' + me.rank + '</span> <span class="text-muted">of ' + list.length + (col ? ' faculty in the college' : ' faculty in your department') + ' &bull; ' + me.score + ' points</span>';
            const top = list.slice(0, 3), order = top.length === 3 ? [1, 0, 2] : top.map((x, i) => i);
            pod.innerHTML = '<div class="fv-podium">' + order.map(i => { const r = top[i]; return '<div class="fv-pod p' + (i + 1) + (this.isMe(r) ? ' me' : '') + '"><div class="fv-pod-av">' + fvInit(r.name) + '</div><div class="fv-pod-name">' + esc(r.name) + '</div><div class="fv-pod-dept">' + esc(r.dept || '') + '</div><div class="fv-pod-score">' + r.score + '</div><div class="fv-pod-step">#' + r.rank + '</div></div>'; }).join('') + '</div>';
            const mx = list[0].score || 1;
            const row = r => '<div class="fv-rk' + (this.isMe(r) ? ' me' : '') + '"><span class="fv-rk-no">' + r.rank + '</span><div class="fv-rk-av">' + fvInit(r.name) + '</div><div class="flex-grow-1 min-w-0"><div class="fw-semibold text-truncate">' + esc(r.name) + (this.isMe(r) ? ' <span class="fv-you">You</span>' : '') + '</div><div class="fv-bar sm"><div style="width:' + Math.round(r.score * 100 / mx) + '%"></div></div>' + (col ? '<div class="text-muted" style="font-size:.7rem">' + esc(r.dept || '') + '</div>' : '') + '</div><div class="text-end"><strong>' + r.score + '</strong>' + this.move(r, sc) + '</div></div>';
            let html = list.slice(3, 10).map(row).join('');
            if (me.rank > 10 || list.indexOf(me) > 9) html += '<div class="text-center text-muted small py-1">...</div>' + row(me);
            lb.innerHTML = html;
        },
        drawAppraisal() {
            const c = this.cur, a = document.getElementById('fvKpiRank'), b = document.getElementById('fvKpiRankSub'); if (!a) return;
            if (!c.live) { a.textContent = '-'; b.textContent = 'Live ranking not connected'; return; }
            a.textContent = '#' + c.meD.rank; b.textContent = 'of ' + c.dept.length + ' in dept. | #' + c.meC.rank + ' of ' + c.college.length + ' in college';
        }
    };
    document.addEventListener('click', e => { const b = e.target.closest('#fvRankSeg button'); if (b) fvRank.setScope(b.dataset.scope); });

    function renderSummary() {
        const recs = fvPubRecords();
        const groups = [['Journal papers', FV.j, 10], ['Conference papers', FV.c, 5], ['Patents', FV.p, 15], ['FDP, workshops, books &amp; outreach', FV.d, 3]];
        const total = groups.reduce((s, g) => s + g[1] * g[2], 0);
        document.getElementById('fvScoreBody').innerHTML = groups.map(g => { const pts = g[1] * g[2], sh = total ? Math.round(pts * 100 / total) : 0;
            return '<tr><td><div class="fw-semibold">' + g[0] + '</div><div class="fv-bar sm"><div style="width:' + sh + '%"></div></div></td><td class="text-end">' + g[1] + '</td><td class="text-end">' + g[2] + '</td><td class="text-end fw-semibold">' + pts + '</td><td class="text-end text-muted">' + (total ? sh + '%' : '-') + '</td></tr>'; }).join('') +
            '<tr><td colspan="3" class="fw-bold">Total API score</td><td class="text-end fw-bold">' + total + '</td><td></td></tr>';
        const withProof = recs.filter(r => r.proof).length, pct = Math.min(100, FV.target * 10);
        document.getElementById('fvKpiScore').textContent = total;
        document.getElementById('fvKpiTarget').textContent = FV.target + ' / 10';
        document.getElementById('fvKpiProof').textContent = withProof + ' / ' + recs.length;
        document.getElementById('fvTargetText').textContent = FV.target + ' of 10';
        document.getElementById('fvTargetBar').style.width = pct + '%';
        const left = Math.max(0, 10 - FV.target);
        document.getElementById('fvTargetNote').textContent = left === 0 ? 'Category \'A\' target met. Further records add to your API score.' : left + ' more journal, conference or patent record' + (left > 1 ? 's are' : ' is') + ' needed. A journal paper adds 10 points and a patent 15.';
        document.querySelectorAll('.fv-gen-date').forEach(e => e.textContent = new Date().toLocaleDateString('en-IN', { day: '2-digit', month: 'long', year: 'numeric' }));
        document.getElementById('fvRecCount').textContent = recs.length + ' record' + (recs.length === 1 ? '' : 's');
        document.getElementById('fvRecBody').innerHTML = recs.length ? recs.map((r, i) => '<tr><td>' + (i + 1) + '</td><td><div class="fw-semibold">' + esc(r.title) + '</div><div class="small text-muted">' + esc(r.authors) + '</div></td><td style="text-transform:capitalize">' + esc(CAT[r.cat] || r.cat) + '</td><td>' + esc(r.date) + '</td><td class="text-end">' + r.pts + '</td><td>' + (r.proof ? '<span class="text-success small"><i class="fa-solid fa-circle-check"></i> Attached</span>' : '<span class="small" style="color:var(--amber)"><i class="fa-solid fa-circle-exclamation"></i> Pending</span>') + '</td></tr>').join('') : '<tr><td colspan="6" class="text-center text-muted py-4">No records in the Vault yet.</td></tr>';

        const go = (pane, txt) => ' <a href="#" class="text-decoration-none no-print" onclick="switchPortalPane(\'' + pane + '\');return false;">' + txt + '</a>';
        const items = [
            [!!FV.orcid, 'ORCID iD linked', FV.orcid || 'Not linked.' + go('profile', 'Add in profile')],
            [!!FV.scopus, 'Scopus Author ID linked', FV.scopus || 'Not linked.' + go('profile', 'Add in profile')],
            [!!(FV.email && FV.mobile), 'Contact details complete', (FV.email && FV.mobile) ? 'Email and mobile on file.' : 'Mobile number or email missing.' + go('profile', 'Update profile')],
            [FV.j > 0, 'At least one journal paper', FV.j > 0 ? FV.j + ' recorded.' : 'None recorded yet.'],
            [FV.target >= 10, 'Category \'A\' target (10 outputs)', FV.target >= 10 ? 'Target met.' : left + ' more needed.'],
            [recs.length > 0 && withProof === recs.length, 'Proof attached to every record', recs.length ? withProof + ' of ' + recs.length + ' records have a proof file.' + (withProof < recs.length ? go('publications', 'Review records') : '') : 'No records yet.'],
            [null, 'Patents', FV.p ? FV.p + ' filed.' : 'None filed. Optional, but each patent carries 15 points.']
        ];
        const checks = items.filter(i => i[0] !== null);
        document.getElementById('fvReadyCount').textContent = checks.filter(i => i[0]).length + ' of ' + checks.length + ' passed';
        document.getElementById('fvChecklist').innerHTML = items.map(i => '<div class="fv-check"><i class="fa-solid ' + (i[0] === true ? 'fa-circle-check ok' : i[0] === false ? 'fa-circle-exclamation pending' : 'fa-circle-info info') + '"></i><div><div class="fw-semibold" style="color:var(--text-heading)">' + i[1] + '</div><div class="text-muted small">' + i[2] + '</div></div></div>').join('');
    }
    function fvDownloadSummary() {
        const q = v => '"' + String(v == null ? '' : v).replace(/"/g, '""') + '"';
        const rows = fvPubRecords();
        const lines = [['Faculty', FV.name], ['ERP ID', FV.erp], ['Department', FV.dept], ['Session', '2026-27'], ['Total API score', FV.score], ['Category A outputs', FV.target + ' / 10'], []].map(r => r.map(q).join(','));
        lines.push(['Category', 'Title', 'Authors', 'Venue / Publisher', 'Date', 'Points', 'Proof attached'].map(q).join(','));
        rows.forEach(r => lines.push([CAT[r.cat] || r.cat, r.title, r.authors, r.venue, r.date, r.pts, r.proof ? 'Yes' : 'No'].map(q).join(',')));
        const a = document.createElement('a'); a.href = URL.createObjectURL(new Blob(['﻿' + lines.join('\r\n')], { type: 'text/csv;charset=utf-8' }));
        a.download = 'appraisal_' + FV.erp + '.csv'; document.body.appendChild(a); a.click(); a.remove();
    }

    const fvProfile = {
        chart: null,
        total() { return FV.j + FV.c + FV.p + FV.d; },
        init() { this.drawComplete(); this.drawBadges(); this.drawTimeline(); },
        drawComplete() {
            const recs = fvPubRecords();
            const items = [['Designation', !!FV.desig, 'editProfileModal'], ['Department', !!FV.dept, 'editProfileModal'], ['Official email', !!FV.email, 'editProfileModal'], ['Mobile number', !!FV.mobile, 'editProfileModal'], ['ORCID iD', !!FV.orcid, 'editProfileModal'], ['Scopus Author ID', !!FV.scopus, 'editProfileModal'],
                ['At least one research record', this.total() > 0, 'addResearchModal'], ['At least one achievement', FV.ach > 0, 'addAchievementModal'], ['Proof attached to every record', recs.length > 0 && recs.every(r => r.proof), 'publications']];
            const done = items.filter(i => i[1]).length, pct = Math.round(done * 100 / items.length);
            document.getElementById('fvCompRing').style.setProperty('--pct', pct + '%'); document.getElementById('fvCompPct').textContent = pct + '%';
            document.getElementById('fvComplete').innerHTML = items.map(i => '<div class="fv-check" style="padding:.5rem 0"><i class="fa-solid ' + (i[1] ? 'fa-circle-check ok' : 'fa-circle pending') + '"></i><div class="flex-grow-1">' + i[0] + '</div>' +
                (i[1] ? '' : '<button class="fv-link-btn no-print" onclick="' + (i[2] === 'publications' ? 'switchPortalPane(\'publications\')' : 'fvOpenModal(\'' + i[2] + '\')') + '">Fix</button>') + '</div>').join('');
        },
        drawBadges() {
            const el = document.getElementById('fvBadges'); if (!el) return;
            const recs = fvPubRecords(), c = fvRank.cur || {};
            const B = [['fa-seedling', 'First Record', this.total() > 0], ['fa-book-open', 'Published Author', FV.j > 0], ['fa-users', 'Conference Speaker', FV.c > 0], ['fa-lightbulb', 'Innovator', FV.p > 0], ['fa-bullseye', 'Category A', FV.target >= 10], ['fa-fire', '100 Club', FV.score >= 100],
                ['fa-shield-halved', 'Verified Researcher', !!(FV.orcid && FV.scopus)], ['fa-folder-closed', 'Fully Documented', recs.length > 0 && recs.every(r => r.proof)], ['fa-trophy', 'Top 3 in Dept.', !!(c.live && c.meD && c.meD.rank <= 3)]];
            const n = B.filter(b => b[2]).length;
            el.innerHTML = B.map(b => '<div class="fv-badge-card ' + (b[2] ? '' : 'locked') + '"><i class="fa-solid ' + b[0] + '"></i><div class="n">' + b[1] + '</div></div>').join('');
            document.getElementById('fvBadgeCount').textContent = n + ' of ' + B.length;
            document.getElementById('fvHeroBadges').textContent = n;
        },
        drawTimeline() {
            const el = document.getElementById('fvTimeline');
            const recs = fvPubRecords().sort((a, b) => String(b.date).localeCompare(String(a.date)));
            if (!recs.length) { el.innerHTML = '<div class="fv-empty">Your timeline fills up as you add records.</div>'; return; }
            let yr = '', html = '';
            recs.forEach(r => {
                const y = String(r.date).slice(0, 4); if (y !== yr) { yr = y; html += '<div class="fv-tl-year">' + esc(y) + '</div>'; }
                const d = new Date(r.date), ds = isNaN(d) ? r.date : d.toLocaleDateString('en-IN', { day: 'numeric', month: 'short' });
                html += '<div class="fv-tl-item"><span class="fv-tl-dot" style="background:' + (CAT_COLOR[r.cat] || '#2563eb') + '"></span><div class="fw-semibold">' + esc(r.title) + '</div><div class="small text-muted" style="text-transform:capitalize">' + esc(CAT[r.cat] || r.cat) + ' - ' + esc(ds) + '</div></div>';
            });
            el.innerHTML = html;
        },
        radar() {
            if (this.chart || !window.Chart) return; const cv = document.getElementById('profileRadar'); if (!cv) return;
            this.chart = new Chart(cv, { type: 'radar', data: { labels: ['Journals', 'Conferences', 'Patents', 'FDP / Books'], datasets: [{ label: 'Records', data: [FV.j, FV.c, FV.p, FV.d], backgroundColor: 'rgba(37,99,235,.18)', borderColor: '#2563eb', pointBackgroundColor: '#2563eb' }] },
                options: { responsive: true, maintainAspectRatio: false, plugins: { legend: { display: false } }, scales: { r: { beginAtZero: true, suggestedMax: Math.max(3, FV.j, FV.c, FV.p, FV.d), ticks: { precision: 0, backdropColor: 'transparent' } } } } });
        },
        copySummary() {
            fvCopy([FV.name + (FV.desig ? ' - ' + FV.desig : ''), 'Dept. of ' + FV.dept + ', NIET Greater Noida', 'ORCID: ' + (FV.orcid || '-'), 'Scopus: ' + (FV.scopus || '-'), 'Research outputs: ' + this.total() + ' | API score: ' + FV.score].join('\n'), 'Profile summary');
        }
    };

    function fvRowText(r) { return Array.from(r.children).slice(0, 4).map(td => td.textContent).join(' ').toLowerCase() + ' ' + (CAT[r.dataset.cat] || ''); }
    const fvSearch = {
        hits: [], sel: -1,
        init() {
            const inp = document.getElementById('liveSearchInput'); if (!inp) return;
            inp.setAttribute('autocomplete', 'off');
            inp.addEventListener('input', () => this.run(inp.value));
            inp.addEventListener('focus', () => { if (inp.value.trim()) this.run(inp.value); });
            inp.addEventListener('keydown', e => {
                if (e.key === 'ArrowDown') { this.sel = Math.min(this.hits.length - 1, this.sel + 1); this.draw(); e.preventDefault(); }
                else if (e.key === 'ArrowUp') { this.sel = Math.max(-1, this.sel - 1); this.draw(); e.preventDefault(); }
                else if (e.key === 'Enter') { e.preventDefault(); if (this.sel >= 0) this.go(this.sel); else this.openVault(inp.value.trim()); }
                else if (e.key === 'Escape') { inp.value = ''; this.run(''); inp.blur(); }
            });
            document.addEventListener('click', e => { if (!e.target.closest('.top-search-wrap')) document.getElementById('fvSearchDrop').classList.remove('open'); });
        },
        run(v) {
            const q = v.trim().toLowerCase();
            const body = document.getElementById('recentPubsTableBody'); let shown = 0, total = 0;
            body.querySelectorAll('tr.pub-row').forEach(r => { total++; const ok = !q || fvRowText(r).includes(q); r.style.display = ok ? '' : 'none'; if (ok) shown++; });
            let nm = document.getElementById('fvRecentNoMatch');
            if (total) { if (!nm) { nm = document.createElement('tr'); nm.id = 'fvRecentNoMatch'; nm.innerHTML = '<td colspan="5" class="text-center text-muted py-4">No records match your search.</td>'; body.appendChild(nm); } nm.style.display = (q && !shown) ? '' : 'none'; }
            this.hits = q ? Array.from(document.querySelectorAll('#pane-publications tr.pub-row')).filter(r => fvRowText(r).includes(q)) : []; this.sel = -1; this.q = v.trim(); this.draw();
        },
        draw() {
            const d = document.getElementById('fvSearchDrop');
            if (!this.q) { d.classList.remove('open'); return; }
            d.innerHTML = (this.hits.length ? this.hits.slice(0, 6).map((r, i) => '<div class="fv-sr' + (i === this.sel ? ' sel' : '') + '" onclick="fvSearch.go(' + i + ')"><span class="fv-sr-tag">' + esc((CAT[r.dataset.cat] || r.dataset.cat).toUpperCase()) + '</span><div class="min-w-0"><div class="t">' + esc(r.dataset.title) + '</div><div class="m">' + esc((r.children[3] || {}).textContent || '') + '</div></div></div>').join('') : '<div class="fv-sr-foot">No records match &ldquo;' + esc(this.q) + '&rdquo;.</div>') +
                (this.hits.length ? '<div class="fv-sr-foot">' + this.hits.length + ' match' + (this.hits.length > 1 ? 'es' : '') + '. Press Enter to open them in the Vault.</div>' : '');
            d.classList.add('open');
        },
        openVault(q) { document.getElementById('fvSearchDrop').classList.remove('open'); switchPortalPane('publications'); fvVault.setQuery(q); },
        go(i) {
            const r = this.hits[i]; if (!r) return; document.getElementById('fvSearchDrop').classList.remove('open');
            switchPortalPane('publications'); fvVault.setQuery(this.q);
            r.classList.remove('fv-flash'); void r.offsetWidth; r.classList.add('fv-flash'); r.scrollIntoView({ block: 'center', behavior: 'smooth' });
        }
    };

    function checkTarget() {
        const k = 'fvTargetDone_' + FV.erp, done = store.get(k, null);
        if (FV.target >= 10 && done === false) { store.set(k, true);
            fvNotif.push({ title: 'Annual target reached', sub: FV.target + ' outputs recorded this session.' });
            setTimeout(() => fvCelebrate.show({ kicker: 'Appraisal', title: 'Annual target reached', sub: 'You have recorded ' + FV.target + ' outputs this session, meeting the Category \'A\' target.', action: { label: 'View summary', fn: () => switchPortalPane('hub') } }), 700);
        } else if (done === null) store.set(k, FV.target >= 10);
    }

    function hookSubmissions() {
        const f = document.querySelector('form[action$="/publications/add"]'); if (!f) return;
        f.addEventListener('submit', () => sessionStorage.setItem('fvJust', JSON.stringify({ cat: f.querySelector('[name=category]').value, title: f.querySelector('[name=title]').value })));
        const j = sessionStorage.getItem('fvJust');
        if (j) { sessionStorage.removeItem('fvJust'); const o = JSON.parse(j);
            fvNotif.push({ title: 'Record saved', sub: o.title });
            fvToast({ cat: o.cat, title: 'Record saved', sub: o.title + ' was added to your Vault.', ms: 6000 }); }
    }

    const fvCmd = {
        sel: 0, shown: [],
        cmds: [
            ['Operations Desk', 'fa-chart-pie', () => switchPortalPane('dashboard')], ['Publications Vault', 'fa-book-bookmark', () => switchPortalPane('publications')],
            ['API Performance', 'fa-calculator', () => switchPortalPane('apiScore')], ['Appraisal Summary', 'fa-clipboard-check', () => switchPortalPane('hub')],
            ['Department Updates', 'fa-newspaper', () => switchPortalPane('feed')], ['Faculty Profile', 'fa-user-gear', () => switchPortalPane('profile')],
            ['Add journal paper', 'fa-book-open', () => openAddModalWithCategory('JOURNAL')], ['Add patent', 'fa-award', () => openAddModalWithCategory('PATENT')],
            ['Add conference paper', 'fa-users', () => openAddModalWithCategory('CONFERENCE')], ['Add book / chapter', 'fa-book', () => openAddModalWithCategory('BOOK_CHAPTER')],
            ['Add FDP / workshop', 'fa-chalkboard-user', () => openAddModalWithCategory('FDP_STTP')],
            ['Export report (Excel / CSV)', 'fa-file-excel', () => new bootstrap.Modal(document.getElementById('reportExportModal')).show()], ['Switch theme', 'fa-circle-half-stroke', () => toggleTheme()]
        ].map(c => ({ t: c[0], i: c[1], f: c[2] })),
        open() { document.getElementById('fvCmd').classList.add('open'); const i = document.getElementById('fvCmdInput'); i.value = ''; i.focus(); this.filter(''); },
        close() { document.getElementById('fvCmd').classList.remove('open'); },
        filter(q) { q = q.toLowerCase(); this.shown = this.cmds.filter(c => c.t.toLowerCase().includes(q)); this.sel = 0; this.draw(); },
        draw() { document.getElementById('fvCmdList').innerHTML = this.shown.length ? this.shown.map((c, i) => '<div class="fv-cmd-row ' + (i === this.sel ? 'sel' : '') + '" onclick="fvCmd.run(' + i + ')"><i class="fa-solid ' + c.i + '"></i>' + esc(c.t) + '</div>').join('') : '<div class="fv-empty">Nothing found</div>'; },
        run(i) { const c = this.shown[i]; if (c) { this.close(); setTimeout(c.f, 80); } }
    };
    document.addEventListener('keydown', e => {
        if ((e.ctrlKey || e.metaKey) && e.key.toLowerCase() === 'k') { e.preventDefault(); fvCmd.open(); return; }
        if (!document.getElementById('fvCmd').classList.contains('open')) return;
        if (e.key === 'Escape') fvCmd.close();
        else if (e.key === 'ArrowDown') { fvCmd.sel = Math.min(fvCmd.shown.length - 1, fvCmd.sel + 1); fvCmd.draw(); e.preventDefault(); }
        else if (e.key === 'ArrowUp') { fvCmd.sel = Math.max(0, fvCmd.sel - 1); fvCmd.draw(); e.preventDefault(); }
        else if (e.key === 'Enter') fvCmd.run(fvCmd.sel);
    });

        /* ---------- Vault: filters, search, proof-pending flag, duplicate guard ---------- */
    const fvVault = {
        cat: 'ALL', q: '',
        apply() {
            const pane = document.getElementById('pane-publications'); if (!pane) return;
            const rows = pane.querySelectorAll('tr.pub-row'); let n = 0;
            rows.forEach(r => {
                const okCat = this.cat === 'ALL' || (this.cat === 'PENDING' ? r.dataset.proof === '0' : r.dataset.cat === this.cat);
                const ok = okCat && (r.dataset.s || '').includes(this.q); r.style.display = ok ? '' : 'none'; if (ok) n++;
            });
            const c = document.getElementById('fvVaultCount'); if (c) c.textContent = n + ' of ' + rows.length + ' records';
            const nm = document.getElementById('fvVaultNoMatch'); if (nm) nm.style.display = (rows.length && !n) ? '' : 'none';
        },
        setQuery(q) { this.q = String(q || '').toLowerCase(); const i = document.getElementById('fvVaultSearch'); if (i) i.value = q || ''; this.cat = 'ALL'; document.querySelectorAll('#fvVaultBar .fv-chip').forEach(x => x.classList.toggle('active', x.dataset.cat === 'ALL')); this.apply(); }
    };
    function initVaultTools() {
        const pane = document.getElementById('pane-publications'); if (!pane) return;
        const tbl = pane.querySelector('.table-responsive'); if (!tbl) return;
        pane.querySelectorAll('tr.pub-row').forEach(r => {
            const hasProof = !!r.querySelector('a[href*="/uploads/proofs/"]'); r.dataset.proof = hasProof ? '1' : '0';
            const bd = r.children[0] && r.children[0].querySelector('.badge');
            if (bd) { const c = CAT_COLOR[r.dataset.cat] || '#2563eb'; bd.className = 'badge'; bd.textContent = FV_LABEL[r.dataset.cat] || r.dataset.cat; bd.style.cssText = 'background:' + c + '1f;color:' + c + ';border:1px solid ' + c + '40;font-weight:600;font-size:.72rem;padding:.35em .7em;'; }
            if (!hasProof) { const td = r.children[4]; if (td) td.innerHTML = '<span class="fv-pending-tag">Proof pending</span>'; }
            r.dataset.s = (Array.from(r.children).slice(0, 4).map(td => td.textContent).join(' ') + ' ' + (CAT[r.dataset.cat] || '')).toLowerCase();
        });
        const tb = pane.querySelector('tbody');
        if (tb && pane.querySelector('tr.pub-row')) { const nm = document.createElement('tr'); nm.id = 'fvVaultNoMatch'; nm.style.display = 'none'; nm.innerHTML = '<td colspan="6" class="text-center text-muted py-4">No records match your filter.</td>'; tb.appendChild(nm); }
        const bar = document.createElement('div'); bar.id = 'fvVaultBar'; bar.className = 'd-flex flex-wrap gap-2 mb-3 align-items-center';
        bar.innerHTML = [['ALL', 'All'], ['JOURNAL', 'Journals'], ['CONFERENCE', 'Conferences'], ['PATENT', 'Patents'], ['BOOK_CHAPTER', 'Books'], ['FDP_STTP', 'FDP / Workshops'], ['PENDING', 'Proof pending']]
            .map((c, i) => '<button type="button" class="fv-chip ' + (i === 0 ? 'active' : '') + '" data-cat="' + c[0] + '">' + c[1] + '</button>').join('') +
            '<span class="small text-muted ms-auto" id="fvVaultCount"></span>' +
            '<input type="text" id="fvVaultSearch" class="form-control form-control-sm" style="max-width:240px" placeholder="Search title, author, venue, date">';
        tbl.parentNode.insertBefore(bar, tbl);
        bar.querySelectorAll('.fv-chip').forEach(b => b.onclick = () => { bar.querySelectorAll('.fv-chip').forEach(x => x.classList.remove('active')); b.classList.add('active'); fvVault.cat = b.dataset.cat; fvVault.apply(); });
        document.getElementById('fvVaultSearch').addEventListener('input', e => { fvVault.q = e.target.value.trim().toLowerCase(); fvVault.apply(); });
        fvVault.apply();

        const ti = document.getElementById('recordTitle'); if (!ti) return;
        const warn = document.createElement('div'); warn.className = 'fv-dup-warn'; ti.parentNode.appendChild(warn);
        const tok = s => new Set(s.toLowerCase().replace(/[^a-z0-9 ]/g, ' ').split(/\s+/).filter(w => w.length > 3));
        ti.addEventListener('input', () => {
            const a = tok(ti.value); let best = null, bs = 0;
            if (a.size >= 3) pane.querySelectorAll('tr.pub-row').forEach(r => { const b = tok(r.dataset.title || ''); let n = 0; a.forEach(w => { if (b.has(w)) n++; });
                const s = n / (a.size + b.size - n || 1); if (s > bs) { bs = s; best = r.dataset.title; } });
            if (bs >= 0.6) { warn.style.display = 'block'; warn.innerHTML = 'A similar record already exists: <b>' + esc(best) + '</b>. Please check before saving.'; } else warn.style.display = 'none';
        });
    }

function openDeleteFromBtn(b) { document.getElementById('deletePubId').value = b.dataset.id; document.getElementById('deleteRecordTitle').textContent = b.dataset.title || ''; fvOpenModal('deleteRecordModal'); }
    function openEditFromBtn(b) { const d = b.dataset; openEditRecordModal(d.id, d.cat, d.title, d.authors, d.venue, d.indexing, d.date); }

    document.addEventListener('DOMContentLoaded', () => {
        fvNotif.init(); initVaultTools(); renderSummary(); fvProfile.init(); hookSubmissions(); checkTarget(); fvSearch.init(); fvRank.render([]); fvFeed.render(); fvFeed.start(); fvCmd.filter('');
        document.getElementById('fvCmdInput').addEventListener('input', e => fvCmd.filter(e.target.value));
        const _sw = window.switchPortalPane;
        window.switchPortalPane = function (p) {
            _sw(p);
            if (p === 'feed') { fvFeed.unseen = 0; document.getElementById('fvFeedNavBadge').style.display = 'none'; }
            if (p === 'profile') fvProfile.radar();
        };
        const qs = new URLSearchParams(location.search), pp = qs.get('pane'), dn = qs.get('done');
        if (pp && document.getElementById('pane-' + pp)) switchPortalPane(pp);
        if (dn) {
            const m = { deleted: 'Record deleted', updated: 'Record updated' }[dn];
            if (m) { fvNotif.push({ title: m }); fvToast({ title: m, ms: 5000 }); }
            history.replaceState(null, '', location.pathname);
        }
    });
</script>
</body>
</html>
