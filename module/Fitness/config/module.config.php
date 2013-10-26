<?php
/**
 * Zend Framework (http://framework.zend.com/)
 *
 * @link      http://github.com/zendframework/ZendSkeletonApplication for the canonical source repository
 * @copyright Copyright (c) 2005-2013 Zend Technologies USA Inc. (http://www.zend.com)
 * @license   http://framework.zend.com/license/new-bsd New BSD License
 */

return array(
    'router' => array(
        'routes' => array(
            'home' => array(
                'type' => 'Zend\Mvc\Router\Http\Literal',
                'options' => array(
                    'route'    => '/',
                    'defaults' => array(
                        'controller' => 'Fitness\Controller\Index',
                        'action'     => 'index',
                    ),
                ),
            ),
            // The following is a route to simplify getting started creating
            // new controllers and actions without needing to create a new
            // module. Simply drop new controllers in, and you can access them
            // using the path /application/:controller/:action
            'fitness' => array(
                'type'    => 'Literal',
                'options' => array(
                    'route'    => '/fitness',
                    'defaults' => array(
                        '__NAMESPACE__' => 'Fitness\Controller',
                        'controller'    => 'Index',
                        'action'        => 'index',
                    ),
                ),
                'may_terminate' => true,
                'child_routes' => array(
                    'default' => array(
                        'type'    => 'Segment',
                        'options' => array(
                            'route'    => '/[:controller[/:action][/:id]]',
                            //'route'    => '/[:controller[/:action]]',
                            'constraints' => array(
                                'controller' => '[a-zA-Z][a-zA-Z0-9_-]*',
                                'action'     => '[a-zA-Z][a-zA-Z0-9_-]*'
                            ),
                            'defaults' => array(
                            ),
                        ),
                    ),
                ),
            ),
<<<<<<< HEAD

            'login' => array(
                'type'    => 'Literal',
                'options' => array(
                    'route'    => '/auth',
                    'defaults' => array(
                        '__NAMESPACE__' => 'SanAuth\Controller',
                        'controller'    => 'Auth',
                        'action'        => 'login',
=======
            'login-personal' => array(
                'type'    => 'Literal',
                'options' => array(
                    'route'    => '/menu',
                    'scheme' => 'https',
                    'defaults' => array(
                        '__NAMESPACE__' => 'Fitness\Controller',
                        'controller'    => 'Index',
                        'action'        => 'menu',
                    ),
                ),
                'may_terminate' => true,
                'child_routes' => array(
                    'process' => array(
                        'type'    => 'Segment',
                        'options' => array(
                            'route'    => '/[:action]',
                            'constraints' => array(
                                'controller' => '[a-zA-Z][a-zA-Z0-9_-]*',
                                'action'     => '[a-zA-Z][a-zA-Z0-9_-]*',
                            ),
                            'defaults' => array(
                            ),
                        ),
                    ),
                ),
            ),
            'login-personal-error' => array(
                'type'    => 'Literal',
                'options' => array(
                    'route'    => '/Index',
                    'defaults' => array(
                        '__NAMESPACE__' => 'Fitness\Controller',
                        'controller'    => 'Index',
                        'action'        => 'index',
>>>>>>> session 3
                    ),
                ),
                'may_terminate' => true,
                'child_routes' => array(
                    'process' => array(
                        'type'    => 'Segment',
                        'options' => array(
                            'route'    => '/[:action]',
                            'constraints' => array(
                                'controller' => '[a-zA-Z][a-zA-Z0-9_-]*',
                                'action'     => '[a-zA-Z][a-zA-Z0-9_-]*',
                            ),
                            'defaults' => array(
                            ),
                        ),
                    ),
                ),
            ),
<<<<<<< HEAD
            
=======

/*
>>>>>>> session 3
            'success' => array(
                'type'    => 'Literal',
                'options' => array(
                    'route'    => '/success',
                    'defaults' => array(
                        '__NAMESPACE__' => 'SanAuth\Controller',
                        'controller'    => 'Success',
                        'action'        => 'index',
                    ),
                ),
                'may_terminate' => true,
                'child_routes' => array(
                    'default' => array(
                        'type'    => 'Segment',
                        'options' => array(
                            'route'    => '/[:action]',
                            'constraints' => array(
                                'controller' => '[a-zA-Z][a-zA-Z0-9_-]*',
                                'action'     => '[a-zA-Z][a-zA-Z0-9_-]*',
                            ),
                            'defaults' => array(
                            ),
                        ),
                    ),
                ),
<<<<<<< HEAD
            ),
=======
            ),*/
>>>>>>> session 3
        ),
    ),
    'service_manager' => array(
        'abstract_factories' => array(
            'Zend\Cache\Service\StorageCacheAbstractServiceFactory',
            'Zend\Log\LoggerAbstractServiceFactory',
        ),
        'aliases' => array(
            'translator' => 'MvcTranslator',
        ),
    ),
    'translator' => array(
        'locale' => 'es_ES',
        'translation_file_patterns' => array(
            array(
                'type'     => 'gettext',
                'base_dir' => __DIR__ . '/../language',
                'pattern'  => '%s.mo',
            ),
        ),
    ),
    'controllers' => array(
        'invokables' => array(
            'Fitness\Controller\Index'      =>  'Fitness\Controller\IndexController',
            'Fitness\Controller\Formulario' =>  'Fitness\Controller\FormularioController',
            'Fitness\Controller\Registros'  =>  'Fitness\Controller\RegistrosController',
            'Fitness\Controller\Trabajo'    =>  'Fitness\Controller\TrabajoController',
            'Fitness\Controller\Reportes'    =>  'Fitness\Controller\ReportesController',
            'Fitness\Controller\Atencion'   =>  'Fitness\Controller\AtencionController',
<<<<<<< HEAD
            
            'Fitness\Controller\Auth' => 'Fitness\Controller\AuthController',
            'Fitness\Controller\Success' => 'Fitness\Controller\SuccessController'
=======

            //'Fitness\Controller\Auth' => 'Fitness\Controller\AuthController',
            //'Fitness\Controller\Success' => 'Fitness\Controller\SuccessController'
>>>>>>> session 3
        ),
    ),
    'view_manager' => array(
        'display_not_found_reason' => true,
        'display_exceptions'       => true,
        'doctype'                  => 'HTML5',
        'not_found_template'       => 'error/404',
        'exception_template'       => 'error/index',
        'template_map' => array(
            //'layout/layout'           => __DIR__ . '/../view/layout/layout.phtml',
            'layout/prueba'           => __DIR__ . '/../view/layout/prueba.phtml',
            'fitness/index/index'     => __DIR__ . '/../view/fitness/index/index.phtml',
            'error/404'               => __DIR__ . '/../view/error/404.phtml',
            'error/index'             => __DIR__ . '/../view/error/index.phtml',
        ),
        'template_path_stack' => array(
           'fitness' => __DIR__ . '/../view',
        ),
    )
);