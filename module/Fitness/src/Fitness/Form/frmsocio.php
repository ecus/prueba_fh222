<?php
namespace Fitness\Form;

use Zend\Captcha;//principal
use Zend\Form\Element; //principal**
use Zend\Form\Form;//principal**
use Zend\Form\Factory;//principal

use Zend\InputFilter\Input;
use Zend\InputFilter\InputFilter;
use Zend\Form\Fieldset;

class Frmsocio extends Form
{
	public function __construct($name = null)
	{
		parent::__construct($name);

//-----------------------txtDni----2-----------------------
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
                            'placeholder'    => '42153562',
                            'class'          => 'form-control numerico',
                            'maxlength'      => '8',
                            'minlength'      => '8',
                            'required'       =>'true'
                        ),
            ));
//-----------------------txtDireccion----2-----------------------
        $this->add(array(
                'name'      =>  'txtDireccion',
                'options'   =>  array(
                            'label' =>  'Direccion: ',
                            'label_attributes'  => array(
                                    'class'     =>  'control-label',
                                    'for'       =>  'txtDireccion'
                                      )
                            ),
                'attributes'=>  array(
                            'id'             => 'txtDireccion',
                            'type'           => 'text',
                            'placeholder'    => 'Calle/Av. Nombre Calle # 100',
                            'class'          => 'form-control direccion',
                            'maxlength'      => '50',
                            // 'minlength'      => '8',
                            'required'       =>'true'
                        ),
            ));
//-----------------cmbDocumento--3-------------------------
        $select = new Element\Select('cmbDocumento');
        $select->setLabel('Documento: ');
        $select->setLabelAttributes(
                    array(
                        'class'     =>  'control-label',
                        'for'       =>  'cmbDocumento'
                        ) );
        $select->setAttributes(
                array(
                    'class'          => 'form-control',
                    'id'             =>  'cmbDocumento'
                    ));
        $select->setEmptyOption('Seleccione...');
         $select->setValueOptions(array(
                1 => 'Dni',
                2 => 'Pasaporte',
                3 => 'Otro'
            ));
        $this->add($select);
//---------------------txtNombre------6--------------------
		$this->add(array(
				'name'		=>	'txtNombre',
				'options'	=>	array(
							'label'	=>	'Nombre: ',
                            'label_attributes'  => array(
                                    'class'     =>  'control-label',
                                    'for'       =>  'txtNombre'
                                      ),
                            ),
				'attributes'=>	array(
                            'id'            =>'txtNombre',
							'type'           =>	'text',
							'placeholder'    =>	'Nombres',
                             'class'         => 'form-control soloTexto',
                            'maxlength'      => '35',
                            'required'       => 'true'
						),
			));
//---------------txtApPaterno-4----------------------------
        $this->add(array(
                'name'      =>  'txtApPaterno',
                'options'   =>  array(
                            'label' =>  'Ap. Paterno: ',
                            'label_attributes'  => array(
                                    'class'     =>  'control-label',
                                    'for'       =>  'txtApPaterno'
                                      ),
                            ),
                'attributes'=>  array(
                            'id'            =>'txtApPaterno',
                            'type'          => 'text',
                            'placeholder'   => 'Apellido Paterno',
                            'class'         => 'form-control soloTexto ',
                            'maxlength'     =>'20',
                            'required'      =>'true'
                        ),
            ));
//----------------txtApMaterno-5---------------------------
        $this->add(array(
                'name'      =>  'txtApMaterno',
                'options'   =>  array(
                            'label' =>  'Ap. Materno: ',
                            'label_attributes'  => array(
                                    'class'     =>  'control-label',
                                    'for'       =>  'txtApMaterno'
                                      ),
                            ),
                'attributes'=>  array(
                            'id'            =>'txtApMaterno',
                            'type'          => 'text',
                            'placeholder'   => 'Apellido Materno',
                            'class'         => 'form-control soloTexto',
                            'maxlength'     =>'20',
                            'required'      =>'true'
                        ),
            ));
