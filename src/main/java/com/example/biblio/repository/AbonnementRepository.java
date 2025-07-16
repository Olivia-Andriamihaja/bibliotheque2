package com.example.biblio.repository;

import com.example.biblio.model.Abonnement;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface AbonnementRepository extends JpaRepository<Abonnement, Long>{
    List<Abonnement> findByUtilisateur_Id(Long id);

}
  