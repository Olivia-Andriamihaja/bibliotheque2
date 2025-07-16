<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Nouvel Abonnement</title>
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
            color: #4c66af;
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
            background: #4c6daf;
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
            background: #4c51af;
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
            display: flex;
            justify-content: center;
            align-items: center;
        }
        
        .main-content h1 {
            color: #333;
            margin-bottom: 30px;
            margin-top: 0;
            text-align: center;
        }
        
        .form-container {
            max-width: 400px;
            width: 100%;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            background: #fff;
        }
        
        h2 {
            color: #514caf;
            font-size: 24px;
            margin-bottom: 20px;
            text-align: center;
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
        
        input, select {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 0.9em;
            box-sizing: border-box;
        }
        
        input:focus, select:focus {
            outline: none;
            border-color: #4c53af;
        }
        
        .btn-submit {
            background: #4c53af;
            color: #fff;
            border: none;
            padding: 10px 20px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 0.9em;
            font-weight: bold;
            transition: background 0.2s;
            width: 100%;
        }
        
        .btn-submit:hover {
            background: #456ba0;
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
                margin: 20px;
                padding: 15px;
            }
        }
        
        @media (max-width: 480px) {
            .form-container {
                padding: 10px;
            }
            
            h2 {
                font-size: 20px;
            }
            
            input, select {
                padding: 8px;
            }
            
            .btn-submit {
                padding: 8px 16px;
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
            <h2>Ajouter un Abonnement</h2>
            <form:form method="post" modelAttribute="abonnement" action="${pageContext.request.contextPath}/abonnement/nouveau">
                <div class="form-group">
                    <form:label path="utilisateur">Nom de l'abonné :</form:label>
                    <select name="utilisateur" id="utilisateur" required>
                        <option value="">-- Choisir un utilisateur --</option>
                        <c:forEach items="${utilisateurs}" var="u">
                            <option value="${u.id}">${u.userName} (${u.email})</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="form-group">
                    <form:label path="nombreJourAbonnement">Durée (mois) :</form:label>
                    <form:input path="nombreJourAbonnement" type="number" min="1" max="24" required="true"/>
                </div>
                <div class="form-group">
                    <form:label path="dateDebutAbonnement">Date de début :</form:label>
                    <form:input path="dateDebutAbonnement" type="date" required="true"/>
                </div>
                <button type="submit" class="btn-submit">Ajouter</button>
            </form:form>
        </div>
    </div>
</body>
</html>