<?php
namespace Fitness\Model\Entity;


class Plan
{
	private $servicio_id_Serv1;
	private $plan_id_Serv;
	private $vigencia;
	public function __construct($datos=array())
	{
		$this->servicio_id_Serv1 =	NULL;
		$this->plan_id_Serv	=	NULL;
		$this->vigencia= NULL;
	}
	public function getData()
	{
		$array=array(
			'servicio_id' =>	$this->servicio_id_Serv1,
			'plan_id'	  =>	$this->plan_id_Serv,
			'vigencia'    => 	$this->vigencia,
			);
		return $array;
	}
	public function setServicioIdServ1($Ser_id)
	{
		$this->servicio_id_Serv1=$Ser_id;
		return $this;
	}
	public function getServicioIdServ1()
	{
		return $this->servicio_id_Serv1;
	}
	public function setPlanIdServ($PlanId)
	{
		$this->plan_id_Serv=$PlanId;
		return $this;
	}
	public function getPlanIdServ()
	{
		return $this->plan_id_Serv;
	}
	public function setVigencia($Vig)
	{
		$this->vigencia=$Vig;
		return $this;
	}
	public function getVigencia()
	{
		return $this->vigencia;
	}
}
?>