<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en" data-lighting="night">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dean &amp; Admin Portal &mdash; Faculty Vault</title>
    
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&family=Syncopate:wght@700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
    
    <style>
        :root {
            --bg-void: #030509;
            --surface-panel: #0b0f19;
            --accent-gold: #f59e0b;
            --accent-gold-glow: rgba(245, 158, 11, 0.3);
            --border-line: rgba(255, 255, 255, 0.12);
            --card-bg: rgba(8, 12, 20, 0.88);
            --card-text: #ffffff;
            --nav-bg: #080c14;
            --nav-text: #f9fafb;
            --input-bg: #030509;
            --input-border: rgba(255, 255, 255, 0.15);
            --input-text: #ffffff;
        }

        [data-lighting="day"] {
            --bg-void: #f8fafc;
            --surface-panel: #ffffff;
            --card-bg: rgba(255, 255, 255, 0.94);
            --card-text: #0f172a;
            --nav-bg: #ffffff;
            --nav-text: #0f172a;
            --input-bg: #f8fafc;
            --input-border: rgba(15, 23, 42, 0.15);
            --input-text: #0f172a;
            --border-line: #e2e8f0;
        }

        * { box-sizing: border-box; margin: 0; padding: 0; }

        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            background: linear-gradient(rgba(3, 5, 9, 0.6), rgba(3, 5, 9, 0.85)), url('${pageContext.request.contextPath}/images/niet-campus.png') no-repeat center center fixed;
            background-size: cover;
            color: var(--card-text);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            overflow-x: hidden;
            transition: background-color 0.4s ease, color 0.4s ease;
        }

        .editorial-nav {
            padding: 0.85rem 3rem;
            display: flex;
            align-items: center;
            justify-content: space-between;
            border-bottom: 4px solid var(--accent-gold);
            position: sticky;
            top: 0;
            z-index: 50;
            background: var(--nav-bg);
            color: var(--nav-text);
            box-shadow: 0 4px 20px rgba(0,0,0,0.15);
        }

        .brand-logo-area {
            display: flex;
            align-items: center;
            gap: 1.5rem;
            text-decoration: none;
        }

        .brand-logo-img {
            height: 44px;
            object-fit: contain;
        }

        .portal-badge-text {
            font-weight: 800;
            font-size: 1.05rem;
            letter-spacing: 1px;
            color: var(--accent-gold);
            text-transform: uppercase;
        }

        .nav-actions {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .btn-lighting-pill {
            background: rgba(128, 128, 128, 0.15);
            border: 1px solid var(--input-border);
            color: inherit;
            font-size: 0.78rem;
            font-weight: 700;
            padding: 0.45rem 1rem;
            border-radius: 40px;
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 8px;
            transition: all 0.2s;
        }

        .btn-lighting-pill:hover {
            background: var(--accent-gold);
            color: #ffffff;
            border-color: var(--accent-gold);
        }

        .btn-faculty-return {
            background: rgba(128, 128, 128, 0.15);
            color: inherit;
            font-size: 0.78rem;
            letter-spacing: 0.5px;
            text-transform: uppercase;
            font-weight: 800;
            padding: 0.5rem 1.3rem;
            border-radius: 40px;
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 6px;
            transition: all 0.25s ease;
        }

        .btn-faculty-return:hover {
            background: var(--accent-gold);
            color: #ffffff;
        }

        /* Center Admin Auth Box Container */
        .admin-hero-container {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 3rem 1.5rem;
        }

        .admin-auth-box {
            width: 100%;
            max-width: 440px;
            background: var(--card-bg);
            backdrop-filter: blur(16px);
            border: 1px solid var(--border-line);
            border-radius: 24px;
            padding: 2.5rem;
            box-shadow: 0 30px 80px rgba(0,0,0,0.6);
            position: relative;
            z-index: 10;
        }

        .form-control {
            background-color: var(--input-bg);
            border: 1.5px solid var(--input-border);
            color: var(--input-text);
            padding: 0.8rem 1rem;
            border-radius: 12px;
        }

        .form-control:focus {
            background-color: var(--input-bg);
            border-color: var(--accent-gold);
            color: var(--input-text);
            box-shadow: 0 0 0 3px rgba(245, 158, 11, 0.25);
        }

        .btn-admin {
            width: 100%;
            background-color: #d97706;
            color: #ffffff;
            font-weight: 800;
            border: none;
            padding: 0.85rem;
            border-radius: 12px;
            text-transform: uppercase;
            box-shadow: 0 4px 14px rgba(217, 119, 6, 0.3);
            transition: background 0.2s;
        }

        .btn-admin:hover {
            background-color: #b45309;
            color: #ffffff;
        }
    </style>
</head>
<body>

    <nav class="editorial-nav">
        <a href="${pageContext.request.contextPath}/" class="brand-logo-area">
            <img src="${pageContext.request.contextPath}/images/niet-logo.png" alt="NIET Logo" class="brand-logo-img">
            <span class="portal-badge-text d-none d-md-inline">Dean & Admin Portal</span>
        </a>

        <div class="nav-actions">
            <button class="btn-lighting-pill" onclick="toggleLighting()" id="lightingBtn">
                <i class="fa-solid fa-moon text-warning" id="lightingIcon"></i>
                <span id="lightingLabel">Night</span>
            </button>
            <a href="${pageContext.request.contextPath}/auth" class="btn-faculty-return">
                <i class="fa-solid fa-arrow-left me-1"></i> Faculty Login
            </a>
        </div>
    </nav>

    <div class="admin-hero-container">
        <div class="admin-auth-box">
            <div class="text-center mb-4">
                <div class="text-warning fs-3 mb-2"><i class="fa-solid fa-user-shield"></i></div>
                <h4 class="fw-bold font-monospace mb-1" style="color: var(--card-text);">DEAN / ADMIN PORTAL</h4>
                <p class="small text-muted mb-0">Authorized Institutional Access</p>
            </div>

            <c:if test="${not empty error}">
                <div class="alert alert-danger py-2 small fw-semibold mb-3">
                    <i class="fa-solid fa-triangle-exclamation me-1"></i> ${error}
                </div>
            </c:if>

            <form action="${pageContext.request.contextPath}/admin/login" method="POST">
                <div class="mb-3">
                    <label class="form-label small fw-bold text-muted">Admin ID</label>
                    <input type="text" name="adminId" class="form-control" placeholder="Enter Admin ID" required autofocus>
                </div>
                <div class="mb-4">
                    <label class="form-label small fw-bold text-muted">Security Passkey</label>
                    <input type="password" name="passkey" class="form-control" placeholder="••••••••••••" required>
                </div>
                <button type="submit" class="btn-admin">AUTHENTICATE &rarr;</button>
            </form>

            <div class="text-center mt-3">
                <a href="${pageContext.request.contextPath}/auth" class="small text-muted text-decoration-none fw-semibold">&larr; Return to Faculty Login</a>
            </div>
        </div>
    </div>

    <div class="py-3 text-center text-secondary small" style="background: rgba(3,5,9,0.9); border-top: 1px solid var(--border-line);">
        &copy; 2026 NIET Greater Noida &bull; Administrative Security Gateway
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', () => {
            const saved = localStorage.getItem('nietAdminLighting') || 'night';
            document.documentElement.setAttribute('data-lighting', saved);
            updateLightingUI(saved);
        });

        function toggleLighting() {
            const current = document.documentElement.getAttribute('data-lighting') || 'night';
            const next = current === 'night' ? 'day' : 'night';
            document.documentElement.setAttribute('data-lighting', next);
            localStorage.setItem('nietAdminLighting', next);
            updateLightingUI(next);
        }

        function updateLightingUI(mode) {
            const icon = document.getElementById('lightingIcon');
            const label = document.getElementById('lightingLabel');
            if (mode === 'day') {
                icon.className = 'fa-solid fa-sun text-warning'; 
                label.innerText = 'Day';
            } else {
                icon.className = 'fa-solid fa-moon text-warning'; 
                label.innerText = 'Night';
            }
        }
    </script>
</body>
</html>