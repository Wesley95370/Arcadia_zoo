<?php

namespace App\Repository;

use App\Entity\Animal;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @extends ServiceEntityRepository<Animal>
 *
 * @method Animal|null find($id, $lockMode = null, $lockVersion = null)
 * @method Animal|null findOneBy(array $criteria, array $orderBy = null)
 * @method Animal[]    findAll()
 * @method Animal[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class AnimalRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, Animal::class);
    }

    /**
     * Sauvegarde une entité Animal dans la base de données.
     *
     * @param Animal $animal L'entité à sauvegarder
     * @param bool $flush Si vrai, exécute un flush pour persister immédiatement
     */
    public function save(Animal $animal, bool $flush = false): void
    {
        $this->getEntityManager()->persist($animal);
        if ($flush) {
            $this->getEntityManager()->flush();
        }
    }

    /**
     * Supprime une entité Animal de la base de données.
     *
     * @param Animal $animal L'entité à supprimer
     * @param bool $flush Si vrai, exécute un flush pour persister immédiatement
     */
    public function remove(Animal $animal, bool $flush = false): void
    {
        $this->getEntityManager()->remove($animal);
        if ($flush) {
            $this->getEntityManager()->flush();
        }
    }
}