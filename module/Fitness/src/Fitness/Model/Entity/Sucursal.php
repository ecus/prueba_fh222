<?php
namespace Fitness\Model\Entity;


class Sucursal
{
	private $id;
	private $display;
	private $ubicacion;
	private $linea;
	private $telefono;
	private $estado;

	public function __construct()
	{
		$this->id		=	NULL;
		$this->display	=	NULL;
		$this->ubicacion=	NULL;
		$this->linea	=	NULL;
		$this->telefono	=	NULL;
		$this->estado	=	NULL;
	}
	public function getData()
	{
		$array=array(
			'id'		=>	$this->id,
			'display'	=>	$this->display,
			'ubicacion'	=>	$this->ubicacion,
			'linea'		=>	$this->linea,
			'telefono'	=>	$this->telefono,
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
	public function setLinea($linea)
	{
		$this->linea=$linea;
		return $this;
	}
	public function getLinea()
	{
		return $this->linea;
	}
	public function setDisplay_Suc($Dis_Suc)
	{
		$this->display=$Dis_Suc;
		return $this;
	}
	public function getDisplay_Suc()
	{
		return $this->display;
	}
	public function setUbicacion_Suc($Ubi_Suc)
	{
		$this->ubicacion=$Ubi_Suc;
		return $this;
	}
	public function getUbicacion_Suc()
	{
		return $this->ubicacion;
	}
	public function setTelefono_Suc($Telef_Suc)
	{
		$this->telefono=$Telef_Suc;
		return $this;
	}
	public function getTelefono_Suc()
	{
		return $this->telefono;
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