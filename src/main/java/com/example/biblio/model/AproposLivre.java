package com.example.biblio.model;

import jakarta.persistence.*;
import java.time.LocalDate;
import java.util.Objects;

import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;

@JsonIdentityInfo(generator = ObjectIdGenerators.PropertyGenerator.class, property = "id")
@Entity
@Table(name = "apropos_livre")
public class AproposLivre {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "date_creation")
    private LocalDate dateCreation;

    @Column(name = "nombre_de_pages")
    private Integer nombreDePages;

    @OneToOne
    @JoinColumn(name = "livre_id", nullable = false)
    private Livre livre;

    // Constructeurs
    public AproposLivre() {
    }

    public AproposLivre(LocalDate dateCreation, Integer nombreDePages, Livre livre) {
        this.dateCreation = dateCreation;
        this.nombreDePages = nombreDePages;
        this.livre = livre;
    }

    // Getters et setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public LocalDate getDateCreation() {
        return dateCreation;
    }

    public void setDateCreation(LocalDate dateCreation) {
        this.dateCreation = dateCreation;
    }

    public Integer getNombreDePages() {
        return nombreDePages;
    }

    public void setNombreDePages(Integer nombreDePages) {
        this.nombreDePages = nombreDePages;
    }

    public Livre getLivre() {
        return livre;
    }

    public void setLivre(Livre livre) {
        this.livre = livre;
    }

    // Equals et hashCode
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        AproposLivre that = (AproposLivre) o;
        return Objects.equals(id, that.id) && 
               Objects.equals(livre, that.livre);
    }
}