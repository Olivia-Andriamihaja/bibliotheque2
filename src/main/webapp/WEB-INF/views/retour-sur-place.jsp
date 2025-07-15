<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Retour des lectures sur place</title>
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
            content: '📚';
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
            max-width: 500px;
            margin: 0 auto;
            background: linear-gradient(145deg, #FAEBD7, #F5F5DC);
            border: 3px solid #D2691E;
            border-radius: 20px;
            padding: 25px;
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
            font-size: 1.8em;
            text-shadow: 1px 1px 2px rgba(0,0,0,0.1);
            margin-bottom: 20px;
            text-align: center;
        }

        .form-container h2::before {
            content: '📚 ';
            margin-right: 10px;
        }

        .form-container label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
            color: #654321;
            text-shadow: 1px 1px 2px rgba(0,0,0,0.1);
        }

        .form-container select {
            width: 100%;
            padding: 12px;
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

        .form-container select:focus {
            border-color: #F4A460;
            box-shadow: 0 4px 8px rgba(0,0,0,0.2);
            background: #fff;
        }

        .form-container button {
            width: 100%;
            background: linear-gradient(145deg, #228B22, #32CD32);
            color: white;
            border: none;
            padding: 12px;
            border-radius: 10px;
            cursor: pointer;
            font-size: 1em;
            font-weight: bold;
            transition: all 0.3s ease;
            font-family: 'Georgia', serif;
            box-shadow: 0 4px 8px rgba(0,0,0,0.2);
            position: relative;
            overflow: hidden;
            margin: 20px 0;
        }

        .form-container button::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.3), transparent);
            transition: left 0.6s ease;
        }

        .form-container button:hover::before {
            left: 100%;
        }

        .form-container button:hover {
            background: linear-gradient(145deg, #32CD32, #228B22);
            transform: translateY(-2px);
            box-shadow: 0 6px 12px rgba(0,0,0,0.3);
        }

        .empty {
            text-align: center;
            padding: 20px;
            color: #654321;
            font-size: 1.1em;
            background: linear-gradient(145deg, #FFF8DC, #FAEBD7);
            border: 2px solid #D2691E;
            border-radius: 15px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.2);
            margin: 20px 0;
            position: relative;
            overflow: hidden;
        }

        .empty::before {
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
        }

        .empty:hover::before {
            opacity: 1;
        }

        .btn-retour {
            display: block;
            width: 100%;
            max-width: 500px;
            margin: 30px auto 0;
            background: linear-gradient(145deg, #D2691E, #F4A460);
            color: #654321;
            text-align: center;
            padding: 12px;
            border-radius: 10px;
            text-decoration: none;
            font-size: 1em;
            font-weight: bold;
            transition: all 0.3s ease;
            font-family: 'Georgia', serif;
            box-shadow: 0 4px 8px rgba(0,0,0,0.2);
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
            background: linear-gradient(145deg, #F4A460, #D2691E);
            transform: translateY(-2px);
            box-shadow: 0 6px 12px rgba(0,0,0,0.3);
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
        }

        @media (max-width: 480px) {
            .form-container {
                padding: 15px;
            }
            
            .main-header {
                padding: 20px;
            }
            
            .main-header h1 {
                font-size: 1.6em;
            }
            
            .btn-retour {
                padding: 10px;
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
            <a href="${pageContext.request.contextPath}/emprunt/retour-sur-place" class="active">📚 Retour lecture sur place</a>
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
        <div class="main-header">
            <h1>Retour des lectures sur place</h1>
        </div>
        
        <div class="form-container">
            <h2>Retour d'un livre lu sur place</h2>
            <form action="${pageContext.request.contextPath}/emprunt/retour-sur-place" method="post">
                <label for="empruntId">Sélectionner la personne :</label>
                <select name="empruntId" id="empruntId" required>
                    <option value="">-- Choisir un emprunt --</option>
                    <c:forEach items="${empruntsSurPlace}" var="e">
                        <option value="${e.id}">${e.emprunteur.userName} (${e.livre.titre}, ${e.typeDeLecture})
                        </option>
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

    <script>
        document.addEventListener('DOMContentLoaded', () => {
            console.log('Page chargée, initialisation du select');
            const select = document.getElementById('empruntId');
            if (select) {
                // S'assurer que le select n'est pas désactivé ou en lecture seule
                select.removeAttribute('disabled');
                select.removeAttribute('readonly');

                select.addEventListener('focus', () => {
                    console.log('Focus sur le select: empruntId');
                });

                select.addEventListener('change', () => {
                    console.log(`Select changé - ID: empruntId, Valeur: ${select.value}`);
                });
            } else {
                console.error('Élément #empruntId non trouvé');
            }
        });
    </script>
</body>
</html>