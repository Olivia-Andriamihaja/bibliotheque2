package com.example.biblio.model;

import jakarta.persistence.*;
import java.time.LocalDate;

import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;


@JsonIdentityInfo(generator = ObjectIdGenerators.PropertyGenerator.class, property = "id")
@Entity
public class Abonnement {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_personne", nullable = false)
    private Users utilisateur;

    private int nombreJourAbonnement;
    private LocalDate dateFinAbonnement;
    private LocalDate dateDebutAbonnement;

    // Constructeurs, getters, setters
    public Abonnement() {}

    public Abonnement(Users utilisateur, int nombreJourAbonnement, LocalDate dateFinAbonnement) {
        this.utilisateur = utilisateur;
        this.nombreJourAbonnement = nombreJourAbonnement;
        this.dateFinAbonnement = dateFinAbonnement;
    }

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public Users getUtilisateur() { return utilisateur; }
    public void setUtilisateur(Users utilisateur) { this.utilisateur = utilisateur; }

    public int getNombreJourAbonnement() { return nombreJourAbonnement; }
    public void setNombreJourAbonnement(int nombreJourAbonnement) { this.nombreJourAbonnement = nombreJourAbonnement; }

    public LocalDate getDateFinAbonnement() { return dateFinAbonnement; }
    public void setDateFinAbonnement(LocalDate dateFinAbonnement) { this.dateFinAbonnement = dateFinAbonnement; }
    
    public LocalDate getDateDebutAbonnement() { return dateDebutAbonnement; }
    public void setDateDebutAbonnement(LocalDate dateDebutAbonnement) { this.dateDebutAbonnement = dateDebutAbonnement; }

    
}