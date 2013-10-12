<?php

namespace Fitness\Form;

use Zend\Captcha;//principal
use Zend\Form\Element; //principal**
use Zend\Form\Form;//principal**
use Zend\Form\Factory;//principal

use Zend\InputFilter\Input;
use Zend\InputFilter\InputFilter;
use Zend\Form\Fieldset;

class frmRepPlan extends Form
{
	public function __construct($name = null)
	{
        parent::__construct($name);
        $select = new Element\Select('cmbServicio');
        $select->setLabel('Servicio: ');
        $select->setLabelAttributes(
                array(
                    'class'     =>  'control-label',
                    'for'       =>  'cmbServicio'
                ));
        $select->setAttributes(
                array(
                    'class'          => 'form-control',
                    'id'        => 'cmbServicio'
                    ));
        $select->setEmptyOption('Seleccione...');
        $this->add($select);

        $this->add(array(
				'name'		=>	'btnInfoPlan',
				'attributes'=>	array(
							'type'	=>	'button',
							'value'	=>	'Ver Detalle',
              'id'    =>  'btnRegInscripcion',
							'title'	=>	'Registar Inscripcion',
							'class'	=>	'btn btn-gym btn-large btn-block',
							'buttonType'    => 'primary',
							'data-toogle'	=>	'button',
						),
			));
	}
}
?>