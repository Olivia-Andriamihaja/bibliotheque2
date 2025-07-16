package com.example.biblio.controller;

import com.example.biblio.model.*;
import com.example.biblio.repository.*;
import com.example.biblio.service.PenaliteService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import jakarta.servlet.http.HttpSession;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

@Controller
public class EmpruntViewController {

    @Autowired
    private LivreRepository livreRepository;

    @Autowired
    private UsersRepository usersRepository;

    @Autowired
    private EmpruntRepository empruntRepository;

    @Autowired
    private PenaliteService penaliteService;
    
    @GetMapping("/emprunt/nouveau")
    public String afficherFormulaireEmprunt(Model model, HttpSession session) {
        Long userId = (Long) session.getAttribute("userId");
        if (userId == null) {
            return "redirect:/login";
        }
        Users admin = usersRepository.findById(userId).orElse(null);
        if (admin == null || !"admin".equalsIgnoreCase(admin.getProfilFormule().getProfil())) {
            return "redirect:/livres?error=notadmin";
        }
        model.addAttribute("livresDisponibles", livreRepository.findAll());
        model.addAttribute("utilisateurs", usersRepository.findAll());
        return "emprunt-form";
    }

    @GetMapping("/emprunt/retour-emporter")
    public String afficherRetourEmporter(Model model) {
        List<Emprunt> empruntsAEmporter = empruntRepository.findByTypeDeLectureAndDateRenduIsNull("A_EMPORTER");
        model.addAttribute("empruntsAEmporter", empruntsAEmporter);
        return "retour-emporter";
    }

    @PostMapping("/emprunt/retour-emporter")
    public String validerRetourEmporter(@RequestParam Long empruntId, @RequestParam String dateRendu, RedirectAttributes redirectAttributes) {
        Emprunt emprunt = empruntRepository.findById(empruntId).orElse(null);
        if (emprunt != null && "A_EMPORTER".equals(emprunt.getTypeDeLecture())) {
            LocalDateTime rendu = LocalDate.parse(dateRendu).atStartOfDay();
            emprunt.setDateRendu(rendu);
            empruntRepository.save(emprunt);

            // Vérifier pénalité
            if (emprunt.getDateFinEmprunt() != null && rendu.isAfter(emprunt.getDateFinEmprunt())) {
                penaliteService.creerPenalitePourEmprunt(emprunt, rendu);
            }
            redirectAttributes.addFlashAttribute("success", "Retour enregistré.");
        } else {
            redirectAttributes.addFlashAttribute("error", "Emprunt introuvable ou non valide.");
        }
        return "redirect:/emprunt/retour-emporter";
    }

    @PostMapping("/emprunt/creer")
    public String creerEmprunt(
            @RequestParam Long idLivre,
            @RequestParam String typeEmprunt,
            @RequestParam Long userId,
            HttpSession session,
            @RequestParam String dateDebutEmprunt) {
        Long adminId = (Long) session.getAttribute("userId");
        if (adminId == null) {
            return "redirect:/login";
        }
        Users admin = usersRepository.findById(adminId).orElse(null);
        if (admin == null || !"admin".equalsIgnoreCase(admin.getProfilFormule().getProfil())) {
            return "redirect:/livres?error=notadmin";
        }
        try {
            Livre livre = livreRepository.findById(idLivre)
                    .orElseThrow(() -> new RuntimeException("Livre non trouvé"));
            Users user = usersRepository.findById(userId)
                    .orElseThrow(() -> new RuntimeException("Utilisateur non trouvé"));
            
            // Vérifier si l'utilisateur a une pénalité active
            if (penaliteService.utilisateurAPenaliteActive(user)) {
                return "redirect:/emprunt/nouveau?error=penalite_active";
            }
            LocalDateTime dateDebut = LocalDate.parse(dateDebutEmprunt).atStartOfDay();
            
            Emprunt emprunt = new Emprunt();
            emprunt.setLivre(livre);
            emprunt.setEmprunteur(user);
            emprunt.setDateDebutEmprunt(dateDebut);
            emprunt.setTypeDeLecture(typeEmprunt);
            emprunt.setProlongement(false);
            emprunt.setNombreProlongement(0);
            if (typeEmprunt.equals("A_EMPORTER")) {
                int nombreJour = user.getProfilFormule().getNombreDeJour();
                LocalDateTime dateFin = dateDebut.plusDays(nombreJour);
                emprunt.setDateFinEmprunt(dateFin);
            } else {
                emprunt.setDateFinEmprunt(null);
            }
            empruntRepository.save(emprunt);
            return "redirect:/livres?success=true";
        } catch (Exception e) {
            return "redirect:/emprunt/nouveau?error=" + e.getMessage();
        }
    }

