<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Emprunter un livre</title>
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

        .form-container {
            max-width: 600px;
            margin: 20px auto;
            padding: 25px;
            background: linear-gradient(145deg, #FAEBD7, #F5F5DC);
            border: 3px solid #D2691E;
            border-radius: 20px;
            box-shadow: 0 8px 20px rgba(0,0,0,0.2);
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
            z-index: 1;
            pointer-events: none;
        }

        .form-container:hover::before {
            opacity: 1;
        }

        .form-container h2 {
            color: #654321;
            font-size: 2em;
            text-shadow: 1px 1px 2px rgba(0,0,0,0.1);
            margin-bottom: 20px;
            text-align: center;
        }

        .form-container h2::before {
            content: '📖 ';
            margin-right: 10px;
        }

        .form-group {
            margin-bottom: 20px;
            position: relative;
            z-index: 5;
        }

        label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
            color: #654321;
            text-shadow: 1px 1px 2px rgba(0,0,0,0.1);
        }

        select {
            width: 100%;
            padding: 10px;
            border: 2px solid #D2691E;
            border-radius: 10px;
            font-size: 1em;
            color: #654321;
            font-family: 'Georgia', serif;
            background: rgba(255, 255, 255, 0.8);
            transition: all 0.3s ease;
            position: relative;
            z-index: 10;
            outline: none;
        }

        select:focus {
            border-color: #F4A460;
            box-shadow: 0 4px 8px rgba(0,0,0,0.2);
            background: #fff;
        }

        .radio-group {
            margin: 15px 0;
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .radio-label {
            font-weight: normal;
            color: #8B4513;
            font-size: 1em;
            display: flex;
            align-items: center;
            gap: 5px;
        }

        input[type="radio"] {
            width: 20px;
            height: 20px;
            accent-color: #D2691E;
            margin-right: 5px;
            position: relative;
            z-index: 10;
        }

        .submit-btn {
            background: linear-gradient(145deg, #228B22, #32CD32);
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 10px;
            cursor: pointer;
            font-size: 1em;
            font-weight: bold;
            transition: all 0.3s ease;
            font-family: 'Georgia', serif;
            box-shadow: 0 4px 8px rgba(0,0,0,0.2);
            position: relative;
            z-index: 10;
            overflow: hidden;
        }

        .submit-btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.3), transparent);
            transition: left 0.6s ease;
        }

        .submit-btn:hover::before {
            left: 100%;
        }

        .submit-btn:hover {
            background: linear-gradient(145deg, #32CD32, #228B22);
            transform: translateY(-2px);
            box-shadow: 0 6px 12px rgba(0,0,0,0.3);
        }

        .btn-retour {
            display: inline-block;
            margin-top: 15px;
            padding: 10px 20px;
            background: linear-gradient(145deg, #D2691E, #F4A460);
            color: #654321;
            text-decoration: none;
            border-radius: 10px;
            font-size: 1em;
            font-weight: bold;
            transition: all 0.3s ease;
            font-family: 'Georgia', serif;
            box-shadow: 0 4px 8px rgba(0,0,0,0.2);
            position: relative;
            z-index: 10;
        }

        .btn-retour:hover {
            background: linear-gradient(145deg, #F4A460, #D2691E);
            transform: translateY(-2px);
            box-shadow: 0 6px 12px rgba(0,0,0,0.3);
        }

        .error-message {
            padding: 20px;
            margin-bottom: 20px;
            border-radius: 15px;
            font-size: 1.1em;
            font-weight: 500;
            color: #721c24;
            background: linear-gradient(145deg, #f8d7da, #f5c6cb);
            border: 2px solid #dc3545;
            position: relative;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            z-index: 5;
        }

        .error-message::before {
            content: '❌ ';
            font-size: 1.3em;
            margin-right: 10px;
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
            
            .form-container {
                margin: 10px;
                padding: 15px;
            }
            
            .form-container h2 {
                font-size: 1.6em;
            }
        }

        @media (max-width: 480px) {
            .form-container {
                padding: 10px;
            }
            
            .form-group {
                margin-bottom: 15px;
            }
            
            .submit-btn, .btn-retour {
                width: 100%;
                text-align: center;
            }
            
            .radio-group {
                flex-direction: column;
                align-items: flex-start;
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
            <a href="${pageContext.request.contextPath}/emprunt/nouveau" class="btn-emprunt active">📖 Emprunter un livre</a>
            <a href="${pageContext.request.contextPath}/emprunt/retour-sur-place">📚 Retour lecture sur place</a>
            <a href="${pageContext.request.contextPath}/emprunt/prolongement">⏰ Prolonger un emprunt</a>
            <a href="${pageContext.request.contextPath}/penalite/gestion">⚖️ Gestion des pénalités</a>
            <a href="${pageContext.request.contextPath}/penalite/parametres">⚙️ Paramètres des pénalités</a>
        </c:if>
        <a href="${pageContext.request.contextPath}/reservation/mes-reservations">📋 Mes réservations</a>
        <a href="${pageContext.request.contextPath}/penalite/mes-penalites">💰 Mes pénalités</a>
        <form action="${pageContext.request.contextPath}/logout" method="post" style="margin:0;">
            <button type="submit" class="btn-logout">🚪 Déconnexion</button>
        </form>
    </div>
    
    <div class="main-content">
        <div class="form-container">
            <h2>Emprunter un livre</h2>
            
            <c:if test="${param.error != null}">
                <div class="error-message">
                    <c:choose>
                        <c:when test="${param.error == 'penalite_active'}">
                            ⚠️ Cet utilisateur a une pénalité active et ne peut pas emprunter de livres.
                        </c:when>
                        <c:when test="${param.error == 'notadmin'}">
                            ❌ Accès refusé. Seuls les administrateurs peuvent emprunter des livres.
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