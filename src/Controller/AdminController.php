<?php

namespace App\Controller;

use App\Entity\Animal;
use App\Entity\Habitat;
use App\Entity\Service;
use App\Entity\Utilisateur;
use App\Entity\RapportVeterinaire;
use App\Entity\Calendrier;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\PasswordHasher\Hasher\UserPasswordHasherInterface;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Mailer\MailerInterface;
use Symfony\Component\Mime\Email;

class AdminController extends AbstractController
{
    #[Route('/admin', name: 'admin_dashboard')]
    public function dashboard(EntityManagerInterface $entityManager): Response
    {
        if (!$this->isGranted('ROLE_ADMIN')) {
            throw $this->createAccessDeniedException('Seuls les admins peuvent accéder à cette page.');
        }

        // Récupérer le nom de l'admin connecté
        $admin = $this->getUser();

        // Récupérer les visites par animal
        $animals = $entityManager->getRepository(Animal::class)->findAll();

        return $this->render('admin/dashboard.html.twig', [
            'admin_name' => $admin->getEmail(),
            'animals' => $animals,
        ]);
    }

    #[Route('/admin/create-user', name: 'admin_create_user')]
    public function createUser(Request $request, UserPasswordHasherInterface $passwordHasher, EntityManagerInterface $entityManager, MailerInterface $mailer): Response
    {
        if (!$this->isGranted('ROLE_ADMIN')) {
            throw $this->createAccessDeniedException('Seuls les admins peuvent créer des utilisateurs.');
        }

        if ($request->isMethod('POST')) {
            $email = $request->request->get('email');
            $role = $request->request->get('role');
            $password = $request->request->get('password');

            if (empty($email) || empty($role) || empty($password)) {
                $this->addFlash('error', 'Tous les champs sont obligatoires.');
                return $this->redirectToRoute('admin_create_user');
            }

            if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
                $this->addFlash('error', 'L\'adresse email n\'est pas valide.');
                return $this->redirectToRoute('admin_create_user');
            }

            if (!in_array($role, ['ROLE_EMPLOYE', 'ROLE_VETERINAIRE'])) {
                $this->addFlash('error', 'Rôle invalide.');
                return $this->redirectToRoute('admin_create_user');
            }

            $user = new Utilisateur();
            $user->setEmail($email);
            $hashedPassword = $passwordHasher->hashPassword($user, $password);
            $user->setPassword($hashedPassword);
            $user->setRole($role);
            $user->setCreatedAt(new \DateTime());

            $entityManager->persist($user);
            $entityManager->flush();

            $emailMessage = (new Email())
                ->from('admin@arcadiazoo.fr')
                ->to($email)
                ->subject('Votre compte Arcadia Zoo a été créé')
                ->html("<p>Un compte a été créé pour vous.</p>
                        <p>Votre email : {$email}</p>
                        <p>Veuillez contacter l'administrateur pour obtenir votre mot de passe.</p>");

            $mailer->send($emailMessage);

            $this->addFlash('success', 'Utilisateur créé avec succès et email envoyé.');
            return $this->redirectToRoute('admin_create_user');
        }

        return $this->render('admin/create_user.html.twig');
    }

    #[Route('/admin/animals', name: 'admin_animals')]
    public function manageAnimals(Request $request, EntityManagerInterface $entityManager): Response
    {
        if (!$this->isGranted('ROLE_ADMIN')) {
            throw $this->createAccessDeniedException('Seuls les admins peuvent accéder à cette page.');
        }

        $habitats = $entityManager->getRepository(Habitat::class)->findAll();
        $animals = $entityManager->getRepository(Animal::class)->findAll();

        if ($request->isMethod('POST')) {
            $action = $request->request->get('action');
            if ($action === 'add') {
                $animal = new Animal();
                $animal->setName($request->request->get('name'));
                $animal->setRace($request->request->get('race'));
                $animal->setImage(json_decode($request->request->get('image'), true));
                $habitat = $entityManager->getRepository(Habitat::class)->find($request->request->get('id_habitat'));
                $animal->setHabitat($habitat);
                $entityManager->persist($animal);
            } elseif ($action === 'update') {
                $animal = $entityManager->getRepository(Animal::class)->find($request->request->get('id'));
                $animal->setName($request->request->get('name'));
                $animal->setRace($request->request->get('race'));
                $animal->setImage(json_decode($request->request->get('image'), true));
                $habitat = $entityManager->getRepository(Habitat::class)->find($request->request->get('id_habitat'));
                $animal->setHabitat($habitat);
            } elseif ($action === 'delete') {
                $animal = $entityManager->getRepository(Animal::class)->find($request->request->get('id'));
                $entityManager->remove($animal);
            }
            $entityManager->flush();
            return $this->redirectToRoute('admin_animals');
        }

        return $this->render('admin/animals.html.twig', [
            'animals' => $animals,
            'habitats' => $habitats,
        ]);
    }

