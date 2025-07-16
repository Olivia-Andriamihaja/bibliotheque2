<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tableau de Bord - Bibliothèque</title>
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
            padding: 2rem;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
        }

        .header {
            background: rgba(255,255,255,0.95);
            padding: 2rem;
            border-radius: 15px;
            margin-bottom: 2rem;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            text-align: center;
        }

        .header h1 {
            color: #2c3e50;
            margin-bottom: 1rem;
            font-size: 2.5rem;
            font-weight: 300;
        }

        .dashboard-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 2rem;
            margin-bottom: 2rem;
        }

        .card {
            background: rgba(255,255,255,0.95);
            padding: 2rem;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
        }

        .card h2 {
            color: #2c3e50;
            margin-bottom: 1rem;
            font-size: 1.5rem;
        }

        .subscription-status {
            display: inline-block;
            padding: 0.8rem 1.5rem;
            border-radius: 25px;
            font-weight: bold;
            margin: 1rem 0;
            font-size: 1.1rem;
        }

        .status-active {
            background: linear-gradient(135deg, #2e6bcc, #2749ae);
            color: white;
        }

        .status-expired {
            background: linear-gradient(135deg, #e74c3c, #c0392b);
            color: white;
        }

        .status-none {
            background: linear-gradient(135deg, #95a5a6, #7f8c8d);
            color: white;
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

        .btn-success {
            background: linear-gradient(135deg, #2e7dcc, #2761ae);
            color: white;
        }

        .btn-warning {
            background: linear-gradient(135deg, #f39c12, #e67e22);
            color: white;
        }

        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
        }

        .quick-actions {
            display: flex;
            flex-wrap: wrap;
            gap: 1rem;
            margin-top: 1.5rem;
        }

        .alert {
            padding: 1rem 1.5rem;
            border-radius: 8px;
            margin-bottom: 1rem;
            font-weight: 500;
        }

        .alert-info {
            background: rgba(52, 152, 219, 0.1);
            border: 1px solid #3498db;
            color: #2980b9;
        }

        .alert-warning {
            background: rgba(243, 156, 18, 0.1);
            border: 1px solid #f39c12;
            color: #e67e22;
        }

        .stats {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
            gap: 1rem;
            margin-top: 1rem;
        }

        .stat-item {
            text-align: center;
            padding: 1rem;
            background: #f8f9fa;
            border-radius: 8px;
        }

        .stat-number {
            font-size: 2rem;
            font-weight: bold;
            color: #3498db;
        }

        .stat-label {
            color: #7f8c8d;
            font-size: 0.9rem;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>📚 Tableau de Bord</h1>
            <p>Bienvenue, <strong>${user.userName}</strong> !</p>
        </div>

        <div class="dashboard-grid">
            <!-- Card Abonnement -->
            <div class="card">
                <h2>💳 Mon Abonnement</h2>
                
                <c:choose>
                    <c:when test="${abonnementActuel != null}">
                        <div>
                            <p>Abonnement actif jusqu'au <strong><fmt:formatDate value="${abonnementActuel.finAbonnement}" pattern="dd/MM/yyyy"/></strong></p>
                            <c:choose>
                                <c:when test="${abonnementActuel.actif}">
                                    <span class="subscription-status status-active">✅ ACTIF</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="subscription-status status-expired">❌ EXPIRÉ</span>
                                </c:otherwise>
                            </c:choose>
                            <p style="margin-top: 1rem;">Durée: ${abonnementActuel.nbMoisAbonnement} mois</p>
                        </div>
                        
                        <div class="quick-actions">
                            <a href="/abonnement/renouveler/${abonnementActuel.id}" class="btn btn-warning">🔄 Renouveler</a>
                            <a href="/abonnement/gestion" class="btn btn-primary">📋 Gérer</a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div>
                            <span class="subscription-status status-none">❌ AUCUN ABONNEMENT</span>
                            <div class="alert alert-warning" style="margin-top: 1rem;">
                                ⚠️ Vous devez souscrire un abonnement pour accéder aux services de la bibliothèque.
                            </div>
                        </div>
                        
                        <div class="quick-actions">
                            <a href="/abonnement/nouveau" class="btn btn-success">➕ Nouveau Abonnement</a>
                            <a href="/abonnement/gestion" class="btn btn-primary">📋 Voir détails</a>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- Card Navigation -->
            <div class="card">
                <h2>🧭 Navigation Rapide</h2>
                <div class="alert alert-info">
                    ℹ️ Accédez rapidement aux fonctionnalités de la bibliothèque.
                </div>
                
                <div class="quick-actions">
                    <a href="/livres" class="btn btn-primary">📖 Catalogue</a>
                    <c:if test="${user.profilFormule != null && user.profilFormule.profil == 'admin'}">
                        <a href="/emprunt" class="btn btn-primary">📋 Emprunts</a>
                        <a href="/retour-sur-place" class="btn btn-primary">↩️ Retours</a>
                    </c:if>
                    <a href="/abonnement/gestion" class="btn btn-primary">💳 Abonnements</a>
                </div>
            </div>

            <!-- Card Profil -->
            <div class="card">
                <h2>👤 Mon Profil</h2>
                <div class="stats">
                    <div class="stat-item">
                        <div class="stat-number">${user.profilFormule.profil}</div>
                        <div class="stat-label">Type de profil</div>
                    </div>
                    <div class="stat-item">
                        <div class="stat-number">${user.email}</div>
                        <div class="stat-label">Email</div>
                    </div>
                    <div class="stat-item">
                        <div class="stat-number">${user.numero}</div>
                        <div class="stat-label">Numéro</div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Actions rapides en bas -->
        <div class="card">
            <h2>⚡ Actions Rapides</h2>
            <div style="display: flex; justify-content: space-between; align-items: center; flex-wrap: wrap;">
                <div class="quick-actions">
                    <a href="/livres" class="btn btn-primary">📖 Parcourir le Catalogue</a>
                    <a href="/abonnement/gestion" class="btn btn-success">💳 Gérer mon Abonnement</a>
                </div>
                <div>
                    <a href="/logout" class="btn" style="background: #e74c3c; color: white;">🚪 Déconnexion</a>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
