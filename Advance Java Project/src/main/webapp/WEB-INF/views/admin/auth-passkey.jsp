<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dean & Admin Verification - NIET Faculty Vault</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <style>
        body {
            background: linear-gradient(135deg, #0f172a 0%, #1e293b 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            color: #f8fafc;
        }
        .passkey-card {
            width: 100%;
            max-width: 440px;
            background: #ffffff;
            border-radius: 20px;
            padding: 2.5rem;
            box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.3);
            color: #0f172a;
        }
        .shield-icon {
            width: 60px;
            height: 60px;
            background: #eff6ff;
            color: #2563eb;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.75rem;
            margin: 0 auto 1.25rem;
        }
    </style>
</head>
<body>

<div class="passkey-card text-center">
    <div class="shield-icon">
        <i class="fa-solid fa-user-shield"></i>
    </div>
    <h4 class="fw-bold mb-1">Dean / Admin Vault</h4>
    <p class="text-muted small mb-4">Elevated privilege check. Enter the Dean security passkey to access multi-faculty aggregation.</p>

    <c:if test="${not empty error}">
        <div class="alert alert-danger py-2 px-3 small fw-semibold text-start mb-3">
            <i class="fa-solid fa-triangle-exclamation me-1"></i> ${error}
        </div>
    </c:if>

    <form action="${pageContext.request.contextPath}/admin/verify-passkey" method="POST">
        <div class="mb-3 text-start">
            <label class="form-label small fw-bold text-uppercase text-muted">Master Security Passkey</label>
            <div class="input-group">
                <span class="input-group-text bg-light"><i class="fa-solid fa-key text-muted"></i></span>
                <input type="password" name="passkey" class="form-control" placeholder="••••••••••••" autofocus required>
            </div>
            <div class="form-text small text-muted">Default Key: <code>NIET@DEAN2026</code></div>
        </div>

        <button type="submit" class="btn btn-primary w-100 py-2 fw-bold mb-2">
            <i class="fa-solid fa-unlock me-1"></i> Unlock Admin Workspace
        </button>
        <a href="${pageContext.request.contextPath}/dashboard" class="btn btn-light w-100 py-2 small fw-semibold text-muted">
            Return to Dashboard
        </a>
    </form>
</div>

</body>
</html>