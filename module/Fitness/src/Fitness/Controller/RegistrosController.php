<?php
namespace Fitness\Controller;

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

use Fitness\Form\Frmsucursal;
use Fitness\Form\Frmpersonal;
use Fitness\Form\frmCuenta;
use Fitness\Form\FrmBuscar;
use Fitness\Form\Frmfreezing;
use Fitness\Form\frmEmpresa;
use Fitness\Form\FrmServicio;
use Fitness\Form\FrmPlan;

use Fitness\Model\Entity\Cuenta;
use Fitness\Model\Entity\Sucursal;
use Fitness\Model\Entity\Personal;
use Fitness\Model\Entity\Freezing;
use Fitness\Model\Entity\Empresa;
use Fitness\Model\Entity\Servicio;
use Fitness\Model\Entity\Plan;

use Fitness\Model\SucursalTabla;
use Fitness\Model\PersonalTabla;
use Fitness\Model\CuentaTabla;
use Fitness\Model\FreezingTabla;
use Fitness\Model\EmpresaTabla;
use Fitness\Model\ServicioTabla;
use Fitness\Model\PlanTabla;

use Fitness\Model\Entity\Socio;
use Fitness\Model\SocioTabla;

use Fitness\Form\frmsocio;
class RegistrosController extends AbstractActionController
{
	public $dbAdapter;
	public function indexAction()
	{
		$container = new Container('personal');
		if (isset($container->iduser)) {
			$this->dbAdapter=$this->getServiceLocator()->get('Zend\Db\Adapter');
			$tablaSuc	=	new SucursalTabla($this->dbAdapter);
			$listaSuc	=	$tablaSuc->listaSucursal();
			$pag		=	$this->getRequest()->getBaseUrl();
			$frmSuc 	=	new Frmsucursal('frmSucursal');
			$frmPer		=	new Frmpersonal('frmPersonal');
			// $frmPer->get("cmbSucursal")->setValueOptions($listaSuc);
			$var		=	array(
					"titulo"		=>	"Registro de Sucursal",
					"frmPersonal" 	=>	$frmPer,
					"frmSucursal" 	=>	$frmSuc,
					"listaSuc" 		=>	$listaSuc,
					"url"			=>	$pag,
					'id'			=>	$container->iduser,
					'per'		=>	$container->idper,
					'nombre'		=>	$container->nombre
				);
			$view = new ViewModel($var);
			$this->layout('layout/menu');
			return $view;
		} else {
			return $this->forward()->dispatch("Fitness\Controller\Index",
									array(
										"action"	=>	"index",
										"msje"		=>	"Debe identificarse, para tener acceso a la aplicación."
										));
		}
	}
//------------------------------------- SUCURSAL -------------------------------------
	public function sucursalAction()
	{
		$container = new Container('personal');
		if (isset($container->iduser)) {
			$this->dbAdapter=$this->getServiceLocator()->get('Zend\Db\Adapter');
			$tablaSuc	=	new SucursalTabla($this->dbAdapter);
			$listaSuc	=	$tablaSuc->listaSucursal();
			$verSucursal=	$tablaSuc->verSucursal();
			$pag		=	$this->getRequest()->getBaseUrl();
			$frmSuc 	=	new Frmsucursal('frmSucursal');
			$var		=	array(
					"titulo"		=>	"Registro de Sucursal",
					"frmSucursal"	=>	$frmSuc,
					"listaSuc"		=>	$listaSuc,
					"verSucursal"	=>	$verSucursal,
					"url"			=>	$pag,
					'id'			=>	$container->iduser,
					'per'		=>	$container->idper,
					'nombre'		=>	$container->nombre
				);
			$view = new ViewModel($var);
			$this->layout('layout/registro');
			return $view;
		} else {
			return $this->forward()->dispatch("Fitness\Controller\Index",
									array(
										"action"	=>	"index",
										"msje"		=>	"Debe identificarse, para tener acceso a la aplicación."
										));
		}
	}

	public function listasucursalAction()
	{
		$container = new Container('personal');
		if (isset($container->iduser)) {
			$request 			= 	$this->getRequest();
			$response 			=	$this->getResponse();
			$this->dbAdapter	=	$this->getServiceLocator()->get('Zend\Db\Adapter');
			$tablaSuc			=	new SucursalTabla($this->dbAdapter);
			$listaSuc 			=	$tablaSuc->verSucursal();
			$listaSuc			=	\Zend\Json\Json::encode($listaSuc);
			$response->setContent(\Zend\Json\Json::prettyPrint($listaSuc,array("indent" => " ")));
			return $response;
		} else {
			return 0;
		}
	}

