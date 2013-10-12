<?php
namespace Fitness\Model\Entity;


class Socio
{
	private $Idsocio;
	private $paterno;
	private $materno;
	private $nombres;
	private $sexo;
	private $fechanac;
	private $email;
	private $telefono;
	private $movil;
	private $direccion;
	private $distrito;
	private $emergencia;
	private $ecivil;
	private $fechavisita;
	private $fecharegistro;
	private $fechainv;
	private $estado;
	private $referido;
	private $empresa;
	private $documento;
	private $numerodoc;
	private $personal;


	public function __construct($datos=array())
	{
		$this->Idsocio	 =	null;
		$this->paterno	 =	null;
		$this->materno	 =	null;
		$this->nombres 	 =	null;
		$this->sexo	 	 =	null;
		$this->fechanac	 =	null;
		$this->email	 =	null;
		$this->telefono  =	null;
		$this->direccion =	null;
		$this->distrito	 =	null;
		$this->movil	 =	null;
		$this->emergencia=	null;
		$this->ecivil	 =	null;
		$this->fechavisita 	 =	null;
		$this->fecharegistro =	null;
		$this->fechainv	 =	null;
		$this->estado	 =	null;
		$this->referido  =	null;
		$this->empresa	 =	null;
		$this->documento =	null;
		$this->numerodoc =	null;
		$this->personal =	null;

	}
	public function getData()
	{
		$array=array(
			'Idsocio'		=>	$this->Idsocio,
			'paterno'	=>	$this->paterno,
			'materno'	=>	$this->materno,
			'nombres'		=>	$this->nombres,
			'fechanac'	=>	$this->fechanac,
			'email'	=> $this->email,
			'telefono'		=>	$this->telefono,
			'movil'	=>	$this->movil,
			'emergencia'	=>	$this->emergencia,
			'ecivil'		=>	$this->ecivil,
			'fechavisita'	=>	$this->fechavisita,
			'fecharegistro'	=>	$this->fecharegistro,
			'fechainv'		=>	$this->fechainv,
			'estado'	=>	$this->estado,
			'referido'	=>	$this->referido,
			'empresa'	=>	$this->empresa,
			'documento'		=>	$this->documento,
			'numerodoc'	=>	$this->numerodoc,
			'sexo'	=>	$this->sexo,
			'personal' => $this->personal,
			);
		return $array;
	}
	public function setId($Idsocio)
	{
		$this->Idsocio=$Idsocio;
		return $this;
	}
	public function getId()
	{
		return $this->Idsocio;
	}
	public function setPaterno($paterno)
	{
		$this->paterno=$paterno;
		return $this;
	}
	public function getPaterno()
	{
		return $this->paterno;
	}
	public function setMaterno($materno)
	{
		$this->materno=$materno;
		return $this;
	}
	public function getMaterno()
	{
		return $this->materno;
	}
	public function setDistrito($distrito)
	{
		$this->distrito= $distrito;
		return $this;
	}
	public function getDistrito()
	{
		return $this->distrito;
	}
	public function setNombres($nombres)
	{
		$this->nombres=$nombres;
		return $this;
	}
	public function getNombres()
	{
		return $this->nombres;
	}
	public function setDireccion($direccion)
	{
		$this->direccion=$direccion;
		return $this;
	}
	public function getDireccion()
	{
		return $this->direccion;
	}
	public function setFechanac($fechanac)
	{
		$this->fechanac=$fechanac;
		return $this;
	}
	public function getFechanac()
	{
		return $this->fechanac;
	}
	public function setEmail($email)
	{
		$this->email=$email;
		return $this;
	}
	public function getEmail()
	{
		return $this->email;
	}
	public function setTelefono($telefono)
	{
		$this->telefono=$telefono;
		return $this;
	}
	public function getTelefono()
	{
		return $this->telefono;
	}
	public function setMovil($movil)
	{
		$this->movil=$movil;
		return $this;
	}
	public function getMovil()
	{
		return $this->movil;
	}
	public function setEmergencia($emergencia)
	{
		$this->emergencia=$emergencia;
		return $this;
	}
	public function getEmergencia()
	{
		return $this->emergencia;
	}
	public function setEcivil($ecivil)
	{
		$this->ecivil=$ecivil;
		return $this;
	}
	public function getEcivil()
	{
		return $this->ecivil;
	}
	public function setFechavisita($fechavisita)
	{
		$this->fechavisita=$fechavisita;
		return $this;
	}
	public function getFechavisita()
	{
		return $this->fechavisita;
	}
	public function setFecharegistro($fecharegistro)
	{
		$this->fecharegistro=$fecharegistro;
		return $this;
	}
	public function getFecharegistro()
	{
		return $this->fecharegistro;
	}

	public function setFechainv($fechainv)
	{
		$this->fechainv=$fechainv;
		return $this;
	}
	public function getFechainv()
	{
		return $this->fechainv;
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
	public function setReferido($referido)
	{
		$this->referido=$referido;
		return $this;
	}
	public function getReferido()
	{
		return $this->referido;
	}
	public function setEmpresa($empresa)
	{
		$this->empresa=$empresa;
		return $this;
	}
	public function getEmpresa()
	{
		return $this->empresa;
	}
	public function setDocumento($documento)
	{
		$this->documento=$documento;
		return $this;
	}
	public function getDocumento()
	{
		return $this->documento;
	}
	public function setNumerodoc($numerodoc)
	{
		$this->numerodoc=$numerodoc;
		return $this;
	}
	public function getNumerodoc()
	{
		return $this->numerodoc;
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
	public function setPersonal($personal)
	{
		$this->personal=$personal;
		return $this;
	}
	public function getPersonal()
	{
		return $this->personal;
	}

	
}
?>