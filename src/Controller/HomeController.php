<?php

namespace App\Controller;

use App\Entity\Calendrier;
use App\Entity\Animal;
use App\Entity\Service;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class HomeController extends AbstractController
{
    #[Route('/', name: 'home')]
    public function index(EntityManagerInterface $entityManager): Response
    {
        $schedules = $entityManager->getRepository(Calendrier::class)->findAll();

        // Récupérer les 2 animaux avec le plus de visites
        $topAnimals = $entityManager->createQueryBuilder()
            ->select('a')
            ->from(Animal::class, 'a')
            ->orderBy('a.visits', 'DESC')
            ->setMaxResults(2)
            ->getQuery()
            ->getResult();

        return $this->render('home/index.html.twig', [
            'welcome_message' => 'Bienvenue au Zoo Arcadia !',
            'schedules' => $schedules,
            'top_animals' => $topAnimals,
        ]);
    }

    #[Route('/services', name: 'services')]
    public function services(EntityManagerInterface $entityManager): Response
    {
        $services = $entityManager->getRepository(Service::class)->findAll();

        return $this->render('services/index.html.twig', [
            'services' => $services,
        ]);
    }
    
}