<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Mes Réservations - Bibliothèque</title>
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
            transform: translateX(5px);
            box-shadow: 0 6px 12px rgba(0,0,0,0.3);
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
            content: '📋';
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

        .alert {
            padding: 20px;
            margin-bottom: 30px;
            border-radius: 15px;
            font-size: 1.1em;
            font-weight: 500;
            position: relative;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }

        .alert-success {
            color: #155724;
            background: linear-gradient(145deg, #d4edda, #c3e6cb);
            border: 2px solid #28a745;
        }

        .alert-success::before {
            content: '✅ ';
            font-size: 1.3em;
            margin-right: 10px;
        }

        .alert-error {
            color: #721c24;
            background: linear-gradient(145deg, #f8d7da, #f5c6cb);
            border: 2px solid #dc3545;
        }

        .alert-error::before {
            content: '❌ ';
            font-size: 1.3em;
            margin-right: 10px;
        }

        /* Bouton de retour */
        .btn-retour {
            background: linear-gradient(145deg, #6c757d, #5a6268);
            color: white;
            border: none;
            padding: 15px 25px;
            border-radius: 10px;
            cursor: pointer;
            font-size: 1em;
            font-weight: bold;
            transition: all 0.3s ease;
            font-family: 'Georgia', serif;
            box-shadow: 0 4px 8px rgba(0,0,0,0.2);
            margin-bottom: 30px;
            text-decoration: none;
            display: inline-block;
            position: relative;
            overflow: hidden;
        }

        .btn-retour::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.3), transparent);
            transition: left 0.6s ease;
        }

        .btn-retour:hover::before {
            left: 100%;
        }

        .btn-retour:hover {
            background: linear-gradient(145deg, #5a6268, #6c757d);
            transform: translateY(-2px);
            box-shadow: 0 6px 12px rgba(0,0,0,0.3);
        }

        /* Conteneur des réservations */
        .reservation-container {
            background: linear-gradient(145deg, #FAEBD7, #F5F5DC);
            border-radius: 20px;
            padding: 30px;
            box-shadow: 0 8px 20px rgba(0,0,0,0.2);
            border: 2px solid #D2691E;
            position: relative;
        }

        /* Item de réservation */
        .reservation-item {
            background: linear-gradient(145deg, #FFF8DC, #FAEBD7);
            border: 2px solid #D2691E;
            border-radius: 15px;
            padding: 25px;
            margin-bottom: 25px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 25px;
        }

        .reservation-item:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 16px rgba(0,0,0,0.2);
        }

        .reservation-item.active {
            border-color: #228B22;
            background: linear-gradient(145deg, #F0FFF0, #F5FFFA);
        }

        .reservation-item.cancelled {
            border-color: #8B0000;
            background: linear-gradient(145deg, #FFF0F5, #FFE4E1);
            opacity: 0.8;
        }

        /* Image du livre */
        .livre-image-small {
            width: 100px;
            height: 150px;
            object-fit: cover;
            border-radius: 10px;
            flex-shrink: 0;
            box-shadow: 0 4px 8px rgba(0,0,0,0.2);
            transition: transform 0.3s ease;
        }

        .reservation-item:hover .livre-image-small {
            transform: scale(1.05);
        }

        /* Détails de la réservation */
        .reservation-details {
            flex: 1;
        }

        .livre-titre {
            font-size: 1.4em;
            font-weight: bold;
            color: #654321;
            margin-bottom: 8px;
            text-shadow: 1px 1px 2px rgba(0,0,0,0.1);
        }

        .livre-auteur {
            color: #8B4513;
            font-style: italic;
            font-size: 1.1em;
            margin-bottom: 8px;
        }

        .livre-auteur::before {
            content: '✍️ ';
            margin-right: 5px;
        }

        .livre-numero {
            color: #A0522D;
            font-size: 0.95em;
            margin-bottom: 15px;
            padding: 5px 10px;
            background: rgba(160, 82, 45, 0.1);
            border-radius: 8px;
            display: inline-block;
        }

        .livre-numero::before {
            content: '🏷️ ';
            margin-right: 5px;
        }

        /* Statut de réservation */
        .reservation-status {
            padding: 10px 15px;
            border-radius: 10px;
            font-size: 0.95em;
            font-weight: bold;
            display: inline-block;
            margin-bottom: 15px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        .status-active {
            background: linear-gradient(145deg, #90EE90, #98FB98);
            color: #006400;
            border: 2px solid #32CD32;
        }

        .status-active::before {
            content: '✅ ';
        }

        .status-cancelled {
            background: linear-gradient(145deg, #FFB6C1, #FFC0CB);
            color: #8B0000;
            border: 2px solid #DC143C;
        }

        .status-cancelled::before {
            content: '❌ ';
        }

        /* Informations de réservation */
        .reservation-info {
            font-size: 0.95em;
            color: #8B4513;
        }

        .reservation-date {
            font-weight: bold;
        }

        /* Actions */
        .reservation-actions {
            display: flex;
            flex-direction: column;
            gap: 15px;
            align-items: flex-end;
        }

        .btn-annuler {
            background: linear-gradient(145deg, #DC143C, #8B0000);
            color: white;
            border: none;
            padding: 12px 20px;
            border-radius: 10px;
            cursor: pointer;
            font-size: 1em;
            font-weight: bold;
            transition: all 0.3s ease;
            font-family: 'Georgia', serif;
            box-shadow: 0 4px 8px rgba(0,0,0,0.2);
            position: relative;
            overflow: hidden;
        }

        .btn-annuler::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.3), transparent);
            transition: left 0.6s ease;
        }

        .btn-annuler:hover::before {
            left: 100%;
        }

        .btn-annuler:hover {
            background: linear-gradient(145deg, #8B0000, #DC143C);
            transform: translateY(-2px);
            box-shadow: 0 6px 12px rgba(0,0,0,0.3);
        }

        /* Aucune réservation */
        .no-reservations {
            text-align: center;
            padding: 50px;
            color: #8B4513;
        }

        .no-reservations h3 {
            margin-bottom: 15px;
            color: #654321;
            font-size: 1.5em;
        }

        .no-reservations p {
            font-size: 1.1em;
            margin-bottom: 20px;
        }

        /* Responsive Design */
        @media (max-width: 1200px) {
            .reservation-item {
                gap: 20px;
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
            
            .reservation-item {
                flex-direction: column;
                text-align: center;
                gap: 15px;
            }
            
            .reservation-actions {
                align-items: center;
                width: 100%;
            }
            
            .main-header h1 {
                font-size: 2em;
            }
        }

        @media (max-width: 480px) {
            .reservation-item {
                padding: 15px;
            }
            
            .main-header {
                padding: 20px;
            }
            
            .main-header h1 {
                font-size: 1.6em;
            }
            
            .livre-image-small {
                width: 80px;
                height: 120px;
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
        <a href="${pageContext.request.contextPath}/reservation/mes-reservations" class="active">📋 Mes réservations</a>
        <a href="${pageContext.request.contextPath}/penalite/mes-penalites">💰 Mes pénalités</a>
        <form action="${pageContext.request.contextPath}/logout" method="post" style="margin:0;">
            <button type="submit" class="btn-logout">🚪 Déconnexion</button>
        </form>
    </div>
    
    <div class="main-content">
        <div class="main-header">
            <h1>Mes Réservations</h1>
        </div>
        
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
                                        Réservé le : <fmt:formatDate value="${reservation.dateReservation}" pattern="dd/MM/yyyy HH:mm" />
                                    </div>
                                </div>
                            </div>
                            
                            <div class="reservation-actions">
                                <c:if test="${reservation.statut == 'ACTIVE'}">
                                    <form action="${pageContext.request.contextPath}/reservation/annuler/${reservation.id}" method="post">
                                        <button type="submit" class="btn-annuler" 
                                                onclick="return confirm('Êtes-vous sûr de vouloir annuler cette réservation ?')">
                                            🗑️ Annuler
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