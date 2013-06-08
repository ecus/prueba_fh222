<?php
namespace Fitness\Controller;

use Zend\Mvc\Controller\AbstractActionController;
use Zend\View\Model\ViewModel;
use Zend\Db\ResultSet\ResultSet;
use Zend\Db\Adapter\Adapter;
use Zend\Db\Sql\Sql;

use Fitness\Form\Regsucursal;
use Fitness\Model\Entity\Sucursal;


class IndexController extends AbstractActionController
{
	public function indexAction()
	{
		//return new ViewModel();
		$pag	=	$this->getRequest()->getBaseUrl();
		$form 	=	new Regsucursal('form');
		$var	=	array(
				"titulo"	=>	"holaaaa carajo este es mi formulario en ZF2",
    			"form"		=>	$form,
				"url"		=>	$pag
			);
		$view = new ViewModel($var);
		//$this->layout('layout/prueba');
		return $view;
	}
}