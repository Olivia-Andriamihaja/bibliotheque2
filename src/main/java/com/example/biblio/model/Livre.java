package com.example.biblio.model;

import jakarta.persistence.*;
import java.util.Objects;

import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;

@JsonIdentityInfo(generator = ObjectIdGenerators.PropertyGenerator.class, property = "id")
@Entity
@Table(name = "livre")
public class Livre {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "num_exemplaire", nullable = false, unique = true)
    private String numExemplaire; // Convention : camelCase

    @Column(nullable = false)
    private String titre;

    @Column(nullable = false)
    private String auteur;

    private String image;

    @OneToOne(mappedBy = "livre", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private AproposLivre aproposLivre;

    // Constructeurs
    public Livre() {
    }

    public Livre(String numExemplaire, String titre, String auteur, String image) {
        this.numExemplaire = numExemplaire;
        this.titre = titre;
        this.auteur = auteur;
        this.image = image;
    }

    // Getters et setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getNumExemplaire() {
        return numExemplaire;
    }

    public void setNumExemplaire(String numExemplaire) {
        this.numExemplaire = numExemplaire;
    }

    public String getTitre() {
        return titre;
    }

    public void setTitre(String titre) {
        this.titre = titre;
    }

    public String getAuteur() {
        return auteur;
    }

    public void setAuteur(String auteur) {
        this.auteur = auteur;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public AproposLivre getAproposLivre() {
        return aproposLivre;
    }

    public void setAproposLivre(AproposLivre aproposLivre) {
        this.aproposLivre = aproposLivre;
    }

    // Equals et hashCode
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Livre livre = (Livre) o;
        return Objects.equals(id, livre.id) && 
               Objects.equals(numExemplaire, livre.numExemplaire);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, numExemplaire);
    }

    @Override
    public String toString() {
        return "Livre{" +
                "id=" + id +
                ", numExemplaire='" + numExemplaire + '\'' +
                ", titre='" + titre + '\'' +
                ", auteur='" + auteur + '\'' +
                ", image='" + image + '\'' +
                '}';
    }
}