<?php
namespace Fitness\Model\Entity;


class Sucursal
{
	private $id;
	private $tipoCta;
	private $moneda;
	private $banco;
	private $estado;
	// public function __construct($datos=array())
	// {
	// 	$this->id		=	$datos['id'];
	// 	$this->display	=	$datos['display'];
	// 	$this->ubicacion=	$datos['ubicacion'];
	// 	$this->telefono	=	$datos['telefono'];

	// }
	public function __construct()
	{
		$this->id		=	NULL;
		$this->tipoCta  =	NULL;
		$this->moneda	=	NULL;
		$this->banco	=	NULL;
		$this->estado	=	NULL;
	}
	public function getData()
	{
		$array=array(
			'id'		=>	$this->id,
			'tipoCta'	=>	$this->tipoCta,
			'moneda'	=>	$this->moneda,
			'banco'	    =>	$this->banco,
			'estado'	=>	$this->estado
			);
		return $array;
	}
	public function setId($Id)
	{
		$this->id=$Id;
		return $this;
	}
	public function getId()
	{
		return $this->id;
	}
	public function setTipo_Cta($tipoCta)
	{
		$this->tipoCta=$tipoCta;
		return $this;
	}
	public function getTipo_Cta()
	{
		return $this->tipoCta;
	}
	
	public function setBanco_Cta($banco)
	{
		$this->banco=$banco;
		return $this;
	}
	public function getBanco_Cta()
	{
		return $this->banco;
	}
	public function setMoneda_Cta($moneda)
	{
		$this->moneda=$moneda;
		return $this;
	}
	public function getMoneda_Cta()
	{
		return $this->moneda;
	}
	public function setEstado($estado)
	{
		$this->estado=$estado;
		return $this;
	}
	public function getEstado()
	{
		return $this->estado;
	}
}
?>