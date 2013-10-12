<?php

namespace Fitness\Form;

use Zend\Captcha;//principal
use Zend\Form\Element; //principal**
use Zend\Form\Form;//principal**
use Zend\Form\Factory;//principal

use Zend\InputFilter\Input;
use Zend\InputFilter\InputFilter;
use Zend\Form\Fieldset;

class FrmCuenta extends Form
{
	public function __construct($name = null)
	{
		parent::__construct($name);

		$this->add(array(
                'name'      =>  'txtBanco',
                'options'   =>  array(
                            'label' =>  'Direccion: ',
                            'label_attributes'  => array(
                                    'class'     =>  'control-label inline',
                                    'for'       =>  'txtBanco'
                                      )
                        ),
                'attributes'=>  array(
                            'type'           => 'text',
                            'placeholder'    => 'Ej.: BCP',
                            'class'          => 'input-medium',
                            'id'            =>  "txtBanco"
                        ),
            ));

        
        $select = new Element\Select('cmbTipo');
        $select->setLabel('Tipo de Cuenta: ');
        $select->setLabelAttributes(
                    array(
                        'class'     =>  'control-label',
                        'for'       =>  'cmbTipo_Cta'
                        ) );
        $select->setAttributes(
                array(
                    'class'          => 'input-large'
                    ));
        $select->setEmptyOption('Seleccione...');
        $select->setValueOptions(array(
                '0' => 'Visa',
                '1' => 'MasterCard',
                '2' => 'DinnersClub'
            ));
        $this->add($select);


        $select = new Element\Select('cmbMoneda');
        $select->setLabel('Tipo de Moneda: ');
        $select->setLabelAttributes(
                    array(
                        'class'     =>  'control-label',
                        'for'       =>  'cmbTipo_Moneda'
                        ) );
        $select->setAttributes(
                array(
                    'class'          => 'input-large'
                    ));
        $select->setEmptyOption('Seleccione...');
        $select->setValueOptions(array(
                '0' => 'Soles',
                '1' => 'Dolares',
                '2' => 'Euros'
            ));
        $this->add($select);

        $this->add(array(
				'name'		=>	'btnRegCuenta',
				'attributes'=>	array(
							'type'	=>	'button',
							'value'	=>	'Registrar',
							'title'	=>	'Registar Cuenta',
                            'id'    =>  'btnRegCuenta',
							'class'	=>	'btn btn-gym btn-large btn-block',
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