    #[Route('/admin/habitats', name: 'admin_habitats')]
    public function manageHabitats(Request $request, EntityManagerInterface $entityManager): Response
    {
        if (!$this->isGranted('ROLE_ADMIN')) {
            throw $this->createAccessDeniedException('Seuls les admins peuvent accéder à cette page.');
        }

        $habitats = $entityManager->getRepository(Habitat::class)->findAll();

        if ($request->isMethod('POST')) {
            $action = $request->request->get('action');
            if ($action === 'add') {
                $habitat = new Habitat();
                $habitat->setName($request->request->get('name'));
                $habitat->setDescription($request->request->get('description'));
                $habitat->setImage(json_decode($request->request->get('image'), true));
                $entityManager->persist($habitat);
            } elseif ($action === 'update') {
                $habitat = $entityManager->getRepository(Habitat::class)->find($request->request->get('id'));
                $habitat->setName($request->request->get('name'));
                $habitat->setDescription($request->request->get('description'));
                $habitat->setImage(json_decode($request->request->get('image'), true));
            } elseif ($action === 'delete') {
                $habitat = $entityManager->getRepository(Habitat::class)->find($request->request->get('id'));
                $entityManager->remove($habitat);
            }
            $entityManager->flush();
            return $this->redirectToRoute('admin_habitats');
        }

        return $this->render('admin/habitats.html.twig', [
            'habitats' => $habitats,
        ]);
    }

    #[Route('/admin/services', name: 'admin_services')]
    public function manageServices(Request $request, EntityManagerInterface $entityManager): Response
    {
        if (!$this->isGranted('ROLE_ADMIN')) {
            throw $this->createAccessDeniedException('Seuls les admins peuvent accéder à cette page.');
        }

        $services = $entityManager->getRepository(Service::class)->findAll();

        if ($request->isMethod('POST')) {
            $action = $request->request->get('action');
            if ($action === 'add') {
                $service = new Service();
                $service->setName($request->request->get('name'));
                $service->setImages(json_decode($request->request->get('images'), true));
                $service->setDescription($request->request->get('description'));
                $entityManager->persist($service);
            } elseif ($action === 'update') {
                $service = $entityManager->getRepository(Service::class)->find($request->request->get('id'));
                $service->setName($request->request->get('name'));
                $service->setImages(json_decode($request->request->get('images'), true));
                $service->setDescription($request->request->get('description'));
            } elseif ($action === 'delete') {
                $service = $entityManager->getRepository(Service::class)->find($request->request->get('id'));
                $entityManager->remove($service);
            }
            $entityManager->flush();
            return $this->redirectToRoute('admin_services');
        }

        return $this->render('admin/services.html.twig', [
            'services' => $services,
        ]);
    }

    #[Route('/admin/schedule', name: 'admin_schedule')]
    public function manageSchedule(Request $request, EntityManagerInterface $entityManager): Response
    {
        if (!$this->isGranted('ROLE_ADMIN')) {
            throw $this->createAccessDeniedException('Seuls les admins peuvent accéder à cette page.');
        }

        $schedules = $entityManager->getRepository(Calendrier::class)->findAll();

        if ($request->isMethod('POST')) {
            $action = $request->request->get('action');
            if ($action === 'add') {
                $schedule = new Calendrier();
                $schedule->setDayOfWeek($request->request->get('day_of_week'));
                $schedule->setOpeningTime(new \DateTime($request->request->get('opening_time')));
                $schedule->setClosingTime(new \DateTime($request->request->get('closing_time')));
                $schedule->setIsHoliday($request->request->get('is_holiday', false));
                $schedule->setIdAdmin($this->getUser());
                $entityManager->persist($schedule);
            } elseif ($action === 'update') {
                $schedule = $entityManager->getRepository(Calendrier::class)->find($request->request->get('id'));
                $schedule->setDayOfWeek($request->request->get('day_of_week'));
                $schedule->setOpeningTime(new \DateTime($request->request->get('opening_time')));
                $schedule->setClosingTime(new \DateTime($request->request->get('closing_time')));
                $schedule->setIsHoliday($request->request->get('is_holiday', false));
            } elseif ($action === 'delete') {
                $schedule = $entityManager->getRepository(Calendrier::class)->find($request->request->get('id'));
                $entityManager->remove($schedule);
            }
            $entityManager->flush();
            return $this->redirectToRoute('admin_schedule');
        }

        return $this->render('admin/schedule.html.twig', [
            'schedules' => $schedules,
        ]);
    }

    #[Route('/admin/reports', name: 'admin_reports')]
    public function manageReports(Request $request, EntityManagerInterface $entityManager): Response
    {
        if (!$this->isGranted('ROLE_ADMIN')) {
            throw $this->createAccessDeniedException('Seuls les admins peuvent accéder à cette page.');
        }

        $animalFilter = $request->query->get('animal');
        $dateFilter = $request->query->get('date');

        $qb = $entityManager->createQueryBuilder()
            ->select('r, a')
            ->from(RapportVeterinaire::class, 'r')
            ->leftJoin('r.idAnimal', 'a');

        if ($animalFilter) {
            $qb->andWhere('a.idAnimal = :animal')
               ->setParameter('animal', $animalFilter);
        }

        if ($dateFilter) {
            $qb->andWhere('r.datePassage LIKE :date')
               ->setParameter('date', $dateFilter . '%');
        }

        $reports = $qb->getQuery()->getResult();
        $animals = $entityManager->getRepository(Animal::class)->findAll();

        return $this->render('admin/reports.html.twig', [
            'reports' => $reports,
            'animals' => $animals,
            'animal_filter' => $animalFilter,
            'date_filter' => $dateFilter,
        ]);
    }
}