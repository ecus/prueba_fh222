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

    private $tipoPromocion_DPromo;
    private $fechaInicio_DPromo;
    private $fechaFin_DPromo;
    private $montoPromocion_DPromo;
    private $dias_DPromo;
    private $porcentaje_DPromo;
    private $empresaMin_DPromo;
    private $empresaMax_DPromo;
    private $horario_DPromo;

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

		$this->tipoPromocion_DPromo =	NULL;
		$this->fechaInicio_DPromo 	=	NULL;
		$this->fechaFin_DPromo 		=	NULL;
		$this->montoPromocion_DPromo=	NULL;
		$this->dias_DPromo 			=	NULL;
		$this->porcentaje_DPromo 	=	NULL;
		$this->empresaMin_DPromo 	=	NULL;
		$this->empresaMax_DPromo 	=	NULL;
		$this->horario_DPromo	   	=	NULL;

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
		$this->servicioBase=$ser;
		return $this;
	}
	public function getServicioBase()
	{
		return $this->servicioBase;
	}

	public function setTipoPromocion($tipo){
		$this->tipoPromocion_DPromo =$tipo;
		return $this;
	}
	public function getTipoPromocion(){
		return $this->tipoPromocion_DPromo;
	}
	public function setFechaInicio($fechaini){
		$this->fechaInicio_DPromo =$fechaini;
		return $this;
	}
	public function getFechaInicio(){
		return $this->fechaInicio_DPromo;
	}
	public function setFechaFin($fechafin){
		$this->fechaFin_DPromo =$fechafin;
		return $this;
	}
	public function getFechaFin(){
		return $this->fechaFin_DPromo;
	}
	public function setMontoPromocion($monto){
    	$this->montoPromocion_DPromo=$monto;
    	return $this;
	}
	public function getMontoPromocion(){
    	return $this->montoPromocion_DPromo;
	}
	public function setDias($dias){
    	$this->dias_DPromo=$dias;
    	return $this;
	}
	public function getDias(){
    	return $this->dias_DPromo;
	}
	public function setPorcentaje($porcentaje){
    	$this->porcentaje_DPromo=$porcentaje;
    	return $this;
	}
	public function getPorcentaje(){
    	return $this->porcentaje_DPromo;
	}
	public function setEmpresaMin($min){
    	$this->empresaMin_DPromo=$min;
    	return $this;
	}
	public function getEmpresaMin(){
    	return $this->empresaMin_DPromo;
	}
	public function setEmpresaMax($max){
    	$this->empresaMax_DPromo=$max;
    	return $this;
	}
	public function getEmpresaMax(){
    	return $this->empresaMax_DPromo;
	}
	public function setHorario($hora){
    	$this->horario_DPromo=$hora;
    	return $this;
	}
	public function getHorario(){
    	return $this->horario_DPromo;
	}
}
?>