//---------------dtpFechanac--8----------------------------
        $this->add(array(
             'type'         => 'Zend\Form\Element\Date',
             'name'         => 'dtpFechanac',
             'options'      => array(
                            'label' => 'Fecha de Nacimiento: ',
                            'format' => 'Y-m-d',
                            'label_attributes'  => array(
                                    'class'     =>  'control-label',
                                    'for'       =>  'dtpFechanac'
                                      )
                        ),
             'attributes' => array(
                        'id' =>      'dtpFechanac',
                        'size' =>'20',
                     'class'        => 'form-control',
                     'min'          => '1950-01-01',
                     'max'          => '2060-01-01',
                     'step'         => '1',
                     'placeholder'  =>'Año-Mes-Dia', // days; default step interval is 1 day
                     'required'     =>'true'
                        )
         ));
//--------------------cmbSexo-------7----------------------
        $select = new Element\Select('cmbSexo');
        $select->setLabel('Sexo: ');
        $select->setLabelAttributes(
                    array(
                        'class'     =>  'control-label',
                        'for'       =>  'cmbSexo'
                        ) );
        $select->setAttributes(
                array(

                    'id' =>  'cmbSexo',
                    'class'          => 'form-control'
                    ));
        $select->setEmptyOption('Seleccione...');
         $select->setValueOptions(array(
                1 => 'Masculino',
                2 => 'Femenino'
            ));
        $this->add($select);
//------------------cmbecivil--13--------------------------
        $select = new Element\Select('cmbecivil');
        $select->setLabel('E. Civil: ');
        $select->setLabelAttributes(
                    array(
                        'class'     =>  'control-label',
                        'for'       =>  'cmbecivil',
                        ) );
        $select->setAttributes(
                array(
                    'id'=> 'cmbecivil',
                    'class'          => 'form-control'
                    ));
        $select->setEmptyOption('Seleccione...');
         $select->setValueOptions(array(
                0 => 'Casado',
                1 => 'Soltero'
            ));
        $this->add($select); 
//------------------cmbCiudad--13--------------------------
        $select = new Element\Select('cmbCiudad');
        $select->setLabel('Ciudad: ');
        $select->setLabelAttributes(
                    array(
                        'class'     =>  'control-label',
                        'for'       =>  'cmbCiudad',
                        ) );
        $select->setAttributes(
                array(
                    'id'=> 'cmbCiudad',
                    'class'          => 'form-control'
                    ));
        $select->setEmptyOption('Seleccione...');
        $this->add($select); 
//------------------cmbdistrito--13--------------------------
        $select = new Element\Select('cmbDistrito');
        $select->setLabel('Distrito: ');
        $select->setLabelAttributes(
                    array(
                        'class'     =>  'control-label',
                        'for'       =>  'cmbDistrito',
                        ) );
        $select->setAttributes(
                array(
                    'id'=> 'cmbDistrito',
                    'class'          => 'form-control'
                    ));
        $select->setEmptyOption('Seleccione...');
        $this->add($select); 
// //--------------------txtTelCasa---10----------------------
    //         $this->add(array(
    //                 'name'      =>  'txtTelCasa',
    //                 'options'   =>  array(
    //                             'label' =>  'Tel. Fijo: ',
    //                             'label_attributes'  => array(
    //                                     'class'     =>  'control-label',
    //                                     'for'       =>  'txtTelCasa'
    //                                       ),
    //                             ),
    //                 'attributes'=>  array(
    //                             'id'            =>  'txtTelCasa',
    //                             'type'           => 'text',
    //                             'placeholder'    => '223344',
    //                             'class'          => 'form-control numerico',
    //                             'maxlength'     =>'6'
    //                         ),
    //             ));
