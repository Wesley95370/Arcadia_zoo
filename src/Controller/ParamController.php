<?php

namespace App\Controller;

use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class ParamController
{
    #[Route('/greet/{name}', name: 'app_greet')]
    public function greet(string $name): Response
    {
        return new Response(sprintf('Hello, %s! This is a static greeting.', $name), 200);
    }
}