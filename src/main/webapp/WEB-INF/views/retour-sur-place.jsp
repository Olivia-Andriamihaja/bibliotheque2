<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Retour des lectures sur place</title>
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
            color: #4c4caf;
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
            background: #5c4caf;
            color: #fff;
            font-weight: bold;
        }
        
        .sidebar a:hover, .sidebar .btn-emprunt:hover {
            background: #333;
        }
        
        .sidebar .btn-emprunt:hover {
            background: #383b8e;
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
            padding: 40px;
            box-sizing: border-box;
        }
        
        .container {
            max-width: 500px;
            margin: 0 auto;
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            padding: 30px;
        }
        
        h2 {
            color: #4c6aaf;
            margin-top: 0;
        }
        
        label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
            color: #333;
        }
        
        select, button {
            width: 100%;
            padding: 12px;
            margin: 0 0 20px 0;
            border-radius: 4px;
            border: 1px solid #ddd;
            box-sizing: border-box;
            font-size: 14px;
        }
        
        select:focus {
            outline: none;
            border-color: #4c59af;
            box-shadow: 0 0 0 2px rgba(76, 175, 80, 0.2);
        }
        
        button {
            background: #4c60af;
            color: #fff;
            border: none;
            font-weight: bold;
            cursor: pointer;
            transition: background 0.2s;
        }
        
        button:hover {
            background: #38428e;
        }
        
        .empty {
            color: #888;
            text-align: center;
            font-style: italic;
            margin-top: 20px;
        }
        
        .btn-retour {
            display: block;
            width: 200px;
            background: #4c6faf;
            color: #fff;
            text-align: center;
            padding: 12px 0;
            border-radius: 4px;
            text-decoration: none;
            font-weight: bold;
            margin: 30px auto 0 auto;
            transition: background 0.2s;
        }
        
        .btn-retour:hover {
            background: #38418e;
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
            
            .container {
                padding: 20px;
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
        </c:if>
        <a href="${pageContext.request.contextPath}/reservation/mes-reservations">Mes réservations</a>
        <a href="${pageContext.request.contextPath}/penalite/mes-penalites">Mes pénalités</a>
        <form action="${pageContext.request.contextPath}/logout" method="post">
            <button type="submit" class="btn-logout">Déconnexion</button>
        </form>
    </div>
    
    <div class="main-content">
        <div class="container">
            <h2>Retour d'un livre lu sur place</h2>
            <form action="${pageContext.request.contextPath}/emprunt/retour-sur-place" method="post">
                <label for="empruntId">Sélectionner la personne :</label>
                <select name="empruntId" id="empruntId" required>
                    <option value="">-- Choisir une personne --</option>
                    <c:forEach items="${empruntsSurPlace}" var="e">
                        <option value="${e.id}">${e.emprunteur.userName} (${e.livre.titre})</option>
                    </c:forEach>
                </select>
                <label for="dateRetour">Date de retour :</label>
                <input type="date" id="dateRetour" name="dateRetour" required>
                <button type="submit">Valider le retour</button>
            </form>
            <c:if test="${empty empruntsSurPlace}">
                <p class="empty">Aucun emprunt sur place en cours.</p>
            </c:if>
        </div>
        
        <a href="${pageContext.request.contextPath}/livres" class="btn-retour">Retour à la liste des livres</a>
    </div>
</body>
</html>