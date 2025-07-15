<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Inscription - Bibliothèque</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            background: linear-gradient(135deg, #8B4513 0%, #D2691E 25%, #F4A460 50%, #DEB887 75%, #F5DEB3 100%);
            min-height: 100vh;
            font-family: 'Georgia', 'Times New Roman', serif;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px 0;
            position: relative;
            overflow-x: hidden;
        }
        
        /* Effet de texture papier ancien */
        body::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: 
                radial-gradient(circle at 20% 80%, rgba(120, 119, 108, 0.3) 0%, transparent 50%),
                radial-gradient(circle at 80% 20%, rgba(255, 255, 255, 0.1) 0%, transparent 50%),
                radial-gradient(circle at 40% 40%, rgba(139, 69, 19, 0.2) 0%, transparent 50%);
            pointer-events: none;
        }
        
        .inscription-container {
            background: linear-gradient(145deg, #FAEBD7 0%, #F5F5DC 100%);
            border-radius: 20px;
            box-shadow: 
                0 20px 40px rgba(0,0,0,0.3),
                inset 0 1px 0 rgba(255,255,255,0.8),
                0 0 0 1px rgba(139, 69, 19, 0.2);
            padding: 50px 40px;
            max-width: 500px;
            width: 100%;
            position: relative;
            border: 3px solid #8B4513;
        }
        
        /* Décoration des coins */
        .inscription-container::before,
        .inscription-container::after {
            content: '';
            position: absolute;
            width: 30px;
            height: 30px;
            background: #8B4513;
            transform: rotate(45deg);
        }
        
        .inscription-container::before {
            top: -6px;
            left: -6px;
        }
        
        .inscription-container::after {
            bottom: -6px;
            right: -6px;
        }
        
        /* Logo bibliothèque */
        .library-logo {
            width: 80px;
            height: 80px;
            margin: 0 auto 30px;
            background: linear-gradient(145deg, #8B4513, #A0522D);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            box-shadow: 
                0 8px 16px rgba(0,0,0,0.3),
                inset 0 2px 4px rgba(255,255,255,0.3);
            position: relative;
        }
        
        .library-logo::before {
            content: '📝';
            font-size: 35px;
            color: #F5DEB3;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.5);
        }
        
        .library-logo::after {
            content: '';
            position: absolute;
            width: 90px;
            height: 90px;
            border: 2px solid #D2691E;
            border-radius: 50%;
            top: -5px;
            left: -5px;
            opacity: 0.6;
        }
        
        h2 {
            text-align: center;
            color: #8B4513;
            margin-bottom: 35px;
            font-size: 2.2em;
            font-weight: bold;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.1);
            position: relative;
        }
        
        h2::after {
            content: '';
            position: absolute;
            bottom: -10px;
            left: 50%;
            transform: translateX(-50%);
            width: 120px;
            height: 3px;
            background: linear-gradient(90deg, #8B4513, #D2691E, #8B4513);
            border-radius: 2px;
        }
        
        form {
            display: flex;
            flex-direction: column;
            gap: 25px;
        }
        
        .form-group {
            display: flex;
            flex-direction: column;
            position: relative;
        }
        
        label, .form-label {
            font-weight: 600;
            color: #654321;
            margin-bottom: 10px;
            font-size: 1.1em;
            position: relative;
        }
        
        /* Icônes pour chaque type de champ */
        label[for*="userName"]::before, .form-label:has(+ input[path="userName"])::before {
            content: '👤';
            margin-right: 8px;
            font-size: 0.9em;
        }
        
        label[for*="motDePasse"]::before, .form-label:has(+ input[path="motDePasse"])::before {
            content: '🔐';
            margin-right: 8px;
            font-size: 0.9em;
        }
        
        label[for*="email"]::before, .form-label:has(+ input[path="email"])::before {
            content: '📧';
            margin-right: 8px;
            font-size: 0.9em;
        }
        
        label[for*="numero"]::before, .form-label:has(+ input[path="numero"])::before {
            content: '📞';
            margin-right: 8px;
            font-size: 0.9em;
        }
        
        label[for*="profil"]::before, .form-label:has(+ select[path="profilFormule"])::before {
            content: '👥';
            margin-right: 8px;
            font-size: 0.9em;
        }
        
        /* Ciblage spécifique pour les labels Spring Form */
        .form-label {
            position: relative;
        }
        
        .form-label:nth-of-type(1)::before {
            content: '👤';
            margin-right: 8px;
            font-size: 0.9em;
        }
        
        .form-label:nth-of-type(2)::before {
            content: '🔐';
            margin-right: 8px;
            font-size: 0.9em;
        }
        
        .form-label:nth-of-type(3)::before {
            content: '📧';
            margin-right: 8px;
            font-size: 0.9em;
        }
        
        .form-label:nth-of-type(4)::before {
            content: '📞';
            margin-right: 8px;
            font-size: 0.9em;
        }
        
        .form-label:nth-of-type(5)::before {
            content: '👥';
            margin-right: 8px;
            font-size: 0.9em;
        }
        
        input[type="text"], input[type="password"], input[type="email"], input[type="number"], select {
            padding: 15px 20px;
            border: 2px solid #D2691E;
            border-radius: 12px;
            font-size: 1.1em;
            background: linear-gradient(145deg, #FFFEF7, #F5F5DC);
            transition: all 0.4s ease;
            box-sizing: border-box;
            font-family: 'Georgia', serif;
            box-shadow: inset 0 2px 4px rgba(0,0,0,0.1);
        }
        
        input[type="text"]:focus, input[type="password"]:focus, input[type="email"]:focus, input[type="number"]:focus, select:focus {
            border: 2px solid #8B4513;
            outline: none;
            background: #FFFEF7;
            box-shadow: 
                0 0 0 3px rgba(139, 69, 19, 0.2),
                inset 0 2px 4px rgba(0,0,0,0.1);
            transform: translateY(-2px);
        }
        
        select {
            cursor: pointer;
            appearance: none;
            background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' fill='%23654321' viewBox='0 0 16 16'%3e%3cpath d='M8 11L3 6h10l-5 5z'/%3e%3c/svg%3e");
            background-repeat: no-repeat;
            background-position: right 15px center;
            background-size: 16px;
            padding-right: 45px;
        }
        
        input[type="submit"] {
            background: linear-gradient(145deg, #8B4513 0%, #A0522D 50%, #8B4513 100%);
            color: #F5DEB3;
            border: none;
            border-radius: 12px;
            padding: 16px 40px;
            font-size: 1.2em;
            font-weight: bold;
            cursor: pointer;
            margin-top: 20px;
            transition: all 0.4s ease;
            font-family: 'Georgia', serif;
            text-shadow: 1px 1px 2px rgba(0,0,0,0.3);
            box-shadow: 
                0 8px 16px rgba(0,0,0,0.3),
                inset 0 1px 0 rgba(255,255,255,0.2);
            position: relative;
            overflow: hidden;
        }
        
        input[type="submit"]::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.3), transparent);
            transition: left 0.6s ease;
        }
        
        input[type="submit"]:hover::before {
            left: 100%;
        }
        
        input[type="submit"]:hover {
            background: linear-gradient(145deg, #A0522D 0%, #8B4513 50%, #A0522D 100%);
            transform: translateY(-3px);
            box-shadow: 
                0 12px 24px rgba(0,0,0,0.4),
                inset 0 1px 0 rgba(255,255,255,0.2);
        }
        
        .login-link {
            text-align: center;
            margin-top: 30px;
            color: #8B4513;
            text-decoration: none;
            font-weight: 600;
            padding: 12px 24px;
            border: 2px solid #8B4513;
            border-radius: 10px;
            transition: all 0.4s ease;
            font-family: 'Georgia', serif;
            background: linear-gradient(145deg, #F5F5DC, #FAEBD7);
            box-shadow: 0 4px 8px rgba(0,0,0,0.2);
            display: inline-block;
        }
        
        .login-link:hover {
            background: linear-gradient(145deg, #8B4513, #A0522D);
            color: #F5DEB3;
            transform: translateY(-2px);
            box-shadow: 0 6px 12px rgba(0,0,0,0.3);
            text-decoration: none;
        }
        
        .error-message {
            color: #8B0000;
            background: linear-gradient(145deg, #FFE4E1, #FFF0F5);
            padding: 15px;
            border-radius: 10px;
            margin-bottom: 25px;
            font-size: 1em;
            border: 2px solid #DC143C;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }
        
        .error-message::before {
            content: '⚠️ ';
            font-size: 1.2em;
        }
        
        /* Décoration d'arrière-plan */
        .decoration {
            position: absolute;
            opacity: 0.1;
            pointer-events: none;
            font-size: 120px;
            color: #8B4513;
            z-index: -1;
        }
        
        .decoration:nth-child(1) {
            top: 10%;
            left: 5%;
            transform: rotate(-15deg);
        }
        
        .decoration:nth-child(2) {
            top: 40%;
            right: 5%;
            transform: rotate(15deg);
        }
        
        .decoration:nth-child(3) {
            bottom: 20%;
            left: 10%;
            transform: rotate(-10deg);
        }
        
        .decoration:nth-child(4) {
            top: 70%;
            right: 15%;
            transform: rotate(25deg);
        }
        
        @media (max-width: 600px) {
            .inscription-container {
                margin: 20px;
                padding: 40px 30px;
                max-width: 420px;
            }
            
            .library-logo {
                width: 70px;
                height: 70px;
            }
            
            .library-logo::before {
                font-size: 30px;
            }
            
            h2 {
                font-size: 1.8em;
            }
            
            .decoration {
                font-size: 80px;
            }
            
            form {
                gap: 20px;
            }
        }
        
        @media (max-width: 400px) {
            .inscription-container {
                padding: 30px 20px;
            }
            
            .decoration {
                display: none;
            }
            
            input[type="text"], input[type="password"], input[type="email"], input[type="number"], select {
                padding: 12px 15px;
                font-size: 1em;
            }
        }
    </style>
</head>
<body>
    <!-- Éléments décoratifs -->
    <div class="decoration">📚</div>
    <div class="decoration">📖</div>
    <div class="decoration">🏛️</div>
    <div class="decoration">✍️</div>
    
    <div class="inscription-container">
        <div class="library-logo"></div>
        <h2>Inscription</h2>

        <c:if test="${errorMessage != null}">
            <div class="error-message">
                ${errorMessage}
            </div>
        </c:if>

        <form:form method="post" modelAttribute="users">
            <div class="form-group">
                <form:label path="userName" cssClass="form-label">Nom d'utilisateur</form:label>
                <form:input path="userName" required="true"/>
            </div>
            <div class="form-group">
                <form:label path="motDePasse" cssClass="form-label">Mot de passe</form:label>
                <form:password path="motDePasse" required="true"/>
            </div>
            <div class="form-group">
                <form:label path="email" cssClass="form-label">Email</form:label>
                <form:input path="email" type="email" required="true"/>
            </div>
            <div class="form-group">
                <form:label path="numero" cssClass="form-label">Numéro</form:label>
                <form:input path="numero" type="number" required="true"/>
            </div>
            <div class="form-group">
                <form:label path="profilFormule" cssClass="form-label">Profil</form:label>
                <form:select path="profilFormule" required="true">
                    <form:option value="">-- Sélectionner un profil --</form:option>
                    <form:options items="${profilFormules}" itemLabel="profil" itemValue="id"/>
                </form:select>
            </div>
            <input type="submit" value="S'inscrire"/>
        </form:form>

        <a href="${pageContext.request.contextPath}/login" class="login-link">Déjà un compte ? Se connecter</a>
    </div>
</body>
</html>