	public function activolistasucursalAction()
	{
		$container = new Container('personal');
		if (isset($container->iduser)) {
			$request 			= 	$this->getRequest();
			$response 			=	$this->getResponse();
			$this->dbAdapter	=	$this->getServiceLocator()->get('Zend\Db\Adapter');
			$tablaSuc			=	new SucursalTabla($this->dbAdapter);
			$listaSuc 			=	$tablaSuc->listaSucursalActivo();
			$listaSuc			=	\Zend\Json\Json::encode($listaSuc);
			$response->setContent(\Zend\Json\Json::prettyPrint($listaSuc,array("indent" => " ")));
			return $response;
		} else {
			return 0;
		}
	}

	public function inactivolistasucursalAction()
	{
		$container = new Container('personal');
		if (isset($container->iduser)) {
			$request 			= 	$this->getRequest();
			$response 			=	$this->getResponse();
			$this->dbAdapter	=	$this->getServiceLocator()->get('Zend\Db\Adapter');
			$tablaSuc			=	new SucursalTabla($this->dbAdapter);
			$listaSuc 			=	$tablaSuc->listaSucursalInactivo();
			$listaSuc			=	\Zend\Json\Json::encode($listaSuc);
			$response->setContent(\Zend\Json\Json::prettyPrint($listaSuc,array("indent" => " ")));
			return $response;
		} else {
			return 0;
		}
	}

