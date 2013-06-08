<?php
namespace Fitness\Controller;

use Zend\Mvc\Controller\AbstractActionController;
use Zend\View\Model\ViewModel;
use Zend\Db\ResultSet\ResultSet;
use Zend\Db\Adapter\Adapter;
use Zend\Db\Sql\Sql;

use Fitness\Form\Regsucursal;
use Fitness\Form\Buscar;
use Fitness\Model\Entity\Sucursal;

class RegistrosController extends AbstractActionController
{
	public function indexAction()
	{
		//return new ViewModel();
		$pag	=	$this->getRequest()->getBaseUrl();
		$form 	=	new Regsucursal('form');
		$var	=	array(
				"titulo"	=>	"Registro de Sucursal",
    			"form"		=>	$form,
				"url"		=>	$pag
			);
		$view = new ViewModel($var);
		//$this->layout('layout/prueba');
		return $view;
	}
	public function regpersonalAction($value='')
	{
		# code...
	}
	public function resultadoAction()
	{
		$this->dbAdapter=$this->getServiceLocator()->get('Zend\Db\Adapter');
    	$data	= array(
    		'id'=>'',
    		'ubicacion'=>'',
    		'telefono'=>'',
    		'display'=>''
    		);
    	$sucursal	=	new Sucursal($data,$this->dbAdapter);
    	$datos	=	$sucursal->listaSucursal($sucursal);
    	$var	=	array(
				"titul"	=>	"Resultado de Sucursal",
    			"datos"		=>	$datos
				//"url"		=>	$pag
			);
    	return new ViewModel($var);
	}
	public function buscarAction()
	{
		$pag	=	$this->getRequest()->getBaseUrl();
		$form 	=	new Buscar('form');
		$var	=	array(
				"titulo"	=>	"Busqueda de Sucursal",
    			"form"		=>	$form,
				"url"		=>	$pag
			);
		$view = new ViewModel($var);
		//$this->layout('layout/prueba');
		return $view;
	}
}