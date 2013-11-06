<?php
namespace Fitness\Model;

use Zend\Db\TableGateway\TableGateway;
use Zend\Db\Adapter\Adapter;
use Fitness\Model\Entity\Sucursal;

class SucursalTabla extends TableGateway
{
	public function __construct(Adapter $adapter = null, $databaseSchema = null, ResultSet $selectResultPrototype = null)
	{
		return parent::__construct('', $adapter, $databaseSchema,
			$selectResultPrototype);
	}
	public function insertarSucursal(Sucursal $suc=NULL)
	{
		try
		{
			$var1	=	$suc->getDisplay_Suc();
			$var2	=	$suc->getUbicacion_Suc();
			$var3	=	$suc->getLinea();
			$var4	=	$suc->getTelefono_Suc();

			$dbAdapter=$this->getAdapter();
			$stmt = $dbAdapter->createStatement();
			$stmt->prepare('CALL pa_insertaSucursal (?,?,?,?,@msje)');
			$stmt->getResource()->bindParam(1, $var1);
			$stmt->getResource()->bindParam(2, $var2);
			$stmt->getResource()->bindParam(3, $var3,\PDO::PARAM_INT);
			$stmt->getResource()->bindParam(4, $var4);
			$stmt->execute();
			$stmt->getResource()->closeCursor();

			$stmt2	=	$dbAdapter->createStatement();
			$stmt2->prepare("SELECT @msje AS mensaje");
			$result	=	$stmt2->execute();
			$output	=	$result->current();
			return $output['mensaje'];
		}catch(Zend_Exception $e){
			return $e->getMessage();
		}
	}
	public function actualizarSucursal(Sucursal $suc=NULL)
	{
		try
		{
			$var1	=	$suc->getDisplay_Suc();
			$var2	=	$suc->getUbicacion_Suc();
			$var3	=	$suc->getLinea();
			$var4	=	$suc->getTelefono_Suc();
			$var5	=	$suc->getEstado();
			$var6	=	$suc->getId();

			$dbAdapter=$this->getAdapter();
			$stmt = $dbAdapter->createStatement();
			$stmt->prepare('CALL pa_actualizaSucursal(?,?,?,?,?,?,@msje)');
			$stmt->getResource()->bindParam(1, $var1);
			$stmt->getResource()->bindParam(2, $var2);
			$stmt->getResource()->bindParam(3, $var3,\PDO::PARAM_INT);
			$stmt->getResource()->bindParam(4, $var4);
			$stmt->getResource()->bindParam(5, $var5,\PDO::PARAM_INT);
			$stmt->getResource()->bindParam(6, $var6,\PDO::PARAM_INT);
			$stmt->execute();
			$stmt->getResource()->closeCursor();

			$stmt2	=	$dbAdapter->createStatement();
			$stmt2->prepare("SELECT @msje AS mensaje");
			$result	=	$stmt2->execute();
			$output	=	$result->current();
			return $output['mensaje'];
		}catch(Zend_Exception $e){
			return $e->getMessage();
		}
	}
	public function listaSucursal()
	{
		try{
			$dbAdapter	=	$this->getAdapter();
			$stmt		=	$dbAdapter->createStatement();
			$stmt->prepare('CALL pa_listaSucursal()');
			$sql		=	$stmt->execute();
			// $info		=	$stmt->getResource()->fetchAll(\PDO::FETCH_OBJ);
			while ($sql->next()) {
				$result[$sql->current()['id_suc']]	=	$sql->current()['nombre_suc'];
			}
			return $result;
		}catch(Zend_Exception $e){
			return $e->getMessage();
		}
	}
	public function listaSucursalActivo()
	{
		try{
			$dbAdapter	=	$this->getAdapter();
			$stmt		=	$dbAdapter->createStatement();
			$stmt->prepare('CALL pa_listaSucursalActivo()');
			$stmt->execute();
			$info		=	$stmt->getResource()->fetchAll(\PDO::FETCH_OBJ);
			return $info;
		}catch(Zend_Exception $e){
			return $e->getMessage();
		}
	}
	public function listaSucursalInactivo()
	{
		try{
			$dbAdapter	=	$this->getAdapter();
			$stmt		=	$dbAdapter->createStatement();
			$stmt->prepare('CALL pa_listaSucursalInactivo()');
			$stmt->execute();
			$info		=	$stmt->getResource()->fetchAll(\PDO::FETCH_OBJ);
			return $info;
		}catch(Zend_Exception $e){
			return $e->getMessage();
		}
	}
	public function verSucursal()
	{
		try{
			$dbAdapter	=	$this->getAdapter();
			$stmt		=	$dbAdapter->createStatement();
			$stmt->prepare('CALL pa_listaSucursal()');
			$stmt->execute();
			$info		=	$stmt->getResource()->fetchAll(\PDO::FETCH_OBJ);
			return $info;
		}catch(Zend_Exception $e){
			return $e->getMessage();
		}
	}
	public function leeSucursal($id)
	{
		try{
			$dbAdapter	=	$this->getAdapter();
			$stmt		=	$dbAdapter->createStatement();
			$stmt->prepare('CALL pa_leeSucursal(?)');
			$stmt->getResource()->bindParam(1, $id);
			$stmt->execute();
			$info		=	$stmt->getResource()->fetchAll(\PDO::FETCH_OBJ);
			return $info;
		}catch(Zend_Exception $e){
			return $e->getMessage();
		}
	}
	public function desactivaSucursal($id)
	{
		try{
			$dbAdapter=$this->getAdapter();
			$stmt = $dbAdapter->createStatement();
			$stmt->prepare('CALL pa_desactivarSucursal(?,@msje)');
			$stmt->getResource()->bindParam(1, $var1);
			$stmt->execute();
			$stmt->getResource()->closeCursor();

			$stmt2	=	$dbAdapter->createStatement();
			$stmt2->prepare("SELECT @msje AS mensaje");
			$result	=	$stmt2->execute();
			$output	=	$result->current();
			return $output['mensaje'];

			// $var		=	array($id);
			// $this->adapter->query('CALL pa_desactivarSucursal (?,@msje)',$var);
			// $resulta =   $this->adapter->query('SELECT @msje as mensaje',Adapter::QUERY_MODE_EXECUTE);
			// $datos =	$resulta->toArray();
			// if (strcmp($datos[0]['mensaje'], null)==0){
			// 	return "Sucursal Eliminada.";
			// }else{
			// 	return $datos[0]['mensaje'];
			// }
			// $result		=	$sql->toArray();
			// $result		=	"Sucursal ahora es Inactiva.";
			// return $result;
		}catch(Zend_Exception $e){
			return $e->getMessage();
		}
	}
}
?>