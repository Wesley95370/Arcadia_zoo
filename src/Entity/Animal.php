<?php

namespace App\Entity;

use App\Repository\AnimalRepository;
use Doctrine\ORM\Mapping as ORM;
use Symfony\Component\Serializer\Annotation\Groups;

#[ORM\Entity(repositoryClass: AnimalRepository::class)]
class Animal
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column(type: 'integer', name: 'id_animal')]
    #[Groups(['animal:read'])]
    private ?int $idAnimal = null;

    #[ORM\Column(type: 'string', length: 100)]
    #[Groups(['animal:read'])]
    private ?string $name = null;

    #[ORM\Column(type: 'string', length: 100)]
    #[Groups(['animal:read'])]
    private ?string $race = null;

    #[ORM\Column(type: 'json', nullable: true)]
    #[Groups(['animal:read'])]
    private ?array $image = null;

    #[ORM\ManyToOne(targetEntity: Habitat::class, inversedBy: 'animals')]
    #[ORM\JoinColumn(name: 'id_habitat', referencedColumnName: 'id_habitat', nullable: true)]
    #[Groups(['animal:read'])]
    private ?Habitat $habitat = null;

    #[ORM\Column(type: 'integer', options: ['default' => 0])]
    #[Groups(['animal:read'])]
    private int $visits = 0;

    #[ORM\Column(type: 'text', nullable: true)]
    #[Groups(['animal:read'])]
    private ?string $description = null;

    public function getIdAnimal(): ?int
    {
        return $this->idAnimal;
    }

    public function getName(): ?string
    {
        return $this->name;
    }

    public function setName(string $name): self
    {
        $this->name = $name;
        return $this;
    }

    public function getRace(): ?string
    {
        return $this->race;
    }

    public function setRace(string $race): self
    {
        $this->race = $race;
        return $this;
    }

    public function getImage(): ?array
    {
        return $this->image;
    }

    public function setImage(?array $image): self
    {
        $this->image = $image;
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

    public function getVisits(): int
    {
        return $this->visits;
    }

    public function setVisits(int $visits): self
    {
        $this->visits = $visits;
        return $this;
    }

    public function incrementVisits(): self
    {
        $this->visits++;
        return $this;
    }

    public function getDescription(): ?string
    {
        return $this->description;
    }

    public function setDescription(?string $description): self
    {
        $this->description = $description;
        return $this;
    }
}