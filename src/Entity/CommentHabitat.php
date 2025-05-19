<?php

namespace App\Entity;

use App\Repository\CommentHabitatRepository;
use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity(repositoryClass: CommentHabitatRepository::class)]
class CommentHabitat
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column(type: 'integer')]
    private ?int $idComment = null;

    #[ORM\Column(type: 'text')]
    private ?string $comment = null;

    #[ORM\Column(type: 'string', length: 255)]
    private ?string $conditionHabitat = null;

    #[ORM\Column(type: 'datetime')]
    private ?\DateTimeInterface $createdAt = null;

    #[ORM\ManyToOne(targetEntity: Utilisateur::class)]
    #[ORM\JoinColumn(name: 'id_veterinaire', referencedColumnName: 'id_utilisateur', nullable: false)]
    private ?Utilisateur $veterinaire = null;

    #[ORM\ManyToOne(targetEntity: Habitat::class)]
    #[ORM\JoinColumn(name: 'id_habitat', referencedColumnName: 'id_habitat', nullable: false)]
    private ?Habitat $habitat = null;

    public function getIdComment(): ?int
    {
        return $this->idComment;
    }

    public function getComment(): ?string
    {
        return $this->comment;
    }

    public function setComment(string $comment): self
    {
        $this->comment = $comment;
        return $this;
    }

    public function getConditionHabitat(): ?string
    {
        return $this->conditionHabitat;
    }

    public function setConditionHabitat(string $conditionHabitat): self
    {
        $this->conditionHabitat = $conditionHabitat;
        return $this;
    }

    public function getCreatedAt(): ?\DateTimeInterface
    {
        return $this->createdAt;
    }

    public function setCreatedAt(\DateTimeInterface $createdAt): self
    {
        $this->createdAt = $createdAt;
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

    public function getHabitat(): ?Habitat
    {
        return $this->habitat;
    }

    public function setHabitat(?Habitat $habitat): self
    {
        $this->habitat = $habitat;
        return $this;
    }
}