package com.example.biblio.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import com.example.biblio.model.Abonnement;
import com.example.biblio.repository.AbonnementRepository;
import com.example.biblio.repository.UsersRepository;

import org.springframework.stereotype.Controller;

@Controller
public class AbonnementController {
    @Autowired
    private AbonnementRepository abonnementRepository;
    @Autowired
    private UsersRepository usersRepository;

    @GetMapping("/abonnement/nouveau-abonnement")
    public String afficherFormulaireAbonnement(org.springframework.ui.Model model) {
        model.addAttribute("abonnement", new Abonnement());
        model.addAttribute("utilisateurs", usersRepository.findAll());
        return "nouveau-abonnement"; // Affiche la vue JSP nouveau-abonnement.jsp
    }

   @PostMapping("/abonnement/nouveau")
    public String ajouterAbonnement(@ModelAttribute Abonnement abonnement) {
        // Calcule la date de fin à partir de la date de début choisie
        abonnement.setDateFinAbonnement(
            abonnement.getDateDebutAbonnement().plusMonths(abonnement.getNombreJourAbonnement())
        );
        abonnementRepository.save(abonnement);
        return "redirect:/livres";
    }
}
