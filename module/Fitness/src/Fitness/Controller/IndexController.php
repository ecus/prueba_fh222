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

use Zend\Session\AbstractManager;
use Zend\Session\Config\ConfigInterface;
use Zend\Session\Container;
use Zend\Session\Config\StandardConfig;
use Zend\Session\Config\SessionConfig;
use Zend\Session\SessionManager;
use Zend\Crypt\Password\Bcrypt;


use Fitness\Form\FrmLogin;
use Fitness\Form\FrmSettingsPer;
use Fitness\Model\PersonalTabla;
use Fitness\Model\Entity\Sucursal;

class IndexController extends AbstractActionController
{
	public $sesion;
	public function indexAction()
	{
		$pag	=	$this->getRequest()->getBaseUrl();
		$msje	=	$this->params()->fromRoute('msje');
		$form 	=	new FrmLogin('form');
		$var	=	array(
				"titulo"	=>	"Debe ir un formulario de Inicio de Sesion",
				"url"		=>	$pag,
				"form"		=>	$form,
				"msje"		=>	$msje
			);
		$view = new ViewModel($var);
		//$this->layout('layout/prueba');'variable'
		return $view;
	}
	public function recibeAction()
	{
		echo "<br><br><br><br>";
		$this->dbAdapter=$this->getServiceLocator()->get('Zend\Db\Adapter');
        $perTabla			=	new PersonalTabla($this->dbAdapter);
		$request            =   $this->getRequest();
        $response           =   $this->getResponse();
        $frm=$request->getpost();

		$recibe				=	$perTabla->loginPersonal($frm['txtUsuario'],$frm['txtClave']);

		if (isset($recibe->msje)) {
			$mensaje	=	$recibe->msje;
			return $this->forward()->dispatch("Fitness\Controller\Personal",
									array(
										"action"	=>	"index",
										"msje"		=>	$mensaje
										));
		} else {
			$bcrypt 		= 	new Bcrypt();
			$config 		=	new SessionConfig();
			$config->setOptions(array(
				'remember_me_seconds'	=> 15,
				'name'					=> 'zf2',
			));

			$manager = new SessionManager($config);

			$container = new Container('personal',$manager);
			$container->iduser 	=	$recibe->id_UPer;
			$container->idper 	=	$recibe->id_per;
			$container->user 	=	$recibe->alias_UPer;
			$container->pass 	=	$bcrypt->create($frm['txtClave']);
			$container->nombre 	=	$recibe->apellidoPaterno_Per .' '. $recibe->apellidoMaterno_Per . ', '. $recibe->nombres_Per;
			$container->sexo 	=	$recibe->sexo_Per;
			$container->sucursal=	$recibe->Sucursal_id_Suc;
			$container->cargo 	=	$recibe->cargo_Per;
			Container::setDefaultManager($manager);
			return $this->redirect()->toRoute('login-personal');
		}
	}
	public function menuAction()
	{
		// echo "<br><br><br><br>";
		$container = new Container('personal');
		if (isset($container->iduser)) {
			$var 	=	array(
				'id'		=>	$container->idper,
				'per'		=>	$container->idper,
				'nombre'	=>	$container->nombre,
				'sucursal'	=>	$container->sucursal,
				'cargo'		=>	$container->cargo,
				'pass'		=>	$container->pass
				);
			$view = new ViewModel($var);
			$this->layout('layout/menu');
			return $view;
		} else {
			// return $this->redirect()->toRoute('login-personal-error');
			return $this->forward()->dispatch("Fitness\Controller\Personal",
									array(
										"action"	=>	"index",
										"msje"		=>	"Debe identificarse, para tener acceso a la aplicación."
										));
		}
	}
	public function settingsperAction()
	{
		$pag	=	$this->getRequest()->getBaseUrl();
		$msje	=	$this->params()->fromRoute('msje');
		$form 	=	new FrmSettingsPer('form');
		$var	=	array(
				"titulo"		=>	"Debe ir un formulario de Inicio de Sesion",
				"url"			=>	$pag,
				"frmSettingsPer"=>	$form,
				"msje"			=>	$msje
			);
		$view = new ViewModel($var);
		//$this->layout('layout/prueba');'variable'
		return $view;
	}
	public function logoutperAction()
	{
		// echo "<br><br><br><br>";
		$container	=	new Container('personal');
		if (isset($container->iduser)) {
			$container->getManager()->getStorage()->clear('personal');
			return $this->forward()->dispatch("Fitness\Controller\Personal",
									array(
										"action"	=>	"index",
										"msje"		=>	"Sesion Finalizada."
										));
		} else {
			return $this->forward()->dispatch("Fitness\Controller\Personal",
									array(
										"action"	=>	"index",
										));
		}
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