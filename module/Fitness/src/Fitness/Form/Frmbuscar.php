<?php

namespace Fitness\Form;

use Zend\Captcha;//principal
use Zend\Form\Element; //principal**
use Zend\Form\Form;//principal**
use Zend\Form\Factory;//principal

use Zend\InputFilter\Input;
use Zend\InputFilter\InputFilter;
use Zend\Form\Fieldset;

class FrmBuscar extends Form
{
	public function __construct($name = null)
	{
		parent::__construct($name);

		$this->add(array(
				'name'		=>	'txtValor',
				'attributes'=>	array(
							'type'           =>	'text',
							'placeholder'    =>	'Que desea Buscar?',
                            'class'          => 'span2 search-query'
						),
			));

        $this->add(array(
                'name'      =>  'buscar',
                'attributes'=>  array(
                            'type'  =>  'submit',
                            'value' =>  'Buscar',
                            'title' =>  'Buscar en el sistema.',
                            'class' =>  'btn btn-inverse',
                            'data-toogle'   =>  'button',
                        ),
            ));
	}
}

?>