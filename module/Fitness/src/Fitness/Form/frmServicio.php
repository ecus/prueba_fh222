<?php
namespace Fitness\Form;

use Zend\Captcha;//principal
use Zend\Form\Element; //principal**
use Zend\Form\Form;//principal**
use Zend\Form\Factory;//principal

use Zend\InputFilter\Input;
use Zend\InputFilter\InputFilter;
use Zend\Form\Fieldset;

class frmServicio extends Form
{
	public function __construct($name = null)
	{
		parent::__construct($name);
        $this->add(array(
                'name'      =>  'txtNombre',
                'options'   =>  array(
                            'label' =>  'Nombre de Servicio: ',
                            'label_attributes'  => array(
                                    'class'     =>  'control-label',
                                    'for'       =>  'txtNombre',
                                      )
                            ),
                'attributes'=>  array(
                            'id'             => 'txtNombre',
                            'type'           => 'text',
                            'placeholder'    => 'Ejm.: Musculacion',
                            'class'          => 'soloTextoNombre form-control',
                            'required'       =>'true'
                        ),
            ));

		$this->add(array(
				'name'		=>	'txtMonto',
				'options'	=>	array(
							'label'	=>	'Monto Base: ',
                            'label_attributes'  => array(
                                    'class'     =>  'control-label',
                                    'for'       =>  'txtMonto'
                                      ),
                            ),
				'attributes'=>	array(
							'type'           =>	'text',
							'placeholder'    =>	'Ejm.: 200.00',
                            'maxlength'      => 4,
                            'class'          => 'moneda form-control',
                            'required'       =>'true',
                            'id'             => 'txtMonto'
						),
			));

        $this->add(array(
                'name'      =>  'txtTipo',
                'attributes'=>  array(
                            'type'           => 'hidden',
                            'value'          => '0',
                            'id'             => 'txtTipo',
                            'class'          => ' ',
                            'required'       =>'true',
                            'value'          => 0
                        ),
            ));

        $this->add(array(
                'name'      =>  'txtdiasCupon',
                'options'   =>  array(
                            'label' =>  'Dias para invitación: ',
                            'label_attributes'  => array(
                                    'class'     =>  'control-label',
                                    'for'       =>  'txtdiasCupon'
                                      ),
                            ),
                'attributes'=>  array(
                            'type'           => 'number',
                            'placeholder'    => 'Ejm.: 3',
                            'maxlength'      => 3,
                            'class'          => 'form-control numerico',
                            'id'        => 'txtdiasCupon'
                        ),
            ));

        $this->add(array(
                'name'      =>  'txtfreezing',
                'options'   =>  array(
                            'label' =>  'Freezing: ',
                            'label_attributes'  => array(
                                    'class'     =>  'control-label',
                                    'for'       =>  'txtfreezing'
                                      ),
                            ),
                'attributes'=>  array(
                            'type'           => 'number',
                            'placeholder'    => 'Ejm.: 15',
                            'class'          => 'form-control numerico',
                            'maxlength'      => 3,
                            'id'        => 'txtfreezing'
                        ),
            ));

        $this->add(array(
                'name'      =>  'txtMontoIni',
                'options'   =>  array(
                            'label' =>  'Monto Inicial: ',
                            'label_attributes'  => array(
                                    'class'     =>  'control-label',
                                    'for'       =>  'txtMontoIni'
                                      ),
                            ),
                'attributes'=>  array(
                            'type'           => 'text',
                            'placeholder'    => 'Ejm.: 250.00',
                            'class'          => 'form-control moneda',
                            'maxlength'      => 4,
                            'id'             => 'txtMontoIni'
                        ),
            ));

        $this->add(array(
             'type'         => 'Zend\Form\Element\Date',
             'name'         => 'dtpFecha',
             'options'      => array(
                            'label' => 'Fecha de Registro: ',
                            'format' => 'Y-m-d',
                            'label_attributes'  => array(
                                    'class'     =>  'control-label ',
                                    'for'       =>  'dtpFecha'
                                      )
                        ),
             'attributes' => array(
                     'class'        => 'form-control',
                     // 'min'          => date('mm/dd/aaaa'),
                     // 'max'          => date('mm/dd/aaaa'),
                     // 'maxlength'      => 3,
                     'value'        => date('Y-m-d'),
                     'step'         => '1',//avanza por dias en esta caso de uno en uno
                     'placeholder'  =>'Año-Mes-Dia', // days; default step interval is 1 day
                     'id'           => 'dtpFecha'
                        )
         ));

        $this->add(array(
                'name'      =>  'txtPromocion',
                'attributes'=>  array(
                            'type'           => 'hidden',
                            'class'          => '',
                            'id'        => 'txtPromocion',
                            'value'        => 0
                        ),
            ));
        $select = new Element\Select('cmbEmpresa');
        $select->setLabel('Empresa: ');
        $select->setLabelAttributes(
                    array(
                        'class'     =>  'control-label',
                        'for'       =>  'cmbEmpresa'
                        ) );
        $select->setAttributes(
                array(
                        'id'        =>  'cmbEmpresa',
                    'class'          => 'form-control',
                    'id'        => 'cmbEmpresa'
                    ));
        $select->setEmptyOption('Seleccione...');
        $select->setValueOptions(array(
            0=>'dsalj'));
        $this->add($select);

        $this->add(array(
                'name'      =>  'txtEstado',
                'attributes'=>  array(
                            'type'           => 'hidden',
                            'class'          => '',
                            'id'        => 'txtEstado'
                        ),
            ));

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

        $select = new Element\Select('lstSucursal');
        $select->setLabel('Sucursales que contaran con este Servicio: ');
        $select->setLabelAttributes(
                    array(
                        'class'     =>  'control-label',
                        'for'       =>  'lstSucursal'
                        ) );
        $select->setAttribute('multiple', true);
        $select->setAttributes(
                array(
                    'class'          => 'form-control',
                    'id'        => 'lstSucursal',
                    'required'  => true,
                    ));
    //$select->setEmptyOption('Seleccione...');
        $this->add($select);

        $select = new Element\Select('cmbEncargado');
        $select->setLabel('Personal Encargado: ');
        $select->setLabelAttributes(
                    array(
                        'class'     =>  'control-label',
                        'for'       =>  'cmbEncargado'
                        ) );
        $select->setAttributes(
                array(
                    'class'          => 'form-control',
                    'id'        => 'cmbEncargado'
                    ));
        $select->setEmptyOption('Seleccione...');
        $this->add($select);

        $select = new Element\Select('cmbSucursal');
        $select->setLabel('Sucursal: ');
        $select->setLabelAttributes(
                    array(
                        'class'     =>  'control-label',
                        'for'       =>  'cmbSucursal'
                        ) );
        $select->setAttributes(
                array(
                    'class'          => 'form-control',
                    'id'        => 'cmbSucursal'
                    ));
        $select->setEmptyOption('Seleccione...');
        $select->setValueOptions(array(
            0=>'dsalj'));
        $this->add($select);

        $dia = new Element\MultiCheckbox('lstDias');
        $dia->setLabel('Programación');
        $this->add($dia);

        // $this->add(array(
        //         'name'      =>  'txthoraIn',
        //         'options'   =>  array(
        //                     'label' =>  'Hora Inicio: ',
        //                     'label_attributes'  => array(
        //                             'class'     =>  'control-label',
        //                             'for'       =>  'txthoraIn'
        //                               ),
        //                     ),
        //         'attributes'=>  array(
        //                     'type'           => 'text',
        //                     'placeholder'    => 'Ejm.: 250.00',
        //                     'class'          => '',
        //                     'id'             => 'txthoraIn'
        //                 ),
        //     ));
        // $this->add(array(
        //         'name'      =>  'txthoraFin',
        //         'options'   =>  array(
        //                     'label' =>  'Hora Fin: ',
        //                     'label_attributes'  => array(
        //                             'class'     =>  'control-label',
        //                             'for'       =>  'txthoraFin'
        //                               ),
        //                     ),
        //         'attributes'=>  array(
        //                     'type'           => 'text',
        //                     'placeholder'    => 'Ejm.: 250.00',
        //                     'class'          => '',
        //                     'id'             => 'txthoraFin'
        //                 ),
        //     ));
        //Botones Enviar - Cancelar
		$this->add(array(
				'name'		=>	'btnRegServicio',
				'attributes'=>	array(
							'type'	=>	'button',
                            'id'    =>  'btnRegServicio',
							'value'	=>	'Registrar',
							'title'	=>	'Registrar Servicio',
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
