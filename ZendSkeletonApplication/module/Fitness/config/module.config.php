<?php

return array(
    'controllers'=>array(
        'invokables'=>array(
            'Fitness\Controller\Index'=>'Fitness\Controller\IndexController'
         ),
     ),
     
     'router'=>array(
        'routes'=>array(
            'cesar'=>array(
                 'type'=>'Segment',
                    'options'=>array(
                        //route'    => '/[:controller[/:action][/:id]]'
                        //'route'    => '/[:controller[/:action]]',
                        'route' => '/fitness[/[:action]]',
                        'constraints' => array(
                                'action'  =>  '[a-zA-Z][a-zA-Z0-9_-]*',
                        ),

                        'defaults'  =>  array(
                                'controller' => 'Fitness\Controller\Index',
                                'action'     => 'index'

                        ),
                    ),
           ),
       ),
    ),

   //Cargamos el view manager
   'view_manager' => array(
        'display_not_found_reason' => true,
        'display_exceptions'       => true,
        'doctype'                  => 'HTML5',
        'not_found_template'       => 'error/404',
        'exception_template'       => 'error/index',
        'template_map' => array(
            'layout/layout'           => __DIR__ . '/../view/layout/layout.phtml',
            'fitness/index/index' => __DIR__ . '/../view/fitness/index/index.phtml',
            'error/404'               => __DIR__ . '/../view/error/404.phtml',
            'error/index'             => __DIR__ . '/../view/error/index.phtml',
        ),
        'template_path_stack' => array(
          'fitness' =>  __DIR__ . '/../view',
        ),
    ),
 );