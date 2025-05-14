-- Table Utilisateur
CREATE TABLE utilisateur (
    id_utilisateur SERIAL PRIMARY KEY,
    email VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    role VARCHAR(50) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Table Contact
CREATE TABLE contact (
    id_contact SERIAL PRIMARY KEY,
    email VARCHAR(255) NOT NULL,
    sujet VARCHAR(255) NOT NULL,
    message TEXT NOT NULL,
    created_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Table Habitat
CREATE TABLE habitat (
    id_habitat SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    image JSON
);

-- Table Animal
CREATE TABLE animal (
    id_animal SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    race VARCHAR(100) NOT NULL,
    image JSON,
    id_habitat INT,
    FOREIGN KEY (id_habitat) REFERENCES habitat(id_habitat) ON DELETE SET NULL
);

-- Table Service
CREATE TABLE service (
    id_service SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    images JSON,
    description TEXT
);

-- Table UserService (liaison entre Utilisateur et Service)
CREATE TABLE user_service (
    id_utilisateur INT,
    id_service INT,
    PRIMARY KEY (id_utilisateur, id_service),
    FOREIGN KEY (id_utilisateur) REFERENCES utilisateur(id_utilisateur) ON DELETE CASCADE,
    FOREIGN KEY (id_service) REFERENCES service(id_service) ON DELETE CASCADE
);

-- Table Avis
CREATE TABLE avis (
    id_avis SERIAL PRIMARY KEY,
    pseudo VARCHAR(100) NOT NULL,
    comment TEXT NOT NULL,
    is_validated BOOLEAN NOT NULL DEFAULT FALSE,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    validate_by INT,
    FOREIGN KEY (validate_by) REFERENCES utilisateur(id_utilisateur) ON DELETE SET NULL
);

-- Table RapportVeterinaire
CREATE TABLE rapport_veterinaire (
    id_rapport_veterinaire SERIAL PRIMARY KEY,
    etat VARCHAR(100) NOT NULL,
    nourriture VARCHAR(100) NOT NULL,
    quantite DECIMAL(10,2) NOT NULL,
    date_passage TIMESTAMP NOT NULL,
    details TEXT,
    id_animal INT,
    id_veterinaire INT,
    FOREIGN KEY (id_animal) REFERENCES animal(id_animal) ON DELETE CASCADE,
    FOREIGN KEY (id_veterinaire) REFERENCES utilisateur(id_utilisateur) ON DELETE SET NULL
);

-- Table Alimentation
CREATE TABLE alimentation (
    id_alimentation SERIAL PRIMARY KEY,
    date TIMESTAMP NOT NULL,
    nourriture VARCHAR(100) NOT NULL,
    quantite DECIMAL(10,2) NOT NULL,
    id_animal INT,
    id_employe INT,
    FOREIGN KEY (id_animal) REFERENCES animal(id_animal) ON DELETE CASCADE,
    FOREIGN KEY (id_employe) REFERENCES utilisateur(id_utilisateur) ON DELETE SET NULL
);

-- Table CommentHabitat
CREATE TABLE comment_habitat (
    id_comment SERIAL PRIMARY KEY,
    comment TEXT NOT NULL,
    condition_habitat VARCHAR(100) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    id_veterinaire INT,
    id_habitat INT,
    FOREIGN KEY (id_veterinaire) REFERENCES utilisateur(id_utilisateur) ON DELETE SET NULL,
    FOREIGN KEY (id_habitat) REFERENCES habitat(id_habitat) ON DELETE CASCADE
);

-- Table ReinitialisationMotDePasse
CREATE TABLE reinitialisation_mot_de_passe (
    id SERIAL PRIMARY KEY,
    selector VARCHAR(20) NOT NULL,
    hashed_token VARCHAR(100) NOT NULL,
    requested_at TIMESTAMP NOT NULL,
    expires_at TIMESTAMP NOT NULL,
    id_utilisateur INT,
    FOREIGN KEY (id_utilisateur) REFERENCES utilisateur(id_utilisateur) ON DELETE CASCADE
);

-- Table Calendrier
CREATE TABLE calendrier (
    id_calendrier SERIAL PRIMARY KEY,
    day_of_week VARCHAR(100) NOT NULL,
    opening_time TIME NOT NULL,
    closing_time TIME NOT NULL,
    is_holiday BOOLEAN NOT NULL DEFAULT FALSE,
    id_admin INT,
    FOREIGN KEY (id_admin) REFERENCES utilisateur(id_utilisateur) ON DELETE SET NULL
);