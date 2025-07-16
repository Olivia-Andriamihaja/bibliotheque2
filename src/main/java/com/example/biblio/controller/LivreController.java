package com.example.biblio.controller;

import com.example.biblio.model.Abonnement;
import com.example.biblio.model.AproposLivre;
import com.example.biblio.model.Livre;
import com.example.biblio.model.Reservation;
import com.example.biblio.model.Users;
import com.example.biblio.repository.LivreRepository;
import com.example.biblio.repository.ReservationRepository;
import com.example.biblio.repository.AbonnementRepository;
import com.example.biblio.repository.UsersRepository;

import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.*;

@Controller
@RequestMapping("/livres")
public class LivreController {

    @Autowired
    private LivreRepository livreRepository;

    @Autowired
    private ReservationRepository reservationRepository;

    @Autowired
    private UsersRepository usersRepository;

    @Autowired
    private AbonnementRepository abonnementRepository;

    // Obtenir les détails "à propos" d’un livre spécifique
    @GetMapping("/{id}/apropos")
    @ResponseBody
    public AproposLivre getAproposLivre(@PathVariable Long id) {
        Optional<Livre> optLivre = livreRepository.findById(id);
        return optLivre.map(Livre::getAproposLivre).orElse(null);
    }

    // Route d’erreur d’abonnement expiré ou inexistant
    @GetMapping("/abonnement/erreur")
    public String redirigerVersErreur() {
        return "erreur";  // erreur.html dans /templates si tu utilises Thymeleaf
    }

    // Afficher tous les livres
    @GetMapping
    public String afficherLivres(Model model, HttpSession session) {
        List<Livre> livres = livreRepository.findAll();
        model.addAttribute("livres", livres);

        // Vérifier si l'utilisateur est connecté
        Long userId = (Long) session.getAttribute("userId");
        if (userId != null) {
            Optional<Users> userOpt = usersRepository.findById(userId);
            if (userOpt.isPresent()) {
                Users user = userOpt.get();
                model.addAttribute("currentUser", user);

                // Vérifier le profil de l’utilisateur
                boolean isAdmin = "admin".equalsIgnoreCase(
                    Optional.ofNullable(user.getProfilFormule())
                            .map(p -> p.getProfil())
                            .orElse("")
                );
                model.addAttribute("isAdmin", isAdmin);

                // Si non admin, vérifier l’abonnement
                if (!isAdmin) {
                    List<Abonnement> abos = abonnementRepository.findByUtilisateur_Id(user.getId());
                    Abonnement aboActif = abos.stream()
                        .filter(abo -> abo.getDateFinAbonnement() != null && !abo.getDateFinAbonnement().isBefore(LocalDate.now()))
                        .findFirst()
                        .orElse(null);
                    if (aboActif == null) {
                        return "redirect:/livres/abonnement/erreur";
                    }
                }

                // Préparer les réservations actives
                Map<Long, Reservation> reservationsParLivre = new HashMap<>();
                for (Livre livre : livres) {
                    reservationRepository.findByLivreAndStatut(livre, "ACTIVE")
                        .ifPresent(reservation -> reservationsParLivre.put(livre.getId(), reservation));
                }

                model.addAttribute("reservationsParLivre", reservationsParLivre);
            }
        }

        return "livres"; // Correspond à livres.html
    }
}
