<?php
namespace Fitness\Model\Entity;

class Procesa
{
	private $nombre;
	private $correo;

	public function __construct($datos=array())
	{
		$this->nombre	=	$datos['nombre'];
		$this->correo	=	$datos['email'];
		
	}
	public function getData()
	{
		$array=array(
			'nom'	=>	$this->nombre,
			'mail'	=>	$this->correo
			);
		return $array;
	}
}
?>