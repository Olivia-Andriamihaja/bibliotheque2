<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Emprunter un livre</title>
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
            transition: background 0.2 lost;
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
        
        .form-container {
            max-width: 600px;
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
        
        .form-group {
            margin-bottom: 15px;
        }
        
        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
            color: #333;
        }
        
        select, input[type="radio"] {
            margin: 8px 0;
        }
        
        select {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 0.9em;
        }
        
        select:focus {
            outline: none;
            border-color: #4CAF50;
        }
        
        .radio-group {
            margin: 10px 0;
            display: flex;
            gap: 20px;
        }
        
        .radio-label {
            font-weight: normal;
            color: #333;
        }
        
        input[type="radio"] {
            margin-right: 5px;
        }
        
        .submit-btn {
            background: #4CAF50;
            color: #fff;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-weight: bold;
            transition: background 0.2s;
            width: 100%;
        }
        
        .submit-btn:hover {
            background: #45a049;
        }
        
        .btn-retour {
            display: block;
            width: 100%;
            background: #4CAF50;
            color: #fff;
            text-align: center;
            padding: 10px 0;
            border-radius: 4px;
            text-decoration: none;
            font-weight: bold;
            margin-top: 20px;
            transition: background 0.2s;
        }
        
        .btn-retour:hover {
            background: #45a049;
        }
        
        .error-message {
            color: #721c24;
            background: #f8d7da;
            border: 1px solid #f5c6cb;
            padding: 10px;
            margin-bottom: 15px;
            border-radius: 4px;
            font-size: 0.9em;
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
            
            .form-container {
                padding: 15px;
            }
        }
        
        @media (max-width: 480px) {
            .form-container {
                padding: 10px;
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
        <form action="${pageContext.request.contextPath}/logout" method="post" style="margin:0;">
            <button type="submit" class="btn-logout">Déconnexion</button>
        </form>
    </div>
    <div class="main-content">
        <div class="form-container">
            <h2>Emprunter un livre</h2>
            
            <c:if test="${param.error != null}">
                <div class="error-message">
                    <c:choose>
                        <c:when test="${param.error == 'penalite_active'}">
                            Cet utilisateur a une pénalité active et ne peut pas emprunter de livres.
                        </c:when>
                        <c:when test="${param.error == 'notadmin'}">
                            Accès refusé. Seuls les administrateurs peuvent emprunter des livres.
                        </c:when>
                        <c:otherwise>
                            Une erreur s'est produite : ${param.error}
                        </c:otherwise>
                    </c:choose>
                </div>
            </c:if>

            <form action="${pageContext.request.contextPath}/emprunt/creer" method="post">
                <div class="form-group">
                    <label for="userId">Sélectionner l'utilisateur :</label>
                    <select name="userId" id="userId" required>
                        <option value="">-- Choisir un utilisateur --</option>
                        <c:forEach items="${utilisateurs}" var="u">
                            <option value="${u.id}">${u.userName} (${u.email})</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="form-group">
                    <label for="livre">Sélectionner un livre :</label>
                    <select name="idLivre" id="livre" required>
                        <option value="">-- Choisir un livre --</option>
                        <c:forEach items="${livresDisponibles}" var="livre">
                            <option value="${livre.id}">${livre.titre} - ${livre.auteur} (${livre.numExemplaire})</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="form-group">
                    <label for="dateDebutEmprunt">Date de début de l'emprunt :</label>
                    <input type="date" id="dateDebutEmprunt" name="dateDebutEmprunt" required>
                </div>
                <div class="form-group">
                    <label>Type d'emprunt :</label>
                    <div class="radio-group">
                        <input type="radio" id="surPlace" name="typeEmprunt" value="SUR_PLACE" required>
                        <label class="radio-label" for="surPlace">Sur place</label>
                        <input type="radio" id="aEmporter" name="typeEmprunt" value="A_EMPORTER">
                        <label class="radio-label" for="aEmporter">À emporter</label>
                    </div>
                </div>
                <button type="submit" class="submit-btn">Emprunter</button>
                <a href="${pageContext.request.contextPath}/livres" class="btn-retour">Retour à la liste des livres</a>
            </form>
        </div>
    </div>
</body>
</html>