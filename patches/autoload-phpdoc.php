<?php
spl_autoload_register(function ($class) {
    if (strpos($class, 'PHPStan\PhpDocParser\\') === 0) {
        $file = '/usr/share/php/' . str_replace('\\', '/', $class) . '.php';
        if (file_exists($file)) {
            require_once $file;
        }
    }
});