package com.example.biblio.model;

import java.time.LocalDate;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;

@Entity
@Table(name = "reservation")
public class Reservation {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "user_id")
    private Users utilisateur;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "livre_id")
    private Livre livre;

    @Column(name = "date_reservation")
    private LocalDate dateReservation;

    @Column(name = "statut")
    private String statut; // ACTIVE, ANNULEE

    public Reservation() {
    }

    public Reservation(Users utilisateur, Livre livre) {
        this.utilisateur = utilisateur;
        this.livre = livre;
        this.dateReservation = LocalDate.now();
        this.statut = "ACTIVE";
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Users getUtilisateur() {
        return utilisateur;
    }

    public void setUtilisateur(Users utilisateur) {
        this.utilisateur = utilisateur;
    }

    public Livre getLivre() {
        return livre;
    }

    public void setLivre(Livre livre) {
        this.livre = livre;
    }

    public LocalDate getDateReservation() {
        return dateReservation;
    }

    public void setDateReservation(LocalDate dateReservation) {
        this.dateReservation = dateReservation;
    }

    public String getStatut() {
        return statut;
    }

    public void setStatut(String statut) {
        this.statut = statut;
    }

    public Object getUser() {
        throw new UnsupportedOperationException("Not supported yet.");
    }
}