	public function leesucursalAction()
	{
		$container = new Container('personal');
		if (isset($container->iduser)) {
			$request 			= 	$this->getRequest();
			$response 			=	$this->getResponse();
			$frm 				= 	$request->getPost();
			$id					=	$frm['id'];
			$this->dbAdapter	=	$this->getServiceLocator()->get('Zend\Db\Adapter');
			$tablaSuc			=	new SucursalTabla($this->dbAdapter);
			$listaSuc 			=	$tablaSuc->leeSucursal($id);
			$listaSuc			=	\Zend\Json\Json::encode($listaSuc);
			// Zend\Json\Json::prettyPrint($json, array("indent" => " ")
			$response->setContent(\Zend\Json\Json::prettyPrint($listaSuc,array("indent" => " ")));
			return $response;
		} else {
			return 0;
		}
	}
	public function desactivasucursalAction()
	{
		$container = new Container('personal');
		if (isset($container->iduser)) {
			$request 			= 	$this->getRequest();
			$response 			=	$this->getResponse();
			$frm 				= 	$request->getPost();
			$id					=	$frm['txtId'];
			$this->dbAdapter	=	$this->getServiceLocator()->get('Zend\Db\Adapter');
			$tablaSuc			=	new SucursalTabla($this->dbAdapter);
			$listaSuc 			=	$tablaSuc->desactivaSucursal($id);
			$listaSuc			=	\Zend\Json\Json::encode($listaSuc);
			// Zend\Json\Json::prettyPrint($json, array("indent" => " ")
			$response->setContent(\Zend\Json\Json::prettyPrint($listaSuc,array("indent" => " ")));
			return $response;
		} else {
			return 0;
		}
	}
	public function regsucursalAction()
	{
		$container = new Container('personal');
		if (isset($container->iduser)) {
			$request = $this->getRequest();
			$response = $this->getResponse();
			if ($request->isPost()) {
					$this->dbAdapter=$this->getServiceLocator()->get('Zend\Db\Adapter');
					$suc		=	new Sucursal();
					$sucTabla	=	new SucursalTabla($this->dbAdapter);
					$frm 		= 	$request->getPost();
					$suc->setDisplay_Suc($frm['txtDisplay']);
					$suc->setUbicacion_Suc($frm['txtUbicacion']);
					$suc->setLinea($frm['cmbLinea']);
					$suc->setTelefono_Suc($frm['txtTelefono']);
					$msje		=	$sucTabla->insertarSucursal($suc);
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

	public function actsucursalAction()
	{
		$container = new Container('personal');
		if (isset($container->iduser)) {
			$request = $this->getRequest();
			$response = $this->getResponse();
			if ($request->isPost()) {
				$this->dbAdapter=$this->getServiceLocator()->get('Zend\Db\Adapter');
				$suc		=	new Sucursal();
				$sucTabla	=	new SucursalTabla($this->dbAdapter);
				$frm 		= 	$request->getPost();
				$suc->setDisplay_Suc($frm['txtDisplay']);
				$suc->setUbicacion_Suc($frm['txtUbicacion']);
				$suc->setLinea($frm['cmbLinea']);
				$suc->setTelefono_Suc($frm['txtTelefono']);
				$suc->setEstado($frm['txtEstado']);
				$suc->setId($frm['txtId']);
	            $msje		=	$sucTabla->actualizarSucursal($suc);
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

//------------------------------------- PERSONAL -------------------------------------

	public function personalAction()
	{
		$container = new Container('personal');
		if (isset($container->iduser)) {
			$this->dbAdapter=$this->getServiceLocator()->get('Zend\Db\Adapter');
			$tablaSuc	=	new SucursalTabla($this->dbAdapter);
			$listaSuc	=	$tablaSuc->listaSucursal();
			$pag		=	$this->getRequest()->getBaseUrl();
			$frmPer		=	new Frmpersonal('frmPersonal');
			// $frmPer->get("cmbSucursal");->setValueOptions($listaSuc)
			$var		=	array(
					"titulo"		=>	"Registro de Sucursal",
					"frmPersonal" 	=>	$frmPer,
					"listaSuc"		=>	$listaSuc,
					"url"			=>	$pag,
					'id'			=>	$container->iduser,
					'per'		=>	$container->idper,
					'nombre'		=>	$container->nombre
				);
			$view = new ViewModel($var);
			$this->layout('layout/registro');
			return $view;
		} else {
			return $this->forward()->dispatch("Fitness\Controller\Index",
									array(
										"action"	=>	"index",
										"msje"		=>	"Debe identificarse, para tener acceso a la aplicación."
										));
		}
	}
	public function regpersonalAction()
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
				$per->setDni($frm['txtDni']);
				$per->setNombre($frm['txtNombre']);
				$per->setApPaterno($frm['txtApPaterno']);
				$per->setApMaterno($frm['txtApMaterno']);
				$per->setFechaNac(date("Y-m-d", strtotime($frm['dtpFecha'])));
				$per->setSexo($frm['txtSexo']);
				$per->setDireccion_per($frm['txtDireccion']);
				$per->setTelfCasa_per($frm['txtTelCasa']);
				$per->setTelfMovil_per($frm['txtTelMovil']);
				$per->setEmail_per($frm['txtEmail']);
	            $msje		=	$perTabla->insertarPersonal($per);
	            if (!$msje)
	                $response->setContent(\Zend\Json\Json::encode(array('response' => false)));
	            else {
	                $response->setContent(\Zend\Json\Json::encode(array('response' => $msje)));
	            }
	        }
			return $response;
		}else{
			return 0;
		}
	}
	public function reguserpersonalAction()
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
				$per->setDni($frm['txtDni']);
				$per->setNombre($frm['txtNombre']);
				$per->setApPaterno($frm['txtApPaterno']);
				$per->setApMaterno($frm['txtApMaterno']);
				$per->setFechaNac(date("Y-m-d", strtotime($frm['dtpFecha'])));
				$per->setSexo($frm['txtSexo']);
				$per->setDireccion_per($frm['txtDireccion']);
				$per->setTelfCasa_per($frm['txtTelCasa']);
				$per->setTelfMovil_per($frm['txtTelMovil']);
				$per->setEmail_per($frm['txtEmail']);
				$alias 		=	$frm['txtUsuario'];
	            $msje		=	$perTabla->insertarPersonalUsuario($per,$alias);
	            if (!$msje)
	                $response->setContent(\Zend\Json\Json::encode(array('response' => false)));
	            else {
	                $response->setContent(\Zend\Json\Json::encode(array('response' => $msje)));
	            }
        	}
			return $response;
		}else{
			return 0;
		}
	}

