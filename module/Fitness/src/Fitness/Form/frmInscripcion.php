<?php

namespace Fitness\Form;

use Zend\Captcha;//principal
use Zend\Form\Element; //principal**
use Zend\Form\Form;//principal**
use Zend\Form\Factory;//principal

use Zend\InputFilter\Input;
use Zend\InputFilter\InputFilter;
use Zend\Form\Fieldset;

class frmInscripcion extends Form
{
	public function __construct($name = null)
	{
		parent::__construct($name);

        $this->add(array(
                'name'      =>  'txtPersonal',
                'options'   =>  array(
                            'label' =>  'ID Personal: ',
                            'label_attributes'  => array(
                                    'class'     =>  'control-label',
                                    'for'       =>  'txtPersonal'
                                      ),
                            ),
                'attributes'=>  array(
                            'type'           => 'text',
                            'placeholder'    => 'Ejm.: 250.00',
                            'class'          => 'form-control',
                            'id'             => 'txtPersonal'
                        ),
            ));

        $this->add(array(
             'type'         => 'Zend\Form\Element\Date',
             'name'         => 'dtpFechaIni',
             'options'      => array(
                            'label' => 'Fecha de Inicio: ',
                            'format' => 'Y-m-d',
                            'label_attributes'  => array(
                                    'class'     =>  'control-label ',
                                    'for'       =>  'dtpFechaIni'
                                      )
                        ),
             'attributes' => array(
                     'class'        => 'form-control',
                     'min'          => '1950-01-01',
                     'max'          => '2060-01-01',
                     'step'         => '1',
                     'id'           => 'dtpFechaIni',
                     'placeholder'  =>'Año-Mes-Dia' // days; default step interval is 1 day
                        )
         ));
        $this->add(array(
             'type'         => 'Zend\Form\Element\Date',
             'name'         => 'dtpFechaFin',
             'options'      => array(
                            'label' => 'Fecha Fin: ',
                            'format' => 'Y-m-d',
                            'label_attributes'  => array(
                                    'class'     =>  'control-label ',
                                    'for'       =>  'dtpFechaFin'
                                      )
                        ),
             'attributes' => array(
                     'class'        => 'form-control',
                     'min'          => '1950-01-01',
                     'max'          => '2060-01-01',
                     'step'         => '1',
                     'id'           => 'dtpFechaFin',
                     'placeholder'  =>'Año-Mes-Dia' // days; default step interval is 1 day
                        )
         ));

        $select = new Element\Select('cmbEstado');
        $select->setLabel('Estado de Inscripcion: ');
        $select->setLabelAttributes(
                    array(
                        'class'     =>  'control-label',
                        'for'       =>  'cmbEstado'
                        ) );
        $select->setAttributes(
                array(
                    'class'          => 'form-control',
                    'id'        => 'cmbEstado'
                    ));
        $select->setEmptyOption('Seleccione...');
        $select->setValueOptions(array(
            0=>'Inactivo',
            1=>'Activo',
            2=>'Suspendido'));
        $this->add($select);

        $select = new Element\Select('cmbTipo');
        $select->setLabel('Tipo de Inscripcion: ');
        $select->setLabelAttributes(
                    array(
                        'class'     =>  'control-label',
                        'for'       =>  'cmbTipo'
                        ) );
        $select->setAttributes(
                array(
                    'class'          => 'form-control',
                    'id'        => 'cmbTipo'
                    ));
        $select->setEmptyOption('Seleccione...');
        $select->setValueOptions(array(
            0=>'Regular',
            1=>'Invitado'));
        $this->add($select);


        $select = new Element\Select('cmbServicio');
        $select->setLabel('Servicio: ');
        $select->setLabelAttributes(
                    array(
                        'class'     =>  'control-label',
                        'for'       =>  'cmbServicio'
                        ) );
        $select->setAttributes(
                array(
                    'class'          => 'form-control',
                    'id'        => 'cmbServicio'
                    ));
        $select->setEmptyOption('Seleccione...');
        $this->add($select);

        $this->add(array(
				'name'		=>	'btnRegInscripcion',
				'attributes'=>	array(
							'type'	=>	'button',
							'value'	=>	'Registrar',
              'id'    =>  'btnRegInscripcion',
							'title'	=>	'Registar Inscripcion',
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