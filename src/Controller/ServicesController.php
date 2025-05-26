<?php

namespace App\Controller;

use App\Entity\Service;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class ServicesController extends AbstractController
{
    #[Route('/services', name: 'app_services')]
    public function index(EntityManagerInterface $entityManager): Response
    {
        $services = $entityManager->getRepository(Service::class)->findAll();

        return $this->render('services/index.html.twig', [
            'services' => $services,
        ]);
    }
}