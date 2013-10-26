<?php

namespace Fitness\Form;

use Zend\Captcha;//principal
use Zend\Form\Element; //principal**
use Zend\Form\Form;//principal**
use Zend\Form\Factory;//principal

use Zend\InputFilter\Input;
use Zend\InputFilter\InputFilter;
use Zend\Form\Fieldset;

class FrmAsistencia extends Form
{
	public function __construct($name = null)
	{
		parent::__construct($name);
//---------------------------------------------------

		
        $this->add(array(
                        'type'         => 'Zend\Form\Element\Date',
                        'name'         => 'dtpFechaReg',
                        'options'      => array(
                            'label' => 'Fecha de Registro de la Asistencia: ',
                            'format' => 'Y-m-d',
                            'label_attributes'  => array(
                                    'class'     =>  'control-label ',
                                    'for'       =>  'dtpFechaReg'
                                      )
                          ),
                    'attributes' => array(
                      'id'             => 'dtpFechaReg',
                     'class'        => 'form-control',
                     'min'          => '1950-01-01',
                     'max'          => '2060-01-01',
                     'step'         => '1',
                     'value'        =>date('Y-m-d'),
                     'placeholder'  =>'Año-Mes-Dia' // days; default step interval is 1 day
                        )
         ));
        $this->add(array(
                        'type'         => 'Zend\Form\Element\Date',
                        'name'         => 'dtpFechaIng',
                        'options'      => array(
                            'label' => 'Fecha de Ingreso de la Asistencia: ',
                            'format' => 'Y-m-d',
                            'label_attributes'  => array(
                                    'class'     =>  'control-label ',
                                    'for'       =>  'dtpFechaIng'
                                    //date'=>'Y:n:j:g:i:s'
                                      )
                          ),
                    'attributes' => array(
                      'id'             => 'dtpFechaIng',
                     'class'        => 'form-control',
                     'min'          => '1950-01-01',
                     'max'          => '2060-01-01',
                     'step'         => '1',
                     'placeholder'  =>'Año-Mes-Dia' // days; default step interval is 1 day
                        )
         ));

        $this->add(array(
				'name'		=>	'btnRegAsistencia',
				'attributes'=>	array(
							'type'	=>	'button',
							'value'	=>	'Registrar',
							'title'	=>	'Registar Asistencia',
              'id'    =>  'btnRegAsistencia',
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