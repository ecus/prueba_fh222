<?php

namespace Fitness\Form;

use Zend\Captcha;//principal
use Zend\Form\Element; //principal**
use Zend\Form\Form;//principal**
use Zend\Form\Factory;//principal

use Zend\InputFilter\Input;
use Zend\InputFilter\InputFilter;
use Zend\Form\Fieldset;

class RegSucursal extends Form
{
	public function __construct($name = null)
	{
		parent::__construct($name);

		$this->add(array(
				'name'		=>	'display',
				'options'	=>	array(
							'label'	=>	'Display: ',
						),
				'attributes'=>	array(
							'type'           =>	'text',
							'placeholder'    =>	'Este nombre aparecerá',
                            'class'          => 'input-large'
						),
			));

        $this->add(array(
                'name'      =>  'ubicacion',
                'options'   =>  array(
                            'label' =>  'Direccion: ',
                        ),
                'attributes'=>  array(
                            'type'           => 'text',
                            'placeholder'    => 'Ingrese Direccion',
                            'class'          => 'input-medium'
                        ),
            ));

        $this->add(array(
                'name'      =>  'telefono',
                'options'   =>  array(
                            'label' =>  'Telefono: ',
                        ),
                'attributes'=>  array(
                            'type'           => 'text',
                            'placeholder'    => '223344',
                            'class'          => 'input-medium'
                        ),
            ));

		$this->add(array(
				'name'		=>	'send',
				'attributes'=>	array(
							'type'	=>	'submit',
							'value'	=>	'Enviar',
							'title'	=>	'Enviar title',
							'class'	=>	'btn btn-primary btn-large btn-block',
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