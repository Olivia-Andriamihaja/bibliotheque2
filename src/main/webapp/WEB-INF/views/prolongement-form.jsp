<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Prolongement d'Emprunt</title>
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
            pointer-events: none;
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
            pointer-events: none;
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
            pointer-events: none;
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
            content: '⏰';
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

        .form-container {
            background: linear-gradient(145deg, #FAEBD7, #F5F5DC);
            border: 3px solid #D2691E;
            border-radius: 20px;
            padding: 25px;
            box-shadow: 0 8px 20px rgba(0,0,0,0.2);
            max-width: 800px;
            position: relative;
            overflow: hidden;
        }

        .form-container::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: linear-gradient(45deg, transparent, rgba(245, 222, 179, 0.3), transparent);
            opacity: 0;
            transition: opacity 0.3s ease;
            pointer-events: none; /* FIX: Ajout de pointer-events: none */
        }

        .form-container:hover::before {
            opacity: 1;
        }

        .form-group {
            margin-bottom: 20px;
            position: relative;
            z-index: 2; /* FIX: Ajout de z-index pour s'assurer que les éléments sont au-dessus */
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
            color: #654321;
            text-shadow: 1px 1px 2px rgba(0,0,0,0.1);
        }

        .form-group select,
        .form-group input {
            width: 100%;
            padding: 12px;
            border: 2px solid #D2691E;
            border-radius: 10px;
            font-size: 16px;
            background: rgba(255,255,255,0.9); /* FIX: Changé de 0.1 à 0.9 pour plus d'opacité */
            color: #654321;
            font-family: 'Georgia', serif;
            transition: all 0.3s ease;
            position: relative;
            z-index: 3; /* FIX: Z-index plus élevé pour les champs de saisie */
        }

        .form-group select:focus,
        .form-group input:focus {
            outline: none;
            border-color: #F4A460;
            box-shadow: 0 4px 8px rgba(0,0,0,0.2);
            background: rgba(255,255,255,1); /* FIX: Fond complètement opaque au focus */
        }

        .btn-submit {
            background: linear-gradient(145deg, #228B22, #32CD32);
            color: white;
            border: none;
            padding: 12px 24px;
            border-radius: 10px;
            cursor: pointer;
            font-size: 1em;
            font-weight: bold;
            transition: all 0.3s ease;
            font-family: 'Georgia', serif;
            box-shadow: 0 4px 8px rgba(0,0,0,0.2);
            position: relative;
            overflow: hidden;
            z-index: 2; /* FIX: Z-index pour le bouton */
        }

        .btn-submit::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.3), transparent);
            transition: left 0.6s ease;
            pointer-events: none;
        }

        .btn-submit:hover::before {
            left: 100%;
        }

        .btn-submit:hover {
            background: linear-gradient(145deg, #32CD32, #228B22);
            transform: translateY(-2px);
            box-shadow: 0 6px 12px rgba(0,0,0,0.3);
        }

        .btn-retour {
            background: linear-gradient(145deg, #A9A9A9, #808080);
            color: #F5F5F5;
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
            text-decoration: none;
            display: inline-block;
            z-index: 2;
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
            pointer-events: none;
        }

        .btn-retour:hover::before {
            left: 100%;
        }

        .btn-retour:hover {
            background: linear-gradient(145deg, #808080, #A9A9A9);
            transform: translateY(-2px);
            box-shadow: 0 6px 12px rgba(0,0,0,0.3);
        }

        .alert {
            padding: 20px;
            margin-bottom: 30px;
            border-radius: 15px;
            font-size: 1.1em;
            font-weight: 500;
            position: relative;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            z-index: 2;
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

        .emprunt-details {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px;
            border: 2px solid #D2691E;
            border-radius: 15px;
            margin-bottom: 15px;
            background: linear-gradient(145deg, #FAEBD7, #F5F5DC);
            box-shadow: 0 4px 8px rgba(0,0,0,0.2);
            position: relative;
            transition: all 0.3s ease;
            overflow: hidden;
            z-index: 2;
        }

        .emprunt-details:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 16px rgba(0,0,0,0.3);
        }

        .emprunt-details::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: linear-gradient(45deg, transparent, rgba(245, 222, 179, 0.3), transparent);
            opacity: 0;
            transition: opacity 0.3s ease;
            pointer-events: none;
        }

        .emprunt-details:hover::before {
            opacity: 1;
        }

        .emprunt-left {
            flex: 1;
            position: relative;
            z-index: 2;
        }

        .emprunt-right {
            text-align: right;
            color: #8B4513;
            font-size: 0.9em;
            position: relative;
            z-index: 2;
        }

        .livre-titre {
            font-weight: bold;
            color: #654321;
            font-size: 1.2em;
            text-shadow: 1px 1px 2px rgba(0,0,0,0.1);
        }

        .livre-auteur {
            color: #8B4513;
            font-style: italic;
            font-size: 1em;
        }

        .livre-auteur::before {
            content: '✍️ ';
            margin-right: 5px;
        }

        .emprunteur-nom {
            color: #228B22;
            font-weight: bold;
            font-size: 1em;
        }

        .emprunteur-nom::before {
            content: '👤 ';
            margin-right: 5px;
        }

        .date-fin {
            color: #DC143C;
            font-weight: bold;
        }

        .no-emprunts {
            text-align: center;
            padding: 40px;
            color: #654321;
            background: linear-gradient(145deg, #FAEBD7, #F5F5DC);
            border: 2px solid #D2691E;
            border-radius: 15px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.2);
            z-index: 2;
            position: relative;
        }

        .no-emprunts h3 {
            font-size: 1.5em;
            margin-bottom: 10px;
            color: #654321;
        }

        .no-emprunts p {
            font-size: 1.1em;
            color: #8B4513;
        }

        /* Responsive Design */
        @media (max-width: 1200px) {
            .form-container {
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
            
            .emprunt-details {
                flex-direction: column;
                align-items: flex-start;
            }
            
            .emprunt-right {
                text-align: left;
                margin-top: 10px;
            }
        }

        @media (max-width: 480px) {
            .form-container {
                padding: 15px;
            }
            
            .emprunt-details {
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
            <a href="${pageContext.request.contextPath}/emprunt/prolongement" class="active">⏰ Prolongement d'emprunt</a>
            <a href="${pageContext.request.contextPath}/penalite/gestion">⚖️ Gestion des pénalités</a>
        </c:if>
        <a href="${pageContext.request.contextPath}/reservation/mes-reservations">📋 Mes réservations</a>
        <a href="${pageContext.request.contextPath}/penalite/mes-penalites">💰 Mes pénalités</a>
        <form action="${pageContext.request.contextPath}/logout" method="post" style="margin:0;">
            <button type="submit" class="btn-logout">🚪 Déconnexion</button>
        </form>
    </div>
    
    <div class="main-content">
        <div class="main-header">
            <h1>Prolongement d'Emprunt</h1>
        </div>
        
        <!-- Messages d'alerte -->
        <c:if test="${not empty success}">
            <div class="alert alert-success">${success}</div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="alert alert-error">${error}</div>
        </c:if>
        
        <a href="${pageContext.request.contextPath}/livres" class="btn-retour">← Retour à l'accueil</a>
        
        <div class="form-container">
            <c:choose>
                <c:when test="${empty empruntsActifs}">
                    <div class="no-emprunts">
                        <h3>Aucun emprunt actif</h3>
                        <p>Il n'y a actuellement aucun emprunt actif à prolonger.</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <h3>Sélectionner un emprunt à prolonger</h3>
                    
                    <form action="${pageContext.request.contextPath}/emprunt/prolonger" method="post">
                        <div class="form-group">
                            <label for="empruntId">Emprunt à prolonger :</label>
                            <select name="empruntId" id="empruntId" required>
                                <option value="">-- Sélectionner un emprunt --</option>
                                <c:forEach items="${empruntsActifs}" var="emprunt">
                                    <option value="${emprunt.id}">
                                        ${emprunt.livre.titre} - ${emprunt.emprunteur.userName} 
                                        (Fin: ${emprunt.dateFinEmprunt.toLocalDate()})
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                        
                        <div class="form-group">
                            <label for="moisSupplementaires">Nombre de mois supplémentaires :</label>
                            <input type="number" name="moisSupplementaires" id="moisSupplementaires" 
                                   min="1" max="12" value="1" required>
                        </div>
                        
                        <button type="submit" class="btn-submit" 
                                onclick="return confirm('Confirmer la prolongation de cet emprunt ?')">
                            Prolonger l'emprunt
                        </button>
                    </form>
                    
                    <!-- Détails des emprunts actifs -->
                    <div style="margin-top: 30px;">
                        <h3>Emprunts actifs actuels :</h3>
                        <c:forEach items="${empruntsActifs}" var="emprunt">
                            <div class="emprunt-details">
                                <div class="emprunt-left">
                                    <div class="livre-titre">${emprunt.livre.titre}</div>
                                    <div class="livre-auteur">par ${emprunt.livre.auteur}</div>
                                    <div class="emprunteur-nom">
                                        Emprunté par : ${emprunt.emprunteur.userName}
                                    </div>
                                </div>
                                <div class="emprunt-right">
                                    <div>Type: ${emprunt.typeDeLecture}</div>
                                    <div>Début: ${emprunt.dateDebutEmprunt.toLocalDate()}</div>
                                    <div class="date-fin">Fin: ${emprunt.dateFinEmprunt.toLocalDate()}</div>
                                    <c:if test="${emprunt.prolongement}">
                                        <div style="color: #B8860B;">
                                            Prolongé ${emprunt.nombreProlongement} fois
                                        </div>
                                    </c:if>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</body>
</html>