// //---------------------txtTelMovil-----11------------------
    //         $this->add(array(
    //                 'name'      =>  'txtTelMovil',
    //                 'options'   =>  array(
    //                             'label' =>  'Movil: ',
    //                             'label_attributes'  => array(
    //                                     'class'     =>  'control-label',
    //                                     'for'       =>  'txtTelMovil'
    //                                       ),
    //                             ),
    //                 'attributes'=>  array(
    //                             'id'            =>'txtTelMovil',
    //                             'type'           => 'text',
    //                             'placeholder'    => '999111222',
    //                             'class'          => 'form-control numerico',
    //                             'maxlength'     =>'9'
    //                         ),
    //             ));
// //-------------------txtTelemergencia--12------------------
    //          $this->add(array(
    //                 'name'      =>  'txtTelemergencia',
    //                 'options'   =>  array(
    //                             'label' =>  'Tel. Emergencia: ',
    //                             'label_attributes'  => array(
    //                                     'class'     =>  'control-label',
    //                                     'for'       =>  'txtTelemergencia',
    //                                     'size'      =>'20'
    //                                       ),
    //                             ),
    //                 'attributes'=>  array(
    //                             'id'            =>'txtTelemergencia',
    //                             'type'           => 'text',
    //                             'placeholder'    => '223344',
    //                             'class'          => 'form-control numerico',
    //                             'maxlength'      =>  '7'
    //                         ),
    //             ));
//---------------------txtEmail-----9----------------------
        $this->add(array(
                'type'      =>  'Email',
                'name'      =>  'txtEmail',
                'options'   =>  array(
                            'label' =>  'E-mail: ',
                            'label_attributes'  => array(
                                    'class'     =>  'control-label',
                                    'for'       =>  'txtEmail'
                                      ),
                            ),
                'attributes'=>  array(
                            'id'        => 'txtEmail',
                            'type'           => 'text',
                            'placeholder'    => 'usuario@mail.com',
                            'maxlength'      => '50',
                            'class'          => 'form-control email'
                        ),
            ));
        $actual=date('Y-m-d');
//--------------------dtpFechaVisita--14-------------------
        $this->add(array(
             'type'         => 'Zend\Form\Element\Date',
             'name'         => 'dtpFechaVisita',
             'options'      => array(
                            'label' => 'Fecha de Visita: ',
                            'format' => 'Y-m-d',
                            'label_attributes'  => array(
                                    'class'     =>  'control-label',
                                    'for'       =>  'dtpFechaVisita'
                                      )
                        ),
             'attributes' => array(
                'id'    => 'dtpFechaVisita',
                     'class'        => 'form-control',
                     'min'          => '1950-01-01',
                     'max'          => '2060-01-01',
                     'step'         => '1',
                     'placeholder'  =>'Año-Mes-Dia', 
                     'value'=>$actual
                        )
         ));
//---------------------dtpFechareg-15----------------------
        $this->add(array(
             'type'         => 'Zend\Form\Element\Date',
             'name'         => 'dtpFechareg',
             'options'      => array(
                            'label' => 'Fecha de Registro: ',
                            'format' => 'Y-m-d',
                            'label_attributes'  => array(
                                    'class'     =>  'control-label',
                                    'for'       =>  'dtpFechareg'
                                      )
                        ),
             'attributes' => array(
                       'id' =>  'dtpFechareg', 
                     'class'        => 'form-control',
                     'min'          => '1950-01-01',
                     'max'          => '2060-01-01',
                     'step'         => '1',
                     'placeholder'  =>'Año-Mes-Dia', 
                     'value'=>$actual
                        )
         ));

//-------------------dtpFechaInvitacion--16----------------
        $this->add(array(
             'type'         => 'Zend\Form\Element\Date',
             'name'         => 'dtpFechaInvitacion',
             'options'      => array(
                            'label' => 'Fecha de Invitacion: ',
                            'format' => 'Y-m-d',
                            'label_attributes'  => array(
                                    'class'     =>  'control-label',
                                    'for'       =>  'dtpFechaInvitacion'
                                      )
                        ),
             'attributes' => array(
                        'id' => 'dtpFechaInvitacion',
                     'class'        => 'form-control',
                     'min'          => '1950-01-01',
                     'max'          => '2060-01-01',
                     'step'         => '1',
                     'placeholder'  =>'Año-Mes-Dia',
                     'value'=>$actual
                        )
         ));