	public function pruebasAction()
	{
		$request = $this->getRequest();
		$response = $this->getResponse();
		if ($request->isPost()) {
			$frm 		= 	$request->getPost();
			$lista 		=	$frm['horario'];
			$suc 		=	$frm['lstSucursal'];
			$xml = new \DomDocument('1.0', 'UTF-8');

			$root = $xml->createElement('lista');
			$root = $xml->appendChild($root);

			$horario=$xml->createElement('horario');
			$horario =$root->appendChild($horario);

				$sucursal=$xml->createElement('sucursal','suc1');
				$sucursal =$horario->appendChild($sucursal);

				$personal=$xml->createElement('personal','per1');
				$personal =$horario->appendChild($personal);

				$detalle=$xml->createElement('detalle');
				$detalle =$horario->appendChild($detalle);

					$dia=$xml->createElement('dia','Lunes');
					$dia =$detalle->appendChild($dia);
					$ini=$xml->createElement('ini','17:00');
					$ini =$detalle->appendChild($ini);
					$fin=$xml->createElement('fin','18:00');
					$fin =$detalle->appendChild($fin);
			$xml->formatOutput = true;
			// print ($xml->saveXML());
			// var_dump($xml->saveXML());

			//Guardar el xml como un archivo de String, es decir, poner los string en la variable $strings_xml:
			$strings_xml = $xml->saveXML();
        }
		$var		=	array(
				'suc'		=> $suc,
				"lista"		=>	$lista
			);
		$view = new ViewModel($var);
		$this->layout('layout/registro');
		return $view;
	}
	public function actpersonalAction()
	{
		$container = new Container('personal');
		if (isset($container->iduser)) {
			$request = $this->getRequest();
			$response = $this->getResponse();
			if ($request->isPost()) {
				$this->dbAdapter=$this->getServiceLocator()->get('Zend\Db\Adapter');
				$per		=	new Personal();
				$perTabla	=	new PersonalTabla($this->dbAdapter);
				$per->setId($frm['txtId']);
				$per->setDni($frm['txtDni']);
				$per->setNombre($frm['txtNombre']);
				$per->setApPaterno($frm['txtApPaterno']);
				$per->setApMaterno($frm['txtApMaterno']);
				$per->setFechaNac(date("Y-m-d", strtotime($frm['dtpFecha'])));
				$per->setSexo($frm['txtSexo']);
				$per->setDireccion_per($frm['txtDireccion']);
				$per->setTelfCasa_per($frm['txtTelCasa']);
				$per->setTelfMovil_per($frm['txtTelMovil']);
				$per->setEmail_per($frm['txtEmail']);
				$per->setEstado($frm['txtEstado']);
	            $msje		=	$perTabla->actualizarPersonal($per);
				if (!$msje)
					$response->setContent(\Zend\Json\Json::encode(array('response' => false)));
				else {
					$response->setContent(\Zend\Json\Json::encode(array('response' => $msje)));
				}
			}
			return $response;
		}else{
			return 0;
		}
	}

	public function actuserpersonalAction()
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
				$per->setNombre($frm['txtNombre']);
				$per->setApPaterno($frm['txtApPaterno']);
				$per->setApMaterno($frm['txtApMaterno']);
				$per->setFechaNac(date("Y-m-d", strtotime($frm['dtpFecha'])));
				$per->setSexo($frm['txtSexo']);
				$per->setDireccion_per($frm['txtDireccion']);
				$per->setTelfCasa_per($frm['txtTelCasa']);
				$per->setTelfMovil_per($frm['txtTelMovil']);
				$per->setEmail_per($frm['txtEmail']);
				$per->setEstado($frm['txtEstado']);
				$estado 		=	$frm['txtEstadoUPer'];
	            $msje		=	$perTabla->actualizarPersonalUsuario($per,$estado);
	            if (!$msje)
	                $response->setContent(\Zend\Json\Json::encode(array('response' => false)));
	            else {
	                $response->setContent(\Zend\Json\Json::encode(array('response' => $msje)));
	            }
	        }
			return $response;
		}else{
			return 0;
		}
	}

	public function buscapersonalAction()
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
	            $msje		=	$perTabla->buscaPersonal($frm['txtDni']);
	            if (!$msje)
	                $response->setContent(\Zend\Json\Json::encode(array('response' => false)));
	            else {
	                $response->setContent(\Zend\Json\Json::encode(array('response' => $msje)));
	            }
	        }
			return $response;
		}else{
			return 0;
		}
	}

