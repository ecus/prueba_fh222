<?php

namespace Fitness\Form;

use Zend\Captcha;//principal
use Zend\Form\Element; //principal**
use Zend\Form\Form;//principal**
use Zend\Form\Factory;//principal

use Zend\InputFilter\Input;
use Zend\InputFilter\InputFilter;
use Zend\Form\Fieldset;

class FrmSettingsPer extends Form
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
                            'maxlength'      => '8',
                            'minlength'      => '8',
                            'required'       => 'true'
                        ),
            ));

        $this->add(array(
                'name'      =>  'txtNombres',
                'options'   =>  array(
                            'label' =>  'Nombres: ',
                            'label_attributes'  => array(
                                    'class'     =>  'control-label',
                                    'for'       =>  'txtNombres'
                                      ),
                            ),
                'attributes'=>  array(
                            'type'           => 'text',
                            'placeholder'    => 'Ejm.: Pedro',
                            'class'          => 'form-control soloTexto',
                            'maxlength'      => '35',
                            'required'       => 'true',
                            'id'             => 'txtNombres'
                        ),
            ));

        $this->add(array(
                'name'      =>  'txtApellidos',
                'options'   =>  array(
                            'label' =>  'Apellidos: ',
                            'label_attributes'  => array(
                                    'class'     =>  'control-label',
                                    'for'       =>  'txtApellidos'
                                      ),
                            ),
                'attributes'=>  array(
                            'type'           => 'text',
                            'placeholder'    => 'Ejm.: Perez Jurado',
                            'class'          => 'form-control soloTexto',
                            'maxlength'      => '35',
                            'required'       => 'true',
                            'id'             => 'txtApellidos'
                        ),
            ));

        $this->add(array(
                'name'      =>  'txtDireccion',
                'options'   =>  array(
                            'label' =>  'Direccion: ',
                            'label_attributes'  => array(
                                    'class'     =>  'control-label',
                                    'for'       =>  'txtDireccion'
                                      ),
                            ),
                'attributes'=>  array(
                            'type'           => 'text',
                            'placeholder'    => 'Ejm.: Ingrese Direccion',
                            'class'          => 'form-control direccion',
                            'maxlength'      => '45',
                            'required'       =>'true',
                            'id'             => 'txtDireccion'
                        ),
            ));

        $this->add(array(
                'name'      =>  'txtTelCasa',
                'options'   =>  array(
                            'label' =>  'Tel. Fijo: ',
                            'label_attributes'  => array(
                                    'class'     =>  'control-label',
                                    'for'       =>  'txtTelCasa'
                                      ),
                            ),
                'attributes'=>  array(
                            'type'           => 'text',
                            'placeholder'    => 'Ejm.: 223344',
                            'maxlength'      => '9',
                            'class'          => 'form-control numerico',
                            'id'             => 'txtTelCasa'
                        ),
            ));

        $this->add(array(
                'name'      =>  'txtTelMovil',
                'options'   =>  array(
                            'label' =>  'Movil: ',
                            'label_attributes'  => array(
                                    'class'     =>  'control-label',
                                    'for'       =>  'txtTelMovil'
                                      ),
                            ),
                'attributes'=>  array(
                            'type'           => 'text',
                            'placeholder'    => 'Ejm.: 999111222',
                            'maxlength'      => '9',
                            'class'          => 'form-control numerico',
                            'id'             => 'txtTelMovil'
                        ),
            ));

        $this->add(array(
                'name'      =>  'txtId',
                'options'   =>  array(
                            'label' =>  'Movil: ',
                            'label_attributes'  => array(
                                    'class'     =>  'control-label',
                                    'for'       =>  'txtId'
                                      ),
                            ),
                'attributes'=>  array(
                            'type'           => 'hidden',
                            'id'             => 'txtId'
                        ),
            ));

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
                            'type'           => 'text',
                            'placeholder'    => 'Ejm.: usuario@mail.com',
                            'maxlength'      => '50',
                            'class'          => 'form-control email',
                            'id'             => 'txtEmail'
                        ),
            ));

        $this->add(array(
             'type'         => 'Zend\Form\Element\Date',
             'name'         => 'dtpFechaNac',
             'options'      => array(
                            'label' => 'Fecha de Nacimiento: ',
                            'format' => 'Y-m-d',
                            'label_attributes'  => array(
                                    'class'     =>  'control-label ',
                                    'for'       =>  'dtpFechaNac'
                                      )
                        ),
             'attributes' => array(
                     'class'        => 'form-control',
                     'min'          => '1950-01-01',
                     'max'          => '2060-01-01',
                     'step'         => '1',
                     'id'             => 'dtpFechaNac',
                     'placeholder'  =>'Año-Mes-Dia' // days; default step interval is 1 day
                        )
         ));


        $this->add(array(
                'name'      =>  'txtClave',
                'options'   =>  array(
                            'label' =>  'Clave Actual: ',
                            'label_attributes'  => array(
                                    'class'     =>  'control-label',
                                    'for'       =>  'txtClaveNueva'
                                      )
                            ),
                'attributes'=>  array(
                            'id'             => 'txtClave',
                            'type'           => 'Password',
                            'placeholder'    => '*******',
                            'class'          => 'form-control',
                            'maxlength'      => '8',
                            'minlength'      => '8',
                            'required'       => 'true'
                        ),
            ));

        $this->add(array(
                'name'      =>  'txtClaveNueva',
                'options'   =>  array(
                            'label' =>  'Nueva Clave: ',
                            'label_attributes'  => array(
                                    'class'     =>  'control-label',
                                    'for'       =>  'txtClaveNueva'
                                      )
                            ),
                'attributes'=>  array(
                            'id'             => 'txtClaveNueva',
                            'type'           => 'Password',
                            'placeholder'    => '*******',
                            'class'          => 'form-control',
                            'maxlength'      => '8',
                            'minlength'      => '8',
                            'required'       => 'true'
                        ),
            ));

        $this->add(array(
                'name'      =>  'txtClaveConfirma',
                'options'   =>  array(
                            'label' =>  'Confirmar Clave: ',
                            'label_attributes'  => array(
                                    'class'     =>  'control-label',
                                    'for'       =>  'txtClaveConfirma'
                                      )
                            ),
                'attributes'=>  array(
                            'id'             => 'txtClaveConfirma',
                            'type'           => 'Password',
                            'placeholder'    => '*******',
                            'class'          => 'form-control',
                            'maxlength'      => '8',
                            'minlength'      => '8',
                            'required'       => 'true'
                        ),
            ));

        // Input File
        $file = new Element\File('txtFoto');
        $file->setLabel('Suba su foto: ')
             ->setAttribute('id', 'image-file')
             ->setAttribute('class', 'form-control')
             ->setLabelAttributes(array('class'=> ''));
        $this->add($file);

        $this->add(array(
                'name'      =>  'btnRegSettingsPer',
                'attributes'=>  array(
                            'type'  =>  'button',
                            'value' =>  'Actualizar',
                            'title' =>  'Actualizar Datos',
                            'id'    =>  'btnRegSettingsPer',
                            'class' =>  'btn btn-gym btn-block',
                            'buttonType'    => 'primary',
                            'data-toogle'   =>  'button',
                        ),
            ));
	}
}

?>