package com.example.biblio.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.example.biblio.model.Livre;

public interface LivreRepository extends JpaRepository<Livre, Long> {
}