    @PostMapping("/emprunt/{id}/retour")
    public String retournerLivre(@PathVariable Long id) {
        Emprunt emprunt = empruntRepository.findById(id).orElse(null);
        
        if (emprunt != null && emprunt.getTypeDeLecture().equals("SUR_PLACE")) {
            emprunt.setDateFinEmprunt(LocalDateTime.now());
            empruntRepository.save(emprunt);
        }
        
        return "redirect:/livres";
    }

    @GetMapping("/emprunt/retour-sur-place")
    public String afficherRetourSurPlace(Model model, HttpSession session) {
        Long userId = (Long) session.getAttribute("userId");
        if (userId != null) {
            Users user = usersRepository.findById(userId).orElse(null);
            if (user != null) {
                boolean isAdmin = "admin".equalsIgnoreCase(user.getProfilFormule().getProfil());
                model.addAttribute("isAdmin", isAdmin);
            }
        }
        
        model.addAttribute("empruntsSurPlace", empruntRepository.findByTypeDeLectureAndDateFinEmpruntIsNull("SUR_PLACE"));
        return "retour-sur-place";
    }

    @PostMapping("/emprunt/retour-sur-place")
    public String validerRetourSurPlace(@RequestParam Long empruntId, @RequestParam String dateRetour) {
        Emprunt emprunt = empruntRepository.findById(empruntId).orElse(null);
        if (emprunt != null && "SUR_PLACE".equals(emprunt.getTypeDeLecture())) {
            LocalDateTime retour = LocalDate.parse(dateRetour).atStartOfDay();
            emprunt.setDateFinEmprunt(retour);
            empruntRepository.save(emprunt);
        }
        return "redirect:/emprunt/retour-sur-place?success";
    }
    
    @GetMapping("/emprunt/prolongement")
    public String afficherFormulaireProlongement(Model model, HttpSession session) {
        Long userId = (Long) session.getAttribute("userId");
        if (userId == null) {
            return "redirect:/login";
        }
        
        Users admin = usersRepository.findById(userId).orElse(null);
        if (admin == null || !"admin".equalsIgnoreCase(admin.getProfilFormule().getProfil())) {
            return "redirect:/livres?error=notadmin";
        }
        
        // Vérifier si l'utilisateur est admin
        boolean isAdmin = "admin".equalsIgnoreCase(admin.getProfilFormule().getProfil());
        model.addAttribute("isAdmin", isAdmin);
        
        // Récupérer tous les emprunts actifs (non terminés)
        List<Emprunt> empruntsActifs = empruntRepository.findByDateFinEmpruntIsNotNullAndDateFinEmpruntAfter(LocalDateTime.now());
        model.addAttribute("empruntsActifs", empruntsActifs);
        
        return "prolongement-form";
    }
    
    @PostMapping("/emprunt/prolonger")
    public String prolongerEmprunt(
            @RequestParam Long empruntId,
            @RequestParam int moisSupplementaires,
            HttpSession session,
            RedirectAttributes redirectAttributes) {
        
        Long adminId = (Long) session.getAttribute("userId");
        if (adminId == null) {
            return "redirect:/login";
        }
        
        Users admin = usersRepository.findById(adminId).orElse(null);
        if (admin == null || !"admin".equalsIgnoreCase(admin.getProfilFormule().getProfil())) {
            return "redirect:/livres?error=notadmin";
        }
        
        try {
            Emprunt emprunt = empruntRepository.findById(empruntId)
                    .orElseThrow(() -> new RuntimeException("Emprunt non trouvé"));
            
            // Vérifier que l'emprunt est encore actif
            if (emprunt.getDateFinEmprunt() == null || emprunt.getDateFinEmprunt().isBefore(LocalDateTime.now())) {
                redirectAttributes.addFlashAttribute("error", "Cet emprunt n'est plus actif");
                return "redirect:/emprunt/prolongement";
            }
            
            // Ajouter les mois supplémentaires
            LocalDateTime nouvelleDateFin = emprunt.getDateFinEmprunt().plusMonths(moisSupplementaires);
            emprunt.setDateFinEmprunt(nouvelleDateFin);
            
            // Marquer comme prolongé et incrémenter le compteur
            emprunt.setProlongement(true);
            emprunt.setNombreProlongement(emprunt.getNombreProlongement() + 1);
            
            empruntRepository.save(emprunt);
            
            redirectAttributes.addFlashAttribute("success", 
                String.format("Emprunt prolongé de %d mois. Nouvelle date de fin: %s", 
                    moisSupplementaires, nouvelleDateFin.toLocalDate()));
            
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Erreur lors de la prolongation: " + e.getMessage());
        }
        
        return "redirect:/emprunt/prolongement";
    }
}
