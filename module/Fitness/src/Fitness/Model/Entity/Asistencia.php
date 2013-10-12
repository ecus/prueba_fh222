<?php
namespace Fitness\Model\Entity;


class Asistencia
{
	//private $Dni;	
	private $idAsis;
	private $idCli;
	private $idPer;
	private $idIns;
	//private $Cliente;
	//private $Sucursal;
	private $FechaReg;
	private $FechaIng;
	private $idSuc;
	private $idHS;

	public function __construct()
	{
		//$this->Dni   	=	NULL;
		$this->idAsis	=	NULL;
		$this->idCli	=	NULL;
		$this->idPer    =	NULL;
		$this->idIns	=	NULL;
		//$this->Cliente	=	NULL;
		//$this->Sucursal	=	NULL;
		$this->FechaReg =   NULL;
		$this->FechaIng =   NULL;
		$this->idSuc    =   NULL;
		$this->idHS    	=   NULL;
	}
	public function getData()
	{
		$array=array(
			
			//'Dni' 			=>  $tis ->Dni,
			'idAsis'		=>	$this->idAsis,
			'idCli'			=>	$this->idCli,
			'idPer'			=>	$this->idPer,
			'idIns'			=>	$this->idIns,
			//'Cliente'		=>	$this->Cliente,
			//'Sucursal'		=>	$this->Sucursal,
			'FechaReg'		=>	$this->FechaReg,
			'FechaIng'		=>	$this->FechaIng,
			'idSuc'			=>	$this->idSuc,
			'idHS'			=>	$this->idHS
			);
		return $array;
	}

	
	public function setIdAsis($idAsis)
	{
		$this->id=$idAsis;
		return $this;
	}
	public function getIdAsis()
	{
		return $this->idAsis;
	}
	public function setidCli($idCli)
	{
		$this->idCli=$idCli;
		return $this;
	}
	public function getidCli()
	{
		return $this->idCli;
	}
	public function setidSuc($idSuc)
	{
		$this->idSuc=$idSuc;
		return $this;
	}
	public function getidSuc()
	{
		return $this->idSuc;
	}
	public function setidHS($idHS)
	{
		$this->idHS=$idHS;
		return $this;
	}
	public function getidHS()
	{
		return $this->idHS;
	}
	public function setidPer($idPer)
	{
		$this->idPer=$idPer;
		return $this;
	}
	public function getidPer()
	{
		return $this->idPer;
	}
	public function setidIns($idIns)
	{
		$this->idIns=$idIns;
		return $this;
	}
	public function getidIns()
	{
		return $this->idIns;
	}
	
	public function setFechaReg($FechaReg)
	{
		$this->FechaReg=$FechaReg;
		return $this;
	}
	public function getFechaReg()
	{
		return $this->FechaReg;
	}
	public function setFechaIng($FechaIng)
	{
		$this->FechaIng=$FechaIng;
		return $this;
	}
	public function getFechaIng()
	{
		return $this->FechaIng;
	}
}
?>