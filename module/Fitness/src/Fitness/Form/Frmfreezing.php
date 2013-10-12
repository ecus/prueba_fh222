<?php
namespace Fitness\Form;

use Zend\Captcha;//principal
use Zend\Form\Element; //principal**
use Zend\Form\Form;//principal**
use Zend\Form\Factory;//principal

use Zend\InputFilter\Input;
use Zend\InputFilter\InputFilter;
use Zend\Form\Fieldset;

class FrmFreezing extends Form
{
	public function __construct($name = null)
	{
		parent::__construct($name);
                     
          $this->add(array(
                'name'      =>  'txtDni',
                'options'   =>  array(
                            'label' =>  'DNI: ',
                            'label_attributes'  => array(
                                    'class'     =>  'control-label',
                                    'for'       =>  'txtDni'
                                      )
                            ),
                'attributes'=>  array(
                            'id'             => 'txtDni',
                            'type'           => 'text',
                            'placeholder'    => 'Ejm.: 42153562',
                            'class'          => 'form-control numerico',
                            'required'       =>'true',
                            'maxlength' =>'8',
                            'minlength' =>'8'
                        ),
            ));

    $this->add(array(
                'name'      =>  'txtCliente',
                'options'   =>  array(
                            'label' =>  'Datos del Cliente: ',
                            'label_attributes'  => array(
                                    'class'     =>  'control-label',
                                    'for'       =>  'txtCliente'
                                      ),
                            ),
                'attributes'=>  array(
                            'id'             => 'txtCliente',
                            'type'           => 'text',
                            'placeholder'    => '',
                            'class'          => 'form-control',
                            'required'       =>'true',
                            'enable'         =>'true',
                            'readonly'       =>  'true'
                        ),
            ));  
        $this->add(array(
             'type'         => 'Zend\Form\Element\Date',
             'name'         => 'dtpFechaInsc',
             'options'      => array(
                            'label' => 'Fecha de  la Inscripcion: ',
                            'format' => 'Y-m-d',
                            'label_attributes'  => array(
                                    'class'     =>  'control-label ',
                                    'for'       =>  'dtpFechaInsc'
                                      )
                        ),
             'attributes' => array(
                      'id'             => 'dtpFechaInsc',
                     'class'        => 'form-control',
                     'min'          => '1950-01-01',
                     'max'          => '2060-01-01',
                     'step'         => '1',
                     'placeholder'  =>'Año-Mes-Dia',
                     'readonly'       =>  'true' // days; default step interval is 1 day
                        )
         ));
         $this->add(array(
                'name'      =>  'txtDias',
                'options'   =>  array(
                            'label' =>  'Cantidad de Dias Free: ',
                            'label_attributes'  => array(
                                    'class'     =>  'control-label',
                                    'for'       =>  'txtDias'
                                      )
                            ),
                'attributes'=>  array(
                            'id'             => 'txtDias',
                            'type'           => 'number',
                            'placeholder'    => '',
                            'class'          => 'form-control numerico',
                            'required'       =>'true',
                            'maxlength'      =>'1',
                            'minlength'      =>'1'
                        ),
            ));

        $this->add(array(
             'type'         => 'Zend\Form\Element\Date',
             'name'         => 'dtpFechaReg',
             'options'      => array(
                            'label' => 'Fecha de Registro del Freezing : ',
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
                     'placeholder'  =>'Año-Mes-Dia' // days; default step interval is 1 day
                        )
         ));
           $this->add(array(
                'name'      =>  'txtDetalle',
                'options'   =>  array(
                            'label' =>  'Comentario: ',
                            'label_attributes'  => array(
                                    'class'     =>  'control-label',
                                    'for'       =>  'txtDetalle'
                                      ),
                            ),
                'attributes'=>  array(
                           'id'             => 'txtDetalle',
                            'type'           => 'text',
                            'placeholder'    => '',
                            'class'          => 'form-control',
                            'required'       =>'true'
                            //'enable'         =>'true'
                        ),
            ));
           $this->add(array(
                  'name'    =>  'txtIdPer',
                  'options' =>  array(
                        'label' =>  ' ',
                                      'label_attributes'  => array(
                                              'class'     =>  'control-label',
                                              'for'       =>  'txtIdPer'
                                                ),
                                      ),
                  'attributes'=>  array(
                        'id'             => 'txtIdPer',
                        'type'           => 'hidden',
                        'placeholder'    => '',
                        'class'          => 'form-control',
                        'required'       =>'true',
                        'value'          =>'1'
                      ),
             ));
              $this->add(array(
                'name'      =>  'txtIdCli',
                'options'   =>  array(
                            'label' =>  '',
                            'label_attributes'  => array(
                                    'class'     =>  'control-label',
                                    'for'       =>  'txtIdCli'
                                      ),
                            ),
                'attributes'=>  array(
                             'id'             => 'txtIdCli',
                            'type'           => 'hidden',
                            'placeholder'    => '',
                            'class'          => 'form-control',
                            'required'       =>'true'
                        ),
            ));
              $this->add(array(
                'name'      =>  'txtIdInsc',
                'options'   =>  array(
                            'label' =>  ' ',
                            'label_attributes'  => array(
                                    'class'     =>  'control-label',
                                    'for'       =>  'txtIdInsc'
                                      ),
                            ),
                'attributes'=>  array(
                            'id'             => 'txtIdInsc',
                            'type'           => 'hidden',
                            'placeholder'    => '',
                            'class'          => 'form-control',
                            'required'       =>'true'
                        ),
            ));
         
        $this->add(array(
        'name'    =>  'btnConsultar',
        'attributes'=>  array(
              'type'  =>  'button',
              'id'    =>  'btnConsultar',
              'value' =>  'Consultar',
              'title' =>  'Consultar Cliente',
              'class' =>  'btn',
              'buttonType'    => 'primary',
              'data-toogle' =>  'button',
            ),
           ));  
        //Botones Enviar - Cancelar
	     	$this->add(array(
				'name'		=>	'send',
				'attributes'=>	array(
							'type'	=>	'button',
              'id'    =>  'btnRegFreezing',
							'value'	=>	'Registrar',
							'title'	=>	'Registrar Freezing',
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
