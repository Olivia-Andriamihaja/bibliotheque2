package com.example.biblio.repository;

import com.example.biblio.model.Users;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import java.util.*;
@Repository
public interface UsersRepository extends JpaRepository<Users, Long> {
    Users findByUserNameAndMotDePasse(String userName, String motDePasse);
    Users findByUserName(String userName);

    @Query("SELECT u FROM Users u LEFT JOIN FETCH u.abonnements WHERE u.id = :id")
    Optional<Users> findByIdWithAbonnements(@Param("id") Long id);
}
