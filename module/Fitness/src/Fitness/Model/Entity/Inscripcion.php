<?php
namespace Fitness\Model\Entity;


class Inscripcion
{
	private $FechaIni_ins;
	private $FechaFin_ins;
	private $estado_ins;
	private $tipo_ins;
	private $Socio_id_Soc;
	private $servicio_id_Serv;
	private $Inscripcion_id_ins;
	private $Personal_id_Per;
	public function __construct()
	{
		$this->FechaIni_ins	 		=	NULL;
		$this->FechaFin_ins	 		=	NULL;
		$this->estado_ins	 		=	NULL;
		$this->tipo_ins 	 		=	NULL;
		$this->Socio_id_Soc	 		=	NULL;
		$this->servicio_id_Serv		=	NULL;
		$this->Inscripcion_id_ins	=	NULL;
		$this->Personal_id_Per 	 	=	NULL;
	}
	public function getData()
	{
		$array=array(
			'FechaIni_ins'			=>	$this->FechaIni_ins,
			'FechaFin_ins'			=>	$this->FechaFin_ins,
			'estado_ins'			=>	$this->estado_ins,
			'tipo_ins'				=>	$this->tipo_ins,
			'Socio_id_Soc'			=>	$this->Socio_id_Soc,
			'servicio_id_Serv'		=>	$this->servicio_id_Serv,
			'Inscripcion_id_ins'	=>	$this->Inscripcion_id_ins,
			'Personal_id_Per'		=>	$this->Personal_id_Per,
			);
		return $array;
	}
	public function setFechaInicio($Fec_Ini)
	{
		$this->FechaIni_ins=$Fec_Ini;
		return $this;
	}
	public function getFechaInicio()
	{
		return $this->FechaIni_ins;
	}
	public function setFechaFin($fec_fin)
	{
		$this->FechaFin_ins=$fec_fin;
		return $this;
	}
	public function getFechaFin()
	{
		return $this->FechaFin_ins;
	}
	public function setEstado_ins($Estd)
	{
		$this->estado_ins=$Estd;
		return $this;
	}
	public function getEstado_ins()
	{
		return $this->estado_ins;
	}
	public function setTipo_ins($tip)
	{
		$this->tipo_ins=$tip;
		return $this;
	}
	public function getTipo_ins()
	{
		return $this->tipo_ins;
	}
	public function setSocio_id($soc)
	{
		$this->Socio_id_Soc=$soc;
		return $this;
	}
	public function getSocio_id()
	{
		return $this->Socio_id_Soc;
	}
	public function setServicio_id($ser)
	{
		$this->servicio_id_Serv=$ser;
		return $this;
	}
	public function getServicio_id()
	{
		return $this->servicio_id_Serv;
	}
	public function setInscripcion_id($ins)
	{
		$this->Inscripcion_id_ins=$ins;
		return $this;
	}
	public function getInscripcion_id()
	{
		return $this->Inscripcion_id_ins;
	}
	public function setPersonal_id($per)
	{
		$this->Personal_id_Per=$per;
		return $this;
	}
	public function getPersonal_id()
	{
		return $this->Personal_id_Per;
	}
}
?>