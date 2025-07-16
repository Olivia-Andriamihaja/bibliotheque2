INSERT INTO livre (num_exemplaire, titre, auteur, image) VALUES 
('LIV001', 'Le Petit Prince', 'Antoine de Saint-Exupéry', '/images/le-petit-prince.jpg'),
('LIV002', '1984', 'George Orwell', '/images/1984.jpg'),
('LIV003', 'L''Étranger', 'Albert Camus', '/images/letranger.jpg'),
('LIV004', 'Notre-Dame de Paris', 'Victor Hugo', '/images/notre-dame.jpg'),
('LIV005', 'Les Misérables', 'Victor Hugo', '/images/les-miserables.jpg');
-- Insertion des profils de base avec leurs caractéristiques
INSERT INTO profil_formule (profil, nombre_de_mois, nblivre_port) VALUES 
    ('Etudiant', 3, 3),       -- Les étudiants peuvent emprunter 3 livres pour 6 mois
    ('Enseignant', 6, 5),    -- Les enseignants peuvent emprunter 5 livres pour 12 mois
    ('Personnel', 2, 2),     -- Le personnel peut emprunter 2 livres pour 12 mois
    ('Public', 1, 1),         -- Le public peut emprunter 1 livre pour 3 mois
    ('admin', 0, 0);

INSERT INTO apropos_livre (date_creation, auteur, nombre_de_pages, niveau_celebriter, livre_id) VALUES
('1943-04-06', 'Antoine de Saint-Exupéry', 96, 5, 1), -- Le Petit Prince
('1949-06-08', 'George Orwell', 328, 5, 2),           -- 1984
('1942-05-19', 'Albert Camus', 123, 4, 3),            -- L'Étranger
('1831-03-16', 'Victor Hugo', 940, 5, 4),             -- Notre-Dame de Paris
('1862-01-01', 'Victor Hugo', 1463, 5, 5); 


    -- -- Suppression et réinitialisation de la table profil_formule
    -- TRUNCATE TABLE profil_formule RESTART IDENTITY CASCADE;

    -- DELETE FROM profil_formule
    -- WHERE id BETWEEN 6 AND 76;

    -- UPDATE sign_in
    -- SET profil = 'admin'
    -- WHERE id = 1;

    -- TRUNCATE TABLE sign_in RESTART IDENTITY;

    -- SELECT setval(pg_get_serial_sequence('profil_formule', 'id'), 6, true);

ALTER TABLE profil_formule RENAME COLUMN nombre_de_mois TO nombre_de_jour;