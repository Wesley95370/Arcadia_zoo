<?php

namespace App\Controller;

use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class HeaderController
{
    #[Route('/custom-header', name: 'app_custom_header')]
    public function customHeader(): Response
    {
        $response = new Response('This page has a custom header!', 200);
        $response->headers->set('X-Custom-Header', 'HelloWorld');
        return $response;
    }
}