<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en" data-lighting="day">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>NIET &mdash; Faculty Vault & Research Repository</title>
    <script>
        (function () {
            var r = document.documentElement;
            r.classList.add('js');
            try {
                var th = localStorage.getItem('nietLightingEngine');
                if (th) r.setAttribute('data-lighting', th);
                r.classList.add(sessionStorage.getItem('nietPortalUnlocked') === 'true' ? 'no-splash' : 'splash-on');
            } catch (e) { r.classList.add('no-splash'); }
        })();
    </script>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&family=Syncopate:wght@700;800&display=swap" rel="stylesheet">
    
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">

    <style>
        :root {
            --bg-void: #f8fafc;
            --surface-panel: #ffffff;
            --accent-red: #d9381e;
            --border-line: #e2e8f0;
            --text-silver: #64748b;
            --card-text: #0f172a;
            --nav-bg: #ffffff;
            --nav-text: #0f172a;
            --input-bg: #f8fafc;
            --input-border: #cbd5e1;
            --input-text: #0f172a;
        }

        [data-lighting="night"] {
            --bg-void: #030509;
            --surface-panel: #0b0f19;
            --accent-red: #f43f5e;
            --border-line: rgba(255, 255, 255, 0.12);
            --text-silver: #9ca3af;
            --card-text: #f9fafb;
            --nav-bg: #080c14;
            --nav-text: #f9fafb;
            --input-bg: #030509;
            --input-border: rgba(255, 255, 255, 0.2);
            --input-text: #f9fafb;
        }

        * { box-sizing: border-box; margin: 0; padding: 0; }

        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            background-color: var(--bg-void);
            color: var(--card-text);
            min-height: 100vh;
            overflow-x: hidden;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            transition: background-color 0.4s ease, color 0.4s ease;
        }

        /* ================= NIET Cinematic Entrance ================= */
        :root { --ns-logo: url('${pageContext.request.contextPath}/images/niet-logo-hd.png'); }
        html.splash-on, html.splash-on body { overflow: hidden; }
        html.no-splash .ns-splash { display: none !important; }

        .ns-splash {
            position: fixed; inset: 0; z-index: 9999; display: grid; place-items: center; overflow: hidden; cursor: pointer;
            background: radial-gradient(ellipse at 50% 45%, #ffffff 35%, #e8eaf0 100%);
            transition: opacity .8s ease, transform .8s ease, filter .8s ease;
        }
        .ns-splash.leaving { opacity: 0; transform: scale(1.06); filter: blur(6px); pointer-events: none; }
        .ns-beam { position: absolute; inset: -20%; pointer-events: none; opacity: 0; transform: translateX(-8%);
            background: linear-gradient(115deg, transparent 30%, rgba(255,226,170,.38) 42%, rgba(255,255,255,0) 58%);
            animation: nsBeam 3.4s .1s ease-out forwards; }
        .ns-dust { position: absolute; inset: 0; width: 100%; height: 100%; pointer-events: none; }
        .ns-scene { position: relative; perspective: 900px; }
        .ns-tilt { transform-style: preserve-3d; transition: transform .25s ease-out; }
        .ns-stack { position: relative; width: clamp(220px, 62vw, 400px); transform-origin: 17% 50%;
            transform: translate(-5vw, -3vh) scale(9);
            filter: blur(10px) drop-shadow(0 14px 14px rgba(29,47,111,0));
            animation: nsCam 2s .2s cubic-bezier(.62,0,.18,1) forwards; }
        .ns-logo { width: 100%; aspect-ratio: 1030/397; background: var(--ns-logo) center/100% 100% no-repeat; }
        .ns-logo.ns-gloss { position: absolute; left: 0; top: 0;
            background: linear-gradient(105deg, transparent 38%, rgba(255,255,255,.95) 50%, transparent 62%) -160% 0/200% 100% no-repeat;
            -webkit-mask: var(--ns-logo) center/100% 100% no-repeat; mask: var(--ns-logo) center/100% 100% no-repeat;
            animation: nsGloss 1.1s 2s ease-in-out forwards; }
        .ns-logo.ns-refl { margin-top: 3px; transform: scaleY(-1); opacity: .12; filter: blur(1.2px);
            -webkit-mask-image: linear-gradient(to top, rgba(0,0,0,.9), transparent 55%);
            mask-image: linear-gradient(to top, rgba(0,0,0,.9), transparent 55%); }
        .ns-shadow { position: absolute; left: 8%; right: 8%; top: calc(100% - 4px); height: 14px; border-radius: 50%; opacity: 0;
            background: radial-gradient(ellipse, rgba(29,47,111,.22), transparent 70%); animation: nsFade 1s 1.9s forwards; }
        .ns-tag { position: absolute; left: 0; right: 0; top: calc(50% + clamp(120px, 29vw, 175px)); text-align: center; padding: 0 1rem; }
        .ns-title { font-size: clamp(13px, 3.4vw, 20px); letter-spacing: .7em; color: #1d2f6f; font-weight: 700; text-transform: uppercase;
            opacity: 0; filter: blur(6px); animation: nsTrack 1.4s 2s cubic-bezier(.2,.8,.2,1) forwards; }
        .ns-line { display: block; width: 0; height: 2px; margin: 12px auto 0; border-radius: 2px;
            background: linear-gradient(90deg, #d62828, #e0a800); animation: nsLine .9s 2.9s ease-out forwards; }
        .ns-slogan { margin-top: 12px; min-height: 1.4em; font-size: clamp(11px, 2.8vw, 14px); letter-spacing: .14em; color: #6b7280; font-style: italic; font-weight: 400; }
        .ns-slogan em { font-style: normal; color: #d62828; font-weight: 700; }
        .ns-slogan .ns-u { display: inline-block; opacity: 0; transform: translateY(6px); animation: nsCh .5s forwards; }
        .ns-skip { position: absolute; left: 0; right: 0; bottom: calc(22px + env(safe-area-inset-bottom, 0px)); text-align: center;
            font-size: .68rem; letter-spacing: .35em; text-transform: uppercase; color: #9aa1b2; opacity: 0; animation: nsFade 1s 1.6s forwards; }
        @keyframes nsCam { 0% { transform: translate(-5vw,-3vh) scale(9); filter: blur(10px) drop-shadow(0 14px 14px rgba(29,47,111,0)); }
            55% { filter: blur(2px) drop-shadow(0 14px 14px rgba(29,47,111,0)); } 85% { transform: scale(1.03); }
            100% { transform: none; filter: blur(0) drop-shadow(0 12px 12px rgba(29,47,111,.16)); } }
        @keyframes nsGloss { to { background-position: 260% 0; } }
        @keyframes nsBeam { 0% { opacity: 0; } 40% { opacity: 1; } 100% { opacity: .75; transform: translateX(4%); } }
        @keyframes nsTrack { to { opacity: 1; filter: blur(0); letter-spacing: .24em; } }
        @keyframes nsLine { to { width: clamp(70px, 18vw, 120px); } }
        @keyframes nsFade { to { opacity: 1; } }
        @keyframes nsCh { to { opacity: 1; transform: none; } }
        @media (prefers-reduced-motion: reduce) { .ns-splash *, .ns-splash { animation-duration: .01s !important; animation-delay: 0s !important; } }

        /* Top Header Navigation Bar */
        .editorial-nav {
            padding: 0.85rem 3rem;
            display: flex;
            align-items: center;
            justify-content: space-between;
            border-bottom: 4px solid var(--accent-red);
            position: sticky;
            top: 0;
            z-index: 50;
            background: var(--nav-bg);
            color: var(--nav-text);
            box-shadow: 0 4px 20px rgba(0,0,0,0.08);
        }

        @keyframes slideDown {
            from { transform: translateY(-100%); opacity: 0; }
            to { transform: translateY(0); opacity: 1; }
        }

        .brand-logo-area {
            display: flex;
            align-items: center;
            gap: 1.5rem;
            text-decoration: none;
        }

        .brand-logo-img {
            height: 48px;
            object-fit: contain;
            transition: transform 0.3s ease;
        }

        .brand-logo-img:hover {
            transform: scale(1.05);
        }

        .nav-actions {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .btn-lighting-pill {
            background: rgba(128, 128, 128, 0.1);
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
            background: var(--accent-red);
            color: #ffffff;
            border-color: var(--accent-red);
        }

        .btn-admin-portal {
            background: var(--accent-red);
            color: #ffffff;
            font-size: 0.78rem;
            letter-spacing: 0.5px;
            text-transform: uppercase;
            font-weight: 800;
            padding: 0.5rem 1.4rem;
            border-radius: 40px;
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 6px;
            box-shadow: 0 4px 15px rgba(217, 56, 30, 0.35);
            transition: all 0.25s ease;
        }

        .btn-admin-portal:hover {
            background: #b52b14;
            color: #ffffff;
            transform: translateY(-2px);
        }

        /* Cinematic Hero Section with Zoom Animation */
        .hero-viewport {
            position: relative;
            min-height: 75vh;
            display: flex;
            align-items: center;
            padding: 5rem 3rem;
            background: linear-gradient(135deg, rgba(15, 23, 42, 0.82), rgba(3, 5, 9, 0.92)), 
                        url('${pageContext.request.contextPath}/images/niet-campus.png') no-repeat center center/cover;
            animation: heroZoom 22s infinite alternate ease-in-out;
            color: #ffffff;
            border-bottom: 5px solid var(--accent-red);
            overflow: hidden;
        }

        [data-lighting="night"] .hero-viewport {
            background: linear-gradient(135deg, rgba(11, 15, 25, 0.88), rgba(3, 5, 9, 0.96)), 
                        url('${pageContext.request.contextPath}/images/niet-campus.png') no-repeat center center/cover;
        }

        @keyframes heroZoom {
            0% { background-position: center center; transform: scale(1); }
            100% { background-position: center top; transform: scale(1.04); }
        }

        html.portal-ready .editorial-nav { animation: slideDown 0.7s cubic-bezier(0.16, 1, 0.3, 1); }

        /* Hero content stays hidden until the entrance finishes, then staggers in */
        .hero-content-anim > * { opacity: 0; transform: translateY(30px); }
        html.portal-ready .hero-content-anim > * { animation: fadeInUp 0.9s cubic-bezier(0.16, 1, 0.3, 1) forwards; }
        html.portal-ready .hero-content-anim > *:nth-child(1) { animation-delay: .05s; }
        html.portal-ready .hero-content-anim > *:nth-child(2) { animation-delay: .2s; }
        html.portal-ready .hero-content-anim > *:nth-child(3) { animation-delay: .38s; }
        html.portal-ready .hero-content-anim > *:nth-child(4) { animation-delay: .52s; }
        html.portal-ready .hero-content-anim > *:nth-child(5) { animation-delay: .68s; }
        html.no-splash .hero-content-anim > * { opacity: 1; transform: none; animation: none; }

        @keyframes fadeInUp {
            to { opacity: 1; transform: translateY(0); }
        }

        .niet-tagline-badge {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            background: rgba(217, 56, 30, 0.35);
            color: #ff765e;
            padding: 0.45rem 1.1rem;
            border-radius: 30px;
            font-size: 0.78rem;
            font-weight: 800;
            letter-spacing: 1px;
            text-transform: uppercase;
            margin-bottom: 1.2rem;
            border: 1px solid rgba(217, 56, 30, 0.5);
            box-shadow: 0 4px 15px rgba(217, 56, 30, 0.3);
        }

        .hero-heading {
            font-size: clamp(2.3rem, 5vw, 4rem);
            font-weight: 800;
            letter-spacing: -0.02em;
            line-height: 1.15;
            margin-bottom: 1.2rem;
            text-shadow: 0 4px 25px rgba(0,0,0,0.7);
        }

        .hero-desc {
            font-size: 1.08rem;
            color: #cbd5e1;
            line-height: 1.7;
            margin-bottom: 2.2rem;
            max-width: 650px;
        }

        .btn-access-portal {
            background: var(--accent-red);
            color: #ffffff;
            font-size: 0.9rem;
            font-weight: 800;
            letter-spacing: 1.2px;
            text-transform: uppercase;
            padding: 1rem 2.6rem;
            border-radius: 40px;
            border: none;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            gap: 12px;
            box-shadow: 0 10px 35px rgba(217, 56, 30, 0.5);
            transition: all 0.3s cubic-bezier(0.16, 1, 0.3, 1);
        }

        .btn-access-portal:hover {
            background: #b52b14;
            color: #ffffff;
            transform: translateY(-3px) scale(1.02);
            box-shadow: 0 15px 40px rgba(217, 56, 30, 0.7);
        }

        /* Interactive Showcase Cards Section */
        .portal-content-section {
            padding: 5rem 3rem;
            background: var(--bg-void);
        }

        .section-title-box {
            text-align: center;
            max-width: 750px;
            margin: 0 auto 3.5rem auto;
        }

        .content-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(320px, 1fr));
            gap: 2rem;
        }

        .content-card {
            background: var(--surface-panel);
            border: 1px solid var(--border-line);
            border-radius: 20px;
            padding: 2.2rem;
            box-shadow: 0 10px 30px rgba(0,0,0,0.06);
            transition: all 0.4s cubic-bezier(0.16, 1, 0.3, 1);
            position: relative;
            overflow: hidden;
        }

        .content-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 4px;
            background: var(--accent-red);
            transform: scaleX(0);
            transform-origin: left;
            transition: transform 0.4s ease;
        }

        .content-card:hover {
            transform: translateY(-8px);
            border-color: var(--accent-red);
            box-shadow: 0 20px 40px rgba(217, 56, 30, 0.15);
        }

        .content-card:hover::before {
            transform: scaleX(1);
        }

        .card-icon-box {
            width: 52px;
            height: 52px;
            background: rgba(217, 56, 30, 0.15);
            color: var(--accent-red);
            border-radius: 14px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.4rem;
            margin-bottom: 1.3rem;
            transition: transform 0.3s ease;
        }

        .content-card:hover .card-icon-box {
            transform: scale(1.1) rotate(5deg);
        }

        /* Experience Innovation Banner */
        .experience-banner {
            padding: 5rem 3rem;
            background: var(--surface-panel);
            border-top: 1px solid var(--border-line);
            border-bottom: 1px solid var(--border-line);
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 3rem;
            flex-wrap: wrap;
        }

        .experience-left {
            flex: 1 1 450px;
        }

        .experience-right {
            flex: 1 1 500px;
            background: linear-gradient(135deg, rgba(217, 56, 30, 0.1), rgba(15, 23, 42, 0.05));
            border: 1.5px solid var(--border-line);
            border-radius: 20px;
            padding: 2.5rem;
        }

        /* Bottom Institutional Metrics Bar */
        .editorial-bottom-bar {
            border-top: 1px solid var(--border-line);
            background: var(--surface-panel);
            display: flex;
            flex-wrap: wrap;
        }

        .bottom-pane-left {
            flex: 1 1 350px;
            border-right: 1px solid var(--border-line);
            padding: 2.5rem 3rem;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .bottom-pane-right {
            flex: 2 1 500px;
            padding: 2.5rem 3rem;
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 2rem;
            flex-wrap: wrap;
        }

        .metric-title {
            font-size: 0.72rem;
            text-transform: uppercase;
            letter-spacing: 1px;
            color: var(--text-silver);
            margin-bottom: 0.3rem;
            font-weight: 700;
        }

        .metric-value {
            font-size: 2.2rem;
            font-weight: 800;
            color: var(--accent-red);
            line-height: 1;
            transition: transform 0.3s;
        }

        .metric-value:hover {
            transform: scale(1.05);
        }

        /* Official Faculty Footer Links */
        .official-footer {
            background: #030509;
            color: #94a3b8;
            padding: 4rem 3rem 2rem 3rem;
            border-top: 4px solid var(--accent-red);
        }

        .footer-links-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
            gap: 2.5rem;
            margin-bottom: 3rem;
        }

        .footer-col h6 {
            color: #ffffff;
            font-weight: 800;
            letter-spacing: 1px;
            text-transform: uppercase;
            margin-bottom: 1.2rem;
            font-size: 0.85rem;
        }

        .footer-col ul {
            list-style: none;
            padding: 0;
        }

        .footer-col ul li {
            margin-bottom: 0.6rem;
        }

        .footer-col ul li a {
            color: #94a3b8;
            text-decoration: none;
            font-size: 0.85rem;
            transition: color 0.2s;
        }

        .footer-col ul li a:hover {
            color: #ffffff;
            text-decoration: underline;
        }

        /* Auth Drawer Modal */
        .auth-drawer-backdrop {
            position: fixed;
            inset: 0;
            background: rgba(3, 5, 9, 0.85);
            backdrop-filter: blur(18px);
            z-index: 2000;
            display: ${not empty error or not empty success ? 'flex' : 'none'};
            align-items: center;
            justify-content: center;
            padding: 1.2rem;
            animation: fadeInBackdrop 0.3s ease;
        }

        @keyframes fadeInBackdrop {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        .auth-drawer-panel {
            width: 100%;
            max-width: 520px;
            background: var(--surface-panel);
            border: 1px solid var(--border-line);
            border-radius: 26px;
            padding: 2.6rem;
            position: relative;
            box-shadow: 0 40px 100px rgba(0, 0, 0, 0.7);
            color: var(--card-text);
            max-height: 90vh;
            overflow-y: auto;
            animation: scaleUpDrawer 0.4s cubic-bezier(0.16, 1, 0.3, 1);
        }

        @keyframes scaleUpDrawer {
            from { transform: scale(0.9) translateY(20px); opacity: 0; }
            to { transform: scale(1) translateY(0); opacity: 1; }
        }

        .drawer-close-btn {
            position: absolute;
            top: 1.25rem;
            right: 1.25rem;
            background: rgba(128, 128, 128, 0.15);
            border: none;
            color: var(--text-silver);
            width: 36px;
            height: 36px;
            border-radius: 50%;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: background 0.2s, color 0.2s;
        }

        .drawer-close-btn:hover { background: var(--accent-red); color: #ffffff; }

        .drawer-title {
            font-size: 1.25rem;
            font-weight: 800;
            margin-bottom: 0.2rem;
            letter-spacing: 0.5px;
        }

        .drawer-sub {
            font-size: 0.78rem;
            color: var(--text-silver);
            margin-bottom: 1.2rem;
        }

        .auth-mode-switch {
            display: flex;
            border-bottom: 2px solid var(--border-line);
            margin-bottom: 1.2rem;
            gap: 2rem;
        }

        .switch-tab-btn {
            background: none;
            border: none;
            color: var(--text-silver);
            font-size: 0.82rem;
            letter-spacing: 1px;
            text-transform: uppercase;
            font-weight: 700;
            padding-bottom: 0.6rem;
            cursor: pointer;
            position: relative;
            transition: color 0.3s;
        }

        .switch-tab-btn.active { color: var(--card-text); }
        .switch-tab-btn.active::after {
            content: '';
            position: absolute;
            bottom: -2px;
            left: 0;
            width: 100%;
            height: 2px;
            background: var(--accent-red);
        }

        .field-label {
            font-size: 0.67rem;
            letter-spacing: 1px;
            text-transform: uppercase;
            font-weight: 700;
            color: var(--text-silver);
            margin-bottom: 0.3rem;
            display: block;
        }

        .dark-input {
            width: 100%;
            background: var(--input-bg);
            border: 1.5px solid var(--input-border);
            color: var(--input-text);
            padding: 0.75rem 1rem;
            font-size: 0.88rem;
            border-radius: 12px;
            margin-bottom: 0.9rem;
            outline: none;
            transition: border-color 0.2s, box-shadow 0.2s;
        }

        .dark-input:focus {
            border-color: var(--accent-red);
            box-shadow: 0 0 0 3px rgba(217, 56, 30, 0.18);
        }

        .btn-drawer-submit {
            width: 100%;
            background: var(--accent-red);
            color: #ffffff;
            border: none;
            padding: 0.9rem;
            font-size: 0.85rem;
            letter-spacing: 1px;
            text-transform: uppercase;
            font-weight: 800;
            border-radius: 12px;
            cursor: pointer;
            transition: background 0.2s, transform 0.2s;
        }

        .btn-drawer-submit:hover {
            background: #b52b14;
            transform: translateY(-1px);
        }

        /* ================= After-entrance extras ================= */
        .scroll-progress { position: fixed; top: 0; left: 0; right: 0; height: 3px; z-index: 60; transform-origin: left; transform: scaleX(0);
            background: linear-gradient(90deg, var(--accent-red), #ffb347); pointer-events: none; }
        .hero-dust { position: absolute; inset: 0; width: 100%; height: 100%; pointer-events: none; z-index: 1; }
        .hero-viewport .container { position: relative; z-index: 2; }
        .hero-slogan { font-size: clamp(1rem, 2vw, 1.35rem); font-weight: 400; font-style: italic; letter-spacing: .04em; color: #e2e8f0; margin-bottom: 1.1rem; }
        .hero-slogan em { font-style: normal; font-weight: 800; color: transparent; -webkit-background-clip: text; background-clip: text;
            background-image: linear-gradient(90deg, #ff765e, #ffd27a, #ff765e); background-size: 200% 100%; animation: sloganShimmer 3.5s linear infinite; }
        @keyframes sloganShimmer { to { background-position: -200% 0; } }

        .js .reveal { opacity: 0; transform: translateY(28px); transition: opacity .8s ease, transform .8s cubic-bezier(0.16, 1, 0.3, 1); }
        .js .reveal.in { opacity: 1; transform: none; }

        .content-card::after { content: ''; position: absolute; inset: 0; pointer-events: none; opacity: 0; transition: opacity .3s;
            background: radial-gradient(260px circle at var(--mx, 50%) var(--my, 50%), rgba(217, 56, 30, 0.14), transparent 60%); }
        .content-card:hover::after { opacity: 1; }

        .drawer-logo-wrap { display: inline-block; background: #ffffff; border: 1px solid var(--border-line); border-radius: 12px; padding: 8px 14px; margin-bottom: 1rem; }
        .drawer-logo { width: 120px; aspect-ratio: 1030/397; background: var(--ns-logo) center/100% 100% no-repeat; }

        @media (prefers-reduced-motion: reduce) {
            .hero-slogan em { animation: none; color: #ff9a85; background: none; }
            .js .reveal { opacity: 1; transform: none; transition: none; }
        }
    </style>
</head>
<body>

    <!-- NIET cinematic entrance (plays once per browser session; click anywhere to skip) -->
    <div class="ns-splash" id="nietSplash" onclick="skipSplash()">
        <div class="ns-beam"></div>
        <canvas class="ns-dust" id="nsDust"></canvas>
        <div class="ns-scene">
            <div class="ns-tilt" id="nsTilt">
                <div class="ns-stack">
                    <div class="ns-logo" role="img" aria-label="NIET Greater Noida"></div>
                    <div class="ns-logo ns-gloss"></div>
                    <div class="ns-logo ns-refl"></div>
                    <div class="ns-shadow"></div>
                </div>
            </div>
        </div>
        <div class="ns-tag">
            <div class="ns-title">Faculty Vault &amp; Repository</div>
            <i class="ns-line"></i>
            <div class="ns-slogan" id="nsSlogan"></div>
        </div>
        <div class="ns-skip">Click anywhere to skip</div>
    </div>
    <div class="scroll-progress" id="scrollProgress"></div>

    <!-- Top Header Navigation Bar -->
    <nav class="editorial-nav">
        <a href="${pageContext.request.contextPath}/" class="brand-logo-area">
            <img src="${pageContext.request.contextPath}/images/niet-logo.png" alt="NIET Logo" class="brand-logo-img">
            <span class="future-ready-text d-none d-md-inline">Faculty Vault & Repository</span>
        </a>

        <div class="nav-actions">
            <button class="btn-lighting-pill" onclick="toggleLighting()" id="lightingBtn">
                <i class="fa-solid fa-moon text-warning" id="lightingIcon"></i>
                <span id="lightingLabel">Night</span>
            </button>
            <a href="${pageContext.request.contextPath}/admin/auth" class="btn-admin-portal">
                <i class="fa-solid fa-user-shield me-1"></i> Admin Portal
            </a>
        </div>
    </nav>

    <!-- Cinematic Hero Section -->
    <section class="hero-viewport">
        <canvas class="hero-dust" id="heroDust"></canvas>
        <div class="container">
            <div class="row align-items-center">
                <div class="col-lg-8 hero-content-anim">
                    <div class="niet-tagline-badge">
                        <i class="fa-solid fa-award"></i> 1st Autonomous Institute in UP
                    </div>
                    <h1 class="hero-heading">Faculty Vault & Research Repository</h1>
                    <div class="hero-slogan">Knowledge, locked in. <em>Legacy, unlocked.</em></div>
                    <p class="hero-desc">
                        Centralized academic repository and publication intelligence platform for faculty members, research scholars, and evaluation boards at NIET Greater Noida.
                    </p>
                    <button onclick="openModal('authDrawer')" class="btn-access-portal">
                        <span>Enter Portal</span>
                        <i class="fa-solid fa-arrow-right-long"></i>
                    </button>
                </div>
            </div>
        </div>
    </section>

    <!-- Faculty Research Ecosystem Section -->
    <section class="portal-content-section">
        <div class="container">
            <div class="section-title-box">
                <span class="badge bg-danger bg-opacity-15 text-danger px-3 py-1 rounded-pill fw-bold mb-2">Excellence & Accreditations</span>
                <h2 class="fw-bold h3 mb-2">World-Class Research & Academic Ecosystem</h2>
                <p class="text-silver small">Recognized globally for innovation, patents, industry conclaves, and high-impact faculty publications.</p>
            </div>
            <div class="content-grid">
                <div class="content-card">
                    <div class="card-icon-box"><i class="fa-solid fa-trophy"></i></div>
                    <h5 class="fw-bold mb-2">NIRF & NAAC A+ Graded</h5>
                    <p class="text-silver small mb-0">Consistently ranked among top engineering and management institutions with premier autonomous status.</p>
                </div>
                <div class="content-card">
                    <div class="card-icon-box"><i class="fa-solid fa-handshake"></i></div>
                    <h5 class="fw-bold mb-2">Industry Conclaves</h5>
                    <p class="text-silver small mb-0">Bridging academic research with corporate technical leadership and global R&D partnerships.</p>
                </div>
                <div class="content-card">
                    <div class="card-icon-box"><i class="fa-solid fa-book-bookmark"></i></div>
                    <h5 class="fw-bold mb-2">IP & Patent Portfolios</h5>
                    <p class="text-silver small mb-0">Empowering faculty members with robust intellectual property recognition and commercialization support.</p>
                </div>
            </div>
        </div>
    </section>

    <!-- Experience Innovation Banner -->
    <section class="experience-banner">
        <div class="container d-flex flex-wrap align-items-center justify-content-between gap-4 w-100">
            <div class="experience-left">
                <span class="badge bg-danger bg-opacity-15 text-danger px-3 py-1 rounded-pill fw-bold mb-2">Campus Life & Labs</span>
                <h2 class="fw-bold h3 mb-3">Experience Life & Innovation at NIET</h2>
                <p class="text-silver small mb-4">State-of-the-art research labs, incubation centers, and vibrant student societies driving technological excellence in Greater Noida.</p>
                <button onclick="openModal('authDrawer')" class="btn btn-outline-danger fw-bold rounded-pill px-4 py-2">
                    Access Faculty Portal &rarr;
                </button>
            </div>
            <div class="experience-right">
                <div class="d-flex align-items-center gap-3 mb-3">
                    <div class="fs-1 fw-bold text-danger" data-count="23">23</div>
                    <div>
                        <h6 class="fw-bold mb-0">Acres of Lush Green Campus</h6>
                        <small class="text-silver">Equipped with modern seminar halls and digital libraries.</small>
                    </div>
                </div>
                <hr class="border-secondary opacity-25">
                <div class="d-flex align-items-center gap-3 mt-3">
                    <div class="fs-1 fw-bold text-danger" data-count="3100" data-suffix="+">3100+</div>
                    <div>
                        <h6 class="fw-bold mb-0">Annual Placements</h6>
                        <small class="text-silver">Top-tier global corporate recruiters & R&D partners.</small>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Bottom Institutional Metrics Bar -->
    <section class="editorial-bottom-bar">
        <div class="blueprint-sketch-pane bottom-pane-left">
            <div style="font-size: 0.68rem; text-transform: uppercase; letter-spacing: 2px; color: var(--accent-red); font-weight: 800; margin-bottom: 0.4rem;">
                <i class="fa-solid fa-compass-drafting me-1"></i> Institutional Standard
            </div>
            <div class="h5 fw-bold mb-1">Autonomous Category 'A'</div>
            <div class="small text-silver">NIRF Ranked &bull; NAAC A+ Grade &bull; NBA Accredited</div>
        </div>

        <div class="bottom-pane-right">
            <div>
                <div class="metric-title"><i class="fa-solid fa-book-bookmark me-1"></i> Indexed Publications</div>
                <div class="metric-value" data-count="250" data-suffix="+">250+</div>
            </div>
            <div>
                <div class="metric-title"><i class="fa-solid fa-award me-1"></i> Patents Filed</div>
                <div class="metric-value" data-count="45" data-suffix="+">45+</div>
            </div>
            <div>
                <div class="metric-title"><i class="fa-solid fa-graduation-cap me-1"></i> Research Scholars</div>
                <div class="metric-value" data-count="15" data-suffix="+">15+</div>
            </div>

            <button onclick="openModal('authDrawer')" class="btn-access-portal">
                <span>Enter Vault</span>
                <i class="fa-solid fa-arrow-right-long"></i>
            </button>
        </div>
    </section>

    <!-- Official Faculty Footer Links -->
    <footer class="official-footer">
        <div class="container">
            <div class="footer-links-grid">
                <div class="footer-col">
                    <h6>Research & Innovation</h6>
                    <ul>
                        <li><a href="#">About R&D Cell</a></li>
                        <li><a href="#">Innovation Labs</a></li>
                        <li><a href="#">Patent Cell</a></li>
                        <li><a href="#">Faculty Publications</a></li>
                    </ul>
                </div>
                <div class="footer-col">
                    <h6>Repository & Standards</h6>
                    <ul>
                        <li><a href="#">NIRF & NAAC Metrics</a></li>
                        <li><a href="#">NBA Accreditation</a></li>
                        <li><a href="#">Autonomous Guidelines</a></li>
                        <li><a href="#">Intellectual Property Cell</a></li>
                    </ul>
                </div>
                <div class="footer-col">
                    <h6>Portal Links</h6>
                    <ul>
                        <li><a href="${pageContext.request.contextPath}/auth">Faculty Vault</a></li>
                        <li><a href="${pageContext.request.contextPath}/admin/auth">Admin Portal</a></li>
                        <li><a href="#">Student ERP Portal</a></li>
                        <li><a href="#">Examination Cell</a></li>
                    </ul>
                </div>
                <div class="footer-col">
                    <h6>Institutional Support</h6>
                    <ul>
                        <li><a href="#">Dean Academics Office</a></li>
                        <li><a href="#">Research Directorate</a></li>
                        <li><a href="#">Center for Global Engagement</a></li>
                        <li><a href="#">Contact R&D Support</a></li>
                    </ul>
                </div>
            </div>
            <hr class="border-secondary opacity-25 mb-4">
            <div class="d-flex flex-wrap justify-content-between align-items-center text-secondary small">
                <div>&copy; 2026 NIET Greater Noida &bull; Faculty Vault & Research Repository. All Rights Reserved.</div>
                <div class="d-flex gap-3 mt-2 mt-md-0">
                    <a href="#" class="text-secondary text-decoration-none">Privacy Policy</a>
                    <a href="#" class="text-secondary text-decoration-none">Terms of Use</a>
                    <a href="#" class="text-secondary text-decoration-none">Sitemap</a>
                </div>
            </div>
        </div>
    </footer>

    <!-- Auth Drawer Modal -->
    <div class="auth-drawer-backdrop" id="authDrawer">
        <div class="auth-drawer-panel">
            <button class="drawer-close-btn" onclick="closeModal('authDrawer')">&times;</button>
            
            <div class="drawer-logo-wrap"><div class="drawer-logo" role="img" aria-label="NIET"></div></div>
            <div class="drawer-title">VAULT ACCESS</div>
            <div class="drawer-sub">Authorized Academic Personnel Verification</div>

            <c:if test="${not empty error}">
                <div class="alert alert-danger py-2 small fw-semibold mb-3">
                    <i class="fa-solid fa-triangle-exclamation me-1"></i> ${error}
                </div>
            </c:if>
            <c:if test="${not empty success}">
                <div class="alert alert-success py-2 small fw-semibold mb-3">
                    <i class="fa-solid fa-circle-check me-1"></i> ${success}
                </div>
            </c:if>

            <div class="auth-mode-switch">
                <button type="button" class="switch-tab-btn active" id="tab-in" onclick="switchDrawerMode('login')">Sign In</button>
                <button type="button" class="switch-tab-btn" id="tab-up" onclick="switchDrawerMode('register')">Register Account</button>
            </div>

            <!-- LOGIN FORM -->
            <form id="drawerLoginForm" action="${pageContext.request.contextPath}/auth" method="POST">
                <label class="field-label">ERP ID or Official Email *</label>
                <input type="text" name="erpIdOrEmail" class="dark-input" placeholder="e.g. ERP101 or name@niet.co.in" required autofocus>

                <label class="field-label">Password *</label>
                <input type="password" name="password" class="dark-input" placeholder="••••••••••••" required>

                <button type="submit" class="btn-drawer-submit mt-2">Access Vault &rarr;</button>
            </form>

            <!-- REGISTER FORM -->
            <form id="drawerRegisterForm" style="display: none;" action="${pageContext.request.contextPath}/register" method="POST" onsubmit="return handleRegisterSubmit(event)">
                <div class="row g-2">
                    <div class="col-8">
                        <label class="field-label">Full Name *</label>
                        <input type="text" name="fullName" class="dark-input" placeholder="Dr. Rajesh Sharma" required>
                    </div>
                    <div class="col-4">
                        <label class="field-label">ERP ID *</label>
                        <input type="text" name="erpId" class="dark-input font-monospace" placeholder="ERP102" required>
                    </div>
                </div>

                <div class="row g-2">
                    <div class="col-6">
                        <label class="field-label">Designation *</label>
                        <select name="designation" class="dark-input" required>
                            <option value="Dean">Dean</option>
                            <option value="Head of Department (HOD)">Head of Department (HOD)</option>
                            <option value="Deputy Head of Department (Deputy HOD)">Deputy Head of Department (Deputy HOD)</option>
                            <option value="Professor">Professor</option>
                            <option value="Assistant Professor" selected>Assistant Professor</option>
                        </select>
                    </div>
                    <div class="col-6">
                        <label class="field-label">Account Role *</label>
                        <select name="isAdminRegistration" class="dark-input">
                            <option value="false">Faculty Member</option>
                            <option value="true">Dean / Admin Account</option>
                        </select>
                    </div>
                </div>

                <label class="field-label">Department / Branch *</label>
                <select name="department" class="dark-input" required>
                    <option value="Computer Science & Engineering">Computer Science & Engineering (CSE)</option>
                    <option value="CSE - Artificial Intelligence & Machine Learning">CSE (AI & Machine Learning)</option>
                    <option value="CSE - Data Science">CSE (Data Science)</option>
                    <option value="Information Technology">Information Technology (IT)</option>
                    <option value="Electronics & Communication">Electronics & Communication (ECE)</option>
                    <option value="Mechanical Engineering">Mechanical Engineering (ME)</option>
                    <option value="Civil Engineering">Civil Engineering (CE)</option>
                    <option value="Electrical Engineering">Electrical Engineering (EE)</option>
                    <option value="Biotechnology">Biotechnology (BT)</option>
                    <option value="Master of Computer Applications">Master of Computer Applications (MCA)</option>
                    <option value="Master of Business Administration">Master of Business Administration (MBA)</option>
                    <option value="Applied Sciences & Humanities">Applied Sciences & Humanities</option>
                </select>

                <label class="field-label">Official Email (@niet.co.in) *</label>
                <div class="input-group mb-2">
                    <input type="email" id="regEmail" name="officialEmail" class="dark-input mb-0" placeholder="name@niet.co.in" required>
                    <button type="button" class="btn btn-outline-danger small fw-bold px-3" onclick="sendEmailOTP()" style="border-radius: 0 10px 10px 0; border-color: var(--accent-red); color: var(--accent-red);">Verify</button>
                </div>

                <div id="otpSection" style="display: none;" class="mb-3 p-3 border rounded-3 bg-dark bg-opacity-50">
                    <label class="field-label text-warning">Enter 6-digit Code sent to Email</label>
                    <input type="text" id="otpCodeInput" name="otpCode" class="dark-input mb-2 text-center font-monospace" placeholder="123456" maxlength="6">
                    <button type="button" class="btn btn-sm btn-success w-100 fw-bold" onclick="verifyOTPCodeLocally()">Confirm Code</button>
                </div>

                <label class="field-label">Create Password *</label>
                <input type="password" name="password" class="dark-input" placeholder="••••••••" required>

                <button type="submit" id="registerSubmitBtn" class="btn-drawer-submit mt-2" disabled style="opacity: 0.5;">
                    Verify Email First &rarr;
                </button>
            </form>
        </div>
    </div>

    <script>
        let isEmailVerified = false;

        document.addEventListener('DOMContentLoaded', () => {
            const savedTheme = localStorage.getItem('nietLightingEngine') || 'day';
            document.documentElement.setAttribute('data-lighting', savedTheme);
            updateLightingUI(savedTheme);

            <c:if test="${not empty success}">
                switchDrawerMode('login');
                openModal('authDrawer');
            </c:if>
            <c:if test="${not empty error}">
                openModal('authDrawer');
            </c:if>
        });

        function openModal(id) { document.getElementById(id).style.display = 'flex'; }
        function closeModal(id) { document.getElementById(id).style.display = 'none'; }

        function switchDrawerMode(mode) {
            document.querySelectorAll('.switch-tab-btn').forEach(b => b.classList.remove('active'));
            if (mode === 'login') {
                document.getElementById('tab-in').classList.add('active');
                document.getElementById('drawerLoginForm').style.display = 'block';
                document.getElementById('drawerRegisterForm').style.display = 'none';
            } else {
                document.getElementById('tab-up').classList.add('active');
                document.getElementById('drawerLoginForm').style.display = 'none';
                document.getElementById('drawerRegisterForm').style.display = 'block';
            }
        }

        function sendEmailOTP() {
            const email = document.getElementById('regEmail').value;
            if (!email || !email.endsWith('@niet.co.in')) {
                alert('Please enter a valid official institutional email ending with (@niet.co.in).');
                return;
            }

            fetch('${pageContext.request.contextPath}/auth/send-otp?email=' + encodeURIComponent(email), {
                method: 'POST'
            })
            .then(res => res.json())
            .then(data => {
                if (data.status === 'SUCCESS') {
                    alert(data.message);
                    document.getElementById('otpSection').style.display = 'block';
                } else {
                    alert(data.message || 'Failed to send OTP.');
                }
            })
            .catch(err => {
                console.error('Error:', err);
                alert('Network error while requesting OTP.');
            });
        }

        function verifyOTPCodeLocally() {
            const code = document.getElementById('otpCodeInput').value;
            if (!code || code.length !== 6) {
                alert('Please enter a valid 6-digit OTP code.');
                return;
            }

            fetch('${pageContext.request.contextPath}/auth/verify-otp?otp=' + encodeURIComponent(code), {
                method: 'POST'
            })
            .then(res => res.json())
            .then(data => {
                if (data.status === 'SUCCESS') {
                    isEmailVerified = true;
                    alert(data.message);
                    document.getElementById('otpSection').style.display = 'none';
                    document.getElementById('regEmail').setAttribute('readonly', 'true');
                    const subBtn = document.getElementById('registerSubmitBtn');
                    subBtn.disabled = false;
                    subBtn.style.opacity = '1';
                    subBtn.innerText = 'Complete Registration →';
                } else {
                    alert(data.message || 'Invalid OTP code.');
                }
            })
            .catch(err => {
                console.error('Error:', err);
                alert('Verification failed due to network error.');
            });
        }

        function handleRegisterSubmit(e) {
            if (!isEmailVerified) {
                e.preventDefault();
                alert('Please verify your official email address first using the verification code!');
                return false;
            }
            return true;
        }

        function toggleLighting() {
            const current = document.documentElement.getAttribute('data-lighting') || 'day';
            const next = current === 'day' ? 'night' : 'day';
            document.documentElement.setAttribute('data-lighting', next);
            localStorage.setItem('nietLightingEngine', next);
            updateLightingUI(next);
        }

        function updateLightingUI(theme) {
            const icon = document.getElementById('lightingIcon');
            const label = document.getElementById('lightingLabel');
            if (theme === 'night') {
                icon.className = 'fa-solid fa-moon text-info';
                label.innerText = 'Night';
            } else {
                icon.className = 'fa-solid fa-sun text-warning';
                label.innerText = 'Day';
            }
        }

        document.querySelectorAll('.auth-drawer-backdrop').forEach(backdrop => {
            backdrop.addEventListener('click', function(e) { if (e.target === this) this.style.display = 'none'; });
        });
    </script>

    <script>
    /* ===== NIET entrance + portal extras ===== */
    (function () {
        var root = document.documentElement;
        var splash = document.getElementById('nietSplash');
        var quick = window.matchMedia('(prefers-reduced-motion: reduce)').matches;
        var timers = [], stopSplashDust = null, finished = false;

        function dust(cv, rgb, count) {
            var x = cv.getContext('2d'), W, H, P = [], run = true, raf, vis = true;
            function size() {
                var r = cv.getBoundingClientRect(); W = cv.width = r.width; H = cv.height = r.height;
                P = Array.from({ length: Math.min(count, Math.round(W / 18)) }, function () {
                    return { x: Math.random() * W, y: Math.random() * H, r: Math.random() * 2 + .6, vx: (Math.random() - .3) * .15,
                             vy: -Math.random() * .22 - .03, a: Math.random() * .5 + .15, p: Math.random() * 6 };
                });
            }
            size(); window.addEventListener('resize', size);
            if ('IntersectionObserver' in window) new IntersectionObserver(function (e) { vis = e[0].isIntersecting; }).observe(cv);
            (function f() {
                if (!run) return;
                if (vis && !document.hidden) {
                    x.clearRect(0, 0, W, H);
                    for (var i = 0; i < P.length; i++) {
                        var p = P[i]; p.x += p.vx; p.y += p.vy; p.p += .02;
                        if (p.y < -5) { p.y = H + 5; p.x = Math.random() * W; }
                        if (p.x > W + 5) p.x = -5;
                        x.fillStyle = 'rgba(' + rgb + ',' + (p.a * (.6 + .4 * Math.sin(p.p))) + ')';
                        x.beginPath(); x.arc(p.x, p.y, p.r, 0, 7); x.fill();
                    }
                }
                raf = requestAnimationFrame(f);
            })();
            return function () { run = false; cancelAnimationFrame(raf); window.removeEventListener('resize', size); };
        }

        function buildSlogan() {
            var el = document.getElementById('nsSlogan'), d = 3.0;
            el.innerHTML = '';
            [['Knowledge, locked in.', false], ['Legacy, unlocked.', true]].forEach(function (pair) {
                var w = document.createElement(pair[1] ? 'em' : 'span');
                pair[0].split('').forEach(function (c, i) {
                    var u = document.createElement('span'); u.className = 'ns-u';
                    u.textContent = c === ' ' ? '\u00A0' : c; u.style.animationDelay = (d + i * .035) + 's'; w.appendChild(u);
                });
                d += pair[0].length * .035 + .25; el.appendChild(w);
                if (!pair[1]) el.appendChild(document.createTextNode('\u00A0 '));
            });
        }

        var tilt = document.getElementById('nsTilt');
        function onMove(e) {
            var px = e.clientX / innerWidth - .5, py = e.clientY / innerHeight - .5;
            tilt.style.transform = 'rotateY(' + px * 14 + 'deg) rotateX(' + (-py * 10) + 'deg)';
        }

        function finish() {
            if (finished) return; finished = true;
            timers.forEach(clearTimeout);
            if (stopSplashDust) stopSplashDust();
            window.removeEventListener('pointermove', onMove);
            root.classList.remove('splash-on'); root.classList.add('portal-ready');
            splash.style.display = 'none';
            try { sessionStorage.setItem('nietPortalUnlocked', 'true'); } catch (e) {}
        }
        window.skipSplash = function () {
            if (finished || splash.classList.contains('leaving')) return;
            timers.forEach(clearTimeout);
            splash.classList.add('leaving');
            timers = [setTimeout(finish, 650)];
        };

        if (root.classList.contains('no-splash')) {
            finished = true;
        } else {
            buildSlogan();
            stopSplashDust = dust(document.getElementById('nsDust'), '224,168,0', 50);
            window.addEventListener('pointermove', onMove);
            timers.push(setTimeout(function () { splash.classList.add('leaving'); }, quick ? 400 : 4300));
            timers.push(setTimeout(finish, quick ? 1100 : 5100));
        }

        /* ---- portal extras ---- */
        dust(document.getElementById('heroDust'), '255,118,94', 45);

        var bar = document.getElementById('scrollProgress'), tick = false;
        function prog() {
            var h = document.documentElement.scrollHeight - innerHeight;
            bar.style.transform = 'scaleX(' + (h > 0 ? Math.min(scrollY / h, 1) : 0) + ')'; tick = false;
        }
        window.addEventListener('scroll', function () { if (!tick) { tick = true; requestAnimationFrame(prog); } }, { passive: true });

        var items = document.querySelectorAll('.section-title-box, .content-card, .experience-left, .experience-right, .bottom-pane-left, .bottom-pane-right, .footer-col');
        items.forEach(function (el, i) { el.classList.add('reveal'); el.style.transitionDelay = ((i % 4) * 0.12) + 's'; });
        if ('IntersectionObserver' in window) {
            var io = new IntersectionObserver(function (entries) {
                entries.forEach(function (en) {
                    if (!en.isIntersecting) return;
                    var el = en.target; el.classList.add('in'); io.unobserve(el);
                    setTimeout(function () { el.classList.remove('reveal', 'in'); el.style.transitionDelay = ''; }, 1400);
                });
            }, { threshold: .15 });
            items.forEach(function (el) { io.observe(el); });
        } else { items.forEach(function (el) { el.classList.remove('reveal'); }); }

        document.querySelectorAll('[data-count]').forEach(function (el) {
            var target = parseInt(el.dataset.count, 10), suf = el.dataset.suffix || '';
            if (!('IntersectionObserver' in window) || quick) return;
            el.textContent = '0' + suf;
            var co = new IntersectionObserver(function (e) {
                if (!e[0].isIntersecting) return; co.disconnect();
                var t0 = performance.now();
                (function step(t) {
                    var k = Math.min((t - t0) / 1600, 1), v = 1 - Math.pow(1 - k, 3);
                    el.textContent = Math.round(target * v) + suf;
                    if (k < 1) requestAnimationFrame(step);
                })(t0);
            }, { threshold: .6 });
            co.observe(el);
        });

        document.querySelectorAll('.content-card').forEach(function (c) {
            c.addEventListener('pointermove', function (e) {
                var r = c.getBoundingClientRect();
                c.style.setProperty('--mx', (e.clientX - r.left) + 'px'); c.style.setProperty('--my', (e.clientY - r.top) + 'px');
            });
        });

        var lf = document.getElementById('drawerLoginForm');
        if (lf) lf.addEventListener('submit', function () {
            var b = lf.querySelector('.btn-drawer-submit');
            setTimeout(function () { b.innerHTML = '<i class="fa-solid fa-circle-notch fa-spin me-2"></i>Verifying\u2026'; b.style.pointerEvents = 'none'; }, 0);
        });
    })();
    </script>
</body>
</html>