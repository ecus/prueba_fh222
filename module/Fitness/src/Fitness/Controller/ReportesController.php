<?php
namespace Fitness\Controller;

use Zend\Mvc\Controller\AbstractActionController;
use Zend\View\Model\ViewModel;
use Zend\Db\ResultSet\ResultSet;
use Zend\Db\Adapter\Adapter;
use Zend\Db\Sql\Sql;

use Zend\Form\Element; //principal**
use Zend\Form\Form;//principal**
use Zend\Form\Factory;//principal

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

use Fitness\Form\frmRepPlan;
class ReportesController extends AbstractActionController
{
	public $dbAdapter;
	public function indexAction()
	{
		$var		=	array(
				"titulo"		=>	"Registro de Sucursal",
			);
		$view = new ViewModel($var);
		$this->layout('layout/menu');
		return $view;
	}
	public function replanAction()
	{
		$this->dbAdapter=$this->getServiceLocator()->get('Zend\Db\Adapter');
		$tablaServ  =   new ServicioTabla($this->dbAdapter);
		$listaServ 	=   $tablaServ->listaServicio();
		// $repServ   	=   $tablaServ->resumenServicio();
		$frmPlan	=	new frmRepPlan('frmPlan');
		$frmPlan->get("cmbServicio")->setValueOptions($listaServ);
		$var		=	array(
				"titulo"		=>	"Registro de Sucursal",
				"frmPlan"	=>	$frmPlan
			);
		$view = new ViewModel($var);
		$this->layout('layout/reportes');
		return $view;
	}
	public function resumenservAction()
	{
		$this->dbAdapter=$this->getServiceLocator()->get('Zend\Db\Adapter');
		$request 	= 	$this->getRequest();
		$response 	=	$this->getResponse();
		$frm 		= 	$request->getPost();
		$id			=	$frm['cmbServicio'];
		$tablaServ  =   new ServicioTabla($this->dbAdapter);
		$repServ   	=   $tablaServ->resumenServicio($id);
		$repServ	=	\Zend\Json\Json::encode($repServ);
		$response->setContent(\Zend\Json\Json::prettyPrint($repServ,array("indent" => " ")));
		return $response;
	}
}
