<?php

namespace App\Entity;

use App\Repository\AvisRepository;
use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity(repositoryClass: AvisRepository::class)]
class Avis
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column(type: 'integer')]
    private ?int $idAvis = null;

    #[ORM\Column(type: 'string', length: 100)]
    private ?string $pseudo = null;

    #[ORM\Column(type: 'text')]
    private ?string $comment = null;

    #[ORM\Column(type: 'boolean')]
    private ?bool $isValidated = null;

    #[ORM\Column(type: 'datetime')]
    private ?\DateTimeInterface $createdAt = null;

    #[ORM\ManyToOne(targetEntity: Utilisateur::class)]
    #[ORM\JoinColumn(name: 'validate_by', referencedColumnName: 'id_utilisateur', nullable: true)]
    private ?Utilisateur $validateBy = null;

    public function getIdAvis(): ?int
    {
        return $this->idAvis;
    }

    public function getPseudo(): ?string
    {
        return $this->pseudo;
    }

    public function setPseudo(string $pseudo): self
    {
        $this->pseudo = $pseudo;
        return $this;
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

    public function isValidated(): ?bool
    {
        return $this->isValidated;
    }

    public function setValidated(bool $isValidated): self
    {
        $this->isValidated = $isValidated;
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

    public function getValidateBy(): ?Utilisateur
    {
        return $this->validateBy;
    }

    public function setValidateBy(?Utilisateur $validateBy): self
    {
        $this->validateBy = $validateBy;
        return $this;
    }
}