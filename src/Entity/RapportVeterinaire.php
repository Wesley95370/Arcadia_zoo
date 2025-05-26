<?php

namespace App\Entity;

use App\Repository\RapportVeterinaireRepository;
use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity(repositoryClass: RapportVeterinaireRepository::class)]
class RapportVeterinaire
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column(type: 'integer', name: 'id_rapport_veterinaire')]
    private ?int $idRapportVeterinaire = null;

    #[ORM\Column(type: 'string', length: 100)]
    private ?string $etat = null;

    #[ORM\Column(type: 'string', length: 100)]
    private ?string $nourriture = null;

    #[ORM\Column(type: 'decimal', precision: 10, scale: 2)]
    private ?float $quantite = null;

    #[ORM\Column(type: 'datetime')]
    private ?\DateTimeInterface $datePassage = null;

    #[ORM\Column(type: 'text', nullable: true)]
    private ?string $details = null;

    #[ORM\ManyToOne(targetEntity: Animal::class)]
    #[ORM\JoinColumn(name: 'id_animal', referencedColumnName: 'id_animal')]
    private ?Animal $idAnimal = null;

    #[ORM\ManyToOne(targetEntity: Utilisateur::class)]
    #[ORM\JoinColumn(name: 'id_veterinaire', referencedColumnName: 'id_utilisateur')]
    private ?Utilisateur $idVeterinaire = null;

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

    public function getQuantite(): ?float
    {
        return $this->quantite;
    }

    public function setQuantite(float $quantite): self
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

    public function setDetails(?string $details): self
    {
        $this->details = $details;
        return $this;
    }

    public function getIdAnimal(): ?Animal
    {
        return $this->idAnimal;
    }

    public function setIdAnimal(?Animal $idAnimal): self
    {
        $this->idAnimal = $idAnimal;
        return $this;
    }

    public function getIdVeterinaire(): ?Utilisateur
    {
        return $this->idVeterinaire;
    }

    public function setIdVeterinaire(?Utilisateur $idVeterinaire): self
    {
        $this->idVeterinaire = $idVeterinaire;
        return $this;
    }
}