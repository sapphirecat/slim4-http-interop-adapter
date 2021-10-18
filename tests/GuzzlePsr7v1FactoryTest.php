<?php

use PHPUnit\Framework\TestCase;

class GuzzlePsr7v1FactoryTest extends TestCase
{
    public function testCanCreateApp(): void
    {
        $app = \Slim\Factory\AppFactory::create();
        $this->assertInstanceOf(\Slim\App::class, $app);
    }
}
