<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestion des Abonnements - Bibliothèque</title>
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
            max-width: 1200px;
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

        .btn-success {
            background: linear-gradient(135deg, #2ecc71, #27ae60);
            color: white;
        }

        .btn-warning {
            background: linear-gradient(135deg, #f39c12, #e67e22);
            color: white;
        }

        .btn-danger {
            background: linear-gradient(135deg, #e74c3c, #c0392b);
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
            border: 1px solid #2ecc71;
            color: #27ae60;
        }

        .alert-error {
            background: rgba(231, 76, 60, 0.1);
            border: 1px solid #e74c3c;
            color: #c0392b;
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

        /* Table */
        .table-container {
            background: rgba(255,255,255,0.95);
            border-radius: 15px;
            padding: 2rem;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
        }

        .table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 1rem;
        }

        .table th,
        .table td {
            padding: 1rem;
            text-align: left;
            border-bottom: 1px solid #ecf0f1;
        }

        .table th {
            background: #f8f9fa;
            font-weight: 600;
            color: #2c3e50;
        }

        .table tbody tr:hover {
            background: #f8f9fa;
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
<body>
    <!-- Sidebar -->
    <div class="sidebar">
        <h2>📚 Bibliothèque</h2>
        <ul>
            <li><a href="/livres">📖 Catalogue</a></li>
            <li><a href="/emprunt" class="<c:if test='${isAdmin}'>show</c:if>">📋 Emprunts</a></li>
            <li><a href="/retour-sur-place" class="<c:if test='${isAdmin}'>show</c:if>">↩️ Retours</a></li>
            <li><a href="/abonnement/gestion" class="active">💳 Abonnements</a></li>
        </ul>
        <a href="/logout" class="logout-btn">🚪 Déconnexion</a>
    </div>

    <div class="main-content">
        <div class="page-header">
            <h1>💳 Gestion des Abonnements</h1>
            <p>Bienvenue, <strong>${user.userName}</strong></p>
        </div>

        <!-- Messages -->
        <c:if test="${not empty success}">
            <div class="alert alert-success">✅ ${success}</div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="alert alert-error">❌ ${error}</div>
        </c:if>

        <!-- Current Subscription Status -->
        <div class="current-subscription">
            <h2>📋 Mon Abonnement Actuel</h2>
            <c:choose>
                <c:when test="${abonnementActuel != null}">
                    <p>
                        Abonnement actif jusqu'au <strong><fmt:formatDate value="${abonnementActuel.finAbonnement}" pattern="dd/MM/yyyy"/></strong>
                        <c:choose>
                            <c:when test="${abonnementActuel.actif}">
                                <span class="subscription-status status-active">ACTIF</span>
                            </c:when>
                            <c:otherwise>
                                <span class="subscription-status status-expired">EXPIRÉ</span>
                            </c:otherwise>
                        </c:choose>
                    </p>
                    <p>Durée: ${abonnementActuel.nbMoisAbonnement} mois</p>
                    
                    <div style="margin-top: 1rem;">
                        <a href="/abonnement/renouveler/${abonnementActuel.id}" class="btn btn-warning">🔄 Renouveler</a>
                    </div>
                </c:when>
                <c:otherwise>
                    <p>
                        Aucun abonnement actif
                        <span class="subscription-status status-none">AUCUN</span>
                    </p>
                    <div style="margin-top: 1rem;">
                        <a href="/abonnement/nouveau" class="btn btn-success">➕ Nouveau Abonnement</a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

        <!-- Action Buttons -->
        <div style="margin-bottom: 2rem; text-align: center;">
            <a href="/abonnement/nouveau" class="btn btn-success">➕ Nouveau Abonnement</a>
        </div>

        <!-- Subscriptions Table -->
        <div class="table-container">
            <h2>📊 <c:choose><c:when test="${isAdmin}">Tous les Abonnements</c:when><c:otherwise>Historique de mes Abonnements</c:otherwise></c:choose></h2>
            
            <c:choose>
                <c:when test="${not empty abonnements}">
                    <table class="table">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <c:if test="${isAdmin}">
                                    <th>Utilisateur</th>
                                </c:if>
                                <th>Durée</th>
                                <th>Date Début</th>
                                <th>Date Fin</th>
                                <th>Statut</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="abonnement" items="${abonnements}">
                                <tr>
                                    <td>${abonnement.id}</td>
                                    <c:if test="${isAdmin}">
                                        <td>${abonnement.utilisateur.userName}</td>
                                    </c:if>
                                    <td>${abonnement.nbMoisAbonnement} mois</td>
                                    <td><fmt:formatDate value="${abonnement.dateDebutAbonnement}" pattern="dd/MM/yyyy"/></td>
                                    <td><fmt:formatDate value="${abonnement.finAbonnement}" pattern="dd/MM/yyyy"/></td>
                                    <td>
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
                                    </td>
                                    <td>
                                        <c:if test="${abonnement.utilisateur.id == user.id or isAdmin}">
                                            <a href="/abonnement/renouveler/${abonnement.id}" class="btn btn-warning" style="font-size: 0.9rem; padding: 8px 16px;">🔄 Renouveler</a>
                                        </c:if>
                                        <c:if test="${isAdmin}">
                                            <form method="post" action="/abonnement/admin/supprimer/${abonnement.id}" style="display: inline;" 
                                                  onsubmit="return confirm('Êtes-vous sûr de vouloir supprimer cet abonnement ?')">
                                                <button type="submit" class="btn btn-danger" style="font-size: 0.9rem; padding: 8px 16px;">🗑️ Supprimer</button>
                                            </form>
                                        </c:if>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:when>
                <c:otherwise>
                    <p style="text-align: center; color: #7f8c8d; margin: 2rem 0;">
                        <c:choose>
                            <c:when test="${isAdmin}">Aucun abonnement trouvé dans le système.</c:when>
                            <c:otherwise>Vous n'avez aucun abonnement pour le moment.</c:otherwise>
                        </c:choose>
                    </p>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</body>
</html>
