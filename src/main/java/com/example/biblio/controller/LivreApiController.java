package com.example.biblio.controller;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.biblio.model.Livre;
import com.example.biblio.repository.LivreRepository;

@RestController
@RequestMapping("/api/livres")
public class LivreApiController {

    @Autowired
    private LivreRepository livreRepository;

    
    @GetMapping
    public List<Livre> getAllLivres() {
        return livreRepository.findAll();
    }

    
    @GetMapping("/{id}")
    public ResponseEntity<Livre> getLivreById(@PathVariable Long id) {
        Optional<Livre> livre = livreRepository.findById(id);
        return livre.map(ResponseEntity::ok)
                    .orElseGet(() -> ResponseEntity.notFound().build());
    }
}
