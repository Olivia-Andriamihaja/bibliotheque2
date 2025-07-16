<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<html>
<head>
    <title>Liste des Livres</title>
    <style>
        /* Style simple pour la modal */
        #reservationModal {
            display: none;
            position: fixed;
            top: 30%;
            left: 35%;
            background: white;
            padding: 20px;
            border: 1px solid black;
            box-shadow: 0 0 10px rgba(0,0,0,0.3);
            z-index: 1000;
        }

        #modalOverlay {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0,0,0,0.5);
            z-index: 999;
        }
    </style>
</head>
<body>
    <h2>Liste des Livres</h2>

    <table border="1">
        <tr>
            <th>ID</th>
            <th>NumExemplaire</th>
            <th>Titre</th>
            <th>Auteur</th>
            <th>Image</th>
            <th>Action</th>
        </tr>

        <c:forEach var="livre" items="${livres}">
            <tr>
                <td>${livre.id}</td>
                <td>${livre.numExemplaire}</td>
                <td>${livre.titre}</td>
                <td>${livre.auteur}</td>
                <td>${livre.image}</td>
                <td>
                    <button type="button" onclick="openModal('${livre.id}')">Réserver</button>
                </td>
            </tr>
        </c:forEach>
    </table>

    <p>ID utilisateur connecté: ${id}</p>

    <c:if test="${profil == 'admin'}">
        <a href="${pageContext.request.contextPath}/ajout-abonnement">Ajouter un abonnement</a><br>
        <a href="${pageContext.request.contextPath}/ajout-emprunt">Ajouter un emprunt</a>
    </c:if>

    <!-- Overlay noir derrière la modal -->
    <div id="modalOverlay" onclick="closeModal()"></div>

    <!-- Modal pour saisir la date -->
    <div id="reservationModal">
        <h3>Réserver un livre</h3>
        <form method="post" action="${pageContext.request.contextPath}/Reservation">
            <input type="hidden" name="idLivre" id="modalIdLivre" />
            
            <label for="dateResevement">Date de début :</label>
            <input type="date" name="dateResevement" id="modalDate" required><br><br>

            <button type="submit">Confirmer</button>
            <button type="button" onclick="closeModal()">Annuler</button>
        </form>
    </div>

    <script>
        function openModal(idLivre) {
            document.getElementById('modalIdLivre').value = idLivre;
            document.getElementById('modalDate').valueAsDate = new Date(); // valeur par défaut : aujourd’hui
            document.getElementById('reservationModal').style.display = 'block';
            document.getElementById('modalOverlay').style.display = 'block';
        }

        function closeModal() {
            document.getElementById('reservationModal').style.display = 'none';
            document.getElementById('modalOverlay').style.display = 'none';
        }
    </script>
</body>
</html>
