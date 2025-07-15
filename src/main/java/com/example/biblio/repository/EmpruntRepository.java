package com.example.biblio.repository;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.example.biblio.model.Emprunt;
import com.example.biblio.model.Users;

public interface EmpruntRepository extends JpaRepository<Emprunt, Long> {

    List<Emprunt> findByEmprunteurAndDateFinEmpruntIsNull(Users emprunteur);
    long countByEmprunteurAndDateFinEmpruntIsNull(Users emprunteur);
    List<Emprunt> findByTypeDeLectureAndDateFinEmpruntIsNull(String typeDeLecture);
    
    // Nouvelle méthode pour récupérer tous les emprunts actifs
    @Query("SELECT e FROM Emprunt e WHERE e.dateFinEmprunt IS NULL OR e.dateFinEmprunt > :maintenant")
    List<Emprunt> findAllActiveEmprunts(@Param("maintenant") LocalDateTime maintenant);
    
    // Méthode pour récupérer les emprunts actifs (avec une date de fin future)
    List<Emprunt> findByDateFinEmpruntIsNotNullAndDateFinEmpruntAfter(LocalDateTime date);
    
    // Méthode pour trouver les emprunts en retard (date de fin dépassée)
    @Query("SELECT e FROM Emprunt e WHERE e.dateFinEmprunt IS NOT NULL AND e.dateFinEmprunt < :maintenant")
    List<Emprunt> findEmpruntsEnRetard(@Param("maintenant") LocalDateTime maintenant);
}

// package com.example.biblio.repository;

// import com.example.biblio.model.Emprunt;
// import com.example.biblio.model.Users;
// import org.springframework.data.jpa.repository.JpaRepository;
// import org.springframework.data.jpa.repository.Query;
// import org.springframework.data.repository.query.Param;
// import java.time.LocalDateTime;
// import java.util.List;

// public interface EmpruntRepository extends JpaRepository<Emprunt, Long> {
//     List<Emprunt> findByEmprunteurAndDateFinEmpruntIsNull(Users emprunteur);
//     long countByEmprunteurAndDateFinEmpruntIsNull(Users emprunteur);
//     List<Emprunt> findByTypeDeLectureAndDateFinEmpruntIsNull(String typeDeLecture);
    
//     // Méthode pour récupérer les emprunts actifs (avec une date de fin future)
//     List<Emprunt> findByDateFinEmpruntIsNotNullAndDateFinEmpruntAfter(LocalDateTime date);
    
//     // Méthode pour trouver les emprunts en retard (date de fin dépassée)
//     @Query("SELECT e FROM Emprunt e WHERE e.dateFinEmprunt IS NOT NULL AND e.dateFinEmprunt < :maintenant")
//     List<Emprunt> findEmpruntsEnRetard(@Param("maintenant") LocalDateTime maintenant);
// }
