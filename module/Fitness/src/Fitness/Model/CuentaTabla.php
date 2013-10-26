<?php
namespace Fitness\Model;

use Zend\Db\ResultSet\ResultSet;
use Zend\Db\Adapter\Adapter;
use Zend\Db\Sql\Sql;
use Zend\Db;
use Zend\Db\Adapter\Driver\ConnectionInterface;
use Zend\Db\Adapter\Driver\StatementInterface;
use Zend\Db\Adapter\Driver\ResultInterface;
use Fitness\Model\Entity\Cuenta;

class CuentaTabla
{
	protected $adapter;
	public function __construct(Adapter $a)
	{
		$this->adapter=$a;
	}
	public function insertarCuenta(Cuenta $cta=NULL)
	{
		try
		{
			$var=array(
						$cta->getTipo_Cta(),
						$cta->getBanco_Cta(),
						$cta->getMoneda_Cta()
					);
			$sql = $this->adapter->query('CALL pa_insertaCuenta (?,?,?,@msje)',$var);
			$resulta =   $this->adapter->query('SELECT @msje as mensaje',Adapter::QUERY_MODE_EXECUTE);
	        $datos	=	$resulta->toArray();
			if (strcmp($datos[0]['mensaje'], null)==0){
				return "Cuenta Registrada.";
			}else{
				return $datos[0]['mensaje'];
			}
		}catch(Zend_Exception $e){
			return $e->getMessage();
		}
	}
	public function listaSucursal()
	{
		$sql 	=	$this->adapter->query('CALL pa_listaSucursal',Adapter::QUERY_MODE_EXECUTE);
		// $result	=	$sql->toArray();
		$result	=	array();
		foreach ($sql->toArray() as $value) {
			$result[$value['id_Cuenta']]=$value['banco_cuenta'];
		}
		return $result;
	}
	public function verSucursal()
	{
		$sql 		=	$this->adapter->query('CALL pa_listaSucursal',Adapter::QUERY_MODE_EXECUTE);
		$result		=	$sql->toArray();
		return $result;
	}
}
?>