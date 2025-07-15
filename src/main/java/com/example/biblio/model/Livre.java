package com.example.biblio.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import jakarta.persistence.Id;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;

@Entity
@Table(name = "livre")
public class Livre {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "num_exemplaire")
    private String NumExemplaire;
    private String titre;
    private String auteur;
    private String image;

    public Livre() {
    }

    public Livre(Long id, String NumExemplaire, String titre, String auteur, String image) {
        this.id = id;
        this.NumExemplaire = NumExemplaire;
        this.titre = titre;
        this.auteur = auteur;
        this.image = image;
    }

    public String getImage() {
        return image;
    }

    public Long getId() {
        return id;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getNumExemplaire() {
        return NumExemplaire;
    }

    public void setNumExemplaire(String numExemplaire) {
        this.NumExemplaire = numExemplaire;
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

    @Override
    public String toString() {
        return "livre{" +
                "id=" + id +
                ", NumExemplaire=" + NumExemplaire +
                ", titre='" + titre + '\'' +
                ", auteur='" + auteur + '\'' +
                ", image='" + image + '\'' +
                '}';
    }
}