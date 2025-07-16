-- INSERT INTO livre (num_exemplaire, titre, auteur, image) VALUES 
-- ('LIV001', 'Le Petit Prince', 'Antoine de Saint-Exupéry', 'https://m.media-amazon.com/images/I/81UUK+NRvnL._AC_UF1000,1000_QL80_.jpg'),
-- ('LIV002', '1984', 'George Orwell', '/images/1984.jpg'),
-- ('LIV003', 'L''Étranger', 'Albert Camus', '/images/letranger.jpg'),
-- ('LIV004', 'Notre-Dame de Paris', 'Victor Hugo', '/images/notre-dame.jpg'),
-- ('LIV005', 'Les Misérables', 'Victor Hugo', '/images/les-miserables.jpg');

INSERT INTO livre (num_exemplaire, titre, auteur, image) VALUES 
('MIS001', 'Le Miserable', 'Victor Hugo', 'https://m.media-amazon.com/images/I/81UUK+NRvnL._AC_UF1000,1000_QL80_.jpg'),
('MIS002', 'Le Miserable', 'Victor Hugo', 'https://m.media-amazon.com/images/I/81UUK+NRvnL._AC_UF1000,1000_QL80_.jpg'),
('MIS002', 'Le Miserable', 'Victor Hugo', 'https://m.media-amazon.com/images/I/81UUK+NRvnL._AC_UF1000,1000_QL80_.jpg'),

('ETR001', 'Etranger', 'Albert Camus', 'https://m.media-amazon.com/images/I/81UUK+NRvnL._AC_UF1000,1000_QL80_.jpg'),
('ETR002', 'Etranger', 'Albert Camus', 'https://m.media-amazon.com/images/I/81UUK+NRvnL._AC_UF1000,1000_QL80_.jpg'),

('HAR001', 'Harry Potter a l ecole des sorciers', 'J.K. Rowling', 'https://m.media-amazon.com/images/I/81UUK+NRvnL._AC_UF1000,1000_QL80_.jpg'),

INSERT INTO apropos_livre (date_creation,nombre_de_pages, livre_id) VALUES
('1862-01-01',1463, 1),   -- Les Misérables
('1862-01-01', 1463, 2),   -- Les Misérables
('1862-01-01',1463, 3),   -- Les Misérables

('1942-05-19',123, 4),   -- L'Étranger
('1942-05-19',123, 5),   -- L'Étranger


('1997-06-26',309, 6);  -- Harry Potter à l'école des sorciers




-- Insertion des profils de base avec leurs caractéristiques
INSERT INTO profil_formule (profil, nombre_de_jour, nblivre_port) VALUES 
    ('Etudiant', 7, 2),       -- Les étudiants peuvent emprunter 3 livres pour 6 mois
    ('Enseignant', 9, 3),    -- Les enseignants peuvent emprunter 5 livres pour 12 mois
    ('Profeseur', 12, 9),
    ('admin', 100, 100);

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