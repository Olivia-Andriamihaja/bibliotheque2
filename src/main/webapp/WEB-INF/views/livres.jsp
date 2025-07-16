<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Liste des Livres</title>
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
            color: #5c4caf;
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
            background: #4c74af;
            color: #fff;
            font-weight: bold;
        }
        
        .sidebar a:hover, .sidebar .btn-emprunt:hover {
            background: #333;
        }
        
        .sidebar .btn-emprunt:hover {
            background: #39388e;
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
        
        .livre-container {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 20px;
            padding: 0;
        }
        
        .livre-card {
            border: 1px solid #ddd;
            padding: 15px;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            background: #fff;
            position: relative;
            transition: transform 0.2s, box-shadow 0.2s;
        }
        
        .livre-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
        }
        
        .livre-card.reserved {
            border-color: #f39c12;
            background: #fef9e7;
        }
        
        .livre-image {
            width: 100%;
            height: 200px;
            object-fit: cover;
            border-radius: 4px;
            margin-bottom: 10px;
        }
        
        .livre-info {
            margin-top: 10px;
        }
        
        .livre-titre {
            font-size: 18px;
            font-weight: bold;
            margin: 8px 0;
            color: #333;
            line-height: 1.3;
        }
        
        .livre-auteur {
            color: #666;
            font-style: italic;
            margin-bottom: 5px;
        }
        
        .livre-numero {
            color: #888;
            font-size: 0.9em;
            margin-bottom: 10px;
        }
        
        .livre-actions {
            margin-top: 15px;
            text-align: center;
        }
        
        .btn-reserver {
            background: #4c51af;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 0.9em;
            font-weight: bold;
            transition: background 0.2s;
            width: 100%;
        }
        
        .btn-reserver:hover {
            background: #454ba0;
        }
        
        .btn-annuler {
            background: #e74c3c;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 0.9em;
            font-weight: bold;
            transition: background 0.2s;
            width: 100%;
        }
        
        .btn-annuler:hover {
            background: #c0392b;
        }
        
        .btn-disabled {
            background: #bdc3c7;
            color: #7f8c8d;
            cursor: not-allowed;
            width: 100%;
            padding: 10px 20px;
            border-radius: 4px;
            font-size: 0.9em;
            font-weight: bold;
        }
        
        .reservation-status {
            margin-top: 10px;
            padding: 8px 12px;
            border-radius: 4px;
            font-size: 0.85em;
            font-weight: bold;
            text-align: center;
        }
        
        .status-libre {
            background: #d4edda;
            color: #191557;
        }
        
        .status-reserve {
            background: #f8d7da;
            color: #721c24;
        }
        
        .status-mes-reservations {
            background: #fff3cd;
            color: #856404;
        }
        
        .alert {
            padding: 15px;
            margin-bottom: 20px;
            border: 1px solid transparent;
            border-radius: 4px;
            font-weight: bold;
        }
        
        .alert-success {
            color: #155724;
            background-color: #d4edda;
            border-color: #c3e6cb;
        }
        
        .alert-error {
            color: #721c24;
            background-color: #f8d7da;
            border-color: #f5c6cb;
        }
        
        /* Responsive */
        @media (max-width: 1024px) {
            .livre-container {
                grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            }
        }
        
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
            
            .livre-container {
                grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
                gap: 15px;
            }
            
            .livre-card {
                padding: 12px;
            }
            
            .livre-image {
                height: 150px;
            }
        }
        
        @media (max-width: 480px) {
            .livre-container {
                grid-template-columns: 1fr;
            }
            
            .main-content {
                padding: 15px;
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
            <a href="${pageContext.request.contextPath}/penalite/parametres">Paramètres des pénalités</a>
            <a href="${pageContext.request.contextPath}/abonnement/nouveau-abonnement">Ajouter un abonnement</a>
            <a href="${pageContext.request.contextPath}/emprunt/retour-emporter">Rendre a emporter</a>
        </c:if>
        <a href="${pageContext.request.contextPath}/reservation/mes-reservations">Mes réservations</a>
        <a href="${pageContext.request.contextPath}/penalite/mes-penalites">Mes pénalités</a>
        <form action="${pageContext.request.contextPath}/logout" method="post">
            <button type="submit" class="btn-logout">Déconnexion</button>
        </form>
    </div>
    
    <div class="main-content">
        <h1>Bibliothèque - Liste des Livres</h1>
        
        <!-- Messages d'alerte -->
        <c:if test="${not empty success}">
            <div class="alert alert-success">${success}</div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="alert alert-error">${error}</div>
        </c:if>
        
        <div class="livre-container">
            <c:forEach items="${livres}" var="livre">
                <c:set var="reservation" value="${reservationsParLivre[livre.id]}" />
                <div class="livre-card ${reservation != null ? 'reserved' : ''}">
                    <img src="${livre.image}" alt="${livre.titre}" class="livre-image">
                    <div class="livre-info">
                        <div class="livre-titre">${livre.titre}</div>
                        <div class="livre-auteur">par ${livre.auteur}</div>
                        <div class="livre-numero">N° ${livre.numExemplaire}</div>
                        
                        <!-- Statut de réservation -->
                        <c:choose>
                            <c:when test="${reservation != null}">
                                <c:choose>
                                    <c:when test="${reservation.utilisateur.id == currentUser.id}">
                                        <div class="reservation-status status-mes-reservations">
                                            Réservé par vous
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="reservation-status status-reserve">
                                            Déjà réservé
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </c:when>
                            <c:otherwise>
                                <div class="reservation-status status-libre">
                                    Disponible
                                </div>
                            </c:otherwise>
                        </c:choose>
                        
                        <!-- Actions -->
                        <div class="livre-actions">
                            <c:choose>
                                <c:when test="${reservation != null && reservation.utilisateur.id == currentUser.id}">
                                    <!-- L'utilisateur a réservé ce livre -->
                                    <form action="${pageContext.request.contextPath}/reservation/annuler/${reservation.id}" method="post" style="display: inline; width: 100%;">
                                        <button type="submit" class="btn-annuler" onclick="return confirm('Êtes-vous sûr de vouloir annuler cette réservation ?')">
                                            Annuler la réservation
                                        </button>
                                    </form>
                                </c:when>
                                <c:when test="${reservation != null}">
                                    <!-- Le livre est réservé par quelqu'un d'autre -->
                                    <button class="btn-reserver btn-disabled" disabled>
                                        Déjà réservé
                                    </button>
                                </c:when>
                                <c:otherwise>
                                    <!-- Le livre est disponible -->
                                    <form action="${pageContext.request.contextPath}/reservation/creer" method="post" style="display: inline; width: 100%;">
                                        <input type="hidden" name="livreId" value="${livre.id}">
                                        <button type="submit" class="btn-reserver">
                                            Réserver
                                        </button>
                                    </form>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</body>
</html>