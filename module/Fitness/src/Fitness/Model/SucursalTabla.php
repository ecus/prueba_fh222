<?php
namespace Fitness\Model;

use Zend\Db\ResultSet\ResultSet;
use Zend\Db\Adapter\Adapter;
use Zend\Db\Sql\Sql;
use Zend\Db;
use Zend\Db\Adapter\Driver\ConnectionInterface;
use Zend\Db\Adapter\Driver\StatementInterface;
use Zend\Db\Adapter\Driver\ResultInterface;
use Fitness\Model\Entity\Sucursal;

class SucursalTabla
{
	protected $adapter;
	public function __construct(Adapter $a)
	{
		$this->adapter=$a;
	}
	public function insertarSucursal(Sucursal $suc=NULL)
	{
		try
		{
			$var=array(
						$suc->getDisplay_Suc(),
						$suc->getUbicacion_Suc(),
						$suc->getLinea(),
						$suc->getTelefono_Suc()
					);
			$sql = $this->adapter->query('CALL pa_insertaSucursal (?,?,?,?,@msje)',$var);
			$resulta =   $this->adapter->query('SELECT @msje as mensaje',Adapter::QUERY_MODE_EXECUTE);
	        $datos	=	$resulta->toArray();
			if (strcmp($datos[0]['mensaje'], null)==0){
				return "Sucursal Registrada.";
			}else{
				return $datos[0]['mensaje'];
			}
		}catch(Zend_Exception $e){
			return $e->getMessage();
		}
	}
	public function actualizarSucursal(Sucursal $suc=NULL)
	{
		try
		{
			$var=array(
						$suc->getDisplay_Suc(),
						$suc->getUbicacion_Suc(),
						$suc->getLinea(),
						$suc->getTelefono_Suc(),
						$suc->getEstado(),
						$suc->getId(),
					);
			$sql = $this->adapter->query('CALL pa_actualizaSucursal(?,?,?,?,?,?,@msje)',$var);
			$resulta =   $this->adapter->query('SELECT @msje as mensaje',Adapter::QUERY_MODE_EXECUTE);
	        $datos	=	$resulta->toArray();
			if (strcmp($datos[0]['mensaje'], null)==0){
				return "Sucursal Actualizada.";
			}else{
				return $datos[0]['mensaje'];
			}
		}catch(Zend_Exception $e){
			return $e->getMessage();
		}
	}
	public function listaSucursal()
	{
		try{
			$sql 	=	$this->adapter->query('CALL pa_listaSucursal',Adapter::QUERY_MODE_EXECUTE);
			// $result	=	$sql->toArray();
			$result	=	array();
			foreach ($sql->toArray() as $value) {
				$result[$value['id_suc']]=$value['nombre_suc'];
			}
			return $result;
		}catch(Zend_Exception $e){
			return $e->getMessage();
		}
	}
	public function listaSucursalActivo()
	{
		try{
			$sql 		=	$this->adapter->query('CALL pa_listaSucursalActivo',Adapter::QUERY_MODE_EXECUTE);
			$result		=	$sql->toArray();
			return $result;

		}catch(Zend_Exception $e){
			return $e->getMessage();
		}
	}
	public function listaSucursalInactivo()
	{
		try{
			$sql 		=	$this->adapter->query('CALL pa_listaSucursalInactivo',Adapter::QUERY_MODE_EXECUTE);
			$result		=	$sql->toArray();
			return $result;
		}catch(Zend_Exception $e){
			return $e->getMessage();
		}
	}
	public function verSucursal()
	{
		try{
			$sql 		=	$this->adapter->query('CALL pa_listaSucursal',Adapter::QUERY_MODE_EXECUTE);
			$result		=	$sql->toArray();
			return $result;
		}catch(Zend_Exception $e){
			return $e->getMessage();
		}
	}
	public function leeSucursal($id)
	{
		try{
			$var		=	array($id);
			$sql 		= $this->adapter->query('CALL pa_leeSucursal (?)',$var);
			$result		=	$sql->toArray();
			return $result;
		}catch(Zend_Exception $e){
			return $e->getMessage();
		}
	}
	public function desactivaSucursal($id)
	{
		try{
			$var		=	array($id);
			$this->adapter->query('CALL pa_desactivarSucursal (?,@msje)',$var);
			$resulta =   $this->adapter->query('SELECT @msje as mensaje',Adapter::QUERY_MODE_EXECUTE);
	        $datos	=	$resulta->toArray();
			if (strcmp($datos[0]['mensaje'], null)==0){
				return "Sucursal Eliminada.";
			}else{
				return $datos[0]['mensaje'];
			}
			// $result		=	$sql->toArray();
			// $result		=	"Sucursal ahora es Inactiva.";
			// return $result;
		}catch(Zend_Exception $e){
			return $e->getMessage();
		}
	}
}
?>