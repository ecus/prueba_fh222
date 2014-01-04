<?php

namespace Fitness\Form;

use Zend\Captcha;//principal
use Zend\Form\Element; //principal**
use Zend\Form\Form;//principal**
use Zend\Form\Factory;//principal

use Zend\InputFilter\Input;
use Zend\InputFilter\InputFilter;
use Zend\Form\Fieldset;

class FrmEmpresa extends Form
{
	public function __construct($name = null)
	{
		parent::__construct($name);

		$this->add(array(
				'name'		=>	'txtNombre',
				'options'	=>	array(
							'label'	=>	'Nombre: ',
                            'label_attributes'  => array(
                                    'class'     =>  'control-label inline',
                                    'for'       =>  'txtNombre'
						              ),
                            ),
				'attributes'=>	array(
							'type'          =>	'text',
							'placeholder'   =>	'Ejm.: Banco',
                            'class'         => 'form-control',
                            'id'            =>  "txtNombre",
                            "required"      =>  true
						),
			));

        $this->add(array(
				'name'		=>	'btnRegEmpresa',
				'attributes'=>	array(
							'type'	=>	'button',
							'value'	=>	'Registrar',
							'title'	=>	'Registar Empresa',
                            'id'    =>  'btnRegEmpresa',
							'class'	=>	'btn btn-gym btn-block',
							'buttonType'    => 'primary',
							'data-toogle'	=>	'button',
						),
			));
        $this->add(array(
                'name'      =>  'cancelar',
                'attributes'=>  array(
                            'type'  =>  'reset',
                            'value' =>  'Cancelar',
                            'title' =>  'Poner campos del formulario en blanco',
                            'class' =>  'btn btn-large btn-inverse',
                            'data-toogle'   =>  'button',
                        ),
            ));
	}
}

?>