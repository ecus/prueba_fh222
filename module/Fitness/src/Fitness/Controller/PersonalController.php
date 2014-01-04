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
use Fitness\Model\Entity\Personal;
use Fitness\Model\Entity\Sucursal;

class PersonalController extends AbstractActionController
{
	public function indexAction()
	{
		$container = new Container('personal');
		if (isset($container->iduser)) {
			return $this->forward()->dispatch("Fitness\Controller\Personal",
									array(
										"action"	=>	"menu",
										'id'	=>	$container->idper,
										'per'		=>	$container->idper,
										'nombre'=>	$container->nombre
										));
		} else {
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
			var_dump($recibe);
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
			// $container->cargo 	=	$recibe->sexo_Per;
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
				'id'	=>	$container->idper,
				'per'		=>	$container->idper,
				'nombre'=>	$container->nombre
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
	public function verpersonalAction()
	{
		$container = new Container('personal');
		if (isset($container->iduser)) {
			$request	=	$this->getRequest();
			$response	=	$this->getResponse();
			if ($request->isPost()) {
				$this->dbAdapter	=	$this->getServiceLocator()->get('Zend\Db\Adapter');
				$per				=	new Personal();
				$perTabla			=	new PersonalTabla($this->dbAdapter);
				$frm				=	$request->getPost();
				$msje				=	$perTabla->verPersonal($frm['txtId']);
				if (!$msje)
					$response->setContent(\Zend\Json\Json::encode(array('response' => false)));
				else {
					$response->setContent(\Zend\Json\Json::encode(array('response' => $msje)));
				}
			}
			return $response;
		} else {
			return 0;
		}
	}
	public function settingsperAction()
	{
		$container = new Container('personal');
		if (isset($container->iduser)) {
			$pag	=	$this->getRequest()->getBaseUrl();
			$msje	=	$this->params()->fromRoute('msje');
			$form 	=	new FrmSettingsPer('form');
			$var	=	array(
					'id'			=>	$container->iduser,
					'per'		=>	$container->idper,
					'nombre'		=>	$container->nombre,
					"titulo"	=>	"Debe ir un formulario de Inicio de Sesion",
					"url"		=>	$pag,
					"frmSettingsPer"=>	$form,
					"msje"		=>	$msje
				);
			$view = new ViewModel($var);
			$this->layout('layout/configuracion');
			// 'variable'
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
	public function actualizaperAction()
	{
		$container = new Container('personal');
		if (isset($container->iduser)) {
			$request = $this->getRequest();
			$response = $this->getResponse();
			if ($request->isPost()) {
					$this->dbAdapter=$this->getServiceLocator()->get('Zend\Db\Adapter');
					$per		=	new Personal();
					$perTabla	=	new PersonalTabla($this->dbAdapter);
					$frm 		= 	$request->getPost();
					$per->setId($frm['txtId']);
					$per->setDni($frm['txtDni']);
					$per->setFechaNac(date("Y-m-d", strtotime($frm['dtpFechaNac'])));
					$per->setDireccion_per($frm['txtDireccion']);
					$per->setTelfCasa_per($frm['txtTelCasa']);
					$per->setTelfMovil_per($frm['txtTelMovil']);
					$per->setEmail_per($frm['txtEmail']);
					$per->setClave($frm['txtClave']);
					$msje		=	$perTabla->actualizaDatosPersonal($per);
					if (!$msje)
						$response->setContent(\Zend\Json\Json::encode(array('response' => false)));
					else {
						$response->setContent(\Zend\Json\Json::encode(array('response' => $msje)));
					}
			}
			return $response;
		} else {
			return 0;
		}
	}
	public function verificaclaveperAction()
	{
		$container = new Container('personal');
		if (isset($container->iduser)) {
			$request = $this->getRequest();
			$response = $this->getResponse();
			if ($request->isPost()) {
					$this->dbAdapter=$this->getServiceLocator()->get('Zend\Db\Adapter');
					$per		=	new Personal();
					$perTabla	=	new PersonalTabla($this->dbAdapter);
					$frm 		= 	$request->getPost();
					$per->setId($frm['txtId']);
					$per->setClave($frm['txtClave']);
					$msje		=	$perTabla->verificaClave($per);
					if (!$msje)
						$response->setContent(\Zend\Json\Json::encode(array('response' => false)));
					else {
						$response->setContent(\Zend\Json\Json::encode(array('response' => $msje)));
					}
			}
			return $response;
		} else {
			return 0;
		}
	}
	public function logoutperAction()
	{
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
}