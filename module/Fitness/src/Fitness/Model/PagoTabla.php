<?php
namespace Fitness\Model;

use Zend\Db\ResultSet\ResultSet;
use Zend\Db\Adapter\Adapter;
use Zend\Db\Sql\Sql;
use Zend\Db;
use Zend\Db\Adapter\Driver\ConnectionInterface;
use Zend\Db\Adapter\Driver\StatementInterface;
use Zend\Db\Adapter\Driver\ResultInterface;
use Fitness\Model\Entity\Pago;

class PagoTabla
{
	protected $adapter;
	public function __construct(Adapter $a)
	{
		$this->adapter=$a;
	}
	public function insertarPago(Pago $f)
	{
		$datos=array(
				
				$f->getFechaRegPago(),
				$f->getFechaPago(),
				$f->getTotal(),
				$f->getMoneda(),
				$f->getFormaPago(),
				$f->getConPago(),
				$f->getEstado(),
				$f->getidServicio(),
				$f->getidCuenta(),
				$f->getidPer(),
				$f->getidSucursal(),
				$f->getidCliente()
				);
		
        $result =	$this->adapter->query('CALL pa_InsertarPago (?,?,?,?,?,?,?,?,?,?,?,?)',$datos);
        //AQUI COMO CONTROLAR EL MENSAJE YA QUE EN EL SCRIPT NO ENVIO NINGUN MENSAJE
        $resulta =   $this->adapter->query('SELECT @a as mensaje',Adapter::QUERY_MODE_EXECUTE);
        $datos	=	$resulta->toArray();
		if (strcmp($datos[0]['mensaje'], null)==0){
				return "Pago Registrado.";
			}else{
				return $datos[0]['mensaje'];
			}
	}
	public function verCliente($txtDni)
	{
		try{
			$var 		= array($txtDni);
			$sql 		=	$this->adapter->query('CALL pa_CliServicio (?)',$var);
			$result		=	$sql->toArray();
			return $result;
		}catch(Zend_Exception $e){
			return $e->getMessage();
		}
	}
	
}
?>