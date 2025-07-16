<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Mes Réservations</title>
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
            color: #4c57af;
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
            background: #6f4caf;
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
            background: #4c5caf;
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
        
        .reservation-container {
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            background: #fff;
        }
        
        .reservation-item {
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 15px;
            margin-bottom: 15px;
            background: #fff;
            display: flex;
            align-items: center;
            gap: 20px;
            transition: transform 0.2s, box-shadow 0.2s;
        }
        
        .reservation-item:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
        }
        
        .reservation-item.active {
            border-color: #4c4caf;
            background: #f8fff8;
        }
        
        .reservation-item.cancelled {
            border-color: #e74c3c;
            background: #fff8f8;
            opacity: 0.7;
        }
        
        .livre-image-small {
            width: 80px;
            height: 120px;
            object-fit: cover;
            border-radius: 4px;
            flex-shrink: 0;
        }
        
        .reservation-details {
            flex: 1;
        }
        
        .livre-titre {
            font-size: 18px;
            font-weight: bold;
            margin-bottom: 5px;
            color: #333;
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
        
        .reservation-info {
            font-size: 0.9em;
            color: #555;
        }
        
        .reservation-date {
            font-weight: bold;
        }
        
        .reservation-status {
            padding: 8px 12px;
            border-radius: 4px;
            font-size: 0.85em;
            font-weight: bold;
            display: inline-block;
            margin-bottom: 10px;
        }
        
        .status-active {
            background: #d4edda;
            color: #155724;
        }
        
        .status-cancelled {
            background: #f8d7da;
            color: #721c24;
        }
        
        .reservation-actions {
            display: flex;
            flex-direction: column;
            gap: 10px;
            align-items: flex-end;
        }
        
        .btn-annuler {
            background: #e74c3c;
            color: #fff;
            border: none;
            padding: 10px 20px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 0.9em;
            font-weight: bold;
            transition: background 0.2s;
        }
        
        .btn-annuler:hover {
            background: #c0392b;
        }
        
        .btn-retour {
            background: #4CAF50;
            color: #fff;
            border: none;
            padding: 10px 20px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 0.9em;
            font-weight: bold;
            transition: background 0.2s;
            text-decoration: none;
            display: inline-block;
        }
        
        .btn-retour:hover {
            background: #45a049;
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
        
        .no-reservations {
            text-align: center;
            padding: 40px;
            color: #666;
            font-size: 1em;
        }
        
        .no-reservations h3 {
            margin-bottom: 10px;
            font-size: 1.2em;
            color: #888;
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
            
            .reservation-container {
                padding: 15px;
            }
            
            .reservation-item {
                flex-direction: column;
                align-items: flex-start;
                gap: 10px;
            }
            
            .reservation-actions {
                align-items: stretch;
                width: 100%;
            }
            
            .btn-annuler, .btn-retour {
                width: 100%;
            }
        }
        
        @media (max-width: 480px) {
            .reservation-container {
                padding: 10px;
            }
            
            .reservation-item {
                padding: 12px;
            }
            
            .livre-image-small {
                width: 60px;
                height: 90px;
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
        <a href="${pageContext.request.contextPath}/reservation/mes-reservations" class="active">Mes réservations</a>
        <a href="${pageContext.request.contextPath}/penalite/mes-penalites">Mes pénalités</a>
        <form action="${pageContext.request.contextPath}/logout" method="post" style="margin:0;">
            <button type="submit" class="btn-logout">Déconnexion</button>
        </form>
    </div>
    
    <div class="main-content">
        <h1>Mes Réservations</h1>
        
        <!-- Messages d'alerte -->
        <c:if test="${not empty success}">
            <div class="alert alert-success">${success}</div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="alert alert-error">${error}</div>
        </c:if>
        
        <a href="${pageContext.request.contextPath}/livres" class="btn-retour">← Retour à la liste des livres</a>
        
        <div class="reservation-container">
            <c:choose>
                <c:when test="${empty reservations}">
                    <div class="no-reservations">
                        <h3>Aucune réservation</h3>
                        <p>Vous n'avez pas encore fait de réservation.</p>
                        <a href="${pageContext.request.contextPath}/livres" class="btn-retour">Voir les livres disponibles</a>
                    </div>
                </c:when>
                <c:otherwise>
                    <c:forEach items="${reservations}" var="reservation">
                        <div class="reservation-item ${reservation.statut == 'ACTIVE' ? 'active' : 'cancelled'}">
                            <img src="${reservation.livre.image}" alt="${reservation.livre.titre}" class="livre-image-small">
                            
                            <div class="reservation-details">
                                <div class="livre-titre">${reservation.livre.titre}</div>
                                <div class="livre-auteur">par ${reservation.livre.auteur}</div>
                                <div class="livre-numero">N° ${reservation.livre.numExemplaire}</div>
                                
                                <div class="reservation-status ${reservation.statut == 'ACTIVE' ? 'status-active' : 'status-cancelled'}">
                                    <c:choose>
                                        <c:when test="${reservation.statut == 'ACTIVE'}">Réservation active</c:when>
                                        <c:otherwise>Réservation annulée</c:otherwise>
                                    </c:choose>
                                </div>
                                
                                <div class="reservation-info">
                                    <div class="reservation-date">
                                        Réservé le : ${reservation.dateReservation}
                                    </div>
                                </div>
                            </div>
                            
                            <div class="reservation-actions">
                                <c:if test="${reservation.statut == 'ACTIVE'}">
                                    <form action="${pageContext.request.contextPath}/reservation/annuler/${reservation.id}" method="post">
                                        <button type="submit" class="btn-annuler" 
                                                onclick="return confirm('Êtes-vous sûr de vouloir annuler cette réservation ?')">
                                            Annuler
                                        </button>
                                    </form>
                                </c:if>
                            </div>
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</body>
</html>