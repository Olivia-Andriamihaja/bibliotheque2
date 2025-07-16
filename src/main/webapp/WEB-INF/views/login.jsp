<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Connexion</title>
    <style>
        body {
            background: linear-gradient(120deg, #4c4eaf 0%, #2196F3 100%);
            min-height: 100vh;
            margin: 0;
            font-family: 'Segoe UI', Arial, sans-serif;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .login-container {
            background: #fff;
            border-radius: 12px;
            box-shadow: 0 6px 24px rgba(0,0,0,0.15);
            padding: 40px 30px;
            max-width: 380px;
            width: 100%;
            text-align: center;
        }
        h2 {
            color: #2196F3;
            margin-bottom: 30px;
            font-size: 1.8em;
        }
        .form-group {
            margin-bottom: 20px;
            text-align: left;
        }
        label {
            display: block;
            font-weight: 600;
            color: #333;
            margin-bottom: 8px;
        }
        input[type="text"], input[type="password"] {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid #ddd;
            border-radius: 8px;
            font-size: 1em;
            background: #f9f9f9;
            transition: all 0.3s ease;
            box-sizing: border-box;
        }
        input[type="text"]:focus, input[type="password"]:focus {
            border: 2px solid #2196F3;
            outline: none;
            background: #fff;
            box-shadow: 0 0 8px rgba(33,150,243,0.2);
        }
        .submit-btn {
            background: linear-gradient(90deg, #4c4caf 0%, #2196F3 100%);
            color: #fff;
            border: none;
            border-radius: 8px;
            padding: 12px 30px;
            font-size: 1.1em;
            font-weight: bold;
            cursor: pointer;
            width: 100%;
            margin-top: 10px;
            transition: all 0.3s ease;
        }
        .submit-btn:hover {
            background: linear-gradient(90deg, #2196F3 0%, #594caf 100%);
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0,0,0,0.2);
        }
        .inscription-link {
            display: inline-block;
            margin-top: 20px;
            color: #2196F3;
            text-decoration: none;
            font-weight: 500;
            padding: 8px 16px;
            border: 1px solid #2196F3;
            border-radius: 6px;
            transition: all 0.3s ease;
        }
        .inscription-link:hover {
            background: #2196F3;
            color: #fff;
        }
        .error-message {
            color: #e74c3c;
            background: #ffeaea;
            padding: 10px;
            border-radius: 6px;
            margin-bottom: 20px;
            font-size: 0.9em;
        }
        .success-message {
            color: #274dae;
            background: #eafff0;
            padding: 10px;
            border-radius: 6px;
            margin-bottom: 20px;
            font-size: 0.9em;
        }
        @media (max-width: 500px) {
            .login-container {
                margin: 20px;
                padding: 30px 20px;
            }
        }
    </style>
</head>
<body>
    <div class="login-container">
        <h2>Connexion</h2>
        
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
                <label for="userName">Nom d'utilisateur :</label>
                <input type="text" id="userName" name="userName" required/>
            </div>
            
            <div class="form-group">
                <label for="motDePasse">Mot de passe :</label>
                <input type="password" id="motDePasse" name="motDePasse" required/>
            </div>
            
            <button type="submit" class="submit-btn">Se connecter</button>
        </form>
        
        <a href="inscription" class="inscription-link">Créer un compte</a>
    </div>
</body>
</html>
