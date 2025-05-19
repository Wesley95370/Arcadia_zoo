<?php

namespace App\Entity;

use App\Repository\CalendrierRepository;
use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity(repositoryClass: CalendrierRepository::class)]
class Calendrier
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column(type: 'integer')]
    private ?int $idCalendrier = null;

    #[ORM\Column(type: 'string', length: 20)]
    private ?string $dayOfWeek = null;

    #[ORM\Column(type: 'time')]
    private ?\DateTimeInterface $openingTime = null;

    #[ORM\Column(type: 'time')]
    private ?\DateTimeInterface $closingTime = null;

    #[ORM\Column(type: 'boolean')]
    private ?bool $isHoliday = null;

    #[ORM\ManyToOne(targetEntity: Utilisateur::class)]
    #[ORM\JoinColumn(name: 'id_admin', referencedColumnName: 'id_utilisateur', nullable: false)]
    private ?Utilisateur $admin = null;

    public function getIdCalendrier(): ?int
    {
        return $this->idCalendrier;
    }

    public function getDayOfWeek(): ?string
    {
        return $this->dayOfWeek;
    }

    public function setDayOfWeek(string $dayOfWeek): self
    {
        $this->dayOfWeek = $dayOfWeek;
        return $this;
    }

    public function getOpeningTime(): ?\DateTimeInterface
    {
        return $this->openingTime;
    }

    public function setOpeningTime(\DateTimeInterface $openingTime): self
    {
        $this->openingTime = $openingTime;
        return $this;
    }

    public function getClosingTime(): ?\DateTimeInterface
    {
        return $this->closingTime;
    }

    public function setClosingTime(\DateTimeInterface $closingTime): self
    {
        $this->closingTime = $closingTime;
        return $this;
    }

    public function isHoliday(): ?bool
    {
        return $this->isHoliday;
    }

    public function setHoliday(bool $isHoliday): self
    {
        $this->isHoliday = $isHoliday;
        return $this;
    }

    public function getAdmin(): ?Utilisateur
    {
        return $this->admin;
    }

    public function setAdmin(?Utilisateur $admin): self
    {
        $this->admin = $admin;
        return $this;
    }
}