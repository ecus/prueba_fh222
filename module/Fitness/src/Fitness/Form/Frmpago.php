<?php
namespace Fitness\Form;

use Zend\Captcha;//principal
use Zend\Form\Element; //principal**
use Zend\Form\Form;//principal**
use Zend\Form\Factory;//principal

use Zend\InputFilter\Input;
use Zend\InputFilter\InputFilter;
use Zend\Form\Fieldset;

class FrmPago extends Form
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
                'name'      =>  'txtServicio',
                'options'   =>  array(
                            'label' =>  'Nombre del Servicio: ',
                            'label_attributes'  => array(
                                    'class'     =>  'control-label',
                                    'for'       =>  'txtServicio'
                                      )
                            ),
                'attributes'=>  array(
                            'id'             => 'txtServicio',
                            'type'           => 'text',
                            'placeholder'    => '',
                            'class'          => 'form-control',
                            'required'       =>'true',
                            'readonly'       =>  'true'
                        ),
            ));

              $this->add(array(
                'name'      =>  'txtPago',
                'options'   =>  array(
                            'label' =>  'Total a Pagar: ',
                            'label_attributes'  => array(
                                    'class'     =>  'control-label',
                                    'for'       =>  'txtPago'
                                      )
                            ),
                'attributes'=>  array(
                            'id'             => 'txtPago',
                            'type'           => 'text',
                            'placeholder'    => '',
                            'class'          => 'form-control',
                            'required'       =>'true',
                            'readonly'       =>  'true'
                        ),
            ));
              $this->add(array(
                        'type'         => 'Zend\Form\Element\Date',
                        'name'         => 'dtpFechaReg',
                        'options'      => array(
                            'label' => 'Fecha de Registro del Pago: ',
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
                     'value'        => date('Y-m-d'),
                     'placeholder'  =>'Año-Mes-Dia' // days; default step interval is 1 day
                        )
         ));
        $this->add(array(
             'type'         => 'Zend\Form\Element\Date',
             'name'         => 'dtpFechaPago',
             'options'      => array(
                            'label' => 'Fecha de Pago: ',
                            'format' => 'Y-m-d',
                            'label_attributes'  => array(
                                    'class'     =>  'control-label ',
                                    'for'       =>  'dtpFechaPago'
                                      )
                        ),
                     'attributes' => array(
                      'id'             => 'dtpFechaPago',
                     'class'        => 'form-control',
                     'min'          => '1950-01-01',
                     'max'          => '2060-01-01',
                     'step'         => '1',
                     'placeholder'  =>'Año-Mes-Dia' // days; default step interval is 1 day
                        )
         ));
      //--------------------------------------------------------------     
        $select = new Element\Select('cmbMoneda');
        $select->setLabel('Tipo de Moneda: ');
        $select->setLabelAttributes(
                    array(
                        'class'     =>  'control-label',
                        'for'       =>  'cmbMoneda'
                        ) );
        $select->setAttributes(
                array(
                    'class'          => 'form-control',
                    'id'             =>  'cmbMoneda'
                    ));
        $select->setEmptyOption('Seleccione...');
         $select->setValueOptions(array(
                1=> 'Soles',
                2 => 'Dolares',
                3 => 'Euros'
            ));
          $this->add($select);
         //--------------------------------------------------------------
        $select = new Element\Select('cmbPago');
        $select->setLabel('Forma de Pago: ');
        $select->setLabelAttributes(
                    array(
                        'class'     =>  'control-label',
                        'for'       =>  'cmbPago'
                        ) );
        $select->setAttributes(
                array(
                    'class'          => 'form-control',
                    'id'             =>  'cmbPago'
                    ));
        $select->setEmptyOption('Seleccione...');
         $select->setValueOptions(array(
                1=> 'Efectivo',
                2 => 'Tarjeta'
                //3 => 'Euros'
            ));
          $this->add($select);
         //--------------------------------------------------------------
        
        $select = new Element\Select('cmbConcepto');
        $select->setLabel('Concepto del Pago: ');
        $select->setLabelAttributes(
                    array(
                        'class'     =>  'control-label',
                        'for'       =>  'cmbConcepto'
                        ) );
        $select->setAttributes(
                array(
                    'class'          => 'form-control',
                    'id'             =>  'cmbConcepto'
                    ));
        $select->setEmptyOption('Seleccione...');
         $select->setValueOptions(array(
                1=> 'Pago por Periodo',
                2 => 'Pago por Deuda'
                //3 => 'Euros'
            ));
          $this->add($select);
         //--------------------------------------------------------------

        $select = new Element\Select('cmbEstado');
        $select->setLabel('Estado del Pago: ');
        $select->setLabelAttributes(
                    array(
                        'class'     =>  'control-label',
                        'for'       =>  'cmbEstado'
                        ) );
        $select->setAttributes(
                array(
                    'class'          => 'form-control',
                    'id'             =>  'cmbEstado'
                    ));
        $select->setEmptyOption('Seleccione...');
         $select->setValueOptions(array(
                0=> 'Anulado',
                1 => 'Activo'
                //3 => 'Euros'
            ));
          $this->add($select);
         //--------------------------------------------------------------
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
                'name'      =>  'txtIdSer',
                'options'   =>  array(
                            'label' =>  ' ',
                            'label_attributes'  => array(
                                    'class'     =>  'control-label',
                                    'for'       =>  'txtIdSer'
                                      ),
                            ),
                'attributes'=>  array(
                            'id'             => 'txtIdSer',
                            'type'           => 'hidden',
                            'placeholder'    => '',
                            'class'          => 'form-control',
                            'required'       =>'true'
                        ),
            ));
              $this->add(array(
                'name'      =>  'txtIdSuc',
                'options'   =>  array(
                            'label' =>  ' ',
                            'label_attributes'  => array(
                                    'class'     =>  'control-label',
                                    'for'       =>  'txtIdSuc'
                                      ),
                            ),
                'attributes'=>  array(
                            'id'             => 'txtIdSuc',
                            'type'           => 'hidden',
                            'placeholder'    => '',
                            'class'          => 'form-control',
                            'required'       =>'true',
                            'value'           =>'1'
                        ),
            ));
         $this->add(array(
                'name'      =>  'txtIdCta',
                'options'   =>  array(
                            'label' =>  ' ',
                            'label_attributes'  => array(
                                    'class'     =>  'control-label',
                                    'for'       =>  'txtIdCta'
                                      ),
                            ),
                'attributes'=>  array(
                            'id'             => 'txtIdCta',
                            'type'           => 'hidden',
                            'placeholder'    => '',
                            'class'          => 'form-control',
                            'required'       =>'true',
                            'value'          =>'1'
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
              'id'    =>  'btnRegPago',
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
