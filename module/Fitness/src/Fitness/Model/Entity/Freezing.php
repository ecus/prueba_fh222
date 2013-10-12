<?php
namespace Fitness\Model\Entity;


class Freezing
{
	private $idFree;
	private $idPersonal;
	private $idCliente;
	private $idInscripcion;
	private $Cliente;
	private $Comentario;
	private $Dni;
	private $FechaInsc;
	private $FechaReg;
	private $CantDias;
	

	public function __construct()
	{
		$this->idFree			=	NULL;
		$this->idPersonal		=	NULL;
		$this->idCliente		=	NULL;
		$this->idInscripcion	=   NULL;
		$this->Cliente   		=	NULL;
		$this->Comentario   		=	NULL;
		$this->Dni				=	NULL;
		$this->FechaInsc		=	NULL;
		$this->FechaReg	        =	NULL;
		$this->CantDias			=   NULL;
		
	}
	
	public function getData()
	{
		$array=array(
			'idFree'		=>	$this->idFree,
			'idPersonal'	=>	$this->idPersonal,
			'idCliente'	    =>	$this->idCliente,
			'idInscripcion' =>  $tis ->idInscripcion,
			'Comentario' =>  $tis ->Comentario,
			'Cliente'	    =>	$this->Cliente,
			'Dni'			=>	$this->Dni,
			'FechaInsc'	    =>	$this->FechaInsc,
			'FechaReg'	=>	$this->FechaReg,
			'CantDias'		=>  $tis ->CantDias		
			
			);
		return $array;
	}
	
	public function setIdFree($idFree)
	{
		$this->idFree=$idFree;
		return $this;
	}
	public function getIdFree()
	{
		return $this->idFree;
	}
	public function setComentario($Comentario)
	{
		$this->Comentario=$Comentario;
		return $this;
	}
	public function getComentario()
	{
		return $this->Comentario;
	}
    public function setIdPersonal($idPersonal)
	{
		$this->idPersonal=$idPersonal;
		return $this;
	}
	public function getIdPersonal()
	{
		return $this->idPersonal;
	}
	public function setIdCliente($idCliente)
	{
		$this->idCliente=$idCliente;
		return $this;
	}
	public function getIdCliente()
	{
		return $this->idCliente;
	}
	
	public function setIdInscripcion($idInscripcion)
	{
		$this->idInscripcion=$idInscripcion;
		return $this;
	}
	public function getIdInscripcion()
	{
		return $this->idInscripcion;
	}
	public function setIdServicio($idServicio)
	{
		$this->idServicio=$idServicio;
		return $this;
	}
	public function getIdServicio()
	{
		return $this->idServicio;
	}
	
    public function setCliente($Cliente)
	{
		$this->Cliente=$Cliente;
		return $this;
	}
	public function getCliente()
	{
		return $this->Cliente;
	}
	public function setDni($Dni)
	{
		$this->Dni=$Dni;
		return $this;
	}
	public function getDni()
	{
		return $this->Dni;
	}
	public function setFechaInsc($FechaInsc)
	{
		$this->FechaInsc=$FechaInsc;
		return $this;
	}
	public function getFechaInsc()
	{
		return $this->FechaInsc;
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
	public function setCantDias($CantDias)
	{
		$this->CantDias=$CantDias;
		return $this;
	}
	public function getCantDias()
	{
		return $this->CantDias;
	}
    
}
?>