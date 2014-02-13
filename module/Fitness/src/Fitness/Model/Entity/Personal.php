<?php
namespace Fitness\Model\Entity;


// use Fitness\Model\Entity\personal;

class Personal
{
	private $apMaterno;
	private $apPaterno;
	private $cargo;
	private $clave;
	private $direccion;
	private $dni;
	private $email;
	private $estado;
	private $fechaNac;
	private $id;
	private $nombre;
	private $sexo;
	private $suc;
	private $tCasa;
	private $tMovil;
	private $user;

	public function __construct()
	{
		$this->apMaterno=	NULL;
		$this->apPaterno=	NULL;
		$this->cargo	=	NULL;
		$this->clave	=	NULL;
		$this->direccion=	NULL;
		$this->dni		=	NULL;
		$this->email	=	NULL;
		$this->estado	=	NULL;
		$this->id		=	NULL;
		$this->nombre	=	NULL;
		$this->sexo		=	NULL;
		$this->suc		=	NULL;
		$this->tCasa	=	NULL;
		$this->tMovil	=	NULL;
		$this->user		=	NULL;
	}
	public function getData()
	{
		$array=array(
			'id'		=>	$this->id,
			'display'	=>	$this->display,
			'ubicacion'	=>	$this->ubicacion,
			'telefono'	=>	$this->telefono,
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
	public function setUser($user)
	{
		$this->user=$user;
		return $this;
	}
	public function getUser()
	{
		return $this->user;
	}
	public function setClave($clave)
	{
		$this->clave=$clave;
		return $this;
	}
	public function getClave()
	{
		return $this->clave;
	}
	public function setDni($dni)
	{
		$this->dni=$dni;
		return $this;
	}
	public function getDni()
	{
		return $this->dni;
	}
	public function setSexo($sexo)
	{
		$this->sexo=$sexo;
		return $this;
	}
	public function getSexo()
	{
		return $this->sexo;
	}
	public function setNombre($nom)
	{
		$this->nombre=$nom;
		return $this;
	}
	public function setFechaNac($fecha)
	{
		$this->fechaNac=$fecha;
		return $this;
	}
	public function getFechaNac()
	{
		return $this->fechaNac;
	}
	public function getNombre()
	{
		return $this->nombre;
	}
	public function setApPaterno($ApPat)
	{
		$this->apPaterno=$ApPat;
		return $this;
	}
	public function getApPaterno()
	{
		return $this->apPaterno;
	}
	public function setApMaterno($ApMat)
	{
		$this->apMaterno=$ApMat;
		// 5648959409823323   11/12
		return $this;
	}
	public function getApMaterno()
	{
		return $this->apMaterno;
	}
	public function setDireccion_per($Direc_per)
	{
		$this->direccion=$Direc_per;
		return $this;
	}
	public function getDireccion_per()
	{
		return $this->direccion;
	}
	public function setTelfCasa_per($TCasa_per)
	{
		$this->tCasa=$TCasa_per;
		return $this;
	}
	public function getTelfCasa_per()
	{
		return $this->tCasa;
	}
	public function setTelfMovil_per($Tmovil_per)
	{
		$this->tMovil=$Tmovil_per;
		return $this;
	}
	public function getTelfMovil_per()
	{
		return $this->tMovil;
	}
	public function setEmail_per($Email_per)
	{
		$this->email=$Email_per;
		return $this;
	}
	public function getEmail_per()
	{
		return $this->email;
	}
	public function setEstado($Ed)
	{
		$this->estado=$Ed;
		return $this;
	}
	public function getEstado()
	{
		return $this->estado;
	}
	public function setSucursal($Sucursal)
	{
		$this->suc=$Sucursal;
		return $this;
	}
	public function getSucursal()
	{
		return $this->suc;
	}
	public function setCargo($cargo)
	{
		$this->cargo=$cargo;
		return $this;
	}
	public function getCargo()
	{
		return $this->cargo;
	}
}
?>