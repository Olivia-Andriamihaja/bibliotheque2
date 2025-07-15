package com.example.biblio.controller;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.biblio.model.Penalite;
import com.example.biblio.model.Users;
import com.example.biblio.repository.PenaliteRepository;
import com.example.biblio.repository.UsersRepository;

@RestController
@RequestMapping("/api/users")
public class UserApiController {

    @Autowired
    private UsersRepository usersRepository;

    @Autowired
    private PenaliteRepository penaliteRepository;

    @GetMapping("/{id}")
    public ResponseEntity<?> getUserWithPenalites(@PathVariable Long id) {
        Optional<Users> optionalUser = usersRepository.findById(id);
        if (optionalUser.isEmpty()) {
            return ResponseEntity.notFound().build();
        }

        Users user = optionalUser.get();
        List<Penalite> penalites = penaliteRepository.findByUtilisateur(user);

        // Retourne tout, y compris mot de passe
        return ResponseEntity.ok(new Object() {
            public final Long id = user.getId();
            public final String userName = user.getUserName();
            public final String email = user.getEmail();
            public final Long numero = user.getNumero();
            public final String profil = user.getProfilFormule() != null ? user.getProfilFormule().getProfil() : null;
            public final List<Penalite> penalitesList = penalites;
        });
    }
}
