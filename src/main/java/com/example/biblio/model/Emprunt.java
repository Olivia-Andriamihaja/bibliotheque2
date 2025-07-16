package com.example.biblio.model;
import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "emprunt")
public class Emprunt {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "id_livre")
    private Livre livre;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "id_nom_emprunteur")
    private Users emprunteur;

    @Column(name = "date_debut_emprunt")
    private LocalDateTime dateDebutEmprunt;

    @Column(name = "date_fin_emprunt")
    private LocalDateTime dateFinEmprunt;
    
    @Column(name = "type_de_lecture")
    private String typeDeLecture;

    @Column(name = "is_prolongement", nullable = false)
    private boolean isProlongement = false;

    @Column(name = "nombre_prolongement", nullable = false)
    private int nombreProlongement = 0;

    @Column(name = "date_rendu")
    private LocalDateTime dateRendu;


    public Emprunt() {}

    public Emprunt(Long id, Users emprunteur, Livre livre, LocalDateTime dateDebutEmprunt, LocalDateTime dateFinEmprunt, String typeDeLecture) {
        this.id = id;
        this.emprunteur = emprunteur;
        this.livre = livre;
        this.dateDebutEmprunt = dateDebutEmprunt;
        this.dateFinEmprunt = dateFinEmprunt;
        this.typeDeLecture = typeDeLecture;
        this.isProlongement = false;
        this.nombreProlongement = 0;
    }

    // Getters et setters

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public Livre getLivre() { return livre; }
    public void setLivre(Livre livre) { this.livre = livre; }

    public Users getEmprunteur() {
        return emprunteur;
    }
    public void setEmprunteur(Users emprunteur) {
        this.emprunteur = emprunteur;
    }

    public LocalDateTime getDateDebutEmprunt() { return dateDebutEmprunt; }
    public void setDateDebutEmprunt(LocalDateTime dateDebutEmprunt) { this.dateDebutEmprunt = dateDebutEmprunt; }

    public LocalDateTime getDateFinEmprunt() { return dateFinEmprunt; }
    public void setDateFinEmprunt(LocalDateTime dateFinEmprunt) { this.dateFinEmprunt = dateFinEmprunt; }
    

    public String getTypeDeLecture() {
        return typeDeLecture;
    }
    
    public void setTypeDeLecture(String typeDeLecture) {
        this.typeDeLecture = typeDeLecture;
    }

    public boolean isProlongement() { return isProlongement; }
    public void setProlongement(boolean isProlongement) { this.isProlongement = isProlongement; }

    public int getNombreProlongement() { return nombreProlongement; }
    public void setNombreProlongement(int nombreProlongement) { this.nombreProlongement = nombreProlongement; }

    public LocalDateTime getDateRendu() { return dateRendu; }
    public void setDateRendu(LocalDateTime dateRendu) { this.dateRendu = dateRendu; }
}