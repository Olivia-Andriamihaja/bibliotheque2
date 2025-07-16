<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Gestion des Pénalités</title>
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
        
        .sidebar a.active {
            background: #4CAF50;
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
        
        .penalite-container {
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            background: #fff;
        }
        
        h2, h3 {
            color: #4CAF50;
            margin-bottom: 20px;
        }
        
        .user-card {
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 15px;
            margin-bottom: 15px;
            background: #fff;
            transition: transform 0.2s, box-shadow 0.2s;
        }
        
        .user-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
        }
        
        .user-card.has-penalty {
            border-color: #e74c3c;
            background: #fff5f5;
        }
        
        .user-name {
            font-size: 1.1em;
            font-weight: bold;
            margin-bottom: 5px;
            color: #333;
        }
        
        .user-email {
            color: #666;
            font-size: 0.9em;
            margin-bottom: 10px;
        }
        
        .user-profile {
            color: #666;
            font-size: 0.9em;
            margin-bottom: 10px;
        }
        
        .penalty-status {
            padding: 5px 12px;
            border-radius: 4px;
            font-size: 0.8em;
            font-weight: bold;
            display: inline-block;
        }
        
        .status-ok {
            background: #d4edda;
            color: #155724;
        }
        
        .status-penalty {
            background: #f8d7da;
            color: #721c24;
        }
        
        .status-loading {
            background: #e9ecef;
            color: #495057;
        }
        
        .btn-verify {
            background: #4CAF50;
            color: #fff;
            border: none;
            padding: 10px 20px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 0.9em;
            font-weight: bold;
            transition: background 0.2s;
        }
        
        .btn-verify:hover {
            background: #45a049;
        }
        
        .config-info {
            background: #e9ecef;
            padding: 15px;
            border-radius: 4px;
            margin-bottom: 20px;
            font-size: 0.9em;
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
        
        .stats-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }
        
        .stat-card {
            background: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            text-align: center;
            transition: transform 0.2s, box-shadow 0.2s;
        }
        
        .stat-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
        }
        
        .stat-number {
            font-size: 2em;
            font-weight: bold;
            color: #4CAF50;
        }
        
        .stat-label {
            color: #666;
            margin-top: 5px;
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
            
            .penalite-container, .stats-container {
                padding: 15px;
            }
        }
        
        @media (max-width: 480px) {
            .penalite-container, .stats-container {
                padding: 10px;
            }
            
            .user-card, .stat-card {
                padding: 12px;
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
            <a href="${pageContext.request.contextPath}/penalite/gestion" class="active">Gestion des pénalités</a>
            <a href="${pageContext.request.contextPath}/penalite/parametres">Paramètres des pénalités</a>
        </c:if>
        <a href="${pageContext.request.contextPath}/reservation/mes-reservations">Mes réservations</a>
        <a href="${pageContext.request.contextPath}/penalite/mes-penalites">Mes pénalités</a>
        <form action="${pageContext.request.contextPath}/logout" method="post" style="margin:0;">
            <button type="submit" class="btn-logout">Déconnexion</button>
        </form>
    </div>
    
    <div class="main-content">
        <h1>Gestion des Pénalités</h1>
        
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
                        statusElement.textContent = '⚠️ Pénalité active';
                        usersWithPenalty++;
                    } else {
                        statusElement.className = 'penalty-status status-ok';
                        statusElement.textContent = '✅ Aucune pénalité';
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