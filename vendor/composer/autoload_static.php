<?php

// autoload_static.php @generated by Composer

namespace Composer\Autoload;

class ComposerStaticInit209bb31a5decc9e07226def1eb0ceaf8
{
    public static $prefixLengthsPsr4 = array (
        'P' => 
        array (
            'PHPMailer\\PHPMailer\\' => 20,
        ),
    );

    public static $prefixDirsPsr4 = array (
        'PHPMailer\\PHPMailer\\' => 
        array (
            0 => __DIR__ . '/..' . '/phpmailer/phpmailer/src',
        ),
    );

    public static $classMap = array (
        'Composer\\InstalledVersions' => __DIR__ . '/..' . '/composer/InstalledVersions.php',
    );

    public static function getInitializer(ClassLoader $loader)
    {
        return \Closure::bind(function () use ($loader) {
            $loader->prefixLengthsPsr4 = ComposerStaticInit209bb31a5decc9e07226def1eb0ceaf8::$prefixLengthsPsr4;
            $loader->prefixDirsPsr4 = ComposerStaticInit209bb31a5decc9e07226def1eb0ceaf8::$prefixDirsPsr4;
            $loader->classMap = ComposerStaticInit209bb31a5decc9e07226def1eb0ceaf8::$classMap;

        }, null, ClassLoader::class);
    }
}