//------------------------------------- SOCIO ----------------------------------------
	public function socioAction()
	{
		$container = new Container('personal');
		if (isset($container->iduser)) {
			$this->dbAdapter=$this->getServiceLocator()->get('Zend\Db\Adapter');
			$tablaSuc	=	new SucursalTabla($this->dbAdapter);
			$listaSuc	=	$tablaSuc->listaSucursal();
			$pag		=	$this->getRequest()->getBaseUrl();
			$frmsoc		=	new frmsocio('frmSocio');
			//$frmsoc-> get("cmbempresa")=setValueOptions($listaSuc);
			$var		=	array(
				"titulo"		=>	"Registro de Socio",
    			"frmSocio"	=>	$frmsoc,
    			"listaSuc"		=>	$listaSuc,
				"url"			=>	$pag,
				'id'			=>	$container->iduser,
					'per'		=>	$container->idper,
				'nombre'		=>	$container->nombre
			);
			$view = new ViewModel($var);
			$this->layout('layout/registro');
			return $view;
		}else{
			return $this->forward()->dispatch("Fitness\Controller\Index",
									array(
										"action"	=>	"index",
										"msje"		=>	"Debe identificarse, para tener acceso a la aplicación."
										));
		}
	}

	public function regsocioAction()
	{
		$container = new Container('personal');
		if (isset($container->iduser)) {
			$request = $this->getRequest();
			$response = $this->getResponse();
			if ($request->isPost()) {
				$this->dbAdapter=$this->getServiceLocator()->get('Zend\Db\Adapter');
				$soc		=	new Socio;
				$socTabla	=	new SocioTabla($this->dbAdapter);

				$frm 		= 	$request->getPost();
				$soc->setpaterno($frm['txtApPaterno']);
				$soc->setmaterno($frm['txtApMaterno']);
				$soc->setnombres($frm['txtNombre']);
				$soc->setfechanac($frm['dtpFechanac']);
				$soc->setemail($frm['txtEmail']);
				$soc->settelefono($frm['txtTelCasa']);
				$soc->setmovil($frm['txtTelMovil']);
				$soc->setemergencia($frm['txtTelemergencia']);
				$soc->setecivil($frm['cmbecivil']);
				$soc->setfechavisita($frm['1985-10-11']);
				$soc->setfecharegistro($frm['1985-10-11']);
				$soc->setfechainv($frm['dtpFechaInvitacion']);
				$soc->setreferido($frm['cmbsocio']);
				$soc->setempresa($frm['cmbempresa']);
				$soc->setdocumento($frm['cmbDocumento']);
				$soc->setnumerodoc($frm['txtDni']);
				$soc->setsexo($frm['cmbSexo']);
				$soc->setpersonal($frm['cmbpersonal']);
				$soc->setestado($frm['cmbestado']);

	            $msje		=	$socTabla->insertaSocio($soc);
	            if (!$msje)
	                $response->setContent(\Zend\Json\Json::encode(array('response' => false)));
	            else {
	                $response->setContent(\Zend\Json\Json::encode(array('response' => $msje)));
	            }
		}else{
			return 0;
		}
	}
		return $response;
	}
	public function regusuariosocioAction()
	{
		$container = new Container('personal');
		if (isset($container->iduser)) {
			$request = $this->getRequest();
			$response = $this->getResponse();
			if ($request->isPost()) {
				$this->dbAdapter=$this->getServiceLocator()->get('Zend\Db\Adapter');
				$soc		=	new Socio;
				$socTabla	=	new SocioTabla($this->dbAdapter);
				$frm 		= 	$request->getPost();
				$soc->setpaterno($frm['txtApPaterno']);
				$soc->setmaterno($frm['txtApMaterno']);
				$soc->setnombres($frm['txtNombre']);
				$soc->setfechanac($frm['dtpFechanac']);
				$soc->setemail($frm['txtEmail']);
				$soc->settelefono($frm['txtTelCasa']);
				$soc->setmovil($frm['txtTelMovil']);
				$soc->setemergencia($frm['txtTelemergencia']);
				$soc->setecivil($frm['cmbecivil']);
				$soc->setfechavisita($frm['1985-10-11']);
				$soc->setfecharegistro($frm['1985-10-11']);
				$soc->setfechainv($frm['dtpFechaInvitacion']);
				$soc->setreferido($frm['cmbsocio']);
				$soc->setempresa($frm['cmbempresa']);
				$soc->setdocumento($frm['cmbDocumento']);
				$soc->setnumerodoc($frm['txtDni']);
				$soc->setsexo($frm['cmbSexo']);
				$soc->setpersonal($frm['cmbpersonal']);
				$soc->setestado($frm['cmbestado']);
				$alias 		=	$frm['txtUsuario'];

				$msje= $socTabla->insertaSocioUsuario($soc,$alias);
				if (!$msje)
	                $response->setContent(\Zend\Json\Json::encode(array('response' => false)));
	            else {
	                $response->setContent(\Zend\Json\Json::encode(array('response' => $msje)));
	            }
            }
			return $response;
		}else{
			return 0;
		}
	}

	public function buscasocioAction()
	{
		$container = new Container('personal');
		if (isset($container->iduser)) {
			$request 			= 	$this->getRequest();
			$response 			=	$this->getResponse();
			$this->dbAdapter	=	$this->getServiceLocator()->get('Zend\Db\Adapter');
			$tablasocio			=	new SocioTabla($this->dbAdapter);
			$frm=$request->getpost();
			$dni=$frm['cmbsocio'];

			$listasocio 			=	$tablasocio->versocio($dni);
			$listasocio			=	\Zend\Json\Json::encode($listasocio);
			$response->setContent(\Zend\Json\Json::prettyPrint($listasocio,array("indent" => " ")));
			return $response;
		}else{
			return 0;
		}
	}
	public function buscaidAction()
	{
		$container = new Container('personal');
		if (isset($container->iduser)) {
		}else{
			return 0;
		}
	}

