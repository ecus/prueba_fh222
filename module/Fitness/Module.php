<?php
namespace Fitness;

use Zend\Mvc\ModuleRouteListener;
use Zend\Mvc\MvcEvent;

// Add these import statements:
use Album\Model\Album;
use Album\Model\AlbumTable;
use Zend\Db\ResultSet\ResultSet;
use Zend\Db\TableGateway\TableGateway;

use Zend\ModuleManager\Feature\AutoloaderProviderInterface;

use Zend\Authentication\AuthenticationService;
use Zend\Authentication\Adapter\DbTable as DbTableAuthAdapter;

class Module
{
    public function onBootstrap(MvcEvent $e)
    {
        $eventManager        = $e->getApplication()->getEventManager();
        $moduleRouteListener = new ModuleRouteListener();
        $moduleRouteListener->attach($eventManager);
    }

    public function getConfig()
    {
        return include __DIR__ . '/config/module.config.php';
    }

    public function getAutoloaderConfig()
    {
        return array(
            'Zend\Loader\ClassMapAutoloader' => array(
                __DIR__ . '/autoload_classmap.php',
            ),
            'Zend\Loader\StandardAutoloader' => array(
                'namespaces' => array(
                    __NAMESPACE__ => __DIR__ . '/src/' . __NAMESPACE__,
                ),
            ),
        );
    }

///dsfds
    public function getServiceConfig()
    {
        return array(
            'factories' => array(
                'Album\Model\AlbumTable' =>  function($sm) {
                    $tableGateway = $sm->get('AlbumTableGateway');
                    $table = new AlbumTable($tableGateway);
                    return $table;
                },
                'AlbumTableGateway' => function ($sm) {
                    $dbAdapter = $sm->get('Zend\Db\Adapter\Adapter');
                    $resultSetPrototype = new ResultSet();
                    $resultSetPrototype->setArrayObjectPrototype(new Album());
                    return new TableGateway('album', $dbAdapter, null, $resultSetPrototype);
                },
            ),
            //////////
            'Fitness\Model\MyAuthStorage' => function($sm){
                return new \Fitness\Model\MyAuthStorage('zf_tutorial');  
            },
            
            'AuthService' => function($sm) {
                $dbAdapter      = $sm->get('Zend\Db\Adapter\Adapter');
                        $dbTableAuthAdapter  = new DbTableAuthAdapter($dbAdapter, 'users','user_name','pass_word', 'MD5(?)');
                
                $authService = new AuthenticationService();
                $authService->setAdapter($dbTableAuthAdapter);
                $authService->setStorage($sm->get('Fitness\Model\MyAuthStorage'));
                 
                return $authService;
            },
        );
    }    
}
