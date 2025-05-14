<?php
namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class HomeController extends AbstractController
{
    #[Route('/', name: 'home')]
    public function index(): Response
    {
        return $this->render('home/index.html.twig', [
            'welcome_message' => 'Bienvenue au Zoo Arcadia !',
        ]);
    }

    #[Route('/activites', name: 'activites')]
    public function activites(): Response
    {
        return $this->render('activites/index.html.twig');
    }

     #[Route('/animaux', name: 'animaux')]
    public function activites(): Response
    {
        return $this->render('animaux/index.html.twig');
    }
}