<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Inscription</title>
    <style>
        body {
            background: linear-gradient(120deg, #4CAF50 0%, #2196F3 100%);
            min-height: 100vh;
            margin: 0;
            font-family: 'Segoe UI', Arial, sans-serif;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px 0;
        }
        .inscription-container {
            background: #fff;
            border-radius: 12px;
            box-shadow: 0 6px 24px rgba(0,0,0,0.15);
            padding: 40px 30px;
            max-width: 420px;
            width: 100%;
        }
        h2 {
            text-align: center;
            color: #2196F3;
            margin-bottom: 30px;
            font-size: 1.8em;
        }
        form {
            display: flex;
            flex-direction: column;
            gap: 20px;
        }
        .form-group {
            display: flex;
            flex-direction: column;
        }
        label, .form-label {
            font-weight: 600;
            color: #333;
            margin-bottom: 8px;
        }
        input[type="text"], input[type="password"], input[type="email"], input[type="number"], select {
            padding: 12px 15px;
            border: 1px solid #ddd;
            border-radius: 8px;
            font-size: 1em;
            background: #f9f9f9;
            transition: all 0.3s ease;
            box-sizing: border-box;
        }
        input[type="text"]:focus, input[type="password"]:focus, input[type="email"]:focus, input[type="number"]:focus, select:focus {
            border: 2px solid #2196F3;
            outline: none;
            background: #fff;
            box-shadow: 0 0 8px rgba(33,150,243,0.2);
        }
        input[type="submit"] {
            background: linear-gradient(90deg, #4CAF50 0%, #2196F3 100%);
            color: #fff;
            border: none;
            border-radius: 8px;
            padding: 14px;
            font-size: 1.1em;
            font-weight: bold;
            cursor: pointer;
            margin-top: 10px;
            transition: all 0.3s ease;
        }
        input[type="submit"]:hover {
            background: linear-gradient(90deg, #2196F3 0%, #4CAF50 100%);
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0,0,0,0.2);
        }
        .login-link {
            text-align: center;
            margin-top: 20px;
            color: #2196F3;
            text-decoration: none;
            font-weight: 500;
        }
        .login-link:hover {
            text-decoration: underline;
        }
        .error-message {
            color: #e74c3c;
            background: #ffeaea;
            padding: 10px;
            border-radius: 6px;
            margin-bottom: 20px;
            font-size: 0.9em;
        }
        @media (max-width: 500px) {
            .inscription-container {
                margin: 20px;
                padding: 30px 20px;
            }
        }
    </style>
</head>
<body>
<div class="inscription-container">
<h2>Formulaire d'inscription</h2>

<c:if test="${errorMessage != null}">
    <div class="error-message">
        ${errorMessage}
    </div>
</c:if>

<form:form method="post" modelAttribute="users">
    <div class="form-group">
        <form:label path="userName" cssClass="form-label">Nom d'utilisateur :</form:label>
        <form:input path="userName" required="true"/>
    </div>
    <div class="form-group">
        <form:label path="motDePasse" cssClass="form-label">Mot de passe :</form:label>
        <form:password path="motDePasse" required="true"/>
    </div>
    <div class="form-group">
        <form:label path="email" cssClass="form-label">Email :</form:label>
        <form:input path="email" type="email" required="true"/>
    </div>
    <div class="form-group">
        <form:label path="numero" cssClass="form-label">Numéro :</form:label>
        <form:input path="numero" type="number" required="true"/>
    </div>
    <div class="form-group">
        <form:label path="profilFormule" cssClass="form-label">Profil :</form:label>
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
