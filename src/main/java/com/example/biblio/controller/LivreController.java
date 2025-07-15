package com.example.biblio.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.example.biblio.model.Livre;
import com.example.biblio.model.Reservation;
import com.example.biblio.model.Users;
import com.example.biblio.repository.LivreRepository;
import com.example.biblio.repository.ReservationRepository;
import com.example.biblio.repository.UsersRepository;

import jakarta.servlet.http.HttpSession;

@Controller
public class LivreController {

    @Autowired
    private LivreRepository livreRepository;

    @Autowired
    private ReservationRepository reservationRepository;

    @Autowired
    private UsersRepository usersRepository;

    @GetMapping("/livres")
    public String afficherLivres(Model model, HttpSession session) {
        List<Livre> livres = livreRepository.findAll();
        model.addAttribute("livres", livres);

        // Récupérer l'utilisateur connecté
        Long userId = (Long) session.getAttribute("userId");
        if (userId != null) {
            Optional<Users> userOpt = usersRepository.findById(userId);
            if (userOpt.isPresent()) {
                Users user = userOpt.get();
                model.addAttribute("currentUser", user);
                
                // Vérifier si l'utilisateur est admin
                boolean isAdmin = "admin".equalsIgnoreCase(user.getProfilFormule().getProfil());
                model.addAttribute("isAdmin", isAdmin);

                // Créer une map pour les réservations par livre
                Map<Long, Reservation> reservationsParLivre = new HashMap<>();
                for (Livre livre : livres) {
                    Optional<Reservation> reservation = reservationRepository.findByLivreAndStatut(livre, "ACTIVE");
                    if (reservation.isPresent()) {
                        reservationsParLivre.put(livre.getId(), reservation.get());
                    }
                }
                model.addAttribute("reservationsParLivre", reservationsParLivre);
            }
        }

        return "livres";
    }

    
}
