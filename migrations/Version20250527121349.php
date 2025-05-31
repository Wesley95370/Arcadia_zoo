<?php

declare(strict_types=1);

namespace DoctrineMigrations;

use Doctrine\DBAL\Schema\Schema;
use Doctrine\Migrations\AbstractMigration;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
final class Version20250527121349 extends AbstractMigration
{
    public function getDescription(): string
    {
        return '';
    }

    public function up(Schema $schema): void
    {
        // this up() migration is auto-generated, please modify it to your needs
        $this->addSql(<<<'SQL'
            ALTER TABLE animal ADD visit_count INT DEFAULT 0 NOT NULL
        SQL);
        $this->addSql(<<<'SQL'
            ALTER TABLE animal DROP visits
        SQL);
        $this->addSql(<<<'SQL'
            ALTER TABLE animal DROP description
        SQL);
        $this->addSql(<<<'SQL'
            ALTER TABLE calendrier ALTER id_admin DROP NOT NULL
        SQL);
        $this->addSql(<<<'SQL'
            ALTER TABLE calendrier ALTER day_of_week TYPE VARCHAR(100)
        SQL);
        $this->addSql(<<<'SQL'
            ALTER TABLE habitat ALTER description DROP NOT NULL
        SQL);
        $this->addSql(<<<'SQL'
            ALTER TABLE rapport_veterinaire ALTER id_animal DROP NOT NULL
        SQL);
        $this->addSql(<<<'SQL'
            ALTER TABLE rapport_veterinaire ALTER id_veterinaire DROP NOT NULL
        SQL);
        $this->addSql(<<<'SQL'
            ALTER TABLE rapport_veterinaire ALTER etat TYPE VARCHAR(100)
        SQL);
        $this->addSql(<<<'SQL'
            ALTER TABLE rapport_veterinaire ALTER nourriture TYPE VARCHAR(100)
        SQL);
        $this->addSql(<<<'SQL'
            ALTER TABLE rapport_veterinaire ALTER quantite TYPE NUMERIC(10, 2)
        SQL);
        $this->addSql(<<<'SQL'
            ALTER TABLE rapport_veterinaire ALTER details DROP NOT NULL
        SQL);
        $this->addSql(<<<'SQL'
            ALTER TABLE utilisateur ALTER id_utilisateur DROP DEFAULT
        SQL);
    }

    public function down(Schema $schema): void
    {
        // this down() migration is auto-generated, please modify it to your needs
        $this->addSql(<<<'SQL'
            CREATE SCHEMA public
        SQL);
        $this->addSql(<<<'SQL'
            ALTER TABLE rapport_veterinaire ALTER id_animal SET NOT NULL
        SQL);
        $this->addSql(<<<'SQL'
            ALTER TABLE rapport_veterinaire ALTER id_veterinaire SET NOT NULL
        SQL);
        $this->addSql(<<<'SQL'
            ALTER TABLE rapport_veterinaire ALTER etat TYPE VARCHAR(255)
        SQL);
        $this->addSql(<<<'SQL'
            ALTER TABLE rapport_veterinaire ALTER nourriture TYPE VARCHAR(255)
        SQL);
        $this->addSql(<<<'SQL'
            ALTER TABLE rapport_veterinaire ALTER quantite TYPE INT
        SQL);
        $this->addSql(<<<'SQL'
            ALTER TABLE rapport_veterinaire ALTER details SET NOT NULL
        SQL);
        $this->addSql(<<<'SQL'
            ALTER TABLE calendrier ALTER id_admin SET NOT NULL
        SQL);
        $this->addSql(<<<'SQL'
            ALTER TABLE calendrier ALTER day_of_week TYPE VARCHAR(20)
        SQL);
        $this->addSql(<<<'SQL'
            CREATE SEQUENCE utilisateur_id_utilisateur_seq
        SQL);
        $this->addSql(<<<'SQL'
            SELECT setval('utilisateur_id_utilisateur_seq', (SELECT MAX(id_utilisateur) FROM utilisateur))
        SQL);
        $this->addSql(<<<'SQL'
            ALTER TABLE utilisateur ALTER id_utilisateur SET DEFAULT nextval('utilisateur_id_utilisateur_seq')
        SQL);
        $this->addSql(<<<'SQL'
            ALTER TABLE animal ADD visits INT DEFAULT NULL
        SQL);
        $this->addSql(<<<'SQL'
            ALTER TABLE animal ADD description TEXT DEFAULT NULL
        SQL);
        $this->addSql(<<<'SQL'
            ALTER TABLE animal DROP visit_count
        SQL);
        $this->addSql(<<<'SQL'
            ALTER TABLE habitat ALTER description SET NOT NULL
        SQL);
    }
}
