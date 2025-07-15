<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Gestion des Pénalités - Bibliothèque</title>
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
            content: '⚖️';
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

        /* Configuration des pénalités */
        .config-info {
            background: linear-gradient(145deg, #FAEBD7, #F5F5DC);
            border-radius: 20px;
            padding: 25px;
            margin-bottom: 30px;
            box-shadow: 0 8px 20px rgba(0,0,0,0.2);
            border: 2px solid #D2691E;
            position: relative;
        }

        .config-info h3 {
            color: #654321;
            margin-bottom: 15px;
            font-size: 1.3em;
            text-shadow: 1px 1px 2px rgba(0,0,0,0.1);
        }

        .config-info p {
            color: #8B4513;
            line-height: 1.6;
        }

        /* Bouton de vérification */
        .btn-verify {
            background: linear-gradient(145deg, #17a2b8, #138496);
            color: white;
            border: none;
            padding: 15px 25px;
            border-radius: 10px;
            cursor: pointer;
            font-size: 1.1em;
            font-weight: bold;
            transition: all 0.3s ease;
            font-family: 'Georgia', serif;
            box-shadow: 0 4px 8px rgba(0,0,0,0.2);
            margin-bottom: 30px;
            position: relative;
            overflow: hidden;
        }

        .btn-verify::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.3), transparent);
            transition: left 0.6s ease;
        }

        .btn-verify:hover::before {
            left: 100%;
        }

        .btn-verify:hover {
            background: linear-gradient(145deg, #138496, #17a2b8);
            transform: translateY(-2px);
            box-shadow: 0 6px 12px rgba(0,0,0,0.3);
        }

        /* Statistiques */
        .stats-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 25px;
            margin-bottom: 40px;
        }

        .stat-card {
            background: linear-gradient(145deg, #FAEBD7, #F5F5DC);
            padding: 25px;
            border-radius: 20px;
            box-shadow: 0 8px 20px rgba(0,0,0,0.2);
            border: 2px solid #D2691E;
            text-align: center;
            transition: all 0.3s ease;
        }

        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 12px 24px rgba(0,0,0,0.3);
        }

        .stat-number {
            font-size: 2.5em;
            font-weight: bold;
            color: #D2691E;
            margin-bottom: 10px;
        }

        .stat-label {
            color: #8B4513;
            font-size: 1.1em;
        }

        /* Liste des utilisateurs */
        .penalite-container {
            background: linear-gradient(145deg, #FAEBD7, #F5F5DC);
            border-radius: 20px;
            padding: 30px;
            margin-bottom: 20px;
            box-shadow: 0 8px 20px rgba(0,0,0,0.2);
            border: 2px solid #D2691E;
            position: relative;
        }

        .penalite-container h2 {
            color: #654321;
            margin-bottom: 25px;
            font-size: 1.8em;
            text-shadow: 1px 1px 2px rgba(0,0,0,0.1);
        }

        .user-card {
            background: linear-gradient(145deg, #FFF8DC, #FAEBD7);
            border: 2px solid #D2691E;
            border-radius: 15px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
            transition: all 0.3s ease;
        }

        .user-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 16px rgba(0,0,0,0.2);
        }

        .user-card.has-penalty {
            border-color: #DC143C;
            background: linear-gradient(145deg, #FFF0F5, #FFE4E1);
        }

        .user-name {
            font-size: 1.2em;
            font-weight: bold;
            color: #654321;
            margin-bottom: 8px;
        }

        .user-email, .user-profile {
            color: #8B4513;
            font-size: 0.95em;
            margin-bottom: 8px;
        }

        .penalty-status {
            padding: 10px 15px;
            border-radius: 10px;
            font-size: 0.95em;
            font-weight: bold;
            display: inline-block;
            margin-top: 10px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        .status-loading {
            background: linear-gradient(145deg, #F0E68C, #FFFFE0);
            color: #B8860B;
            border: 2px solid #DAA520;
        }

        .status-ok {
            background: linear-gradient(145deg, #90EE90, #98FB98);
            color: #006400;
            border: 2px solid #32CD32;
        }

        .status-ok::before {
            content: '✅ ';
        }

        .status-penalty {
            background: linear-gradient(145deg, #FFB6C1, #FFC0CB);
            color: #8B0000;
            border: 2px solid #DC143C;
        }

        .status-penalty::before {
            content: '⚠️ ';
        }

        /* Responsive Design */
        @media (max-width: 1200px) {
            .stats-container {
                grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));
                gap: 20px;
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
            
            .stats-container {
                grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
                gap: 15px;
            }
            
            .main-header h1 {
                font-size: 2em;
            }
        }

        @media (max-width: 480px) {
            .stats-container {
                grid-template-columns: 1fr;
                gap: 15px;
            }
            
            .penalite-container, .config-info {
                padding: 20px;
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
            <a href="${pageContext.request.contextPath}/emprunt/prolongement">⏰ Prolonger un emprunt</a>
            <a href="${pageContext.request.contextPath}/penalite/gestion" class="active">⚖️ Gestion des pénalités</a>
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
            <h1>Gestion des Pénalités</h1>
        </div>
        
        <!-- Messages d'alerte -->
        <c:if test="${not empty success}">
            <div class="alert alert-success">${success}</div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="alert alert-error">${error}</div>
        </c:if>
        
        <!-- Configuration des pénalités -->
        <div class="config-info">
            <h3>⚙️ Configuration des pénalités</h3>
            <p>${parametres}</p>
        </div>
        
        <!-- Bouton de vérification manuelle -->
        <form action="${pageContext.request.contextPath}/penalite/verifier" method="post" style="display: inline;">
            <button type="submit" class="btn-verify">🔍 Vérifier les pénalités maintenant</button>
        </form>
        
        <!-- Statistiques -->
        <div class="stats-container">
            <div class="stat-card">
                <div class="stat-number" id="totalUsers">${utilisateurs.size()}</div>
                <div class="stat-label">Utilisateurs total</div>
            </div>
            <div class="stat-card">
                <div class="stat-number" id="usersWithPenalty">0</div>
                <div class="stat-label">Avec pénalités actives</div>
            </div>
            <div class="stat-card">
                <div class="stat-number" id="usersOk">0</div>
                <div class="stat-label">Sans pénalité</div>
            </div>
        </div>
        
        <!-- Liste des utilisateurs -->
        <div class="penalite-container">
            <h2>👥 État des utilisateurs</h2>
            
            <c:choose>
                <c:when test="${empty utilisateurs}">
                    <p>Aucun utilisateur trouvé.</p>
                </c:when>
                <c:otherwise>
                    <div id="usersList">
                        <c:forEach items="${utilisateurs}" var="user">
                            <div class="user-card" data-user-id="${user.id}">
                                <div class="user-name">${user.userName}</div>
                                <div class="user-email">${user.email}</div>
                                <div class="user-profile">Profil: ${user.profilFormule.profil}</div>
                                <div class="penalty-status-container">
                                    <span class="penalty-status status-loading">Vérification en cours...</span>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <script>
        // Simuler la vérification des pénalités pour chaque utilisateur
        document.addEventListener('DOMContentLoaded', function() {
            const userCards = document.querySelectorAll('.user-card');
            let usersWithPenalty = 0;
            let usersOk = 0;
            
            userCards.forEach(function(card, index) {
                setTimeout(function() {
                    const statusElement = card.querySelector('.penalty-status');
                    
                    // Simulation aléatoire pour la démonstration
                    // Dans une vraie application, ceci serait un appel AJAX
                    const hasPenalty = Math.random() < 0.2; // 20% de chance d'avoir une pénalité
                    
                    if (hasPenalty) {
                        card.classList.add('has-penalty');
                        statusElement.className = 'penalty-status status-penalty';
                        statusElement.textContent = 'Pénalité active';
                        usersWithPenalty++;
                    } else {
                        statusElement.className = 'penalty-status status-ok';
                        statusElement.textContent = 'Aucune pénalité';
                        usersOk++;
                    }
                    
                    // Mettre à jour les statistiques
                    document.getElementById('usersWithPenalty').textContent = usersWithPenalty;
                    document.getElementById('usersOk').textContent = usersOk;
                    
                }, index * 200); // Délai progressif pour l'effet visuel
            });
        });
    </script>
</body>
</html>