//--------------------cmbestado--17------------------------
         
        $select = new Element\Select('cmbestado');
        $select->setLabel('Tipo de Registro: ');
        $select->setLabelAttributes(
                    array(
                        'class'     =>  'control-label',
                        'for'       =>  'cmbestado'
                        ) );
        $select->setAttributes(
                array(
                    'class'          => 'form-control',
                    'id'             => 'cmbestado'
                    ));
        $select->setEmptyOption('Seleccione...');
         $select->setValueOptions(array(
                0 => 'Socio',
                1 => 'Invitado',
                2 => 'Visita',
                3 => 'Recuperacion',
                4 => 'Becado'
            ));
        $this->add($select);
//---------------------cmbsocio------18--------------------
         
        $this->add(array(
                'name'      =>  'cmbsocio',
                'options'   =>  array(
                            'label' =>  'Dni-Socio ref.: ',
                            'label_attributes'  => array(
                                    'class'     =>  'control-label',
                                    'for'       =>  'cmbsocio'
                                      ),
                            ),
                'attributes'=>  array(
                            'id'            =>'cmbsocio',
                            'type'           => 'text',
                            'placeholder'    => 'Socio Referido',
                            'class'          => 'form-control numerico',
                            // 'required'       =>'true'
                        ),
            ));

        $this->add(array(
                'name'      =>  'send',
                'attributes'=>  array(
                            'type'  =>  'button',
                            'id'    =>  'btnbuscaSocio',
                            'value' =>  'Registrar',
                            'title' =>  'Registrar Socio',
                            'class' =>  'btn btn-gym btn-large btn-block',
                            'buttonType'    => 'primary',
                            'data-toogle'   =>  'button',
                        ),
            ));
//--------------------cmbempresa-----------19--------------
         
        $select = new Element\Select('cmbempresa');
        $select->setLabel('Empresa: ');
        $select->setLabelAttributes(
                    array(
                        'class'     =>  'control-label',
                        'for'       =>  'cmbempresa'
                        ) );
        $select->setAttributes(
                array(
                    'class'          => 'form-control',
                    'id'             =>  'cmbempresa'
                    ));
        $select->setEmptyOption('Seleccione...');
         $select->setValueOptions(array(
                1=> 'Nueva',
            ));
        $this->add($select);
//--------------------cmbpersonal----------20--------------
        $select = new Element\Select('cmbpersonal');
        $select->setLabel('Personal: ');
        $select->setLabelAttributes(
                    array(
                        'class'     =>  'control-label',
                        'for'       =>  'cmbpersonal'
                        ) );
        $select->setAttributes(
                array(
                    'class'          => 'form-control',
                    'id'             =>  'cmbpersonal'
                    ));
        $select->setEmptyOption('Seleccione...');
        $this->add($select);

//---------------Input File
        $file = new Element\File('txtFoto');
        $file->setLabel('Suba su foto')
             ->setAttribute('id', 'image-file')
             ->setLabelAttributes(array('class'=> 'form-control'));
        $this->add($file);

        

        //Botones regus
        $this->add(array(
                'name'      =>  'send1',
                'attributes'=>  array(
                            'type'  =>  'button',
                            'id'    =>  'btnRegUsSocio',
                            'value' =>  'Registrar',
                            'title' =>  'Registrar Usuario Socio',
                            'class' =>  'btn btn-gym btn-large btn-block',
                            'buttonType'    => 'primary',
                            'data-toogle'   =>  'button',
                        ),
            ));

        //Botones Enviar - Cancelar
		$this->add(array(
				'name'		=>	'send',
				'attributes'=>	array(
							'type'	=>	'button',
                            'id'    =>  'btnRegSocio',
							'value'	=>	'Registrar',
							'title'	=>	'Registrar Socio',
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