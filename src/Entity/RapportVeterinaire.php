<?php

namespace App\Entity;

use App\Repository\RapportVeterinaireRepository;
use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity(repositoryClass: RapportVeterinaireRepository::class)]
class RapportVeterinaire
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column(type: 'integer')]
    private ?int $idRapportVeterinaire = null;

    #[ORM\Column(type: 'string', length: 255)]
    private ?string $etat = null;

    #[ORM\Column(type: 'string', length: 255)]
    private ?string $nourriture = null;

    #[ORM\Column(type: 'integer')]
    private ?int $quantite = null;

    #[ORM\Column(type: 'datetime')]
    private ?\DateTimeInterface $datePassage = null;

    #[ORM\Column(type: 'text')]
    private ?string $details = null;

    #[ORM\ManyToOne(targetEntity: Animal::class)]
    #[ORM\JoinColumn(name: 'id_animal', referencedColumnName: 'id_animal', nullable: false)]
    private ?Animal $animal = null;

    #[ORM\ManyToOne(targetEntity: Utilisateur::class)]
    #[ORM\JoinColumn(name: 'id_veterinaire', referencedColumnName: 'id_utilisateur', nullable: false)]
    private ?Utilisateur $veterinaire = null;

    public function getIdRapportVeterinaire(): ?int
    {
        return $this->idRapportVeterinaire;
    }

    public function getEtat(): ?string
    {
        return $this->etat;
    }

    public function setEtat(string $etat): self
    {
        $this->etat = $etat;
        return $this;
    }

    public function getNourriture(): ?string
    {
        return $this->nourriture;
    }

    public function setNourriture(string $nourriture): self
    {
        $this->nourriture = $nourriture;
        return $this;
    }

    public function getQuantite(): ?int
    {
        return $this->quantite;
    }

    public function setQuantite(int $quantite): self
    {
        $this->quantite = $quantite;
        return $this;
    }

    public function getDatePassage(): ?\DateTimeInterface
    {
        return $this->datePassage;
    }

    public function setDatePassage(\DateTimeInterface $datePassage): self
    {
        $this->datePassage = $datePassage;
        return $this;
    }

    public function getDetails(): ?string
    {
        return $this->details;
    }

    public function setDetails(string $details): self
    {
        $this->details = $details;
        return $this;
    }

    public function getAnimal(): ?Animal
    {
        return $this->animal;
    }

    public function setAnimal(?Animal $animal): self
    {
        $this->animal = $animal;
        return $this;
    }

    public function getVeterinaire(): ?Utilisateur
    {
        return $this->veterinaire;
    }

    public function setVeterinaire(?Utilisateur $veterinaire): self
    {
        $this->veterinaire = $veterinaire;
        return $this;
    }
}