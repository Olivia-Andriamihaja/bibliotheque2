<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Renouveler Abonnement - Bibliothèque</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding-left: 280px;
        }

        /* Sidebar */
        .sidebar {
            position: fixed;
            left: 0;
            top: 0;
            width: 280px;
            height: 100vh;
            background: linear-gradient(180deg, #2c3e50 0%, #3498db 100%);
            padding: 2rem 0;
            z-index: 1000;
            box-shadow: 4px 0 15px rgba(0,0,0,0.1);
        }

        .sidebar h2 {
            color: white;
            text-align: center;
            margin-bottom: 2rem;
            font-size: 1.5rem;
            font-weight: 300;
        }

        .sidebar ul {
            list-style: none;
        }

        .sidebar ul li {
            margin: 0.5rem 0;
        }

        .sidebar ul li a {
            display: block;
            color: #ecf0f1;
            text-decoration: none;
            padding: 1rem 2rem;
            transition: all 0.3s ease;
            border-left: 4px solid transparent;
        }

        .sidebar ul li a:hover, .sidebar ul li a.active {
            background: rgba(255,255,255,0.1);
            border-left: 4px solid #f39c12;
            transform: translateX(5px);
        }

        .logout-btn {
            position: absolute;
            bottom: 2rem;
            left: 2rem;
            right: 2rem;
            background: #e74c3c;
            color: white;
            border: none;
            padding: 1rem;
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            text-align: center;
            display: block;
        }

        .logout-btn:hover {
            background: #c0392b;
            transform: translateY(-2px);
        }

        /* Main Content */
        .main-content {
            padding: 2rem;
            max-width: 800px;
        }

        .page-header {
            background: rgba(255,255,255,0.95);
            padding: 2rem;
            border-radius: 15px;
            margin-bottom: 2rem;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            text-align: center;
        }

        .page-header h1 {
            color: #2c3e50;
            margin-bottom: 1rem;
            font-size: 2.5rem;
            font-weight: 300;
        }

        .btn {
            display: inline-block;
            padding: 12px 24px;
            border: none;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s ease;
            cursor: pointer;
            margin: 0.5rem;
        }

        .btn-primary {
            background: linear-gradient(135deg, #3498db, #2980b9);
            color: white;
        }

        .btn-warning {
            background: linear-gradient(135deg, #f39c12, #e67e22);
            color: white;
        }

        .btn-secondary {
            background: linear-gradient(135deg, #95a5a6, #7f8c8d);
            color: white;
        }

        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
        }

        /* Alerts */
        .alert {
            padding: 1rem 1.5rem;
            border-radius: 8px;
            margin-bottom: 1rem;
            font-weight: 500;
        }

        .alert-success {
            background: rgba(46, 204, 113, 0.1);
            border: 1px solid #1d549c;
            color: #27ae60;
        }

        .alert-error {
            background: rgba(231, 76, 60, 0.1);
            border: 1px solid #e74c3c;
            color: #c0392b;
        }

        .alert-warning {
            background: rgba(243, 156, 18, 0.1);
            border: 1px solid #f39c12;
            color: #e67e22;
        }

        .alert-info {
            background: rgba(52, 152, 219, 0.1);
            border: 1px solid #3498db;
            color: #2980b9;
        }

        /* Current Subscription Card */
        .current-subscription {
            background: rgba(255,255,255,0.95);
            padding: 2rem;
            border-radius: 15px;
            margin-bottom: 2rem;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
        }

        .subscription-status {
            display: inline-block;
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-weight: bold;
            margin-left: 1rem;
        }

        .status-active {
            background: #2ecc71;
            color: white;
        }

        .status-expired {
            background: #e74c3c;
            color: white;
        }

        .status-none {
            background: #95a5a6;
            color: white;
        }

        /* Form */
        .form-container {
            background: rgba(255,255,255,0.95);
            padding: 2rem;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            margin-bottom: 2rem;
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-group label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 600;
            color: #2c3e50;
        }

        .form-control {
            width: 100%;
            padding: 1rem;
            border: 2px solid #ecf0f1;
            border-radius: 8px;
            font-size: 1rem;
            transition: all 0.3s ease;
        }

        .form-control:focus {
            outline: none;
            border-color: #3498db;
            box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.1);
        }

        .subscription-option {
            background: #f8f9fa;
            padding: 1.5rem;
            border-radius: 8px;
            margin-bottom: 1rem;
            border: 2px solid transparent;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .subscription-option:hover {
            border-color: #3498db;
            background: #e3f2fd;
        }

        .subscription-option.selected {
            border-color: #f39c12;
            background: #fff3cd;
        }

        .subscription-option h4 {
            margin-bottom: 0.5rem;
            color: #2c3e50;
        }

        .subscription-option p {
            color: #7f8c8d;
            margin: 0;
        }

        .price {
            font-size: 1.2rem;
            font-weight: bold;
            color: #f39c12;
            float: right;
        }

        @media (max-width: 768px) {
            body {
                padding-left: 0;
            }
            
            .sidebar {
                transform: translateX(-100%);
            }
            
            .main-content {
                padding: 1rem;
            }
        }
    </style>
</head>
<body data-expired="${abonnement.expire}" data-duration="${abonnement.nbMoisAbonnement}" data-end-date="<fmt:formatDate value='${abonnement.finAbonnement}' pattern='yyyy-MM-dd'/>">
    <!-- Sidebar -->
    <div class="sidebar">
        <h2>📚 Bibliothèque</h2>
        <ul>
            <li><a href="/livres">📖 Catalogue</a></li>
            <li><a href="/emprunt" class="<c:if test='${isAdmin}'>show</c:if>">📋 Emprunts</a></li>
            <li><a href="/retour-sur-place" class="<c:if test='${isAdmin}'>show</c:if>">↩️ Retours</a></li>
            <li><a href="/abonnement/gestion">💳 Abonnements</a></li>
        </ul>
        <a href="/logout" class="logout-btn">🚪 Déconnexion</a>
    </div>

    <div class="main-content">
        <div class="page-header">
            <h1>🔄 Renouveler Abonnement</h1>
            <p>Bienvenue, <strong>${user.userName}</strong></p>
        </div>

        <!-- Messages -->
        <c:if test="${not empty success}">
            <div class="alert alert-success">✅ ${success}</div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="alert alert-error">❌ ${error}</div>
        </c:if>

        <!-- Current Subscription Info -->
        <div class="current-subscription">
            <h2>📋 Abonnement à Renouveler</h2>
            <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 1rem;">
                <div>
                    <p><strong>Utilisateur:</strong> ${abonnement.utilisateur.userName}</p>
                    <p><strong>Date de début:</strong> <fmt:formatDate value="${abonnement.dateDebutAbonnement}" pattern="dd/MM/yyyy"/></p>
                    <p><strong>Date de fin actuelle:</strong> <fmt:formatDate value="${abonnement.finAbonnement}" pattern="dd/MM/yyyy"/></p>
                    <p><strong>Durée actuelle:</strong> ${abonnement.nbMoisAbonnement} mois</p>
                </div>
                <div>
                    <c:choose>
                        <c:when test="${abonnement.actif}">
                            <span class="subscription-status status-active">ACTIF</span>
                        </c:when>
                        <c:when test="${abonnement.expire}">
                            <span class="subscription-status status-expired">EXPIRÉ</span>
                        </c:when>
                        <c:otherwise>
                            <span class="subscription-status status-none">${abonnement.statut}</span>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
            
            <c:choose>
                <c:when test="${abonnement.expire}">
                    <div class="alert alert-warning">
                        ⚠️ Cet abonnement a expiré. Le renouvellement commencera à partir d'aujourd'hui.
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="alert alert-info">
                        ℹ️ Cet abonnement est encore actif. Le renouvellement prolongera la date de fin existante.
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

        <!-- Renewal Form -->
        <div class="form-container">
            <h2>📝 Choisir la Prolongation</h2>
            <form method="post" action="/abonnement/renouveler/${abonnement.id}">
                <div class="form-group">
                    <label>Durée de prolongation :</label>
                    
                    <div class="subscription-option" onclick="selectOption(1, this)">
                        <h4>Prolonger de 1 mois</h4>
                        <p>Extension courte</p>
                        <span class="price">15€</span>
                        <div style="clear: both;"></div>
                    </div>
                    
                    <div class="subscription-option" onclick="selectOption(3, this)">
                        <h4>Prolonger de 3 mois</h4>
                        <p>Extension populaire - <strong>Économisez 10%</strong></p>
                        <span class="price">40€</span>
                        <div style="clear: both;"></div>
                    </div>
                    
                    <div class="subscription-option" onclick="selectOption(6, this)">
                        <h4>Prolonger de 6 mois</h4>
                        <p>Extension longue - <strong>Économisez 20%</strong></p>
                        <span class="price">72€</span>
                        <div style="clear: both;"></div>
                    </div>
                    
                    <div class="subscription-option" onclick="selectOption(12, this)">
                        <h4>Prolonger de 12 mois</h4>
                        <p>Extension maximale - <strong>Économisez 30%</strong></p>
                        <span class="price">126€</span>
                        <div style="clear: both;"></div>
                    </div>
                    
                    <input type="hidden" id="nbMois" name="nbMois" value="" required>
                </div>

                <div class="form-group" style="text-align: center; margin-top: 2rem;">
                    <button type="submit" class="btn btn-warning" id="submitBtn" disabled>
                        🔄 Renouveler l'Abonnement
                    </button>
                    <a href="/abonnement/gestion" class="btn btn-secondary">↩️ Retour</a>
                </div>
            </form>
        </div>

        <!-- Preview of new end date -->
        <div class="form-container" id="previewContainer" style="display: none;">
            <h3>📅 Aperçu du Renouvellement</h3>
            <p><strong>Nouvelle date de fin:</strong> <span id="newEndDate"></span></p>
            <p><strong>Nouvelle durée totale:</strong> <span id="newTotalDuration"></span> mois</p>
        </div>
    </div>

    <script>
        function selectOption(months, element) {
            // Retirer la sélection de toutes les options
            const options = document.querySelectorAll('.subscription-option');
            options.forEach(opt => opt.classList.remove('selected'));
            
            // Sélectionner l'option cliquée
            element.classList.add('selected');
            
            // Mettre à jour le champ caché
            document.getElementById('nbMois').value = months;
            
            // Activer le bouton de soumission
            document.getElementById('submitBtn').disabled = false;
            
            // Calculer et afficher l'aperçu
            updatePreview(months);
        }

        function updatePreview(additionalMonths) {
            // Récupérer les données depuis les attributs data
            const isExpired = document.body.getAttribute('data-expired') === 'true';
            const currentDuration = parseInt(document.body.getAttribute('data-duration'));
            
            let newTotalDuration;
            
            if (isExpired) {
                newTotalDuration = additionalMonths;
            } else {
                newTotalDuration = currentDuration + additionalMonths;
            }
            
            // Calculer la nouvelle date de fin (approximation)
            const today = new Date();
            let baseDate;
            
            if (isExpired) {
                baseDate = today;
            } else {
                baseDate = new Date(document.body.getAttribute('data-end-date'));
            }
            
            const newEndDate = new Date(baseDate.getFullYear(), baseDate.getMonth() + additionalMonths, baseDate.getDate());
            const formattedDate = newEndDate.toLocaleDateString('fr-FR');
            
            // Mettre à jour l'aperçu
            document.getElementById('newEndDate').textContent = formattedDate;
            document.getElementById('newTotalDuration').textContent = newTotalDuration;
            document.getElementById('previewContainer').style.display = 'block';
        }
    </script>
</body>
</html>
