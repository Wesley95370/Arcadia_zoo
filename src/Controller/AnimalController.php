<?php

namespace App\Controller;

use App\Entity\Animal;
use App\Repository\AnimalRepository;
use App\Repository\HabitatRepository;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\RedirectResponse;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;

#[Route('/animaux')]
class AnimalController extends AbstractController
{
    #[Route('', name: 'app_animals', methods: ['GET'])]
    public function index(AnimalRepository $animalRepository, SerializerInterface $serializer): Response
    {
        $animals = $animalRepository->findAll();
        $jsonAnimals = $serializer->serialize($animals, 'json', ['groups' => 'animal:read']);
        return $this->render('animaux/index.html.twig', [
            'animals' => $animals,
            'jsonAnimals' => $jsonAnimals,
        ]);
    }

    #[Route('/api/animals', name: 'api_animals_create', methods: ['POST'])]
    public function create(Request $request, AnimalRepository $animalRepository, HabitatRepository $habitatRepository, SerializerInterface $serializer): JsonResponse
    {
        $data = json_decode($request->getContent(), true);
        $animal = new Animal();
        $animal->setName($data['name']);
        $animal->setRace($data['race']);
        $animal->setImage(['url' => $data['image']['url']]);
        $animal->setHabitat($habitatRepository->find($data['idHabitat']));
        $animal->setVisits($data['visits'] ?? 0);
        $animal->setDescription($data['description'] ?? null);

        $animalRepository->save($animal, true);

        $json = $serializer->serialize($animal, 'json', ['groups' => 'animal:read']);
        return new JsonResponse($json, 201, [], true);
    }

    #[Route('/api/animals/{id}', name: 'api_animals_update', methods: ['PUT'])]
    public function update(int $id, Request $request, AnimalRepository $animalRepository, SerializerInterface $serializer): JsonResponse
    {
        $animal = $animalRepository->find($id);
        if (!$animal) {
            return new JsonResponse(['error' => 'Animal not found'], 404);
        }

        $data = json_decode($request->getContent(), true);
        $animal->setRace($data['race']);
        $animal->setDescription($data['description'] ?? null);

        $animalRepository->save($animal, true);

        $json = $serializer->serialize($animal, 'json', ['groups' => 'animal:read']);
        return new JsonResponse($json, 200, [], true);
    }

    #[Route('/api/animals/{id}', name: 'api_animals_delete', methods: ['DELETE'])]
    public function delete(int $id, AnimalRepository $animalRepository): JsonResponse
    {
        $animal = $animalRepository->find($id);
        if (!$animal) {
            return new JsonResponse(['error' => 'Animal not found'], 404);
        }

        $animalRepository->remove($animal, true);
        return new JsonResponse(null, 204);
    }

    #[Route('/{id}/visit', name: 'animal_increment_visit', methods: ['GET'])]
    public function incrementVisit(int $id, AnimalRepository $animalRepository): RedirectResponse
    {
        $animal = $animalRepository->find($id);
        if (!$animal) {
            $this->addFlash('error', 'Animal non trouvé');
            return $this->redirectToRoute('app_animals');
        }

        $animal->incrementVisits();
        $animalRepository->save($animal, true);

        $this->addFlash('success', sprintf('Visite incrémentée pour %s. Total: %d', $animal->getName(), $animal->getVisits()));

        return $this->redirectToRoute('app_animals');
    }

    #[Route('/api/animals/{id}/increment-visits', name: 'api_animals_increment_visits', methods: ['POST'])]
    public function incrementVisits(int $id, AnimalRepository $animalRepository, SerializerInterface $serializer): JsonResponse
    {
        $animal = $animalRepository->find($id);
        if (!$animal) {
            return new JsonResponse(['error' => 'Animal not found'], 404);
        }

        $animal->incrementVisits();
        $animalRepository->save($animal, true);

        $json = $serializer->serialize($animal, 'json', ['groups' => 'animal:read']);
        return new JsonResponse($json, 200, [], true);
    }
}