//------------------------------------- SERVICIO -------------------------------------
	public function servicioAction()
	{
		$container = new Container('personal');
		if (isset($container->iduser)) {
			$this->dbAdapter=$this->getServiceLocator()->get('Zend\Db\Adapter');
			$tablaSuc	=	new SucursalTabla($this->dbAdapter);
			$tablaEmp	=	new EmpresaTabla($this->dbAdapter);
			$tablaPer	=	new PersonalTabla($this->dbAdapter);
			$listaSuc	=	$tablaSuc->listaSucursal();
			$listaEmp	=	$tablaEmp->listaEmpresa();
			$listaPer	=	$tablaPer->listaPersonal();
			$frmSer		=	new FrmServicio('frmServicio');
			$frmSer->get("cmbEncargado")->setValueOptions($listaPer);
			$frmSer->get("cmbSucursal")->setValueOptions($listaSuc);
			$frmSer->get("cmbEmpresa")->setValueOptions($listaEmp);
			$frmSer->get("lstSucursal")->setValueOptions($listaSuc);
			// $container = new Container('personal');
			// var_dump($frmSer);
			$var		=	array(
				"titulo"		=>	"Registro de Servicio",
				"frmServicio"	=>	$frmSer,
				'id'			=>	$container->iduser,
				'per'			=>	$container->idper,
				'nombre'		=>	$container->nombre,
			);
			$view = new ViewModel($var);
			$this->layout('layout/registro');
			return $view;
		}else{
			return $this->forward()->dispatch("Fitness\Controller\Index",
									array(
										"action"	=>	"index",
										"msje"		=>	"Debe identificarse, para tener acceso a la aplicación."
										));
		}
	}

	public function regservicioAction()
	{
		$container = new Container('personal');
		if (isset($container->iduser)) {
			$request = $this->getRequest();
			$response = $this->getResponse();
			if ($request->isPost()) {
				$this->dbAdapter=$this->getServiceLocator()->get('Zend\Db\Adapter');
				$ser		=	new Servicio();
				$serTabla	=	new ServicioTabla($this->dbAdapter);
				$frm 		= 	$request->getPost();
				// $ser->setNombre_ser('nuedo');
				$ser->setNombre_ser($frm['txtNombre']);
				$ser->setMontoBase_ser($frm['txtMonto']);
				$ser->setTipo_ser($frm['txtTipo']);
				$ser->setDiasCupon_ser(($frm['txtdiasCupon']=='')?null:$frm['txtdiasCupon']);
				$ser->setFreezing_ser(($frm['txtfreezing']=='')?null:$frm['txtfreezing']);
				$ser->setMontoInicial_ser(($frm['txtMontoIni']=='')?null:$frm['txtMontoIni']);
				$ser->setfechaReg_ser($frm['dtpFecha']);
				$ser->setPromocion_ser(0);
				// $ser->setEmpresa_id_emp(($frm['cmbEmpresa']=='')?null:$frm['cmbEmpresa']);
				$ser->setPersonal_id_per($frm['txtPersonal']);
				$sucursales	=	$frm['lstSucursal'];
				$horario	=	$frm['horario'];
				$msje		=	$serTabla->insertarServicio($ser,$horario,$sucursales);
	            if (!$msje)
	                $response->setContent(\Zend\Json\Json::encode(array('response' => false)));
	            else {
	                $response->setContent(\Zend\Json\Json::encode(array('response' => $msje)));

	            }
	        }
			return $response;
		}else{
			return 0;
		}
	}

