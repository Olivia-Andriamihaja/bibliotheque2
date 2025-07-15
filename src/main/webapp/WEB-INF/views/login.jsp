<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Connexion - Bibliothèque</title>
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
            position: relative;
            overflow: hidden;
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
        
        .login-container {
            background: linear-gradient(145deg, #FAEBD7 0%, #F5F5DC 100%);
            border-radius: 20px;
            box-shadow: 
                0 20px 40px rgba(0,0,0,0.3),
                inset 0 1px 0 rgba(255,255,255,0.8),
                0 0 0 1px rgba(139, 69, 19, 0.2);
            padding: 50px 40px;
            max-width: 450px;
            width: 100%;
            text-align: center;
            position: relative;
            border: 3px solid #8B4513;
        }
        
        /* Décoration des coins */
        .login-container::before,
        .login-container::after {
            content: '';
            position: absolute;
            width: 30px;
            height: 30px;
            background: #8B4513;
            transform: rotate(45deg);
        }
        
        .login-container::before {
            top: -6px;
            left: -6px;
        }
        
        .login-container::after {
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
            content: '📚';
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
            width: 80px;
            height: 3px;
            background: linear-gradient(90deg, #8B4513, #D2691E, #8B4513);
            border-radius: 2px;
        }
        
        .form-group {
            margin-bottom: 25px;
            text-align: left;
            position: relative;
        }
        
        label {
            display: block;
            font-weight: 600;
            color: #654321;
            margin-bottom: 10px;
            font-size: 1.1em;
            position: relative;
        }
        
        label::before {
            content: '📖';
            margin-right: 8px;
            font-size: 0.9em;
        }
        
        input[type="text"], input[type="password"] {
            width: 100%;
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
        
        input[type="text"]:focus, input[type="password"]:focus {
            border: 2px solid #8B4513;
            outline: none;
            background: #FFFEF7;
            box-shadow: 
                0 0 0 3px rgba(139, 69, 19, 0.2),
                inset 0 2px 4px rgba(0,0,0,0.1);
            transform: translateY(-2px);
        }
        
        .submit-btn {
            background: linear-gradient(145deg, #8B4513 0%, #A0522D 50%, #8B4513 100%);
            color: #F5DEB3;
            border: none;
            border-radius: 12px;
            padding: 16px 40px;
            font-size: 1.2em;
            font-weight: bold;
            cursor: pointer;
            width: 100%;
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
            background: linear-gradient(145deg, #A0522D 0%, #8B4513 50%, #A0522D 100%);
            transform: translateY(-3px);
            box-shadow: 
                0 12px 24px rgba(0,0,0,0.4),
                inset 0 1px 0 rgba(255,255,255,0.2);
        }
        
        .inscription-link {
            display: inline-block;
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
        }
        
        .inscription-link:hover {
            background: linear-gradient(145deg, #8B4513, #A0522D);
            color: #F5DEB3;
            transform: translateY(-2px);
            box-shadow: 0 6px 12px rgba(0,0,0,0.3);
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
        
        .success-message {
            color: #006400;
            background: linear-gradient(145deg, #F0FFF0, #E6FFE6);
            padding: 15px;
            border-radius: 10px;
            margin-bottom: 25px;
            font-size: 1em;
            border: 2px solid #32CD32;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }
        
        .success-message::before {
            content: '✅ ';
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
            left: 10%;
            transform: rotate(-15deg);
        }
        
        .decoration:nth-child(2) {
            top: 60%;
            right: 10%;
            transform: rotate(15deg);
        }
        
        .decoration:nth-child(3) {
            bottom: 10%;
            left: 20%;
            transform: rotate(-10deg);
        }
        
        @media (max-width: 600px) {
            .login-container {
                margin: 20px;
                padding: 40px 30px;
                max-width: 380px;
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
        }
        
        @media (max-width: 400px) {
            .login-container {
                padding: 30px 20px;
            }
            
            .decoration {
                display: none;
            }
        }
    </style>
</head>
<body>
    <!-- Éléments décoratifs -->
    <div class="decoration">📚</div>
    <div class="decoration">📖</div>
    <div class="decoration">🏛️</div>
    
    <div class="login-container">
        <div class="library-logo"></div>
        <h2>Bibliothèque</h2>
        
        <c:if test="${param.error != null}">
            <div class="error-message">
                Identifiants incorrects. Veuillez réessayer.
            </div>
        </c:if>
        
        <c:if test="${param.success != null}">
            <div class="success-message">
                Inscription réussie ! Vous pouvez maintenant vous connecter.
            </div>
        </c:if>
        
        <form method="post" action="${pageContext.request.contextPath}/login">
            <div class="form-group">
                <label for="userName">Nom d'utilisateur</label>
                <input type="text" id="userName" name="userName" required/>
            </div>
            
            <div class="form-group">
                <label for="motDePasse">Mot de passe</label>
                <input type="password" id="motDePasse" name="motDePasse" required/>
            </div>
            
            <button type="submit" class="submit-btn">Se connecter</button>
        </form>
        
        <a href="inscription" class="inscription-link">Créer un compte</a>
    </div>
</body>
</html>