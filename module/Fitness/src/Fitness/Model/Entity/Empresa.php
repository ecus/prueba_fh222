<?php
namespace Fitness\Model\Entity;


class Empresa
{
	private $id_Emp;
	private $Nombre_Emp;

	public function __construct()
	{
		$this->id_Emp	  =	NULL;
		$this->Nombre_Emp =	NULL;
	}
	public function getData()
	{
		$array=array(
			'id'		=>	$this->id_Emp,
			'nombre'	=>	$this->Nombre_Emp,
			);
		return $array;
	}
	public function setId($Id)
	{
		$this->id_Emp=$Id;
		return $this;
	}
	public function getId()
	{
		return $this->id_Emp;
	}
	
	public function setNombre_Em($nomb_emp)
	{
		$this->Nombre_Emp=$nomb_emp;
		return $this;
	}
	public function getNombre_Em()
	{
		return $this->Nombre_Emp;
	}
}
?>