//------------------------------------- PLAN -----------------------------------------
	public function planAction()
	{
		$container = new Container('personal');
		if (isset($container->iduser)) {
			$frmPlan		=	new FrmPlan('frmPlan');
			$this->dbAdapter=$this->getServiceLocator()->get('Zend\Db\Adapter');
			$tablaSuc	=	new SucursalTabla($this->dbAdapter);
			$tablaEmp	=	new EmpresaTabla($this->dbAdapter);
			$tablaPer	=	new PersonalTabla($this->dbAdapter);
			$tablaServ	=	new ServicioTabla($this->dbAdapter);
			$listaSuc	=	$tablaSuc->listaSucursal();
			$listaPlan	=	$tablaServ->listaPlan();
			// $listaEmp	=	$tablaEmp->listaEmpresa();
			$listaPer	=	$tablaPer->listaPersonal();
			$listaServ	=	$tablaServ->listaServicioBase();
			$frmPlan->get("cmbEncargado")->setValueOptions($listaPer);
			$frmPlan->get("cmbSucursal")->setValueOptions($listaSuc);
			// $frmPlan->get("cmbEmpresa")->setValueOptions($listaEmp);
			$frmPlan->get("cmbPlanBase")->setValueOptions($listaPlan);
			$frmPlan->get("lstSucursal")->setValueOptions($listaSuc);
			$frmPlan->get("lstServicios")->setValueOptions($listaServ);
			$var		=	array(
					"titulo"		=>	"Registrar Plan",
					"frmPlan"		=>	$frmPlan,
					'id'			=>	$container->iduser,
					'per'		=>	$container->idper,
					'nombre'		=>	$container->nombre
				);
			$view = new ViewModel($var);
			$this->layout('layout/registro');
			return $view;
		}else{
			return 0;
		}
	}
	public function regplanAction()
	{
		$container = new Container('personal');
		if (isset($container->iduser)) {
			$request = $this->getRequest();
			$response = $this->getResponse();
			if ($request->isPost()) {
				$this->dbAdapter=$this->getServiceLocator()->get('Zend\Db\Adapter');
				$ser		=	new Servicio();
				$serTabla	=	new ServicioTabla($this->dbAdapter);
				$frm 		= 	$request->getPost();
				// $ser->setNombre_ser('nuedo');
				$ser->setNombre_ser($frm['txtNombre']);
				$ser->setMontoBase_ser($frm['txtMonto']);
				$ser->setTipo_ser($frm['txtTipo']);
				$ser->setDiasCupon_ser(($frm['txtdiasCupon']=='')?null:$frm['txtdiasCupon']);
				$ser->setFreezing_ser(($frm['txtfreezing']=='')?null:$frm['txtfreezing']);
				$ser->setMontoInicial_ser(($frm['txtMontoIni']=='')?null:$frm['txtMontoIni']);
				$ser->setCuota_ser($frm['txtCuotaMax']);
				$ser->setTipoDuracion_ser($frm['txtTipoDuracion']);
				$ser->setPagoMaximo_ser($frm['chkLimite']);
				$ser->setDuracion_ser($frm['txtDuracion']);
				$ser->setfechaReg_ser($frm['dtpFecha']);
				$ser->setPromocion_ser(0);
				$ser->setservicioBase(($frm['cmbPlanBase']=='')?null:$frm['cmbPlanBase']);
				// $ser->setEmpresa_id_emp(($frm['cmbEmpresa']=='')?null:$frm['cmbEmpresa']);
				$ser->setPersonal_id_per($frm['txtPersonal']);
				$sucursales	=	$frm['lstSucursal'];
				$servicios	=	$frm['lstServicios'];
				$horario	=	$frm['horario'];
				$msje		=	$serTabla->insertarPlan($ser,$horario,$sucursales,$servicios);
				if (!$msje)
					$response->setContent(\Zend\Json\Json::encode(array('response' => false)));
				else {
					$response->setContent(\Zend\Json\Json::encode(array('response' => $msje)));
				}
	        }
			return $response;
		}else{
			return 0;
		}
	}

	public function resumenplanAction()
	{
		$this->dbAdapter=$this->getServiceLocator()->get('Zend\Db\Adapter');
		$request 	= 	$this->getRequest();
		$response 	=	$this->getResponse();
		$frm 		= 	$request->getPost();
		$id			=	$frm['cmbPlanBase'];
		$tablaServ  =   new ServicioTabla($this->dbAdapter);
		$repServ   	=   $tablaServ->resumenServicio($id);
		$repServ	=	\Zend\Json\Json::encode($repServ);
		$response->setContent(\Zend\Json\Json::prettyPrint($repServ,array("indent" => " ")));
		return $response;
	}
