package com.example.biblio.repository;

import com.example.biblio.model.Emprunt;
import com.example.biblio.model.Users;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import java.time.LocalDateTime;
import java.util.List;

public interface EmpruntRepository extends JpaRepository<Emprunt, Long> {
    List<Emprunt> findByEmprunteurAndDateFinEmpruntIsNull(Users emprunteur);
    long countByEmprunteurAndDateFinEmpruntIsNull(Users emprunteur);
    List<Emprunt> findByTypeDeLectureAndDateFinEmpruntIsNull(String typeDeLecture);
    
    // Méthode pour récupérer les emprunts actifs (avec une date de fin future)
    List<Emprunt> findByDateFinEmpruntIsNotNullAndDateFinEmpruntAfter(LocalDateTime date);
    
    // Méthode pour trouver les emprunts en retard (date de fin dépassée)
    @Query("SELECT e FROM Emprunt e WHERE e.dateFinEmprunt IS NOT NULL AND e.dateFinEmprunt < :maintenant")
    List<Emprunt> findEmpruntsEnRetard(@Param("maintenant") LocalDateTime maintenant);

    List<Emprunt> findByTypeDeLectureAndDateRenduIsNull(String typeDeLecture);
}
