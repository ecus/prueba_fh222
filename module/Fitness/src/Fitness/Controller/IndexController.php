<?php
namespace Fitness\Controller;

use Zend\Mvc\MvcEvent;
use Zend\Http\Response;
use Zend\Mvc\Controller\Plugin\Redirect;
use Zend\Mvc\Controller\AbstractActionController;
use Zend\View\Model\ViewModel;
use Zend\Db\ResultSet\ResultSet;
use Zend\Db\Adapter\Adapter;
use Zend\Db\Sql\Sql;

use Zend\Cache\StorageFactory;
use Zend\Session\Storage\ArrayStorage;
use Zend\Session\SaveHandler\Cache;
use Zend\Session\SessionManager;

use Fitness\Form\FrmLogin;
use Fitness\Model\Entity\Sucursal;

class IndexController extends AbstractActionController
{
	public function indexAction()
	{
		//return new ViewModel();
		$pag	=	$this->getRequest()->getBaseUrl();
		$form 	=	new FrmLogin('form');
		$var	=	array(
				"titulo"	=>	"Debe ir un formulario de Inicio de Sesion",
				"url"		=>	$pag,
				"form"		=>	$form
			);
		$view = new ViewModel($var);
		//$this->layout('layout/prueba');
		return $view;
	}
	public function recibeAction()
	{
		$request            =   $this->getRequest();
        $response           =   $this->getResponse();
        $frm=$request->getpost();

        $populateStorage = array(
        			'usuario' 	=> $frm['txtUsuario'],
        			'clave' 	=> $frm['txtClave'],);
		$storage = new ArrayStorage($populateStorage);
		$manager = new SessionManager();
		$manager->setStorage($storage);

		session_start();
        echo "<br><br><br><br>";
        var_dump($manager);
		// return $this->redirect()->toUrl('menu');
	}
	public function menuAction()
	{
		$view = new ViewModel();
		return $view;
	}
	public function javascriptAction()
	{
		$view = new ViewModel();
		return $view;
	}
	public function gettingstartedAction()
	{
		$view = new ViewModel();
		return $view;
	}
	public function cssAction()
	{
		$view = new ViewModel();
		return $view;
	}
	public function customizeAction()
	{
		$view = new ViewModel();
		return $view;
	}
	public function componentsAction()
	{
		$view = new ViewModel();
		return $view;
	}
}