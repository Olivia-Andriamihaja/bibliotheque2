<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Mes Pénalités</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            margin: 0;
            padding: 0;
            display: flex;
            min-height: 100vh;
            background: linear-gradient(135deg, #8B4513 0%, #D2691E 25%, #F4A460 50%, #DEB887 75%, #F5DEB3 100%);
            font-family: 'Georgia', 'Times New Roman', serif;
            position: relative;
        }

        /* Effet de texture papier ancien */
        body::before {
            content: '';
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: 
                radial-gradient(circle at 20% 80%, rgba(120, 119, 108, 0.2) 0%, transparent 50%),
                radial-gradient(circle at 80% 20%, rgba(255, 255, 255, 0.1) 0%, transparent 50%),
                radial-gradient(circle at 40% 40%, rgba(139, 69, 19, 0.15) 0%, transparent 50%);
            pointer-events: none;
            z-index: 1;
        }

        .sidebar {
            width: 280px;
            background: linear-gradient(180deg, #654321 0%, #8B4513 100%);
            color: #F5DEB3;
            min-height: 100vh;
            padding: 30px 20px;
            box-sizing: border-box;
            display: flex;
            flex-direction: column;
            align-items: flex-start;
            position: fixed;
            top: 0;
            left: 0;
            z-index: 1000;
            box-shadow: 4px 0 20px rgba(0,0,0,0.3);
            border-right: 3px solid #D2691E;
        }

        .sidebar::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: url("data:image/svg+xml,%3Csvg width='40' height='40' viewBox='0 0 40 40' xmlns='http://www.w3.org/2000/svg'%3E%3Cg fill='%23D2691E' fill-opacity='0.1'%3E%3Cpath d='M20 0L0 20L20 40L40 20L20 0Z'/%3E%3C/g%3E%3C/svg%3E");
            opacity: 0.3;
        }

        .sidebar-header {
            display: flex;
            align-items: center;
            margin-bottom: 40px;
            position: relative;
            z-index: 2;
        }

        .sidebar-logo {
            width: 50px;
            height: 50px;
            background: linear-gradient(145deg, #D2691E, #F4A460);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 15px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.3);
        }

        .sidebar-logo::before {
            content: '🏛️';
            font-size: 24px;
        }

        .sidebar h2 {
            color: #F5DEB3;
            margin: 0;
            font-size: 1.5em;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.5);
            position: relative;
            z-index: 2;
        }

        .sidebar a {
            display: block;
            color: #F5DEB3;
            text-decoration: none;
            margin: 12px 0;
            padding: 15px 20px;
            border-radius: 10px;
            transition: all 0.3s ease;
            position: relative;
            z-index: 2;
            background: rgba(255,255,255,0.1);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(245, 222, 179, 0.2);
            font-weight: 500;
        }

        .sidebar a::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: linear-gradient(45deg, transparent, rgba(245, 222, 179, 0.1), transparent);
            border-radius: 10px;
            opacity: 0;
            transition: opacity 0.3s ease;
        }

        .sidebar a:hover::before {
            opacity: 1;
        }

        .sidebar a.btn-emprunt {
            background: linear-gradient(145deg, #D2691E, #F4A460);
            color: #654321;
            font-weight: bold;
            box-shadow: 0 4px 8px rgba(0,0,0,0.2);
        }

        .sidebar a:hover, .sidebar .btn-emprunt:hover {
            background: linear-gradient(145deg, #F4A460, #D2691E);
            color: #654321;
            transform: translateX(5px);
            box-shadow: 0 6px 12px rgba(0,0,0,0.3);
        }

        .sidebar a.active {
            background: linear-gradient(145deg, #F4A460, #D2691E);
            color: #654321;
            font-weight: bold;
            box-shadow: 0 4px 8px rgba(0,0,0,0.2);
        }

        .btn-logout {
            background: linear-gradient(145deg, #8B0000, #DC143C);
            color: #F5DEB3;
            border: none;
            border-radius: 10px;
            padding: 15px 20px;
            margin-top: 30px;
            cursor: pointer;
            font-size: 1em;
            font-weight: bold;
            transition: all 0.3s ease;
            font-family: 'Georgia', serif;
            box-shadow: 0 4px 8px rgba(0,0,0,0.2);
            position: relative;
            z-index: 2;
            width: 100%;
        }

        .btn-logout:hover {
            background: linear-gradient(145deg, #DC143C, #8B0000);
            transform: translateY(-2px);
            box-shadow: 0 6px 12px rgba(0,0,0,0.3);
        }

        .main-content {
            flex: 1;
            padding: 40px;
            margin-left: 280px;
            position: relative;
            z-index: 2;
        }

        .main-header {
            background: linear-gradient(145deg, #FAEBD7, #F5F5DC);
            border-radius: 20px;
            padding: 30px;
            margin-bottom: 40px;
            box-shadow: 0 8px 20px rgba(0,0,0,0.2);
            border: 2px solid #D2691E;
            position: relative;
        }

        .main-header::before {
            content: '';
            position: absolute;
            top: -5px;
            left: -5px;
            right: -5px;
            bottom: -5px;
            background: linear-gradient(45deg, #D2691E, #F4A460, #D2691E);
            border-radius: 20px;
            z-index: -1;
            opacity: 0.3;
        }

        .main-header h1 {
            color: #654321;
            font-size: 2.5em;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.1);
            margin: 0;
            text-align: center;
            position: relative;
        }

        .main-header h1::before {
            content: '⚖️';
            margin-right: 20px;
            font-size: 0.8em;
        }

        .main-header h1::after {
            content: '';
            position: absolute;
            bottom: -10px;
            left: 50%;
            transform: translateX(-50%);
            width: 200px;
            height: 3px;
            background: linear-gradient(90deg, #8B4513, #D2691E, #8B4513);
            border-radius: 2px;
        }

        .penalite-container {
            background: linear-gradient(145deg, #FAEBD7, #F5F5DC);
            border: 3px solid #D2691E;
            border-radius: 20px;
            padding: 25px;
            box-shadow: 0 8px 20px rgba(0,0,0,0.2);
            margin-bottom: 20px;
            position: relative;
            overflow: hidden;
        }

        .penalite-container::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: linear-gradient(45deg, transparent, rgba(245, 222, 179, 0.3), transparent);
            opacity: 0;
            transition: opacity 0.3s ease;
        }

        .penalite-container:hover::before {
            opacity: 1;
        }

        .penalite-item {
            border: 2px solid #D2691E;
            border-radius: 15px;
            padding: 20px;
            margin-bottom: 15px;
            background: linear-gradient(145deg, #FAEBD7, #F5F5DC);
            box-shadow: 0 4px 8px rgba(0,0,0,0.2);
            position: relative;
            transition: all 0.3s ease;
            overflow: hidden;
        }

        .penalite-item:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 16px rgba(0,0,0,0.3);
        }

        .penalite-item.active {
            border-color: #DC143C;
            background: linear-gradient(145deg, #FFF8DC, #FAEBD7);
            box-shadow: 0 4px 8px rgba(220, 20, 60, 0.3);
        }

        .penalite-item.terminee {
            border-color: #A9A9A9;
            background: linear-gradient(145deg, #F5F5DC, #FAEBD7);
            opacity: 0.8;
        }

        .penalite-titre {
            font-size: 1.3em;
            font-weight: bold;
            margin-bottom: 10px;
            color: #654321;
            text-shadow: 1px 1px 2px rgba(0,0,0,0.1);
        }

        .penalite-titre::before {
            content: '⚠️ ';
            margin-right: 5px;
        }

        .penalite-info {
            margin-bottom: 10px;
            color: #8B4513;
            font-size: 1em;
        }

        .penalite-info::before {
            content: '📝 ';
            margin-right: 5px;
        }

        .penalite-status {
            padding: 10px 15px;
            border-radius: 10px;
            font-size: 0.9em;
            font-weight: bold;
            display: inline-block;
            position: relative;
            overflow: hidden;
        }

        .penalite-status::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: linear-gradient(45deg, transparent, rgba(255,255,255,0.2), transparent);
            opacity: 0;
            transition: opacity 0.3s ease;
        }

        .penalite-status:hover::before {
            opacity: 1;
        }

        .status-active {
            background: linear-gradient(145deg, #FFB6C1, #FFC0CB);
            color: #8B0000;
            border: 2px solid #DC143C;
        }

        .status-active::before {
            content: '🔒 ';
            font-size: 1.2em;
        }

        .status-terminee {
            background: linear-gradient(145deg, #90EE90, #98FB98);
            color: #006400;
            border: 2px solid #32CD32;
        }

        .status-terminee::before {
            content: '✅ ';
            font-size: 1.2em;
        }

        .alert {
            padding: 20px;
            margin-bottom: 30px;
            border-radius: 15px;
            font-size: 1.1em;
            font-weight: 500;
            position: relative;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }

        .alert-warning {
            color: #856404;
            background: linear-gradient(145deg, #fff3cd, #ffeeba);
            border: 2px solid #ffc107;
        }

        .alert-warning::before {
            content: '⚠️ ';
            font-size: 1.3em;
            margin-right: 10px;
        }

        .alert-info {
            color: #0c5460;
            background: linear-gradient(145deg, #d1ecf1, #bee5eb);
            border: 2px solid #17a2b8;
        }

        .alert-info::before {
            content: 'ℹ️ ';
            font-size: 1.3em;
            margin-right: 10px;
        }

        .no-penalites {
            text-align: center;
            padding: 40px;
            color: #654321;
            background: linear-gradient(145deg, #FAEBD7, #F5F5DC);
            border: 2px solid #D2691E;
            border-radius: 15px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.2);
        }

        .no-penalites h3 {
            font-size: 1.5em;
            margin-bottom: 10px;
            color: #654321;
        }

        .no-penalites p {
            font-size: 1.1em;
            color: #8B4513;
        }

        /* Responsive Design */
        @media (max-width: 1200px) {
            .penalite-container {
                padding: 20px;
            }
        }

        @media (max-width: 768px) {
            .sidebar {
                width: 100%;
                position: static;
                min-height: auto;
                padding: 20px;
            }
            
            .main-content {
                margin-left: 0;
                padding: 20px;
            }
            
            .main-header h1 {
                font-size: 2em;
            }
        }

        @media (max-width: 480px) {
            .penalite-container {
                padding: 15px;
            }
            
            .penalite-item {
                padding: 15px;
            }
            
            .main-header {
                padding: 20px;
            }
            
            .main-header h1 {
                font-size: 1.6em;
            }
        }
    </style>
</head>
<body>
    <div class="sidebar">
        <div class="sidebar-header">
            <div class="sidebar-logo"></div>
            <h2>Menu</h2>
        </div>
        <a href="${pageContext.request.contextPath}/livres">🏠 Accueil</a>
        <c:if test="${isAdmin}">
            <a href="${pageContext.request.contextPath}/emprunt/nouveau" class="btn-emprunt">📖 Emprunter un livre</a>
            <a href="${pageContext.request.contextPath}/emprunt/retour-sur-place">📚 Retour lecture sur place</a>
            <a href="${pageContext.request.contextPath}/emprunt/prolongement">⏰ Prolonger un emprunt</a>
            <a href="${pageContext.request.contextPath}/penalite/gestion">⚖️ Gestion des pénalités</a>
        </c:if>
        <a href="${pageContext.request.contextPath}/reservation/mes-reservations">📋 Mes réservations</a>
        <a href="${pageContext.request.contextPath}/penalite/mes-penalites" class="active">💰 Mes pénalités</a>
        <form action="${pageContext.request.contextPath}/logout" method="post" style="margin:0;">
            <button type="submit" class="btn-logout">🚪 Déconnexion</button>
        </form>
    </div>
    
    <div class="main-content">
        <div class="main-header">
            <h1>Mes Pénalités</h1>
        </div>
        
        <c:if test="${not empty penalitesActives}">
            <div class="alert alert-warning">
                <strong>Attention !</strong> Vous avez ${penalitesActives.size()} pénalité(s) active(s). 
                Vous ne pouvez pas emprunter de nouveaux livres tant que vos pénalités sont en cours.
            </div>
        </c:if>

        <c:if test="${empty penalitesActives}">
            <div class="alert alert-info">
                <strong>Aucune pénalité active</strong> - Vous pouvez emprunter des livres normalement.
            </div>
        </c:if>
        
        <div class="penalite-container">
            <h2>Historique des pénalités</h2>
            
            <c:choose>
                <c:when test="${empty penalites}">
                    <div class="no-penalites">
                        <h3>Aucune pénalité</h3>
                        <p>Vous n'avez jamais eu de pénalité. Continuez à rendre vos livres à temps !</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <c:forEach items="${penalites}" var="penalite">
                        <div class="penalite-item ${penalite.statut == 'ACTIVE' ? 'active' : 'terminee'}">
                            <div class="penalite-titre">
                                Pénalité pour "${penalite.emprunt.livre.titre}"
                            </div>
                            
                            <div class="penalite-info">
                                <strong>Motif :</strong> ${penalite.motif}
                            </div>
                            
                            <div class="penalite-info">
                                <strong>Durée :</strong> ${penalite.dureePenaliteJours} jours
                                (${penalite.joursRetard} jours de retard)
                            </div>
                            
                            <div class="penalite-info">
                                <strong>Période :</strong> 
                                Du ${penalite.dateDebutPenalite.toLocalDate()} au ${penalite.dateFinPenalite.toLocalDate()}
                            </div>
                            
                            <div class="penalite-status ${penalite.statut == 'ACTIVE' ? 'status-active' : 'status-terminee'}">
                                <c:choose>
                                    <c:when test="${penalite.statut == 'ACTIVE'}">
                                        <c:choose>
                                            <c:when test="${penalite.active}">Pénalité en cours</c:when>
                                            <c:otherwise>Pénalité expirée (en cours de mise à jour)</c:otherwise>
                                        </c:choose>
                                    </c:when>
                                    <c:otherwise>Pénalité terminée</c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</body>
</html>