<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Paramètres des Pénalités</title>
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
            color: #604caf;
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
            background: #4c6aaf;
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
            background: #4c75af;
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
        
        .config-container {
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            background: #fff;
        }
        
        h2, h3 {
            color: #4c53af;
            margin-bottom: 20px;
        }
        
        .param-card {
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 15px;
            margin-bottom: 15px;
            background: #fff;
            transition: transform 0.2s, box-shadow 0.2s;
        }
        
        .param-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
        }
        
        .param-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 10px;
        }
        
        .param-title {
            font-size: 1.1em;
            font-weight: bold;
            color: #333;
        }
        
        .param-value {
            font-size: 1.5em;
            font-weight: bold;
            color: #4c7faf;
        }
        
        .param-description {
            color: #666;
            font-size: 0.9em;
            margin-bottom: 10px;
        }
        
        .param-form {
            display: flex;
            gap: 10px;
            align-items: center;
        }
        
        .param-input {
            width: 80px;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
            text-align: center;
            font-size: 0.9em;
        }
        
        .param-input:focus {
            outline: none;
            border-color: #4c68af;
        }
        
        .btn-update {
            background: #4c56af;
            color: #fff;
            border: none;
            padding: 8px 16px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 0.9em;
            font-weight: bold;
            transition: background 0.2s;
        }
        
        .btn-update:hover {
            background: #45a049;
        }
        
        .info-box {
            background: #e9ecef;
            padding: 15px;
            border-radius: 4px;
            margin: 15px 0;
            font-size: 0.9em;
        }
        
        .example-box {
            background: #e9ecef;
            padding: 15px;
            border-radius: 4px;
            margin: 15px 0;
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
            
            .config-container {
                padding: 15px;
            }
        }
        
        @media (max-width: 480px) {
            .config-container, .param-card {
                padding: 10px;
            }
            
            .param-form {
                flex-direction: column;
                align-items: flex-start;
            }
            
            .param-input {
                width: 100%;
            }
            
            .btn-update {
                width: 100%;
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
            <a href="${pageContext.request.contextPath}/penalite/parametres" class="active">Paramètres des pénalités</a>
        </c:if>
        <a href="${pageContext.request.contextPath}/reservation/mes-reservations">Mes réservations</a>
        <a href="${pageContext.request.contextPath}/penalite/mes-penalites">Mes pénalités</a>
        <form action="${pageContext.request.contextPath}/logout" method="post" style="margin:0;">
            <button type="submit" class="btn-logout">Déconnexion</button>
        </form>
    </div>
    
    <div class="main-content">
        <h1>⚙️ Paramètres des Pénalités</h1>
        
        <!-- Messages d'alerte -->
        <c:if test="${not empty success}">
            <div class="alert alert-success">✅ ${success}</div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="alert alert-error">❌ ${error}</div>
        </c:if>
        
        <div class="config-container">
            <div class="info-box">
                <h3>📊 Configuration Actuelle</h3>
                <p><strong>${config}</strong></p>
            </div>

            <!-- Paramètres modifiables -->
            <c:forEach items="${parametres}" var="param">
                <div class="param-card">
                    <div class="param-header">
                        <div>
                            <div class="param-title">
                                <c:choose>
                                    <c:when test="${param.nomParametre == 'JOURS_GRACE'}">🕐 Période那 de grâce</c:when>
                                    <c:when test="${param.nomParametre == 'PENALITE_BASE_JOURS'}">⏱️ Pénalité de base</c:when>
                                    <c:when test="${param.nomParametre == 'PENALITE_PAR_JOUR_RETARD'}">📈 Pénalité par jour de retard</c:when>
                                    <c:otherwise>${param.nomParametre}</c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                        <div class="param-value">${param.valeur} jour(s)</div>
                    </div>
                    
                    <div class="param-description">${param.description}</div>
                    
                    <form action="${pageContext.request.contextPath}/penalite/parametres/modifier" method="post" class="param-form">
                        <input type="hidden" name="parametre" value="${param.nomParametre}">
                        <label for="valeur_${param.nomParametre}">Nouvelle valeur :</label>
                        <input type="number" 
                               id="valeur_${param.nomParametre}" 
                               name="valeur" 
                               value="${param.valeur}" 
                               min="0" 
                               max="365" 
                               class="param-input" 
                               required>
                        <button type="submit" class="btn-update">Modifier</button>
                    </form>
                </div>
            </c:forEach>
            
            <div class="example-box">
                <h3>📝 Simulation avec les paramètres actuels</h3>
                <div id="simulation">
                    <p><strong>Exemple :</strong> Un livre devait être rendu le 1er juillet, mais est rendu le 10 juillet (9 jours de retard)</p>
                    <div id="calcul-simulation"></div>
                </div>
            </div>
            
            <div class="info-box">
                <h3>ℹ️ Comment ça fonctionne</h3>
                <ul>
                    <li><strong>Période de grâce :</strong> Délai accordé après la date d'échéance avant d'appliquer une pénalité</li>
                    <li><strong>Pénalité de base :</strong> Durée minimale de blocage des emprunts</li>
                    <li><strong>Pénalité par jour :</strong> Jours supplémentaires ajoutés pour chaque jour de retard au-delà de la grâce</li>
                </ul>
                <p><strong>Formule :</strong> Pénalité = Base + ((Jours de retard - Grâce) × Pénalité par jour)</p>
            </div>
        </div>
    </div>

    <script>
        // Simulation automatique du calcul
        function calculerSimulation() {
            const joursGrace = parseInt(document.querySelector('input[name="valeur"][type="number"]').value) || 3;
            const penaliteBase = parseInt(document.querySelectorAll('input[name="valeur"][type="number"]')[1].value) || 7;
            const penaliteParJour = parseInt(document.querySelectorAll('input[name="valeur"][type="number"]')[2].value) || 2;
            
            const joursRetard = 9; // Exemple fixe
            const joursRetardEffectif = Math.max(0, joursRetard - joursGrace);
            const penaliteTotal = penaliteBase + (joursRetardEffectif * penaliteParJour);
            
            document.getElementById('calcul-simulation').innerHTML = `
                <ul>
                    <li>Retard réel : ${joursRetard} jours</li>
                    <li>Période de grâce : ${joursGrace} jours → Retard effectif : ${joursRetard} - ${joursGrace} = ${joursRetardEffectif} jours</li>
                    <li>Calcul : ${penaliteBase} jours (base) + (${joursRetardEffectif} × ${penaliteParJour}) = <strong>${penaliteTotal} jours de pénalité</strong></li>
                </ul>
                <p><strong>Résultat :</strong> L'utilisateur ne pourra pas emprunter pendant ${penaliteTotal} jours</p>
            `;
        }
        
        // Recalculer à chaque modification d'input
        document.querySelectorAll('input[type="number"]').forEach(input => {
            input.addEventListener('input', calculerSimulation);
        });
        
        // Calcul initial
        document.addEventListener('DOMContentLoaded', calculerSimulation);
    </script>
</body>
</html>