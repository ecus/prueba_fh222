<?php
namespace Fitness\Model\Entity;


class UsuarioSocio
{
	private $Id_USoc;
	private $clave_user;
	private $estado_user;
	private $socio_id_Soc;
	public function __construct($datos=array())
	{
		$this->Id_USoc		 =	$datos['Id_USoc'];
		$this->Clave_user	 =	$datos['clave_user'];
		$this->estado_user	 =	$datos['estado_user'];
		$this->socio_id_Soc =	$datos['socio_id_Soc'];

	}
	public function getData()
	{
		$array=array(
			'Id_USoc'		=>	$this->Id_USoc,
			'clave_user'	=>	$this->Clave_user,
			'estado_USoc'	=>	$this->estado_user,
			'socio_USoc'	=>	$this->socio_id_Soc,
			);
		return $array;
	}
	public function setIdUS($Id_US)
	{
		$this->Id_USoc=$Id_US;
		return $this;
	}
	public function getIdUS()
	{
		return $this->Id_USoc;
	}
	public function setClaveUS($Clav_US)
	{
		$this->clave_user=$Clav_US;
		return $this;
	}
	public function getClaveUS()
	{
		return $this->clave_user;
	}
	public function setEstadoUS($Estd_US)
	{
		$this->estado_user=$Estd_US;
		return $this;
	}
	public function getEstadoUS()
	{
		return $this->estado_user;
	}
	public function setPersonalUS($Soc_US)
	{
		$this->socio_id_Soc=$Soc_US;
		return $this;
	}
	public function getPersonalUS()
	{
		return $this->socio_id_Soc;
	}


}