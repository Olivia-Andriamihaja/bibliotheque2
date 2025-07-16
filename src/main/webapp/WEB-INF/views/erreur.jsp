<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Abonnement requis</title>
    <style>
        body {
            background-color: #f5fff0; /* fond vert très pâle */
            font-family: 'Segoe UI', sans-serif;
            color: #1b5e20; /* vert foncé pour le texte */
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        .container {
            background-color: white;
            border: 2px solid #a5d6a7; /* vert pomme pâle */
            border-radius: 12px;
            padding: 40px;
            max-width: 600px;
            text-align: center;
            box-shadow: 0 8px 16px rgba(0, 128, 0, 0.1);
        }

        h1 {
            font-size: 2em;
            margin-bottom: 20px;
            color: #2e7d32; /* vert pomme plus soutenu */
        }

        p {
            font-size: 1.2em;
            line-height: 1.6em;
        }

        a.button {
            display: inline-block;
            margin-top: 25px;
            padding: 12px 25px;
            background-color: #66bb6a; /* vert pomme vif */
            color: white;
            font-weight: bold;
            text-decoration: none;
            border-radius: 8px;
            transition: background-color 0.3s ease;
        }

        a.button:hover {
            background-color: #4caf50;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>⚠️ Abonnement requis</h1>
        <p>
            Pour accéder à la bibliothèque, vous devez disposer d’un abonnement actif.<br>
            Veuillez procéder au renouvellement de votre abonnement pour continuer à profiter de nos services 📚.
        </p>
    </div>
</body>
</html>
