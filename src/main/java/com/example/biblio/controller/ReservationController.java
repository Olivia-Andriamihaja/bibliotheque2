package com.example.biblio.controller;

import com.example.biblio.model.Reservation;
import com.example.biblio.model.Users;
import com.example.biblio.model.Livre;
import com.example.biblio.repository.ReservationRepository;
import com.example.biblio.repository.UsersRepository;
import com.example.biblio.repository.LivreRepository;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.Optional;

@Controller
@RequestMapping("/reservation")
public class ReservationController {

    @Autowired
    private ReservationRepository reservationRepository;

    @Autowired
    private UsersRepository usersRepository;

    @Autowired
    private LivreRepository livreRepository;

    @PostMapping("/creer")
    public String creerReservation(@RequestParam Long livreId, 
                                   HttpSession session,
                                   RedirectAttributes redirectAttributes) {
        Long userId = (Long) session.getAttribute("userId");
        if (userId == null) {
            redirectAttributes.addFlashAttribute("error", "Vous devez être connecté pour réserver un livre");
            return "redirect:/login";
        }

        try {
            Optional<Users> userOpt = usersRepository.findById(userId);
            Optional<Livre> livreOpt = livreRepository.findById(livreId);

            if (userOpt.isEmpty() || livreOpt.isEmpty()) {
                redirectAttributes.addFlashAttribute("error", "Utilisateur ou livre non trouvé");
                return "redirect:/livres";
            }

            Users user = userOpt.get();
            Livre livre = livreOpt.get();

            // Vérifier si le livre est déjà réservé
            Optional<Reservation> reservationExistante = reservationRepository.findByLivreAndStatut(livre, "ACTIVE");
            if (reservationExistante.isPresent()) {
                redirectAttributes.addFlashAttribute("error", "Ce livre est déjà réservé");
                return "redirect:/livres";
            }

            // Vérifier si l'utilisateur a déjà réservé ce livre
            Optional<Reservation> reservationUser = reservationRepository.findByUtilisateurAndLivreAndStatut(user, livre, "ACTIVE");
            if (reservationUser.isPresent()) {
                redirectAttributes.addFlashAttribute("error", "Vous avez déjà réservé ce livre");
                return "redirect:/livres";
            }

            // Créer la réservation
            Reservation reservation = new Reservation(user, livre);
            reservationRepository.save(reservation);

            redirectAttributes.addFlashAttribute("success", "Livre réservé avec succès !");

        } catch (Exception e) {
            e.printStackTrace(); // Pour voir l'erreur dans les logs
            redirectAttributes.addFlashAttribute("error", "Erreur lors de la réservation: " + e.getMessage());
        }

        return "redirect:/livres";
    }

    @PostMapping("/annuler/{id}")
    public String annulerReservation(@PathVariable Long id, 
                                     HttpSession session,
                                     RedirectAttributes redirectAttributes) {
        Long userId = (Long) session.getAttribute("userId");
        if (userId == null) {
            return "redirect:/login";
        }

        try {
            Optional<Reservation> reservationOpt = reservationRepository.findById(id);
            if (reservationOpt.isEmpty()) {
                redirectAttributes.addFlashAttribute("error", "Réservation non trouvée");
                return "redirect:/livres";
            }

            Reservation reservation = reservationOpt.get();

            // Vérifier que c'est bien l'utilisateur qui a fait la réservation
            if (!reservation.getUtilisateur().getId().equals(userId)) {
                redirectAttributes.addFlashAttribute("error", "Vous ne pouvez annuler que vos propres réservations");
                return "redirect:/livres";
            }

            // Annuler la réservation
            reservation.setStatut("ANNULEE");
            reservationRepository.save(reservation);

            redirectAttributes.addFlashAttribute("success", "Réservation annulée avec succès !");

        } catch (Exception e) {
            e.printStackTrace(); // Pour voir l'erreur dans les logs
            redirectAttributes.addFlashAttribute("error", "Erreur lors de l'annulation: " + e.getMessage());
        }

        return "redirect:/livres";
    }

    @GetMapping("/mes-reservations")
    public String mesReservations(HttpSession session, Model model) {
        Long userId = (Long) session.getAttribute("userId");
        if (userId == null) {
            return "redirect:/login";
        }

        Optional<Users> userOpt = usersRepository.findById(userId);
        if (userOpt.isEmpty()) {
            return "redirect:/login";
        }

        Users user = userOpt.get();
        var reservations = reservationRepository.findByUtilisateur(user);
        
        // Vérifier si l'utilisateur est admin
        boolean isAdmin = "admin".equalsIgnoreCase(user.getProfilFormule().getProfil());
        
        model.addAttribute("reservations", reservations);
        model.addAttribute("user", user);
        model.addAttribute("isAdmin", isAdmin);

        return "mes-reservations";
    }
}
