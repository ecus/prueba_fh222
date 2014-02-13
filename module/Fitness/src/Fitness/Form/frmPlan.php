<?php
namespace Fitness\Form;

use Zend\Captcha;//principal
use Zend\Form\Element; //principal**
use Zend\Form\Form;//principal**
use Zend\Form\Factory;//principal

use Zend\InputFilter\Input;
use Zend\InputFilter\InputFilter;
use Zend\Form\Fieldset;

class FrmPlan extends Form
{
	public function __construct($name = null)
	{
		parent::__construct($name);

/////// PLAN
    ///// txtNombre
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

    ///// txtCuotaMax
        $this->add(array(
                'name'      =>  'txtCuotaMax',
                'options'   =>  array(
                            'label' =>  'Max. de fraccionamiento: ',
                            'label_attributes'  => array(
                                    'class'     =>  'control-label',
                                    'for'       =>  'txtCuotaMax'
                                      ),
                            ),
                'attributes'=>  array(
                            'type'           => 'number',
                            'placeholder'    => 'Ejm.: 2',
                            'class'          => 'form-control',
                            'required'       =>'true',
                            'id'        => 'txtCuotaMax'
                        ),
            ));
    /// txtDuracion
        $this->add(array(
                'name'      =>  'txtDuracion',
                'options'   =>  array(
                            'label' =>  'Periodo: ',
                            'label_attributes'  => array(
                                    'class'     =>  'control-label',
                                    'for'       =>  'txtDuracion'
                                      ),
                            ),
                'attributes'=>  array(
                            'type'           => 'number',
                            'placeholder'    => 'Ejm.: 2',
                            'class'          => 'form-control',
                            'required'       =>'true',
                            'id'        => 'txtDuracion'
                        ),
            ));
    ///// txtMonto
        $this->add(array(
                'name'      =>  'txtMonto',
                'options'   =>  array(
                            'label' =>  'Precio Base: ',
                            'label_attributes'  => array(
                                    'class'     =>  'control-label',
                                    'for'       =>  'txtMonto'
                                      ),
                            ),
                'attributes'=>  array(
                            'type'           => 'text',
                            'placeholder'    => 'Ejm.: 200.00',
                            'maxlength'      => 4,
                            'class'          => 'moneda form-control',
                            'required'       =>'true',
                            'id'             => 'txtMonto'
                        ),
            ));
    /// txtTipo
        $this->add(array(
                'name'      =>  'txtTipo',
                'attributes'=>  array(
                            'type'           => 'hidden',
                            'value'          => '0',
                            'id'             => 'txtTipo',
                            'class'          => 'form-control',
                            'required'       =>'true',
                            'value'          => 1
                        ),
            ));

    /// txtTipoDuraion
        $this->add(array(
                'name'      =>  'txtTipoDuracion',
                'attributes'=>  array(
                            'type'           => 'hidden',
                            'value'          => '0',
                            'id'             => 'txtTipoDuracion',
                            'class'          => 'form-control',
                            'required'       =>'true',
                            'value'          => 3
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
                            'maxlength'      => 2,
                            'class'          => 'numerico form-control',
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
                            'class'          => 'numerico form-control',
                            'maxlength'      => 3,
                            'id'               => 'txtfreezing'
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
                            'class'          => 'moneda form-control',
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
                            'class'          => 'form-control',
                            'maxlength'      => 3,
                            'id'        => 'txtdiasCupon'
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
                    'class'          => ' form-control',
                    'id'        => 'lstSucursal',
                    'required'  => true,
                    ));
        $this->add($select);

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
                            'type'           => 'hidden',
                            'placeholder'    => 'Ejm.: 250.00',
                            'class'          => ' form-control',
                            'id'             => 'txtPersonal'
                        ),
            ));
        $select = new Element\Select('lstServicios');
        $select->setLabel('Servicios con que contara con este Plan: ');
        $select->setLabelAttributes(
                    array(
                        'class'     =>  'control-label',
                        'for'       =>  'lstServicios'
                        ));
        $select->setAttribute('multiple', true);
        $select->setAttributes(
                array(
                    'class'          => ' form-control',
                    'id'        => 'lstServicios',
                    'required'  => true,
                    ));
    //$select->setEmptyOption('Seleccione...');
        $this->add($select);


        $select = new Element\Select('cmbTipoPlan');
        $select->setLabel('Tipo Plan: ');
        $select->setLabelAttributes(
                    array(
                        'class'     =>  'control-label',
                        'for'       =>  'cmbTipoPlan'
                        ) );
        $select->setAttributes(
                array(
                    'class'          => 'form-control',
                    'id'        => 'cmbTipoPlan'
                    ));
        $select->setEmptyOption('Seleccione...');
        $select->setValueOptions(array(
            1=>'Regular',
            2=>'Nutricional',
            3=>'Musculacion'));
        $this->add($select);


        $this->add(array(
                'name'      =>  'txtPromocion',
                'attributes'=>  array(
                            'type'           => 'hidden',
                            'class'          => ' form-control',
                            'id'        => 'txtPromocion'
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
                    'class'          => 'form-control',
                    'id'        => 'cmbEmpresa'
                    ));
        $select->setEmptyOption('Seleccione...');
        $select->setValueOptions(array(
            0=>'dsalj'));
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
        $this->add($select);

        $select = new Element\Select('cmbPlanBase');
        $select->setLabel('Actualizar Plan: ');
        $select->setLabelAttributes(
                    array(
                        'class'     =>  'control-label',
                        'for'       =>  'cmbPlanBase'
                        ) );
        $select->setAttributes(
                array(
                    'class'          => 'form-control',
                    'id'        => 'cmbPlanBase'
                    ));
        $select->setEmptyOption('Seleccione...');
        $this->add($select);

        $plan = new Element\MultiCheckbox('lstDetallePlan');
        $plan->setLabel('Detalle de Servicio Incluidos');
        $this->add($plan);

        $this->add(array(
                'name'      =>  'txtvigencia',
                'options'   =>  array(
                            'label' =>  'Vigencia: ',
                            'label_attributes'  => array(
                                    'class'     =>  'control-label',
                                    'for'       =>  'txtvigencia'
                                      ),
                            ),
                'attributes'=>  array(
                            'type'           => 'text',
                            'placeholder'    => 'Ejm.: 250.00',
                            'class'          => 'form-control',
                            'id'             => 'txtvigencia'
                        ),
            ));

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

        $select = new Element\Select('cmbTipoPro');
        $select->setLabel('Promocion: ');
        $select->setLabelAttributes(
                    array(
                        'class'     =>  'control-label',
                        'for'       =>  'cmbTipoPro'
                        ) );
        $select->setAttributes(
                array(
                    'class'          => 'form-control',
                    'id'        => 'cmbTipoPro'
                    ));
        $select->setEmptyOption('Seleccione...');
        $select->setValueOptions(array(
                1 => "Precio",
                2 => "Empresa",
                3 => "Porcentual",
                4 => "Dias"
            ));
        $this->add($select);

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
                     // 'min'          => date('mm/dd/aaaa'),
                     // 'max'          => date('mm/dd/aaaa'),
                     'step'         => '1',//avanza por dias en esta caso de uno en uno
                     'placeholder'  =>'Año-Mes-Dia', // days; default step interval is 1 day
                     'id'           => 'dtpFechaIni'
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
                     // 'min'          => date('mm/dd/aaaa'),
                     // 'max'          => date('mm/dd/aaaa'),
                     'step'         => '1',//avanza por dias en esta caso de uno en uno
                     'placeholder'  =>'Año-Mes-Dia', // days; default step interval is 1 day
                     'id'           => 'dtpFechaFin'
                        )
         ));

         $this->add(array(
                'name'      =>  'txtMontoPro',
                'options'   =>  array(
                            'label' =>  'Monto Promocion: ',
                            'label_attributes'  => array(
                                    'class'     =>  'control-label',
                                    'for'       =>  'txtMontoPro'
                                      ),
                            ),
                'attributes'=>  array(
                            'type'           => 'text',
                            'placeholder'    => 'Ejm.: 250.00',
                            'class'          => 'form-control',
                            'id'             => 'txtMontoPro'
                        ),
            ));

         $this->add(array(
                'name'      =>  'txtdiasPro',
                'options'   =>  array(
                            'label' =>  'Dias Promocion: ',
                            'label_attributes'  => array(
                                    'class'     =>  'control-label',
                                    'for'       =>  'txtdiasPro'
                                      ),
                            ),
                'attributes'=>  array(
                            'type'           => 'number',
                            'placeholder'    => 'Ejm.: 3',
                            'class'          => 'form-control',
                            'required'       =>'true',
                            'id'        => 'txtdiasPro'
                        ),
            ));

         $this->add(array(
                'name'      =>  'txtPorcentaje',
                'options'   =>  array(
                            'label' =>  'Procentaje: ',
                            'label_attributes'  => array(
                                    'class'     =>  'control-label',
                                    'for'       =>  'txtPorcentaje',
                                    'id'        => 'txtPorcentaje'
                                      )
                            ),
                'attributes'=>  array(
                            'id'             => 'txtPorcentaje',
                            'type'           => 'text',
                            'placeholder'    => 'Ejm.: Musculacion',
                            'class'          => 'form-control ',
                            'required'       =>'true'
                        ),
            ));

         $this->add(array(
                'name'      =>  'txtEmpresaMin',
                'options'   =>  array(
                            'label' =>  'Convenio minimo de empresas: ',
                            'label_attributes'  => array(
                                    'class'     =>  'control-label',
                                    'for'       =>  'txtEmpresaMin'
                                      ),
                            ),
                'attributes'=>  array(
                            'type'           => 'number',
                            'placeholder'    => 'Ejm.: 15',
                            'class'          => 'form-control',
                            'required'       =>'true',
                            'id'        => 'txtEmpresaMin'
                        ),
            ));

         $this->add(array(
                'name'      =>  'txtEmpresaMax',
                'options'   =>  array(
                            'label' =>  'Convenio maximo de empresas: ',
                            'label_attributes'  => array(
                                    'class'     =>  'control-label',
                                    'for'       =>  'txtEmpresaMax'
                                      ),
                            ),
                'attributes'=>  array(
                            'type'           => 'number',
                            'placeholder'    => 'Ejm.: 15',
                            'class'          => 'form-control',
                            'required'       =>'true',
                            'id'        => 'txtEmpresaMax'
                        ),
            ));



        $creaUser = new Element\Checkbox('chkLimite');
        $creaUser->setLabel('Fin de mes como Plazo maximo de Pago.');
        $creaUser->setLabelAttributes(array(
                    'class'     =>  'control-label',
                    'for'       =>  'chkLimite'
                    ));
        // $creaUser->setChecked('true');
        $creaUser->setAttributes(array(
                    // 'class'   => 'form-control',
                    'id'      => 'chkLimite'
                    ));
        $this->add($creaUser);


        //Botones Enviar - Cancelar
		$this->add(array(
				'name'		=>	'btnRegPlan',
				'attributes'=>	array(
							'type'	=>	'button',
                            'id'    =>  'btnRegPlan',
							'value'	=>	'Registrar',
							'title'	=>	'Registrar Plan',
							'class'	=>	'btn btn-gym btn-large btn-block',
							'buttonType'    => 'primary',
							'data-toogle'	=>	'button',
						),
			));
        $this->add(array(
                'name'      =>  'btnCancelar',
                'attributes'=>  array(
                            'type'  =>  'reset',
                            'value' =>  'Nuevo',
                            'title' =>  'Poner campos del formulario en blanco',
                            'class' =>  'btn btn-large btn-default btn-block',
                            'data-toogle'   =>  'button',
                        ),
            ));
	}
}