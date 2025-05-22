<?php

namespace App\Controller;

use App\Entity\Contact;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class ContactController extends AbstractController
{
    #[Route('/contact', name: 'app_contact', methods: ['GET', 'POST'])]
    public function index(Request $request, EntityManagerInterface $entityManager): Response
    {
        if ($request->isMethod('POST')) {
            // Récupérer les données du formulaire
            $email = $request->request->get('email');
            $sujet = $request->request->get('sujet');
            $message = $request->request->get('message');

            // Validation simple
            if (empty($email) || empty($sujet) || empty($message)) {
                $this->addFlash('error', 'Tous les champs sont obligatoires.');
                return $this->redirectToRoute('app_contact');
            }

            if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
                $this->addFlash('error', 'L\'adresse email n\'est pas valide.');
                return $this->redirectToRoute('app_contact');
            }

            // Créer une nouvelle entrée dans la table Contact
            $contact = new Contact();
            $contact->setEmail($email);
            $contact->setSujet($sujet);
            $contact->setMessage($message);
            $contact->setCreatedDate(new \DateTime());

            // Sauvegarder dans la base de données
            $entityManager->persist($contact);
            $entityManager->flush();

            $this->addFlash('success', 'Merci pour votre message ! Nous vous répondrons bientôt.');
            return $this->redirectToRoute('app_contact');
        }

        return $this->render('contact/index.html.twig');
    }
}