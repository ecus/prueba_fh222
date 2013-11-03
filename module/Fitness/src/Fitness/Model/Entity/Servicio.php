<?php
namespace Fitness\Model\Entity;


class Servicio
{
	private $id_ser;
	private $nombre_ser;
	private $montoBase_ser;
	private $tipo_ser;
	private $diascupon_ser;
	private $freezing_ser;
	private $montoInicial_ser;
	private $fechaRegistro_ser;
	private $promocion_ser;
	private $tipoDur_ser;
	private $duracion_ser;
	private $pagoMaximo_ser;
	private $cuota_ser;
	private $personal_id_per;
	private $servicioBase;

	public function __construct($datos=array())
	{
		$this->id_ser		 		=	NULL;
		$this->nombre_ser	 		=	NULL;
		$this->montoBase_ser 		=	NULL;
		$this->tipo_ser		 		=	NULL;
		$this->diascupon_ser 		=	NULL;
		$this->freezing_ser  		=	NULL;
		$this->montoInicial_ser		=	NULL;
		$this->fechaRegistro_ser	=	NULL;
		$this->promocion_ser 		=	NULL;
		$this->personal_id_per 		=	NULL;
		$this->servicioBase 		=	NULL;
	}
	public function getData()
	{
		$array=array(
			'id'					=>	$this->id_ser,
			'nombre'				=>	$this->nombre_ser,
			'montoBase'				=>	$this->montoBase_ser,
			'tipo'					=>	$this->tipo_ser,
			'dias'					=>	$this->diascupon_ser,
			'freezing'				=>	$this->freezing_ser,
			'montoInicial'			=>	$this->montoInicial_ser,
			'fecha'					=>	$this->fechaRegistro_ser,
			'promocion'				=>	$this->promocion_ser,
			'personal'				=>	$this->personal_id_per,
			'servicioBase'			=>	$this->servicioBase
			);
		return $array;
	}
	public function setId_ser($Id)
	{
		$this->id_ser=$Id;
		return $this;
	}
	public function getId_ser()
	{
		return $this->id_ser;
	}
	public function setNombre_ser($nom)
	{
		$this->nombre_ser=$nom;
		return $this;
	}
	public function getNombre_ser()
	{
		return $this->nombre_ser;
	}
	public function setMontoBase_ser($monto)
	{
		$this->montoBase_ser=$monto;
		return $this;
	}
	public function getMontoBase_ser()
	{
		return $this->montoBase_ser;
	}
	public function setTipo_ser($tipo)
	{
		$this->tipo_ser=$tipo;
		return $this;
	}
	public function getTipo_ser()
	{
		return $this->tipo_ser;
	}
	public function setDiasCupon_ser($dias)
	{
		$this->diascupon_ser=$dias;
		return $this;
	}
	public function getDiasCupon_ser()
	{
		return $this->diascupon_ser;
	}
	public function setFreezing_ser($free)
	{
		$this->freezing_ser=$free;
		return $this;
	}
	public function getFreezing_ser()
	{
		return $this->freezing_ser;
	}
	public function setMontoInicial_ser($inicial)
	{
		$this->montoInicial_ser=$inicial;
		return $this;
	}
	public function getMontoInicial_ser()
	{
		return $this->montoInicial_ser;
	}
	public function setfechaReg_ser($reg)
	{
		$this->fechaRegistro_ser=$reg;
		return $this;
	}
	public function getfechaReg_ser()
	{
		return $this->fechaRegistro_ser;
	}
	public function setPromocion_ser($prom)
	{
		$this->promocion_ser=$prom;
		return $this;
	}
	public function getPromocion_ser()
	{
		return $this->promocion_ser;
	}
	public function setCuota_ser($Id)
	{
		$this->cuota_ser=$Id;
		return $this;
	}
	public function getCuota_ser()
	{
		return $this->cuota_ser;
	}
	public function setTipoDuracion_ser($Id)
	{
		$this->tipoDur_ser=$Id;
		return $this;
	}
	public function getTipoDuracion_ser()
	{
		return $this->tipoDur_ser;
	}
	public function setDuracion_ser($Id)
	{
		$this->duracion_ser=$Id;
		return $this;
	}
	public function getDuracion_ser()
	{
		return $this->duracion_ser;
	}
	public function setPagoMaximo_ser($Id)
	{
		$this->pagoMaximo_ser=$Id;
		return $this;
	}
	public function getPagoMaximo_ser()
	{
		return $this->pagoMaximo_ser;
	}
	public function setPersonal_id_per($per)
	{
		$this->personal_id_per=$per;
		return $this;
	}
	public function getPersonal_id_per()
	{
		return $this->personal_id_per;
	}
	public function setServicioBase($ser)
	{
		$this->servicioBase=$per;
		return $this;
	}
	public function getServicioBase()
	{
		return $this->servicioBase;
	}
}
?>