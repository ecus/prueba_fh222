<?php
/**
 * Zend Framework (http://framework.zend.com/)
 *
 * @link      http://github.com/zendframework/ZendSkeletonApplication for the canonical source repository
 * @copyright Copyright(c) 2005-2013 Zend Technologies USA Inc. (http://www.zend.com)
 * @license   http://framework.zend.com/license/new-bsd New BSD License
 */

namespace Fitness\Controller;

use Zend\Mvc\Controller\AbstractActionController;
use Zend\View\Model\ViewModel;
use Zend\Db\ResultSet\ResultSet;
use Zend\Db\Adapter\Adapter;
use Zend\Db\Sql\Sql;

use Fitness\Form\Formularios;
use Fitness\Model\Entity\Procesa;
use Fitness\Model\Entity\Pedidos;

class FormularioController extends AbstractActionController
{
    public function indexAction()
    {
        //return new ViewModel();
        $view = new ViewModel();
        //$this->layout('layout/prueba');
        return $view;
    }
    public function registrapersonalAction()
    {
    	$this->dbAdapter=$this->getServiceLocator()->get('Zend\Db\Adapter');
    	//var_dump($this->dbAdapter);
        $data=array('45733853','Erik','Urrutia','Santamaria','Juan Vizcardo # 178 - PJ Muro',
            '074273545','958903956','e_urrutia@outlook.com','A',1); //
        // var_dump($data);
        $result =	$this->dbAdapter->query('CALL pa_insertaPersonal (?,?,?,?,?,?,?,?,?,?,@a)',$data);
        $resulta =   $this->dbAdapter->query('SELECT @a as mensaje',Adapter::QUERY_MODE_EXECUTE);
    	// var_dump($resulta);
        $datos	=	$resulta->toArray();
    	return new ViewModel(array("datos"=>$datos));
    }
    public function tablaAction()
    {
    	$this->dbAdapter	=	$this->getServiceLocator()->get('Zend\Db\Adapter');
    	$Ped		=	new Pedidos($this->dbAdapter);
    	$valores	=	array(
    		"titulo"	=>	"mostrando datos desde TableGateway",
    		"datos"		=>	$Ped->listaPedidos()
    		);
    	return new ViewModel($valores);
    }
    public function verAction()
    {
    	$id = (string) $this->params()->fromRoute("id",0);
    	$this->dbAdapter	=	$this->getServiceLocator()->get('Zend\Db\Adapter');
    	$Ped		=	new Pedidos($this->dbAdapter);
    	$valores	=	array(
    		"titulo"	=>	"Datos recibido en detalle",
    		"datos"		=>	$Ped->leePersonal($id)
    		);
    	return new ViewModel($valores);
    }
    public function formularioAction()
    {
    	$form 	=	new Formularios('form');
    	$pag	=	$this->getRequest()->getBaseUrl();

    	$form->get("lenguaje")->setValueOptions(array('0'=>'Inglés','1'=>'Español'));
        //$form->get("genero")->setValueOptions(array('f'=>'Femenino','m'=>'Masculino','n'=>'no definido'));
        $form->get("oculto")->setAttribute("value","87");
        $form->get("preferencias")->setValueOptions(array('m'=>'Música','d'=>'Deporte','o'=>'Ocio'));
    	return new ViewModel(array(
    			"titulo"	=>	"holaaaa sdffdsfmi formulario en ZF2",
    			"form"		=>	$form,
    			"url"		=>	$pag
    		));
    }
    public function recibeAction()
    {
    	//recibe datos del formulario
    	$data	= $this->request->getPost();
    	//procesamos datos ya sea operaciones o en BD
    	$procesa	=	new Procesa($data);
    	//obtenemos valores obtenidos del proceso
    	$datos	=	$procesa->getData();
    	//mandamos valores obtenidos del proces
    	return new ViewModel(array('datos'=>$datos));
    }
}