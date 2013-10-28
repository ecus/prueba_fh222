<?php

namespace Fitness\Form;

use Zend\Captcha;//principal
use Zend\Form\Element; //principal**
use Zend\Form\Form;//principal**
use Zend\Form\Factory;//principal

use Zend\InputFilter\Input;
use Zend\InputFilter\InputFilter;
use Zend\Form\Fieldset;

class FrmLogin extends Form
{
	public function __construct($name = null)
	{
		parent::__construct($name);

		$this->add(array(
                'name'      =>  'txtUsuario',
                'options'   =>  array(
                            'label' =>  'Usuario: ',
                            'label_attributes'  => array(
                                    'class'     =>  'control-label col-2',
                                    'for'       =>  'txtUsuario'
                                      ),
                            ),
                'attributes'=>  array(
                            'type'           => 'text',
                            'placeholder'    => 'Ejm.: eurrutia',
                            'class'          => 'form-control',
                            'id'             => 'txtUsuario'
                        ),
            ));
		$this->add(array(
                'name'      =>  'txtClave',
                'options'   =>  array(
                            'label' =>  'Clave: ',
                            'label_attributes'  => array(
                                    'class'     =>  'control-label col-2',
                                    'for'       =>  'txtClave'
                                      ),
                            ),
                'attributes'=>  array(
                            'type'           => 'password',
                            'placeholder'    => '******',
                            'class'          => 'form-control',
                            'id'             => 'txtClave'
                        ),
            ));

        $this->add(array(
                'name'      =>  'btnIngreso',
                'attributes'=>  array(
                            'type'  =>  'submit',
                            'value' =>  'Ingresar',
                            'title' =>  'Ingresar al sistema.',
                            'class' =>  'btn btn-gym btn-block',
                            'data-toogle'   =>  'button',
                        ),
            ));
	}
}

?>