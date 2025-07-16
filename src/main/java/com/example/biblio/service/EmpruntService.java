package com.example.biblio.service;

import com.example.biblio.model.*;
import com.example.biblio.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;

@Service
public class EmpruntService {

    @Autowired
    private EmpruntRepository empruntRepository;

    @Autowired
    private LivreRepository livreRepository;

    @Autowired
    private UsersRepository usersRepository;

    @Transactional
    public Emprunt creerEmprunt(Long idLivre, Long idEmprunteur) {
        // Récupérer le livre et l'utilisateur
        Livre livre = livreRepository.findById(idLivre)
            .orElseThrow(() -> new RuntimeException("Livre non trouvé"));
        
        Users emprunteur = usersRepository.findById(idEmprunteur)
            .orElseThrow(() -> new RuntimeException("Utilisateur non trouvé"));

        // Obtenir le profil de l'utilisateur
        ProfilFormule profil = emprunteur.getProfilFormule();
        if (profil == null) {
            throw new RuntimeException("L'utilisateur n'a pas de profil associé");
        }

        // Créer l'emprunt
        LocalDateTime dateDebut = LocalDateTime.now();
        LocalDateTime dateFin = dateDebut.plusMonths(profil.getNombreDeJour());

        Emprunt emprunt = new Emprunt();
        emprunt.setLivre(livre);
        emprunt.setEmprunteur(emprunteur);
        emprunt.setDateDebutEmprunt(dateDebut);
        emprunt.setDateFinEmprunt(dateFin);
        emprunt.setTypeDeLecture("normal"); // ou une autre valeur par défaut
        emprunt.setProlongement(false);
        emprunt.setNombreProlongement(0);

        return empruntRepository.save(emprunt);
    }
}
