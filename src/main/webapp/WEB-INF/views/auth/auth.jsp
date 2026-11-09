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

        /* ================= NIET Entrance (editorial, hand-timed) ================= */
        :root { --ns-logo: url('${pageContext.request.contextPath}/images/niet-logo-hd.png'); }
        html.splash-on, html.splash-on body { overflow: hidden; }
        html.no-splash .ns-splash { display: none !important; }

        .ns-splash { position: fixed; inset: 0; z-index: 9999; overflow: hidden; cursor: pointer; display: grid; place-items: center;
            background: radial-gradient(ellipse at 50% 36%, #ffffff 0%, #f7f3eb 62%, #eee8dc 100%); color: #1b2440; font-family: 'Plus Jakarta Sans', sans-serif; }
        .ns-splash::after { content: ''; position: absolute; inset: 0; pointer-events: none; opacity: .07; mix-blend-mode: multiply;
            background-image: url("data:image/svg+xml;utf8,<svg xmlns='http://www.w3.org/2000/svg' width='160' height='160'><filter id='n'><feTurbulence type='fractalNoise' baseFrequency='.9' numOctaves='2' stitchTiles='stitch'/><feColorMatrix values='0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 .6 0'/></filter><rect width='100%25' height='100%25' filter='url(%23n)'/></svg>"); }
        .ns-arcs { position: absolute; inset: 0; width: 100%; height: 100%; pointer-events: none; }
        .ns-arcs circle { fill: none; stroke-width: 1; stroke-dasharray: 1; stroke-dashoffset: 1; animation: nsDraw 3.4s cubic-bezier(.6,0,.2,1) forwards; }
        .ns-arcs .a1 { stroke: rgba(217,56,30,.20); animation-delay: .2s; } .ns-arcs .a2 { stroke: rgba(29,47,111,.12); animation-delay: .6s; } .ns-arcs .a3 { stroke: rgba(217,56,30,.10); animation-delay: 1s; }

        .ns-corner { position: absolute; padding: 12px 16px; font-size: .64rem; letter-spacing: .3em; text-transform: uppercase; font-weight: 700; color: #868c9e; opacity: 0; animation: nsFade .9s .4s forwards; }
        .ns-corner::before { content: ''; position: absolute; width: 14px; height: 14px; border: 1px solid rgba(217,56,30,.6); }
        .ns-tl { top: 18px; left: 20px; } .ns-tl::before { top: 0; left: 0; border-right: 0; border-bottom: 0; }
        .ns-tr { top: 18px; right: 20px; } .ns-tr::before { top: 0; right: 0; border-left: 0; border-bottom: 0; }
        .ns-bl { bottom: 22px; left: 20px; } .ns-bl::before { bottom: 0; left: 0; border-right: 0; border-top: 0; }
        .ns-br { bottom: 22px; right: 20px; font-variant-numeric: tabular-nums; } .ns-br::before { bottom: 0; right: 0; border-left: 0; border-top: 0; }

        .ns-center { position: relative; z-index: 2; display: flex; flex-direction: column; align-items: center; text-align: center; padding: 0 1.2rem; max-width: min(94vw, 760px); }
        .ns-greet { margin-bottom: clamp(1.2rem, 4.5vh, 2.4rem); font-size: clamp(.7rem, 1.8vw, .84rem); letter-spacing: .34em; text-transform: uppercase; font-weight: 700; color: #7b8194; opacity: 0; transform: translateY(8px); animation: nsUp .9s .5s forwards; }
        .ns-lockup { position: relative; width: clamp(250px, 58vw, 440px); animation: nsSettle 3.4s .9s cubic-bezier(.2,.7,.2,1) both; }
        .ns-logo { width: 100%; aspect-ratio: 1030/395; background: var(--ns-logo) center/100% 100% no-repeat; clip-path: inset(0 100% 0 0); animation: nsWipe 1.9s 1.1s cubic-bezier(.65,0,.25,1) forwards; }
        .ns-bar { position: absolute; top: -7%; bottom: -7%; left: 0; width: 3px; background: #d9381e; box-shadow: 0 0 14px rgba(217,56,30,.5); opacity: 0; animation: nsBar 1.9s 1.1s cubic-bezier(.65,0,.25,1) forwards; }
        .ns-rule { display: block; width: 0; height: 2px; margin: clamp(1.1rem, 3.6vh, 1.9rem) 0 clamp(.9rem, 2.6vh, 1.3rem); background: linear-gradient(90deg, #d9381e, #e0a800); animation: nsRule .9s 3.1s ease-out forwards; }
        .ns-title { font-size: clamp(.92rem, 2.6vw, 1.32rem); font-weight: 700; text-transform: uppercase; letter-spacing: .5em; color: #1d2f6f; opacity: 0; animation: nsTrack 1.5s 3.3s cubic-bezier(.2,.8,.2,1) forwards; }
        .ns-slogan { margin-top: .9rem; font-size: clamp(.92rem, 2.4vw, 1.18rem); line-height: 1.6; color: #565e72; }
        .ns-slogan span { display: block; opacity: 0; transform: translateY(10px); }
        .ns-slogan .l1 { font-style: italic; animation: nsUp .9s 4.4s forwards; }
        .ns-slogan .l2 { font-weight: 800; color: #d9381e; animation: nsUp .9s 5.3s forwards; }
        .ns-facts { list-style: none; display: flex; flex-wrap: wrap; justify-content: center; margin-top: 1.5rem; }
        .ns-facts li { font-size: .66rem; letter-spacing: .2em; text-transform: uppercase; font-weight: 700; color: #6b7186; opacity: 0; transform: translateY(8px); animation: nsUp .7s forwards; padding: .15rem 0; }
        .ns-facts li + li::before { content: ''; display: inline-block; width: 4px; height: 4px; margin: 0 12px 2px 12px; border-radius: 50%; background: #d9381e; vertical-align: middle; }
        .ns-facts li:nth-child(1) { animation-delay: 6.2s; } .ns-facts li:nth-child(2) { animation-delay: 6.45s; } .ns-facts li:nth-child(3) { animation-delay: 6.7s; } .ns-facts li:nth-child(4) { animation-delay: 6.95s; }
        .ns-motto { margin-top: 1.1rem; font-family: Georgia, 'Times New Roman', serif; font-style: italic; font-size: clamp(.95rem, 2.2vw, 1.12rem); color: #d9381e; opacity: 0; transform: translateY(8px); animation: nsUp .9s 7.4s forwards; }
        .ns-progress { position: absolute; left: 0; right: 0; bottom: 0; height: 3px; background: rgba(29,47,111,.08); }
        .ns-progress i { display: block; height: 100%; width: 0; background: linear-gradient(90deg, #d9381e, #ff8a5c); }
        .ns-skip { position: absolute; bottom: 24px; left: 50%; transform: translateX(-50%); background: none; border: 1px solid rgba(29,47,111,.25); color: #1d2f6f; border-radius: 30px; padding: .4rem 1.15rem; font: 700 .68rem 'Plus Jakarta Sans', sans-serif; letter-spacing: .22em; text-transform: uppercase; cursor: pointer; opacity: 0; animation: nsFade .8s 1.6s forwards; transition: all .2s; }
        .ns-skip:hover { border-color: #d9381e; color: #d9381e; }
        .ns-curtain { position: absolute; inset: 0; z-index: 5; background: #d9381e; transform: translateX(-101%); }
        .ns-curtain::before { content: ''; position: absolute; top: 0; bottom: 0; right: 0; width: 14px; background: #1d2f6f; }
        .ns-splash.leaving .ns-curtain { transform: none; transition: transform .75s cubic-bezier(.77,0,.18,1); }
        .ns-splash.leaving2 { background: transparent !important; cursor: default; pointer-events: none; }
        .ns-splash.leaving2::after { display: none; }
        .ns-splash.leaving2 > *:not(.ns-curtain) { visibility: hidden; }
        .ns-splash.leaving2 .ns-curtain { transform: translateX(101%); transition: transform .85s cubic-bezier(.77,0,.18,1); }
        @keyframes nsDraw { to { stroke-dashoffset: 0; } }
        @keyframes nsWipe { to { clip-path: inset(0 0 0 0); } }
        @keyframes nsBar { 0% { left: 0; opacity: 1; } 92% { left: 100%; opacity: 1; } 100% { left: 100%; opacity: 0; } }
        @keyframes nsSettle { from { transform: scale(1.04); } to { transform: scale(1); } }
        @keyframes nsRule { to { width: 96px; } }
        @keyframes nsTrack { to { opacity: 1; letter-spacing: .2em; } }
        @keyframes nsUp { to { opacity: 1; transform: none; } }
        @keyframes nsFade { to { opacity: 1; } }
        @media (max-width: 600px) { .ns-bl, .ns-tl { display: none; } .ns-title { letter-spacing: .3em; } @keyframes nsTrack { to { opacity: 1; letter-spacing: .14em; } } }
        @media (prefers-reduced-motion: reduce) { .ns-splash *, .ns-splash::after { animation-duration: .01s !important; animation-delay: 0s !important; } .ns-curtain { transition: none !important; } }

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

        /* Cinematic Hero Section: only the photo layer drifts, text stays crisp */
        .hero-viewport { position: relative; min-height: 78vh; display: flex; align-items: center; padding: 5rem 3rem; color: #ffffff; border-bottom: 5px solid var(--accent-red); overflow: hidden; background: #0b0f19; }
        .hero-viewport::before { content: ''; position: absolute; inset: 0; z-index: 0; will-change: transform;
            background: linear-gradient(105deg, rgba(10, 16, 32, 0.92) 0%, rgba(10, 16, 32, 0.70) 48%, rgba(3, 5, 9, 0.55) 100%), url('${pageContext.request.contextPath}/images/niet-campus.png') no-repeat center center/cover;
            animation: heroZoom 26s infinite alternate ease-in-out; }
        [data-lighting="night"] .hero-viewport::before { background: linear-gradient(105deg, rgba(5, 8, 16, 0.94) 0%, rgba(8, 12, 22, 0.80) 50%, rgba(3, 5, 9, 0.70) 100%), url('${pageContext.request.contextPath}/images/niet-campus.png') no-repeat center center/cover; }
        @keyframes heroZoom { 0% { transform: scale(1); } 100% { transform: scale(1.07); } }

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

        /* ================= Professional layout additions ================= */
        html { scroll-behavior: smooth; }
        section[id] { scroll-margin-top: 90px; }
        .brand-logo-area { gap: 1rem; }
        .brand-logo-img { height: 44px; width: auto; }
        [data-lighting="night"] .brand-logo-img { background: #ffffff; border-radius: 8px; padding: 4px 9px; }
        .brand-sep { width: 1px; height: 30px; background: var(--border-line); }
        .brand-text { display: flex; flex-direction: column; line-height: 1.15; color: var(--nav-text); }
        .brand-text b { font-size: 1rem; font-weight: 800; letter-spacing: -.01em; } .brand-text small { font-size: .66rem; letter-spacing: .18em; text-transform: uppercase; color: var(--accent-red); font-weight: 800; }
        .nav-links { display: flex; align-items: center; gap: .3rem; }
        .nav-links a { color: var(--nav-text); text-decoration: none; font-size: .84rem; font-weight: 600; padding: .5rem .9rem; border-radius: 30px; transition: all .2s; }
        .nav-links a:hover, .nav-links a.active { color: var(--accent-red); background: rgba(217, 56, 30, 0.10); }
        .btn-outline-nav { color: var(--nav-text); border: 1.5px solid var(--input-border); background: transparent; font-size: .78rem; font-weight: 800; letter-spacing: .5px; text-transform: uppercase; padding: .48rem 1.1rem; border-radius: 40px; text-decoration: none; display: inline-flex; align-items: center; gap: 6px; transition: all .2s; }
        .btn-outline-nav:hover { border-color: var(--accent-red); color: var(--accent-red); }
        .btn-ghost { background: rgba(255,255,255,.08); color: #fff; border: 1.5px solid rgba(255,255,255,.35); font-size: .88rem; font-weight: 700; letter-spacing: 1px; text-transform: uppercase; padding: .95rem 2rem; border-radius: 40px; text-decoration: none; display: inline-flex; align-items: center; gap: 10px; transition: all .25s; backdrop-filter: blur(6px); }
        .btn-ghost:hover { background: #fff; color: #0f172a; }
        .hero-cta { display: flex; flex-wrap: wrap; gap: 1rem; align-items: center; }
        .hero-slogan { font-size: clamp(1.05rem, 2vw, 1.4rem); }

        .trust-strip { background: var(--surface-panel); border-bottom: 1px solid var(--border-line); }
        .trust-strip ul { list-style: none; display: flex; flex-wrap: wrap; justify-content: center; gap: .6rem 2.4rem; padding: 1.1rem 0; margin: 0; }
        .trust-strip li { font-size: .74rem; font-weight: 800; letter-spacing: .12em; text-transform: uppercase; color: var(--text-silver); display: flex; align-items: center; gap: 9px; }
        .trust-strip li i { color: var(--accent-red); font-size: .95rem; }

        .eyebrow { display: inline-block; font-size: .7rem; letter-spacing: .24em; text-transform: uppercase; font-weight: 800; color: var(--accent-red); margin-bottom: .7rem; }
        .section-alt { background: var(--surface-panel); border-top: 1px solid var(--border-line); border-bottom: 1px solid var(--border-line); }
        .content-card h5 { font-size: 1.06rem; }
        .feature-tag { display: inline-block; margin-top: 1rem; font-size: .68rem; font-weight: 800; letter-spacing: .1em; text-transform: uppercase; color: var(--accent-red); }

        .steps { display: grid; grid-template-columns: repeat(auto-fit, minmax(210px, 1fr)); gap: 1.5rem; position: relative; counter-reset: st; }
        .step-card { position: relative; text-align: center; padding: 1.6rem 1.2rem 1.4rem; background: var(--bg-void); border: 1px solid var(--border-line); border-radius: 18px; transition: all .3s; }
        .step-card:hover { border-color: var(--accent-red); transform: translateY(-5px); box-shadow: 0 18px 36px rgba(217,56,30,.12); }
        .step-no { width: 46px; height: 46px; margin: -2.6rem auto .9rem; border-radius: 50%; background: var(--accent-red); color: #fff; display: flex; align-items: center; justify-content: center; font-weight: 800; font-size: 1.05rem; box-shadow: 0 8px 20px rgba(217,56,30,.4); border: 4px solid var(--surface-panel); }
        .step-card i.si { font-size: 1.5rem; color: var(--accent-red); margin-bottom: .7rem; display: block; }
        .step-card h6 { font-weight: 800; margin-bottom: .4rem; } .step-card p { font-size: .84rem; color: var(--text-silver); margin: 0; }
        .steps-wrap { padding-top: 1.6rem; }
        .cta-band { margin-top: 3.2rem; border-radius: 22px; padding: 2.2rem 2.4rem; display: flex; flex-wrap: wrap; align-items: center; justify-content: space-between; gap: 1.5rem; color: #fff; background: linear-gradient(120deg, #0f172a, #1b2440 60%, #8a2413); }
        .cta-band h4 { color: #fff; font-weight: 800; margin: 0 0 .3rem; } .cta-band p { margin: 0; color: #cbd5e1; font-size: .92rem; }

        .faq-list { display: flex; flex-direction: column; gap: .8rem; }
        .faq-item { background: var(--surface-panel); border: 1px solid var(--border-line); border-radius: 16px; overflow: hidden; transition: border-color .25s, box-shadow .25s; }
        .faq-item.open { border-color: var(--accent-red); box-shadow: 0 12px 30px rgba(217,56,30,.10); }
        .faq-q { width: 100%; background: none; border: 0; color: var(--card-text); text-align: left; padding: 1.15rem 1.4rem; font: 700 .96rem 'Plus Jakarta Sans', sans-serif; display: flex; justify-content: space-between; align-items: center; gap: 1rem; cursor: pointer; }
        .faq-q i { color: var(--accent-red); transition: transform .3s; flex: 0 0 auto; } .faq-item.open .faq-q i { transform: rotate(45deg); }
        .faq-a { max-height: 0; overflow: hidden; transition: max-height .35s ease; }
        .faq-a p { padding: 0 1.4rem 1.2rem; margin: 0; color: var(--text-silver); font-size: .9rem; line-height: 1.7; }

        .to-top { position: fixed; right: 22px; bottom: 22px; width: 46px; height: 46px; border-radius: 50%; border: 0; background: var(--accent-red); color: #fff; font-size: 1rem; cursor: pointer; z-index: 80; box-shadow: 0 10px 25px rgba(217,56,30,.45); opacity: 0; transform: translateY(14px); pointer-events: none; transition: all .3s; }
        .to-top.show { opacity: 1; transform: none; pointer-events: auto; } .to-top:hover { background: #b52b14; }
        .btn-admin-portal { white-space: nowrap; }
        @media (max-width: 576px) { .btn-admin-portal { padding: .5rem .95rem; font-size: .7rem; } .btn-lighting-pill span { display: none; } .nav-actions { gap: 8px; } }
        @media (max-width: 992px) { .editorial-nav { padding: .75rem 1rem; } .hero-viewport, .portal-content-section, .experience-banner { padding-left: 1.2rem; padding-right: 1.2rem; } .bottom-pane-left, .bottom-pane-right { padding: 2rem 1.2rem; } }
    </style>
</head>
<body>

    <!-- NIET entrance: plays once per browser session. Click anywhere or press "Skip intro" to skip. -->
    <div class="ns-splash" id="nietSplash" onclick="skipSplash()" role="dialog" aria-label="Loading Faculty Vault">
        <svg class="ns-arcs" viewBox="0 0 1000 1000" preserveAspectRatio="xMidYMid slice" aria-hidden="true">
            <circle class="a1" cx="500" cy="500" r="250" pathLength="1"/>
            <circle class="a2" cx="500" cy="500" r="380" pathLength="1"/>
            <circle class="a3" cx="500" cy="500" r="520" pathLength="1"/>
        </svg>
        <div class="ns-corner ns-tl">NIET &middot; Greater Noida</div>
        <div class="ns-corner ns-tr" id="nsClock"></div>
        <div class="ns-corner ns-bl" id="nsStatus">Initialising</div>
        <div class="ns-corner ns-br"><span id="nsPct">0</span>%</div>

        <div class="ns-center">
            <div class="ns-greet" id="nsGreet">Welcome</div>
            <div class="ns-lockup">
                <div class="ns-logo" role="img" aria-label="NIET Greater Noida"></div>
                <i class="ns-bar"></i>
            </div>
            <i class="ns-rule"></i>
            <div class="ns-title">Faculty Vault &amp; Repository</div>
            <div class="ns-slogan"><span class="l1">Knowledge, locked in.</span><span class="l2">Legacy, unlocked.</span></div>
            <ul class="ns-facts"><li>Est. 2001</li><li>NAAC A+</li><li>NBA Accredited</li><li>1st Autonomous Institute in UP</li></ul>
            <div class="ns-motto">Get Future Ready</div>
        </div>
        <div class="ns-progress"><i id="nsFill"></i></div>
        <button type="button" class="ns-skip" onclick="event.stopPropagation(); skipSplash()">Skip intro</button>
        <div class="ns-curtain"></div>
    </div>
    <div class="scroll-progress" id="scrollProgress"></div>

    <!-- Top Header Navigation Bar -->
    <nav class="editorial-nav">
        <a href="${pageContext.request.contextPath}/" class="brand-logo-area">
            <img src="${pageContext.request.contextPath}/images/niet-logo-hd.png" alt="NIET Greater Noida" class="brand-logo-img"
                 onerror="this.onerror=null;this.src='${pageContext.request.contextPath}/images/niet-logo.png'">
            <span class="brand-sep d-none d-md-block"></span>
            <span class="brand-text d-none d-md-flex"><b>Faculty Vault</b><small>Research Repository</small></span>
        </a>

        <div class="nav-links d-none d-lg-flex" id="navLinks">
            <a href="#features">Features</a>
            <a href="#how">How it works</a>
            <a href="#excellence">Excellence</a>
            <a href="#faq">FAQ</a>
        </div>

        <div class="nav-actions">
            <button class="btn-lighting-pill" onclick="toggleLighting()" id="lightingBtn" aria-label="Toggle day and night mode">
                <i class="fa-solid fa-moon text-warning" id="lightingIcon"></i>
                <span id="lightingLabel">Night</span>
            </button>
            <a href="${pageContext.request.contextPath}/admin/auth" class="btn-outline-nav d-none d-sm-inline-flex">
                <i class="fa-solid fa-user-shield"></i> Admin
            </a>
            <button onclick="openModal('authDrawer')" class="btn-admin-portal" style="border:0;cursor:pointer">
                <i class="fa-solid fa-right-to-bracket"></i> Faculty Login
            </button>
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
                    <div class="hero-cta">
                        <button onclick="openModal('authDrawer')" class="btn-access-portal">
                            <span>Enter Portal</span>
                            <i class="fa-solid fa-arrow-right-long"></i>
                        </button>
                        <a href="#features" class="btn-ghost"><i class="fa-regular fa-circle-play"></i> Explore features</a>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Accreditation ribbon -->
    <section class="trust-strip">
        <div class="container">
            <ul>
                <li><i class="fa-solid fa-ranking-star"></i> NIRF Ranked</li>
                <li><i class="fa-solid fa-circle-check"></i> NAAC A+ Grade</li>
                <li><i class="fa-solid fa-shield-halved"></i> NBA Accredited</li>
                <li><i class="fa-solid fa-landmark"></i> Autonomous Category 'A'</li>
                <li><i class="fa-solid fa-calendar-check"></i> Established 2001</li>
            </ul>
        </div>
    </section>

    <!-- What the Vault does -->
    <section class="portal-content-section" id="features">
        <div class="container">
            <div class="section-title-box">
                <span class="eyebrow">The Platform</span>
                <h2 class="fw-bold h3 mb-2">Everything faculty research needs, in one vault</h2>
                <p class="text-silver small">From the first journal paper to the last patent, record it once and let the Vault handle scoring, reporting and audit.</p>
            </div>
            <div class="content-grid">
                <div class="content-card">
                    <div class="card-icon-box"><i class="fa-solid fa-book-open"></i></div>
                    <h5 class="fw-bold mb-2">Publication Repository</h5>
                    <p class="text-silver small mb-0">Log journal papers, conference proceedings and book chapters with authors, venue and indexing details in a single searchable place.</p>
                </div>
                <div class="content-card">
                    <div class="card-icon-box"><i class="fa-solid fa-lightbulb"></i></div>
                    <h5 class="fw-bold mb-2">Patent &amp; IP Tracking</h5>
                    <p class="text-silver small mb-0">Keep every filed and granted patent on record, ready for appraisal, accreditation and commercialization support.</p>
                </div>
                <div class="content-card">
                    <div class="card-icon-box"><i class="fa-solid fa-chart-simple"></i></div>
                    <h5 class="fw-bold mb-2">Automatic API Scoring</h5>
                    <p class="text-silver small mb-0">Research output is converted into API points as you submit it, so appraisals rest on real, verifiable data.</p>
                </div>
                <div class="content-card">
                    <div class="card-icon-box"><i class="fa-solid fa-gauge-high"></i></div>
                    <h5 class="fw-bold mb-2">Live Dean Dashboard</h5>
                    <p class="text-silver small mb-0">Department-wise rankings, monthly trends and a live audit trail give the Research Directorate a clear institutional picture.</p>
                </div>
                <div class="content-card">
                    <div class="card-icon-box"><i class="fa-solid fa-user-lock"></i></div>
                    <h5 class="fw-bold mb-2">Verified Faculty Access</h5>
                    <p class="text-silver small mb-0">Registration is limited to official @niet.co.in addresses and confirmed with a one-time password sent to your inbox.</p>
                </div>
                <div class="content-card">
                    <div class="card-icon-box"><i class="fa-solid fa-file-export"></i></div>
                    <h5 class="fw-bold mb-2">Report-ready Exports</h5>
                    <p class="text-silver small mb-0">Download CSV summaries or print-ready reports for NAAC, NIRF and NBA documentation in a few clicks.</p>
                </div>
            </div>
        </div>
    </section>

    <!-- How it works -->
    <section class="portal-content-section section-alt" id="how">
        <div class="container">
            <div class="section-title-box">
                <span class="eyebrow">Getting Started</span>
                <h2 class="fw-bold h3 mb-2">From sign-up to scored in four steps</h2>
                <p class="text-silver small">It takes a couple of minutes to get set up. After that, adding research is a short form.</p>
            </div>
            <div class="steps-wrap">
                <div class="steps">
                    <div class="step-card"><div class="step-no">1</div><i class="si fa-solid fa-id-card"></i><h6>Register</h6><p>Use your official @niet.co.in email and ERP ID.</p></div>
                    <div class="step-card"><div class="step-no">2</div><i class="si fa-solid fa-envelope-circle-check"></i><h6>Verify with OTP</h6><p>Enter the one-time code sent to your inbox.</p></div>
                    <div class="step-card"><div class="step-no">3</div><i class="si fa-solid fa-file-circle-plus"></i><h6>Add your research</h6><p>Record papers, chapters and patents with their details.</p></div>
                    <div class="step-card"><div class="step-no">4</div><i class="si fa-solid fa-trophy"></i><h6>Track your score</h6><p>See your API points and standing, updated instantly.</p></div>
                </div>
            </div>
            <div class="cta-band">
                <div><h4>Ready to put your research on record?</h4><p>Sign in or create your faculty account to get started.</p></div>
                <button onclick="openModal('authDrawer')" class="btn-access-portal"><span>Get started</span><i class="fa-solid fa-arrow-right-long"></i></button>
            </div>
        </div>
    </section>

    <!-- Faculty Research Ecosystem Section -->
    <section class="portal-content-section" id="excellence">
        <div class="container">
            <div class="section-title-box">
                <span class="eyebrow">Excellence &amp; Accreditations</span>
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
                <span class="eyebrow">Campus Life &amp; Labs</span>
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

    <!-- FAQ -->
    <section class="portal-content-section" id="faq">
        <div class="container" style="max-width: 860px;">
            <div class="section-title-box">
                <span class="eyebrow">Help &amp; Support</span>
                <h2 class="fw-bold h3 mb-2">Frequently asked questions</h2>
                <p class="text-silver small">Can't find what you need? Contact the R&amp;D support team listed in the footer.</p>
            </div>
            <div class="faq-list">
                <div class="faq-item"><button class="faq-q" type="button" aria-expanded="false"><span>Who can register for the Faculty Vault?</span><i class="fa-solid fa-plus"></i></button><div class="faq-a"><p>Faculty members with an official @niet.co.in email address and a valid ERP ID. Personal email addresses are not accepted.</p></div></div>
                <div class="faq-item"><button class="faq-q" type="button" aria-expanded="false"><span>I did not receive my verification OTP. What should I do?</span><i class="fa-solid fa-plus"></i></button><div class="faq-a"><p>Check your spam or junk folder first, then wait a minute and press Verify again. If it still does not arrive, contact the R&amp;D support team.</p></div></div>
                <div class="faq-item"><button class="faq-q" type="button" aria-expanded="false"><span>How is my API score calculated?</span><i class="fa-solid fa-plus"></i></button><div class="faq-a"><p>Each publication and patent you record adds points to your score. The weights are set by the Research Directorate and may be revised, and the score updates as soon as you submit.</p></div></div>
                <div class="faq-item"><button class="faq-q" type="button" aria-expanded="false"><span>Who can see my submissions?</span><i class="fa-solid fa-plus"></i></button><div class="faq-a"><p>Your records are visible to you and to authorised administrators of the Research Directorate for appraisal and accreditation work.</p></div></div>
                <div class="faq-item"><button class="faq-q" type="button" aria-expanded="false"><span>Can I download my research record?</span><i class="fa-solid fa-plus"></i></button><div class="faq-a"><p>Yes. Reports can be exported for appraisal and for NAAC, NIRF and NBA documentation.</p></div></div>
            </div>
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

    <button class="to-top" id="toTop" aria-label="Back to top"><i class="fa-solid fa-arrow-up"></i></button>

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
    /* ===== NIET entrance (hand-timed) + portal extras ===== */
    (function () {
        var root = document.documentElement;
        var splash = document.getElementById('nietSplash');
        var $ = function (id) { return document.getElementById(id); };
        var quick = window.matchMedia('(prefers-reduced-motion: reduce)').matches;
        var finished = false, leaving = false, raf = 0, clockTimer = 0, pct = 0, loaded = document.readyState === 'complete';
        var MIN_MS = 8800, MAX_MS = 15000;      // the intro runs at least ~9 s; never hangs longer than 15 s

        window.addEventListener('load', function () { loaded = true; });

        function finish() {
            if (finished) return; finished = true;
            cancelAnimationFrame(raf); clearInterval(clockTimer);
            root.classList.remove('splash-on'); root.classList.add('portal-ready');
            splash.style.display = 'none';
            try { sessionStorage.setItem('nietPortalUnlocked', 'true'); } catch (e) {}
        }
        function leave() {
            if (leaving || finished) return; leaving = true;
            cancelAnimationFrame(raf); setPct(100);
            if (quick) { finish(); return; }
            splash.classList.add('leaving');                                   // red curtain sweeps in
            setTimeout(function () { splash.classList.add('leaving2'); root.classList.add('portal-ready'); }, 780);   // ...and out, revealing the page
            setTimeout(finish, 1750);
        }
        window.skipSplash = function () { leave(); };

        function setPct(p) {
            pct = p; var n = Math.round(p);
            $('nsPct').textContent = n; $('nsFill').style.width = p + '%';
            $('nsStatus').textContent = n >= 100 ? 'Ready' : n >= 85 ? 'Almost there' : n >= 55 ? 'Syncing publications & patents' : n >= 25 ? 'Loading research repository' : 'Securing your session';
        }
        function greet() {
            var h = new Date().getHours();
            $('nsGreet').textContent = (h < 12 ? 'Good morning' : h < 17 ? 'Good afternoon' : 'Good evening') + ', Faculty';
            var t = function () { $('nsClock').textContent = new Date().toLocaleTimeString('en-IN', { hour: '2-digit', minute: '2-digit' }); };
            t(); clockTimer = setInterval(t, 20000);
        }

        if (root.classList.contains('no-splash')) {
            finished = true;
        } else {
            greet(); setPct(0);
            var t0 = performance.now();
            (function tick(now) {
                var t = now - t0;
                var target = Math.min(t / MIN_MS, 1) * 92;
                if ((t >= MIN_MS && loaded) || t >= MAX_MS) { setTimeout(leave, 450); target = 99; }
                setPct(pct + (target - pct) * .12);
                if (!leaving) raf = requestAnimationFrame(tick);
            })(t0);
        }

        /* ---- hero particles (subtle) ---- */
        function dust(cv, rgb, count) {
            if (!cv) return;
            var x = cv.getContext('2d'), W, H, P = [], vis = true;
            function size() {
                var r = cv.getBoundingClientRect(); W = cv.width = r.width; H = cv.height = r.height;
                P = Array.from({ length: Math.min(count, Math.round(W / 26)) }, function () {
                    return { x: Math.random() * W, y: Math.random() * H, r: Math.random() * 1.6 + .5, vx: (Math.random() - .3) * .12, vy: -Math.random() * .18 - .03, a: Math.random() * .4 + .12, p: Math.random() * 6 };
                });
            }
            size(); window.addEventListener('resize', size);
            if ('IntersectionObserver' in window) new IntersectionObserver(function (e) { vis = e[0].isIntersecting; }).observe(cv);
            (function f() {
                if (vis && !document.hidden) {
                    x.clearRect(0, 0, W, H);
                    for (var i = 0; i < P.length; i++) {
                        var p = P[i]; p.x += p.vx; p.y += p.vy; p.p += .02;
                        if (p.y < -5) { p.y = H + 5; p.x = Math.random() * W; } if (p.x > W + 5) p.x = -5;
                        x.fillStyle = 'rgba(' + rgb + ',' + (p.a * (.6 + .4 * Math.sin(p.p))) + ')'; x.beginPath(); x.arc(p.x, p.y, p.r, 0, 7); x.fill();
                    }
                }
                requestAnimationFrame(f);
            })();
        }
        if (!quick) dust($('heroDust'), '255,118,94', 36);

        /* ---- scroll progress, back-to-top, nav highlight ---- */
        var bar = $('scrollProgress'), toTop = $('toTop'), tick2 = false;
        var navA = Array.prototype.slice.call(document.querySelectorAll('#navLinks a'));
        var secs = navA.map(function (a) { return document.querySelector(a.getAttribute('href')); });
        function onScroll() {
            var h = document.documentElement.scrollHeight - innerHeight;
            bar.style.transform = 'scaleX(' + (h > 0 ? Math.min(scrollY / h, 1) : 0) + ')';
            toTop.classList.toggle('show', scrollY > 700);
            var cur = -1; secs.forEach(function (el, i) { if (el && el.getBoundingClientRect().top < 140) cur = i; });
            navA.forEach(function (a, i) { a.classList.toggle('active', i === cur); });
            tick2 = false;
        }
        window.addEventListener('scroll', function () { if (!tick2) { tick2 = true; requestAnimationFrame(onScroll); } }, { passive: true });
        toTop.addEventListener('click', function () { window.scrollTo({ top: 0, behavior: 'smooth' }); });

        /* ---- scroll reveal (removes itself afterwards so hover effects keep working) ---- */
        var items = document.querySelectorAll('.section-title-box, .content-card, .step-card, .cta-band, .faq-item, .trust-strip li, .experience-left, .experience-right, .bottom-pane-left, .bottom-pane-right, .footer-col');
        items.forEach(function (el, i) { el.classList.add('reveal'); el.style.transitionDelay = ((i % 4) * 0.1) + 's'; });
        if ('IntersectionObserver' in window) {
            var io = new IntersectionObserver(function (entries) {
                entries.forEach(function (en) {
                    if (!en.isIntersecting) return;
                    var el = en.target; el.classList.add('in'); io.unobserve(el);
                    setTimeout(function () { el.classList.remove('reveal', 'in'); el.style.transitionDelay = ''; }, 1400);
                });
            }, { threshold: .12 });
            items.forEach(function (el) { io.observe(el); });
        } else { items.forEach(function (el) { el.classList.remove('reveal'); }); }

        /* ---- animated counters ---- */
        document.querySelectorAll('[data-count]').forEach(function (el) {
            var target = parseInt(el.dataset.count, 10), suf = el.dataset.suffix || '';
            if (!('IntersectionObserver' in window) || quick) return;
            el.textContent = '0' + suf;
            var co = new IntersectionObserver(function (e) {
                if (!e[0].isIntersecting) return; co.disconnect();
                var t0 = performance.now();
                (function step(t) {
                    var k = Math.min((t - t0) / 1600, 1), v = 1 - Math.pow(1 - k, 3);
                    el.textContent = Math.round(target * v) + suf; if (k < 1) requestAnimationFrame(step);
                })(t0);
            }, { threshold: .6 });
            co.observe(el);
        });

        /* ---- card spotlight ---- */
        document.querySelectorAll('.content-card').forEach(function (c) {
            c.addEventListener('pointermove', function (e) {
                var r = c.getBoundingClientRect();
                c.style.setProperty('--mx', (e.clientX - r.left) + 'px'); c.style.setProperty('--my', (e.clientY - r.top) + 'px');
            });
        });

        /* ---- FAQ accordion ---- */
        document.querySelectorAll('.faq-q').forEach(function (btn) {
            btn.addEventListener('click', function () {
                var item = btn.parentElement, ans = item.querySelector('.faq-a'), open = item.classList.contains('open');
                document.querySelectorAll('.faq-item.open').forEach(function (o) { o.classList.remove('open'); o.querySelector('.faq-a').style.maxHeight = 0; o.querySelector('.faq-q').setAttribute('aria-expanded', 'false'); });
                if (!open) { item.classList.add('open'); ans.style.maxHeight = ans.scrollHeight + 'px'; btn.setAttribute('aria-expanded', 'true'); }
            });
        });

        /* ---- login button feedback ---- */
        var lf = $('drawerLoginForm');
        if (lf) lf.addEventListener('submit', function () {
            var b = lf.querySelector('.btn-drawer-submit');
            setTimeout(function () { b.innerHTML = '<i class="fa-solid fa-circle-notch fa-spin me-2"></i>Verifying\u2026'; b.style.pointerEvents = 'none'; }, 0);
        });
    })();
    </script>
</body>
</html>