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

class TrabajoController extends AbstractActionController
{
    public function indexAction()
    {
        return new ViewModel();
    }
    public function otroAction()
    {
    	return new ViewModel();
    }
    public function recibeparametrosAction()
    {
        $saludo="mensaje a mostrar en vistav en parametro";
        $arrayName = array('Pedro','Pablo','Erik','Claudia' );
        return new ViewModel(array('saludo' => $saludo,'otro'=> 'otro mensaje','nombres'=> $arrayName ));
    }
    public function valoresurlAction()
    {
        $id = (int) $this->params()->fromRoute("id",null);
        $url = $this->getRequest()->getBaseUrl();
        $titulo = "titulo a mostrar : valores por url metodo GET";
        return new ViewModel( array('titulo'=>$titulo , 'id'=>$id , 'url'=> $url) );
    }
    public function redireccionarAction()
    {
        return $this->redirect()->toUrl($this->getRequest()->getBaseUrl().'/application/trabajo/index');
    }
    public function cargaotravistaAction()
    {
        return $this->forward()->dispatch('Application\Controller\Trabajo', array('action'=>'index')) ;
    }
    public function renderAction($value='')
    {
        $View = new ViewModel();
        return $View;
    }
}