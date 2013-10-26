<?php
namespace Fitness\Form;

use Zend\Captcha;//principal
use Zend\Form\Element; //principal**
use Zend\Form\Form;//principal**
use Zend\Form\Factory;//principal

use Zend\InputFilter\Input;
use Zend\InputFilter\InputFilter;
use Zend\Form\Fieldset;

class FrmPersonal extends Form
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
				'name'		=>	'txtNombre',
				'options'	=>	array(
							'label'	=>	'Nombre: ',
                            'label_attributes'  => array(
                                    'class'     =>  'control-label',
                                    'for'       =>  'txtNombre'
                                      ),
                            ),
				'attributes'=>	array(
							'type'           =>	'text',
							'placeholder'    =>	'Ejm.: Pedro',
                            'class'          => 'form-control soloTexto',
                            'maxlength'      => '35',
                            'required'       => 'true',
                            'id'             => 'txtNombre'
						),
			));

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
                            'type'           => 'text',
                            'placeholder'    => 'Ejm.: Ruiz',
                            'class'          => 'form-control soloTexto ',
                            'maxlength'      => '35',
                            'required'       => 'true',
                            'id'             => 'txtApPaterno'
                        ),
            ));

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
                            'type'           => 'text',
                            'placeholder'    => 'Ejm.: Apellido Materno',
                            'class'          => 'form-control soloTexto',
                            'maxlength'      => '35',
                            'required'       =>'true',
                            'id'             => 'txtApMaterno'
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
             'name'         => 'dtpFecha',
             'options'      => array(
                            'label' => 'Fecha de Nacimiento: ',
                            'format' => 'Y-m-d',
                            'label_attributes'  => array(
                                    'class'     =>  'control-label ',
                                    'for'       =>  'dtpFecha'
                                      )
                        ),
             'attributes' => array(
                     'class'        => 'form-control',
                     'min'          => '1950-01-01',
                     'max'          => '2060-01-01',
                     'step'         => '1',
                     'id'             => 'dtpFecha',
                     'placeholder'  =>'Año-Mes-Dia' // days; default step interval is 1 day
                        )
         ));

        // Input File
        $file = new Element\File('txtFoto');
        $file->setLabel('Suba su foto: ')
             ->setAttribute('id', 'image-file')
             ->setAttribute('class', 'form-control')
             ->setLabelAttributes(array('class'=> ''));
        $this->add($file);

        // ComboBox
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
                0 => 'Masculino',
                1 => 'Femenino'
            ));
        $this->add($select);




        $element = new Element\MultiCheckbox('foo');
        $element->setLabel('Sexo: ');
        $element->setLabelAttributes(
                    array(
                        'class'     =>  'control-label',
                        'for'       =>  'cmbSexo'
                        ) );
        // , array(
        //         'label'=>'dasd',
        //         'multiOptions' => array(
        //             'foo' => 'Foo Option',
        //             'bar' => 'Bar Option',
        //             'baz' => 'Baz Option',
        //             'bat' => 'Bat Option',
        //         )
        //     ));


        // Checkbox
        $creaUser = new Element\Checkbox('chkCrear');
        $creaUser->setLabel('&nbsp; Usuario con acceso a sistema.');
        $creaUser->setLabelAttributes(array(
                    'class'     =>  ''
                    ));
        $creaUser->setChecked('true');
        // $creaUser->attributes(array('class'   => 'input-large'));
        $this->add($creaUser);


        /*//////////////*/
        // checkbox
        $condiciones = new Element\Checkbox('condiciones');
        $condiciones->setLabel('Acepto Las Condiciones');
        $this->add($condiciones);
        //multicheckbox
        $preferencias = new Element\MultiCheckbox('preferencias');
        $preferencias->setLabel('Indique sus preferencias: ');
        $preferencias->setLabelAttributes(array(
            'class'=>'btn btn-gym'
            ));
        $preferencias->setValueOptions(array('m'=>'Música','d'=>'Deporte','o'=>'Ocio'));
        $this->add($preferencias);
        /*//////////////*/

        //Botones Enviar - Cancelar
		$this->add(array(
				'name'		=>	'btnRegPersonal',
				'attributes'=>	array(
							'type'	=>	'button',
                            'id'    =>  'btnRegPersonal',
							'value'	=>	'Registrar',
							'title'	=>	'Registrar Personal',
							'class'	=>	'btn btn-gym btn-large btn-block',
							'buttonType'    => 'primary',
							'data-toogle'	=>	'button',
						),
			));
        $this->add(array(
                'name'      =>  'cancelar',
                'attributes'=>  array(
                            'type'          =>  'reset',
                            'value'         =>  'Cancelar',
                            'title'         =>  'Poner campos del formulario en blanco',
                            'class'         =>  'btn btn-large btn-inverse',
                            'data-toogle'   =>  'button',
                        ),
            ));
	}
}
