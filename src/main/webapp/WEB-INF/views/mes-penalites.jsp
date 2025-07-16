<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Mes Pénalités</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            display: flex;
            min-height: 100vh;
            background: #f7f7f7;
            font-family: Arial, sans-serif;
        }
        
        .sidebar {
            width: 220px;
            background: #222;
            color: #fff;
            min-height: 100vh;
            padding: 30px 10px;
            box-sizing: border-box;
            display: flex;
            flex-direction: column;
            align-items: flex-start;
            position: fixed;
            top: 0;
            left: 0;
            z-index: 1000;
        }
        
        .sidebar h2 {
            color: #4CAF50;
            margin-bottom: 30px;
            margin-top: 0;
        }
        
        .sidebar a {
            display: block;
            color: #fff;
            text-decoration: none;
            margin: 8px 0;
            padding: 10px 15px;
            border-radius: 4px;
            transition: background 0.2s;
            width: calc(100% - 30px);
            box-sizing: border-box;
        }
        
        .sidebar a.btn-emprunt {
            background: #4CAF50;
            color: #fff;
            font-weight: bold;
        }
        
        .sidebar a:hover, .sidebar .btn-emprunt:hover {
            background: #333;
        }
        
        .sidebar .btn-emprunt:hover {
            background: #388e3c;
        }
        
        .sidebar a.active {
            background: #4CAF50;
        }
        
        .sidebar form {
            margin-top: auto;
            width: 100%;
        }
        
        .btn-logout {
            width: 100%;
            padding: 10px 15px;
            background: #d32f2f;
            color: #fff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-weight: bold;
            transition: background 0.2s;
        }
        
        .btn-logout:hover {
            background: #b71c1c;
        }
        
        .main-content {
            margin-left: 220px;
            flex: 1;
            padding: 30px;
            box-sizing: border-box;
        }
        
        .main-content h1 {
            color: #333;
            margin-bottom: 30px;
            margin-top: 0;
        }
        
        .penalite-container {
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            background: #fff;
        }
        
        h2 {
            color: #4CAF50;
            font-size: 24px;
            margin-bottom: 20px;
        }
        
        .penalite-item {
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 15px;
            margin-bottom: 15px;
            background: #fff;
            transition: transform 0.2s, box-shadow 0.2s;
        }
        
        .penalite-item:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
        }
        
        .penalite-item.active {
            border-color: #e74c3c;
            background: #fff5f5;
        }
        
        .penalite-item.terminee {
            border-color: #95a5a6;
            background: #f8f9fa;
            opacity: 0.8;
        }
        
        .penalite-titre {
            font-size: 18px;
            font-weight: bold;
            margin-bottom: 10px;
            color: #e74c3c;
        }
        
        .penalite-info {
            margin-bottom: 10px;
            font-size: 0.9em;
            color: #333;
        }
        
        .penalite-status {
            padding: 5px 12px;
            border-radius: 4px;
            font-size: 0.8em;
            font-weight: bold;
            display: inline-block;
        }
        
        .status-active {
            background: #f8d7da;
            color: #721c24;
        }
        
        .status-terminee {
            background: #d4edda;
            color: #155724;
        }
        
        .alert {
            padding: 15px;
            margin-bottom: 20px;
            border: 1px solid transparent;
            border-radius: 4px;
            font-weight: bold;
        }
        
        .alert-warning {
            color: #856404;
            background-color: #fff3cd;
            border-color: #ffeaa7;
        }
        
        .alert-info {
            color: #0c5460;
            background-color: #d1ecf1;
            border-color: #bee5eb;
        }
        
        .no-penalites {
            text-align: center;
            padding: 40px;
            color: #666;
            font-size: 1em;
        }
        
        .no-penalites h3 {
            margin-bottom: 10px;
            font-size: 1.2em;
        }
        
        /* Responsive */
        @media (max-width: 768px) {
            .sidebar {
                position: static;
                width: 100%;
                min-height: auto;
                padding: 20px;
            }
            
            .main-content {
                margin-left: 0;
                padding: 20px;
            }
            
            body {
                flex-direction: column;
            }
            
            .penalite-container {
                padding: 15px;
            }
        }
        
        @media (max-width: 480px) {
            .penalite-container {
                padding: 10px;
            }
            
            .penalite-item {
                padding: 12px;
            }
        }
    </style>
</head>
<body>
    <div class="sidebar">
        <h2>Menu</h2>
        <a href="${pageContext.request.contextPath}/livres">Accueil</a>
        <c:if test="${isAdmin}">
            <a href="${pageContext.request.contextPath}/emprunt/nouveau" class="btn-emprunt">Emprunter un livre</a>
            <a href="${pageContext.request.contextPath}/emprunt/retour-sur-place">Retour lecture sur place</a>
            <a href="${pageContext.request.contextPath}/emprunt/prolongement">Prolonger un emprunt</a>
            <a href="${pageContext.request.contextPath}/penalite/gestion">Gestion des pénalités</a>
        </c:if>
        <a href="${pageContext.request.contextPath}/reservation/mes-reservations">Mes réservations</a>
        <a href="${pageContext.request.contextPath}/penalite/mes-penalites" class="active">Mes pénalités</a>
        <form action="${pageContext.request.contextPath}/logout" method="post" style="margin:0;">
            <button type="submit" class="btn-logout">Déconnexion</button>
        </form>
    </div>
    
    <div class="main-content">
        <h1>Mes Pénalités</h1>
        
        <c:if test="${not empty penalitesActives}">
            <div class="alert alert-warning">
                <strong>⚠️ Attention !</strong> Vous avez ${penalitesActives.size()} pénalité(s) active(s). 
                Vous ne pouvez pas emprunter de nouveaux livres tant que vos pénalités sont en cours.
            </div>
        </c:if>

        <c:if test="${empty penalitesActives}">
            <div class="alert alert-info">
                <strong>✅ Aucune pénalité active</strong> - Vous pouvez emprunter des livres normalement.
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