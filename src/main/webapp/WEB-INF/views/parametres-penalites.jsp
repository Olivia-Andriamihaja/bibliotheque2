<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Paramètres des Pénalités</title>
    <style>
        :root {
            --primary-color: #2c3e50;
            --secondary-color: #34495e;
            --accent-color: #3498db;
            --light-color: #ecf0f1;
            --dark-color: #2c3e50;
            --success-color: #27ae60;
            --warning-color: #f39c12;
            --danger-color: #e74c3c;
            --border-radius: 8px;
            --box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            --transition: all 0.3s ease;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f5f7fa;
            color: var(--dark-color);
            line-height: 1.6;
        }

        .app-container {
            display: flex;
            min-height: 100vh;
        }

        /* Sidebar */
        .sidebar {
            width: 260px;
            background-color: var(--primary-color);
            color: white;
            padding: 2rem 1.5rem;
            position: fixed;
            height: 100%;
            box-shadow: 2px 0 10px rgba(0, 0, 0, 0.1);
            transition: var(--transition);
            z-index: 100;
        }

        .sidebar-header {
            display: flex;
            align-items: center;
            margin-bottom: 2.5rem;
            padding-bottom: 1rem;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        }

        .sidebar-logo {
            width: 40px;
            height: 40px;
            background-color: var(--accent-color);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 12px;
            color: white;
            font-size: 1.2rem;
        }

        .sidebar-title {
            font-size: 1.2rem;
            font-weight: 600;
        }

        .sidebar-nav {
            margin-top: 1rem;
        }

        .sidebar-link {
            display: flex;
            align-items: center;
            padding: 0.8rem 1rem;
            margin-bottom: 0.5rem;
            color: rgba(255, 255, 255, 0.8);
            text-decoration: none;
            border-radius: var(--border-radius);
            transition: var(--transition);
        }

        .sidebar-link:hover {
            background-color: rgba(255, 255, 255, 0.1);
            color: white;
        }

        .sidebar-link i {
            margin-right: 10px;
            font-size: 1.1rem;
        }

        .sidebar-link.active {
            background-color: var(--accent-color);
            color: white;
        }

        .btn-logout {
            width: 100%;
            padding: 0.8rem;
            background-color: var(--danger-color);
            color: white;
            border: none;
            border-radius: var(--border-radius);
            margin-top: 2rem;
            cursor: pointer;
            font-weight: 500;
            transition: var(--transition);
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .btn-logout:hover {
            background-color: #c0392b;
        }

        .btn-logout i {
            margin-right: 8px;
        }

        /* Main Content */
        .main-content {
            flex: 1;
            margin-left: 260px;
            padding: 2.5rem;
        }

        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2.5rem;
        }

        .page-title {
            font-size: 1.8rem;
            font-weight: 600;
            color: var(--primary-color);
        }

        .alert {
            padding: 1rem;
            border-radius: var(--border-radius);
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
        }

        .alert-success {
            background-color: rgba(39, 174, 96, 0.1);
            color: var(--success-color);
            border-left: 4px solid var(--success-color);
        }

        .alert-success::before {
            content: '\f058'; /* Font Awesome check-circle */
            font-family: 'Font Awesome 6 Free';
            font-weight: 900;
            margin-right: 0.8rem;
            font-size: 1.2rem;
        }

        .alert-error {
            background-color: rgba(231, 76, 60, 0.1);
            color: var(--danger-color);
            border-left: 4px solid var(--danger-color);
        }

        .alert-error::before {
            content: '\f06a'; /* Font Awesome exclamation-circle */
            font-family: 'Font Awesome 6 Free';
            font-weight: 900;
            margin-right: 0.8rem;
            font-size: 1.2rem;
        }

        .config-container {
            max-width: 800px;
            background-color: white;
            border-radius: var(--border-radius);
            padding: 1.5rem;
            box-shadow: var(--box-shadow);
            transition: var(--transition);
        }

        .config-container:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15);
        }

        .param-card {
            background-color: #f9f9f9;
            border: 1px solid #bdc3c7;
            border-radius: var(--border-radius);
            padding: 1rem;
            margin-bottom: 1rem;
            transition: var(--transition);
        }

        .param-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.1);
        }

        .param-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 0.5rem;
        }

        .param-title {
            font-size: 1.2rem;
            font-weight: 600;
            color: var(--primary-color);
        }

        .param-title::before {
            content: '\f013'; /* Font Awesome cog */
            font-family: 'Font Awesome 6 Free';
            font-weight: 900;
            margin-right: 0.5rem;
        }

        .param-value {
            font-size: 1.2rem;
            font-weight: 600;
            color: var(--success-color);
        }

        .param-description {
            font-size: 0.95rem;
            color: #7f8c8d;
            margin-bottom: 0.5rem;
        }

        .param-description::before {
            content: '\f05a'; /* Font Awesome info-circle */
            font-family: 'Font Awesome 6 Free';
            font-weight: 900;
            margin-right: 0.5rem;
        }

        .param-form {
            display: flex;
            gap: 0.5rem;
            align-items: center;
        }

        .param-input {
            width: 100px;
            padding: 0.6rem;
            border: 1px solid #bdc3c7;
            border-radius: var(--border-radius);
            font-size: 0.95rem;
            color: var(--dark-color);
            transition: var(--transition);
        }

        .param-input:focus {
            border-color: var(--accent-color);
            outline: none;
            box-shadow: 0 0 5px rgba(52, 152, 219, 0.3);
        }

        .btn-update {
            padding: 0.6rem 1rem;
            background-color: var(--accent-color);
            color: white;
            border: none;
            border-radius: var(--border-radius);
            cursor: pointer;
            font-weight: 500;
            transition: var(--transition);
            font-size: 0.95rem;
        }

        .btn-update:hover {
            background-color: #2980b9;
        }

        .info-box {
            background-color: white;
            border: 1px solid #bdc3c7;
            border-radius: var(--border-radius);
            padding: 1rem;
            margin: 1rem 0;
            box-shadow: var(--box-shadow);
            transition: var(--transition);
        }

        .info-box:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15);
        }

        .info-box h3 {
            font-size: 1.4rem;
            font-weight: 600;
            color: var(--primary-color);
            margin-bottom: 0.5rem;
        }

        .info-box p, .info-box ul {
            font-size: 0.95rem;
            color: #7f8c8d;
        }

        .info-box ul li::before {
            content: '\f0a9'; /* Font Awesome arrow-circle-right */
            font-family: 'Font Awesome 6 Free';
            font-weight: 900;
            margin-right: 0.5rem;
        }

        .example-box {
            background-color: white;
            border: 1px solid #bdc3c7;
            border-radius: var(--border-radius);
            padding: 1rem;
            margin: 1rem 0;
            box-shadow: var(--box-shadow);
            transition: var(--transition);
        }

        .example-box:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15);
        }

        .example-box h3 {
            font-size: 1.4rem;
            font-weight: 600;
            color: var(--primary-color);
            margin-bottom: 0.5rem;
        }

        .example-box p, .example-box ul {
            font-size: 0.95rem;
            color: #7f8c8d;
        }

        /* Responsive */
        @media (max-width: 992px) {
            .sidebar {
                width: 220px;
                padding: 1.5rem 1rem;
            }
            
            .main-content {
                margin-left: 220px;
                padding: 1.5rem;
            }
        }

        @media (max-width: 768px) {
            .sidebar {
                transform: translateX(-100%);
                position: fixed;
                z-index: 1000;
            }
            
            .sidebar.active {
                transform: translateX(0);
            }
            
            .main-content {
                margin-left: 0;
            }
            
            .param-form {
                flex-direction: column;
                align-items: flex-start;
            }
            
            .param-input {
                width: 100%;
            }
        }

        @media (max-width: 576px) {
            .config-container {
                padding: 1rem;
            }
            
            .page-title {
                font-size: 1.6rem;
            }
        }
    </style>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>
    <div class="app-container">
        <!-- Sidebar -->
        <div class="sidebar">
            <div class="sidebar-header">
                <div class="sidebar-logo">
                    <i class="fas fa-book"></i>
                </div>
                <h2 class="sidebar-title">Bibliothèque</h2>
            </div>
            <nav class="sidebar-nav">
                <a href="${pageContext.request.contextPath}/livres" class="sidebar-link">
                    <i class="fas fa-home"></i> Accueil
                </a>
                <c:if test="${isAdmin}">
                    <a href="${pageContext.request.contextPath}/emprunt/nouveau" class="sidebar-link">
                        <i class="fas fa-book-open"></i> Emprunter un livre
                    </a>
                    <a href="${pageContext.request.contextPath}/emprunt/retour-sur-place" class="sidebar-link">
                        <i class="fas fa-exchange-alt"></i> Retour lecture sur place
                    </a>
                    <a href="${pageContext.request.contextPath}/emprunt/prolongement" class="sidebar-link">
                        <i class="fas fa-clock"></i> Prolonger un emprunt
                    </a>
                    <a href="${pageContext.request.contextPath}/penalite/gestion" class="sidebar-link">
                        <i class="fas fa-gavel"></i> Gestion des pénalités
                    </a>
                    <a href="${pageContext.request.contextPath}/penalite/parametres" class="sidebar-link active">
                        <i class="fas fa-cog"></i> Paramètres des pénalités
                    </a>
                </c:if>
                <a href="${pageContext.request.contextPath}/reservation/mes-reservations" class="sidebar-link">
                    <i class="fas fa-list"></i> Mes réservations
                </a>
                <a href="${pageContext.request.contextPath}/penalite/mes-penalites" class="sidebar-link">
                    <i class="fas fa-money-bill-wave"></i> Mes pénalités
                </a>
                <form action="${pageContext.request.contextPath}/logout" method="post" style="margin:0;">
                    <button type="submit" class="btn-logout">
                        <i class="fas fa-sign-out-alt"></i> Déconnexion
                    </button>
                </form>
            </nav>
        </div>
        
        <!-- Main Content -->
        <div class="main-content">
            <div class="page-header">
                <h1 class="page-title">Paramètres des Pénalités</h1>
            </div>
            
            <!-- Messages d'alerte -->
            <c:if test="${not empty success}">
                <div class="alert alert-success">${success}</div>
            </c:if>
            <c:if test="${not empty error}">
                <div class="alert alert-error">${error}</div>
            </c:if>
            
            <div class="config-container">
                <div class="info-box">
                    <h3>Configuration Actuelle</h3>
                    <p><strong>${config}</strong></p>
                </div>

                <!-- Paramètres modifiables -->
                <c:forEach items="${parametres}" var="param">
                    <div class="param-card">
                        <div class="param-header">
                            <div>
                                <div class="param-title">
                                    <c:choose>
                                        <c:when test="${param.nomParametre == 'JOURS_GRACE'}">Période de grâce</c:when>
                                        <c:when test="${param.nomParametre == 'PENALITE_BASE_JOURS'}">Pénalité de base</c:when>
                                        <c:when test="${param.nomParametre == 'PENALITE_PAR_JOUR_RETARD'}">Pénalité par jour de retard</c:when>
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
                                   required 
                                   step="1" 
                                   aria-label="Nouvelle valeur pour ${param.nomParametre}">
                            <button type="submit" class="btn-update">Modifier</button>
                        </form>
                    </div>
                </c:forEach>
                
                <div class="example-box">
                    <h3>Simulation avec les paramètres actuels</h3>
                    <div id="simulation">
                        <p><strong>Exemple :</strong> Un livre devait être rendu le 1er juillet, mais est rendu le 10 juillet (9 jours de retard)</p>
                        <div id="calcul-simulation"></div>
                    </div>
                </div>
                
                <div class="info-box">
                    <h3>Comment ça fonctionne</h3>
                    <ul>
                        <li><strong>Période de grâce :</strong> Délai accordé après la date d'échéance avant d'appliquer une pénalité</li>
                        <li><strong>Pénalité de base :</strong> Durée minimale de blocage des emprunts</li>
                        <li><strong>Pénalité par jour :</strong> Jours supplémentaires ajoutés pour chaque jour de retard au-delà de la grâce</li>
                    </ul>
                    <p><strong>Formule :</strong> Pénalité = Base + ((Jours de retard - Grâce) × Pénalité par jour)</p>
                </div>
            </div>
        </div>
    </div>

    <script>
        function calculerSimulation() {
            const inputs = document.querySelectorAll('input[name="valeur"][type="number"]');
            const joursGrace = inputs[0] ? parseInt(inputs[0].value) || 3 : 3;
            const penaliteBase = inputs[1] ? parseInt(inputs[1].value) || 7 : 7;
            const penaliteParJour = inputs[2] ? parseInt(inputs[2].value) || 2 : 2;

            console.log('Simulation - Jours de grâce:', joursGrace, 'Pénalité de base:', penaliteBase, 'Pénalité par jour:', penaliteParJour);

            const joursRetard = 9; // Exemple fixe
            const joursRetardEffectif = Math.max(0, joursRetard - joursGrace);
            const penaliteTotal = penaliteBase + (joursRetardEffectif * penaliteParJour);

            const simulationDiv = document.getElementById('calcul-simulation');
            if (simulationDiv) {
                simulationDiv.innerHTML = `
                    <ul>
                        <li>Retard réel : ${joursRetard} jours</li>
                        <li>Période de grâce : ${joursGrace} jours → Retard effectif : ${joursRetard} - ${joursGrace} = ${joursRetardEffectif} jours</li>
                        <li>Calcul : ${penaliteBase} jours (base) + (${joursRetardEffectif} × ${penaliteParJour}) = <strong>${penaliteTotal} jours de pénalité</strong></li>
                    </ul>
                    <p><strong>Résultat :</strong> L'utilisateur ne pourra pas emprunter pendant ${penaliteTotal} jours</p>
                `;
            } else {
                console.error('Élément #calcul-simulation non trouvé');
            }
        }

        function initializeInputs() {
            const inputs = document.querySelectorAll('input[name="valeur"][type="number"]');
            inputs.forEach(input => {
                // S'assurer que l'input n'est pas désactivé ou en lecture seule
                input.removeAttribute('disabled');
                input.removeAttribute('readonly');
                
                input.addEventListener('input', () => {
                    console.log(`Input changé - ID: ${input.id}, Valeur: ${input.value}`);
                    calculerSimulation();
                });

                // Ajouter un écouteur pour confirmer le focus
                input.addEventListener('focus', () => {
                    console.log(`Focus sur l'input: ${input.id}`);
                });

                // Ajouter un écouteur pour les pressions de touches
                input.addEventListener('keydown', (e) => {
                    console.log(`Touche pressée dans ${input.id}: ${e.key}`);
                });
            });
        }

        document.addEventListener('DOMContentLoaded', () => {
            console.log('Page chargée, initialisation des inputs et calcul initial');
            initializeInputs();
            calculerSimulation();
        });
    </script>
</body>
</html>