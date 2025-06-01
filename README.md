Arcadia Zoo 🐾
Bienvenue dans le projet Arcadia Zoo, un site web pour un zoo fictif situé au cœur de la forêt de Brocéliande, en activité depuis 1959. Ce projet a été développé pour gérer les habitats, les animaux, les services, et les utilisateurs (administrateurs, vétérinaires, employés) avec une interface utilisateur moderne et responsive.

📖 Aperçu du Projet
Arcadia Zoo est une application web construite avec Symfony, utilisant une base de données PostgreSQL. Le projet inclut une interface publique pour explorer les habitats et animaux, une section admin pour gérer les utilisateurs et les données, et une navbar responsive avec un menu burger pour les petits écrans. Les images des habitats (Savane, Jungle, Marais) ont été intégrées avec des fichiers spécifiques (Savane_mini.jpg, Jungle_mini.jpg, Marais_mini.jpg).

🛠️ Outils Utilisés
Symfony : Framework PHP pour la structure MVC et la gestion des entités (Habitats, Animaux, Utilisateurs).
PostgreSQL : Base de données relationnelle pour stocker les données.
pgAdmin : Outil d’administration pour gérer la base de données PostgreSQL.
Docker : Conteneurisation pour exécuter l’application et ses dépendances (PHP, Nginx, PostgreSQL, pgAdmin).
Docker Hub : Hébergement des images Docker (nom d’utilisateur : kevinjerome953).
Canva : Création de visuels (par exemple, le logo ArcadiaLogo.png).
Trello : Gestion des tâches et suivi du projet.
Postman : Test des API REST (par exemple, routes comme /admin/create_user).
Google Fonts : Polices utilisées dans le design :
Peralta : Pour les titres et les liens de la navbar.
Merriweather : Pour les textes principaux (si utilisé dans d’autres pages).
Caveat : Pour les slogans et éléments décoratifs.
Joy : Outil de design pour prototyper l’interface (si utilisé pour des maquettes).
GitHub : Gestion du code source (branche : kevin).
📂 Structure du Projet
src/ : Code source Symfony (contrôleurs, entités, services).
templates/ : Templates Twig (pages comme admin/index.html.twig, habitat/index.html.twig).
assets/styles/ : Fichiers CSS (par exemple, navbar.css, habitat.css).
public/images/ : Images statiques (Savane_mini.jpg, Jungle_mini.jpg, Marais_mini.jpg, ArcadiaLogo.png).
docker/ : Configurations Docker (PHP, Nginx).
docker-compose.yaml : Définition des services Docker.
🚀 Installation et Lancement
Prérequis
Docker et Docker Compose installés.
Git installé.
Compte Docker Hub (facultatif pour pousser les images).
Étape 1 : Cloner le Projet
Clone le repository GitHub et change de branche :
git clone <URL_DU_REPOSITORY>
cd arcadia-zoo
git checkout kevin

Étape 2 : Configurer Docker
Assure-toi que ton docker-compose.yaml est à jour (voir le fichier dans le projet). Voici un aperçu des services :

app : Application Symfony (PHP-FPM).
web : Serveur PHP intégré (port 8000).
nginx : Serveur web (port 80).
database : PostgreSQL (port 5432).
pgadmin : Interface pgAdmin (port 5050).
Construis et lance les conteneurs :
docker-compose up -d --build

Étape 3 : Installer les Dépendances Symfony
Entre dans le conteneur app et installe les dépendances :
docker exec -it projet_zoo-app bash
composer install

Étape 4 : Configurer la Base de Données
Exécute les migrations pour créer les tables :
php bin/console doctrine:migrations:migrate

Étape 5 : Compiler les Assets
Compile les assets avec Webpack Encore :
yarn install
yarn encore dev

Étape 6 : Accéder à l’Application
Site Web : Ouvre http://localhost:8000.
pgAdmin : Ouvre http://localhost:5050 (email : admin@example.com, mot de passe : admin).
Hôte : database
Port : 5432
Base : arcadia_zoo
Utilisateur : arcadia_kevin
Mot de passe : password123
🖥️ Fonctionnalités
Interface Publique :
Page d’accueil avec une navbar responsive (menu burger sur mobile).
Liste des habitats (Savane, Jungle, Marais) avec images spécifiques.
Liste des animaux par habitat avec compteur de visites.
Interface Admin :
Tableau de bord pour gérer les animaux, habitats, services, et utilisateurs.
Création de comptes (vétérinaires, employés).
Responsive Design :
Menu burger activé pour les écrans < 768px.
Styles adaptés pour mobile et desktop.
🎨 Design et Styles
Polices :
Peralta : Liens de la navbar.
Caveat : Slogan de la navbar ("Un zoo familial au cœur de la forêt de Brocéliande, depuis 1959").
Couleurs :
#F1E7D0 : Fond admin et navbar.
#8B5E3C : Liens et éléments interactifs.
Images :
Savane_mini.jpg, Jungle_mini.jpg, Marais_mini.jpg pour les habitats.
ArcadiaLogo.png pour le logo.
🐳 Docker Hub
L’image de l’application est hébergée sur Docker Hub :

Repository : kevinjerome953/arcadia-zoo
Commandes pour pousser une nouvelle version : docker build -t kevinjerome953/arcadia-zoo:latest -f docker/php/Dockerfile ./docker/php docker push kevinjerome953/arcadia-zoo:latest
🧪 Tests
Postman : Utilisé pour tester les routes API (par exemple, création d’utilisateur via /admin/create_user).
Lighthouse : Analyse de la performance (problème initial résolu en s’assurant que la page charge correctement).
📈 Suivi du Projet
Trello : Tableau Kanban pour organiser les tâches (par exemple, "Développer la navbar", "Intégrer les images des habitats").
Canva : Création du logo et des visuels pour le site.
📝 Commandes Utiles
Docker
Construire et lancer les conteneurs : docker-compose up -d --build
Arrêter les conteneurs : docker-compose down
Voir les logs : docker logs projet_zoo-app
Accéder à un conteneur : docker exec -it projet_zoo-app bash
GitHub
Changer de branche : git checkout kevin
Pousser les modifications : git add . git commit -m "Ajout du README" git push origin kevin
Symfony
Exécuter les migrations : php bin/console doctrine:migrations:migrate
Vider le cache : php bin/console cache:clear
🐞 Résolution des Problèmes
Problème Lighthouse : Résolu en s’assurant que la fenêtre est au premier plan et que la page charge correctement.
CSS Admin : Résolu en retirant encore_entry_link_tags('admin') et en utilisant des styles inline.
Tables Non Visibles : Résolu en exécutant les migrations Doctrine.
🚀 Prochaines Étapes
Ajouter des tests unitaires et fonctionnels avec PHPUnit.
Optimiser les performances (Lighthouse scores).
Intégrer plus de fonctionnalités (par exemple, gestion des avis clients).
Développeur : Kevin

Branche GitHub : kevin

Docker Hub : kevinjerome953
