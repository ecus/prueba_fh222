<?php
namespace Fitness\Model\Entity;


class Pago
{
	private $idPago;
	private $idPer;
	private $idSucursal;
	private $idCliente;
	private $Dni;
	private $Cliente;
	private $idServicio;
	private $NameServicio;
	private $Total;
	private $FechaRegPago;
	private $FechaPago;
	private $Moneda;
	private $FormaPago;
	private $ConPago;
	private $Estado;
	private $idCuenta;
	
	public function __construct()
	{
		$this->idPago			=	NULL;
		$this->idPer			=	NULL;
		$this->idSucursal		=	NULL;
		$this->idCliente		=   NULL;
		$this->Dni   			=	NULL;
		$this->Cliente   		=	NULL;
		$this->idServicio		=	NULL;
		$this->NameServicio		=	NULL;
		$this->Total	        =	NULL;
		$this->FechaRegPago		=   NULL;
		$this->FechaPago		=	NULL;
		$this->Moneda			=	NULL;
		$this->FormaPago		=	NULL;
		$this->ConPago			=	NULL;
		$this->Estado			=	NULL;
		$this->idCuenta			=	NULL;
	}
	
	public function getData()
	{
		$array=array(
			'idPago'		=>	$this->idPago,
			'idPer'			=>	$this->idPer,
			'idSucursal'	=>	$this->idSucursal,
			'idCliente' 	=>  $tis ->idCliente,
			'Dni' 			=>  $tis ->Dni,
			'Cliente'	    =>	$this->Cliente,
			'idServicio'	=>	$this->idServicio,
			'NameServicio'  =>	$this->NameServicio,
			'Total'			=>	$this->Total,
			'FechaRegPago'	=>  $tis ->FechaRegPago,
			'FechaPago'		=>	$this->FechaPago,
			'Moneda'		=>	$this->Moneda,
			'FormaPago'		=>	$this->FormaPago,
			'ConPago'		=>$this->ConPago,
			'Estado'		=>$this->Estado,
			'idCuenta'		=>$this->idCuenta		
			);
		return $array;
	}
	
	public function setidPago($idPago)
	{
		$this->idPago=$idPago;
		return $this;
	}
	public function getidPago()
	{
		return $this->idPago;
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
    public function setidSucursal($idSucursal)
	{
		$this->idSucursal=$idSucursal;
		return $this;
	}
	public function getidSucursal()
	{
		return $this->idSucursal;
	}
	public function setidCliente($idCliente)
	{
		$this->idCliente=$idCliente;
		return $this;
	}
	public function getidCliente()
	{
		return $this->idCliente;
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
	public function setCliente($Cliente)
	{
		$this->Cliente=$Cliente;
		return $this;
	}
	public function getCliente()
	{
		return $this->Cliente;
	}
	public function setidServicio($idServicio)
	{
		$this->idServicio=$idServicio;
		return $this;
	}
	public function getidServicio()
	{
		return $this->idServicio;
	}
	public function setNameServicio($NameServicio)
	{
		$this->NameServicio=$NameServicio;
		return $this;
	}
	public function getNameServicio()
	{
		return $this->NameServicio;
	}
	public function setTotal($Total)
	{
		$this->Total=$Total;
		return $this;
	}
	public function getTotal()
	{
		return $this->Total;
	}
	public function setFechaRegPago($FechaRegPago)
	{
		$this->FechaRegPago=$FechaRegPago;
		return $this;
	}
	public function getFechaRegPago()
	{
		return $this->FechaRegPago;
	}
	public function setFechaPago($FechaPago)
	{
		$this->FechaPago=$FechaPago;
		return $this;
	}
	public function getFechaPago()
	{
		return $this->FechaPago;
	}
	public function setMoneda($Moneda)
	{
		$this->Moneda=$Moneda;
		return $this;
	}
	public function getMoneda()
	{
		return $this->Moneda;
	}
	public function setFormaPago($FormaPago)
	{
		$this->FormaPago=$FormaPago;
		return $this;
	}
	public function getFormaPago()
	{
		return $this->FormaPago;
	}
	public function setConPago($ConPago)
	{
		$this->ConPago=$ConPago;
		return $this;
	}
	public function getConPago()
	{
		return $this->ConPago;
	}
	public function setEstado($Estado)
	{
		$this->Estado=$Estado;
		return $this;
	}
	public function getEstado()
	{
		return $this->Estado;
	}
	public function setidCuenta($idCuenta)
	{
		$this->idCuenta=$idCuenta;
		return $this;
	}
	public function getidCuenta()
	{
		return $this->idCuenta;
	}
    
}
?>