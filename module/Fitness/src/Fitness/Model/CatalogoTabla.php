<?php
namespace Fitness\Model;

// use Zend\Db\ResultSet\ResultSet;
// use Zend\Db\Adapter\Adapter;
// use Zend\Db\Sql\Sql;
// use Zend\Db;
// use Zend\Db\Adapter\Driver\ConnectionInterface;
// use Zend\Db\Adapter\Driver\StatementInterface;
// use Zend\Db\Adapter\Driver\ResultInterface;
use Zend\Db\TableGateway\TableGateway;
use Zend\Db\Adapter\Adapter;
// use Fitness\Model\Entity\Cuenta;

class CatalogoTabla extends TableGateway
{
	public function __construct(Adapter $adapter = null, $databaseSchema = null, ResultSet $selectResultPrototype = null)
	{
		return parent::__construct('', $adapter, $databaseSchema, $selectResultPrototype);
	}
	public function listaCiudad()
	{
		try{
			$dbAdapter=$this->getAdapter();
			$stmt = $dbAdapter->createStatement(); 
			$stmt->prepare('CALL pa_listaCiudad()'); 
			$sql=$stmt->execute();
			while ($sql->next()) {
				$result[$sql->current()['id_Ciu']]=$sql->current()['nombre_Ciu'];
			}
			return $result;
		}catch(Zend_Exception $e){
			throw $e;	
		}
		// foreach ($sql->toArray() as $value) {
		// 	$result[$value['id_Ciu']]=$value['nombre_Ciu'];
	}
	public function listaDistrito($id)
	{
		try{
			$dbAdapter=$this->getAdapter();
			$stmt = $dbAdapter->createStatement(); 
			$stmt->prepare('CALL pa_listaDistrito(:id)'); 
			$stmt->getResource()->bindParam(':id', $id, \PDO::PARAM_INT); 
			$sql=$stmt->execute();
			while ($sql->next()) {
				$result[$sql->current()['id_Dis']]=$sql->current()['nombre_Dis'];
			}
			// var_dump(count($result));
			return $result;
		}catch(Zend_Exception $e){
			throw $e;	
		}
		// $sql 		=	$this->adapter->query('CALL pa_listaSucursal',Adapter::QUERY_MODE_EXECUTE);
		// $result		=	$sql->toArray();
		// return $result;
	}
}
?>