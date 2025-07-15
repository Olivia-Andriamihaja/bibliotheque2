package com.example.biblio.repository;

import com.example.biblio.model.Reservation;
import com.example.biblio.model.Users;
import com.example.biblio.model.Livre;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface ReservationRepository extends JpaRepository<Reservation, Long> {
    
    List<Reservation> findByUtilisateur(Users utilisateur);
    
    List<Reservation> findByLivre(Livre livre);
    
    Optional<Reservation> findByUtilisateurAndLivreAndStatut(Users utilisateur, Livre livre, String statut);
    
    List<Reservation> findByStatut(String statut);
    
    Optional<Reservation> findByLivreAndStatut(Livre livre, String statut);
}
