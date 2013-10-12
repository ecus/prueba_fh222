<?php

namespace Fitness\Form;

use Zend\Captcha;//principal
use Zend\Form\Element; //principal**
use Zend\Form\Form;//principal**
use Zend\Form\Factory;//principal

use Zend\InputFilter\Input;
use Zend\InputFilter\InputFilter;
use Zend\Form\Fieldset;

class FrmSucursal extends Form
{
	public function __construct($name = null)
	{
		parent::__construct($name);

		$this->add(array(
				'name'		=>	'txtDisplay',
				'options'	=>	array(
							'label'	=>	'Nombre: ',
                            'label_attributes'  => array(
                                    'class'     =>  'control-label inline',
                                    'for'       =>  'txtDisplay'
						              ),
                            ),
				'attributes'=>	array(
							'type'          =>	'text',
							'placeholder'   =>	'Ejm.: Villareal',
                            'class'         => 'form-control soloTexto',
                            'id'            =>  "txtDisplay",
                            "required"      =>  true
						),
			));

        $this->add(array(
                'name'      =>  'txtUbicacion',
                'options'   =>  array(
                            'label' =>  'Direccion: ',
                            'label_attributes'  => array(
                                    'class'     =>  'control-label inline',
                                    'for'       =>  'txtUbicacion'
                                      )
                        ),
                'attributes'=>  array(
                            'type'           => 'text',
                            'placeholder'    => 'Ejm.: La Libertad 855 - Villareal',
                            'class'          => 'form-control direccion',
                            'id'            =>  "txtUbicacion"
                        ),
            ));

        $this->add(array(
                'name'      =>  'txtTelefono',
                'options'   =>  array(
                            'label' =>  'Telefono: ',
                            'label_attributes'  => array(
                                    'class'     =>  'control-label inline',
                                    'for'       =>  'txtTelefono'
                                      )
                        ),
                'attributes'=>  array(
                            'type'           => 'text',
                            'placeholder'    => 'Ejm.: 223344',
                            'class'          => 'form-control numerico',
                            'id'            =>  "txtTelefono"
                        ),
            ));

        $select = new Element\Select('cmbLinea');
        $select->setLabel('Linea: ');
        $select->setLabelAttributes(
                    array(
                        'class'     =>  'control-label',
                        'for'       =>  'cmbSucursal'
                        ) );
        $select->setAttributes(
                array(
                        'id'        =>  'cmbLinea',
                    'class'          => 'form-control'
                    ));
        $select->setEmptyOption('Seleccione...');
        $select->setValueOptions(array(
                0 => 'Fitness House',
                1 => 'Go Fit!'
            ));
        $this->add($select);

        $select = new Element\Select('cmbEstado');
        $select->setLabel('Estado: ');
        $select->setLabelAttributes(
                    array(
                        'class'     =>  'control-label',
                        'for'       =>  'cmbSucursal'
                        ) );
        $select->setAttributes(
                array(
                        'id'        =>  'cmbLinea',
                    'class'          => 'form-control'
                    ));
        $select->setEmptyOption('Seleccione...');
        $select->setValueOptions(array(
                0 => 'Inactivo',
                1 => 'Activo'
            ));
        $this->add($select);

        $this->add(array(
				'name'		=>	'btnRegSucursal',
				'attributes'=>	array(
							'type'	=>	'button',
							'value'	=>	'Registrar',
							'title'	=>	'Registar Sucursal',
                            'id'    =>  'btnRegSucursal',
							'class'	=>	'btn btn-gym btn-lg btn-block',
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