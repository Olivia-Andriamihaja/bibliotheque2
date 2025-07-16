package com.example.biblio.model;

import jakarta.persistence.*;

@Entity
@Table(name = "profil_formule")
public class ProfilFormule {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String profil;
    private int nombreDeJour;
    private int nblivrePort;

    public ProfilFormule() {}

    public ProfilFormule(Long id, String profil, int nombreDeJour, int nblivrePort) {
        this.id = id;
        this.profil = profil;
        this.nombreDeJour = nombreDeJour;
        this.nblivrePort = nblivrePort;
    }

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getProfil() { return profil; }
    public void setProfil(String profil) { this.profil = profil; }

    public int getNombreDeJour() { return nombreDeJour; }
    public void setNombreDeJour(int nombreDeJour) { this.nombreDeJour = nombreDeJour; }

    public int getNblivrePort() { return nblivrePort; }
    public void setNblivrePort(int nblivrePort) { this.nblivrePort = nblivrePort; }
}