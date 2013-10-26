<?php

namespace Fitness\Form;

use Zend\Captcha;//principal
use Zend\Form\Element; //principal**
use Zend\Form\Form;//principal**
use Zend\Form\Factory;//principal

use Zend\InputFilter\Input;
use Zend\InputFilter\InputFilter;
use Zend\Form\Fieldset;

class Formularios extends Form
{
	public function __construct($name = null)
	{
		parent::__construct($name);

		$this->add(array(
				'name'		=>	'nombre',
				'options'	=>	array(
							'label'	=>	'Nombre Completo: ',
						),
				'attributes'=>	array(
							'type'	=>	'text',
							'placeholder'	=>	'Nombre Completo',
						),
			));

		$factory	= new Factory();
		$email	=	$factory->createElement(array(
				'type'		=>	'Zend\Form\Element\Email',
				'name'		=>	'email',
				'options'	=>	array(
							'label'	=>	'Correo: ',
						),
				'attributes'=>	array(
							'placeholder'	=>	'email@pagina.com',
						),
			));
		$this->add($email);

		// $name = new Element('name');
		// $name->setLabel('Your name');
		// $name->setOption('Your name');
		// $name->setAttributes(array(
		//     'type'  => 'text'
		// ));
		$this->add(array(
				'name'		=>	'send',
				'attributes'=>	array(
							'type'	=>	'submit',
							'value'	=>	'Enviar',
							'title'	=>	'Enviar title',
							'class'	=>	'btn',
							'buttonType'    => 'success',
							'data-toogle'	=>	'button',
						),
			));
		///////////////////////////////////////////////
		//
		//
		//campo de tipo password
         $this->add(array(
            'name' => 'pass',
            'options' => array(
                'label' => 'Password',
            ),
            'attributes' => array(
                'type' => 'password',
                'class' => 'mama'
            ),
        ));
        // File Input
        $file = new Element\File('image-file');
        $file->setLabel('Suba su foto')
             ->setAttribute('id', 'image-file');
        $this->add($file);



        //radio button
        // $radio = new Element\Radio('genero');
        //  $radio->setLabel('Cuál es tu género ?');
        // //type="button" class="btn btn-primary"
        //  $this->add($radio);
         $radio=$factory->createElement(array(
         	'type' => 'Zend\Form\Element\Radio',
            'name' => 'genero',
            'options' => array(
                'label' => 'Cuál es tu género ?',
                'value_options' => array(
						'0' => 'Female',
						'1' => 'Male',
						),
            ),
            // 'attributes' => array(
                
            // ),
            'setLabelAttributes' => array(
                'class' => 'btn btn-primary'
            ),
        ));
         $this->add($radio);


    //select
    $select = new Element\Select('lenguaje');
     $select->setLabel('Cuál en tu lengua materna?');
     $select->setAttribute('multiple', true);
    //$select->setEmptyOption('Seleccione...');
    $this->add($select);
     
        $pais = new Element\Select('pais');
     $pais->setLabel('Cuál es tu país?');
     $pais->setEmptyOption('Seleccione...');
     $pais->setValueOptions(array(
      'european' => array(
         'label' => 'European languages',
         'options' => array(
            '0' => 'French',
            '1' => 'Italian',
         ),
      ),
      'asian' => array(
         'label' => 'Asian languages',
         'options' => array(
            '2' => 'Japanese',
            '3' => 'Chinese',
         ),
      ),
     ));
     $this->add($pais);
        //campo oculto
        $oculto = new Element\Hidden('oculto');
        $this->add($oculto);
     // checkbox
        $condiciones = new Element\Checkbox('condiciones');
        $condiciones->setLabel('Acepto Las Condiciones');
        $this->add($condiciones);
     //multicheckbox
        $preferencias = new Element\MultiCheckbox('preferencias');
        $preferencias->setLabel('Indique sus preferencias');
        $this->add($preferencias);
	}
}

?>