//------------------------------------- PROMOCION ------------------------------------
	public function promocionAction()
	{
		$container = new Container('personal');
		if (isset($container->iduser)) {
			$frmPlan		=	new frmPlan('frmPlan');
			$this->dbAdapter=$this->getServiceLocator()->get('Zend\Db\Adapter');
			$tablaSuc	=	new SucursalTabla($this->dbAdapter);
			$tablaEmp	=	new EmpresaTabla($this->dbAdapter);
			$tablaPer	=	new PersonalTabla($this->dbAdapter);
			$tablaServ	=	new ServicioTabla($this->dbAdapter);
			$listaSuc	=	$tablaSuc->listaSucursal();
			$listaEmp	=	$tablaEmp->listaEmpresa();
			$listaPer	=	$tablaPer->listaPersonal();
			$listaServ	=	$tablaServ->listaServicioBase();
			$frmPlan->get("cmbEncargado")->setValueOptions($listaPer);
			$frmPlan->get("cmbSucursal")->setValueOptions($listaSuc);
			$frmPlan->get("cmbEmpresa")->setValueOptions($listaEmp);
			$frmPlan->get("lstSucursal")->setValueOptions($listaSuc);
			$frmPlan->get("lstServicios")->setValueOptions($listaServ);
			$var		=	array(
					"titulo"		=>	"Registrar Plan",
					"frmPlan"		=>	$frmPlan,
					'id'			=>	$container->iduser,
					'per'		=>	$container->idper,
					'nombre'		=>	$container->nombre
				);
			$view = new ViewModel($var);
			$this->layout('layout/registro');
			return $view;
		}else{
			return $this->forward()->dispatch("Fitness\Controller\Index",
									array(
										"action"	=>	"index",
										"msje"		=>	"Debe identificarse, para tener acceso a la aplicación."
										));
		}
	}

//------------------------------------- EMPRESA --------------------------------------
	public function empresaAction()
	{
		$container	=	new Container('personal');
		if (isset($container->iduser)) {
			$frmEmp	=	new FrmEmpresa('frmEmpresa');
			$var	=	array(
					"titulo"		=>	"Registro de Empresa",
					"frmEmpresa"	=>	$frmEmp,
					'id'			=>	$container->iduser,
					'per'		=>	$container->idper,
					'nombre'		=>	$container->nombre
				);
			$view	=	new ViewModel($var);
			$this->layout('layout/registro');
			return $view;
		} else {
			return $this->forward()->dispatch("Fitness\Controller\Index",
									array(
										"action"	=>	"index",
										"msje"		=>	"Debe identificarse, para tener acceso a la aplicación."
										));
		}
	}
	public function regempresaAction()
	{
		$container	=	new Container('personal');
		if (isset($container->iduser)) {
			$request	=	$this->getRequest();
			$response	=	$this->getResponse();
			if ($request->isPost()) {
				$this->dbAdapter	=	$this->getServiceLocator()->get('Zend\Db\Adapter');
				$emp				=	new Empresa();
				$empTabla			=	new EmpresaTabla($this->dbAdapter);
				$frm				=	$request->getPost();
				$emp->setNombre_Em($frm['txtNombre']);
				$msje				=	$empTabla->insertarEmpresa($emp);
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
}
