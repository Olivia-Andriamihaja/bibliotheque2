<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Prolongement d'Emprunt</title>
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
        
        .btn-retour {
            display: inline-block;
            background: #6c757d;
            color: #fff;
            text-decoration: none;
            padding: 10px 20px;
            border-radius: 4px;
            margin-bottom: 30px;
            font-weight: bold;
            transition: background 0.2s;
        }
        
        .btn-retour:hover {
            background: #5a6268;
        }
        
        .form-container {
            max-width: 600px;
            background: #fff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            margin-bottom: 30px;
        }
        
        .form-container h3 {
            color: #4CAF50;
            margin-top: 0;
            margin-bottom: 20px;
        }
        
        .form-group {
            margin-bottom: 20px;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
            color: #333;
        }
        
        .form-group select,
        .form-group input[type="number"] {
            width: 100%;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
            box-sizing: border-box;
        }
        
        .form-group select:focus,
        .form-group input[type="number"]:focus {
            outline: none;
            border-color: #4CAF50;
            box-shadow: 0 0 0 2px rgba(76, 175, 80, 0.2);
        }
        
        .btn-submit {
            width: 100%;
            padding: 12px;
            background: #4CAF50;
            color: #fff;
            border: none;
            border-radius: 4px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            transition: background 0.2s;
        }
        
        .btn-submit:hover {
            background: #45a049;
        }
        
        .no-emprunts {
            text-align: center;
            padding: 40px;
            color: #666;
        }
        
        .no-emprunts h3 {
            color: #888;
            margin-bottom: 15px;
        }
        
        .emprunt-details {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            padding: 15px;
            margin-bottom: 15px;
            background: #f8f9fa;
            border-radius: 8px;
            border-left: 4px solid #4CAF50;
        }
        
        .emprunt-left {
            flex: 1;
        }
        
        .emprunt-right {
            flex: 0 0 auto;
            text-align: right;
            min-width: 200px;
            font-size: 0.9em;
            color: #666;
        }
        
        .emprunt-right div {
            margin-bottom: 4px;
        }
        
        .livre-titre {
            font-size: 18px;
            font-weight: bold;
            color: #333;
            margin-bottom: 5px;
        }
        
        .livre-auteur {
            color: #666;
            font-style: italic;
            margin-bottom: 8px;
        }
        
        .emprunteur-nom {
            color: #333;
            font-weight: 500;
        }
        
        .date-fin {
            font-weight: bold;
            color: #e74c3c;
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
                padding: 20px;
            }
            
            .emprunt-details {
                flex-direction: column;
                gap: 10px;
            }
            
            .emprunt-right {
                text-align: left;
                min-width: auto;
            }
        }
        
        @media (max-width: 480px) {
            .main-content {
                padding: 15px;
            }
            
            .form-container {
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
        </c:if>
        <a href="${pageContext.request.contextPath}/reservation/mes-reservations">Mes réservations</a>
        <a href="${pageContext.request.contextPath}/penalite/mes-penalites">Mes pénalités</a>
        <form action="${pageContext.request.contextPath}/logout" method="post">
            <button type="submit" class="btn-logout">Déconnexion</button>
        </form>
    </div>
    
    <div class="main-content">
        <h1>Prolongement d'Emprunt</h1>
        
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
                </c:otherwise>
            </c:choose>
        </div>
        
        <!-- Détails des emprunts actifs -->
        <c:if test="${not empty empruntsActifs}">
            <div class="form-container">
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
                                <div style="color: #f39c12;">
                                    Prolongé ${emprunt.nombreProlongement} fois
                                </div>
                            </c:if>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:if>
    </div>
</body>
</html>