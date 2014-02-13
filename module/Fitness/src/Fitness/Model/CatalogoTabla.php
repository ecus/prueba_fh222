<?php
namespace Fitness\Model;

use Zend\Db\TableGateway\TableGateway;
use Zend\Db\Adapter\Adapter;

class CatalogoTabla extends TableGateway
{
	public function __construct(Adapter $adapter = null, $databaseSchema = null, ResultSet $selectResultPrototype = null)
	{
		return parent::__construct('', $adapter, $databaseSchema, $selectResultPrototype);
	}
	public function listaCiudad()
	{
		try{
			$result = array('' => '' );
			$dbAdapter=$this->getAdapter();
			$stmt = $dbAdapter->createStatement();
			$stmt->prepare('CALL pa_listaCiudad()');
			$sql=$stmt->execute();
			while ($sql->next()) {
				if (isset($sql->current()['id_Ciu'])) {
					$result[$sql->current()['id_Ciu']]=$sql->current()['nombre_Ciu'];
				} else {
					$result[null]='';
				}
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
				if (isset($sql->current()['id_Dis'])) {
					$result[$sql->current()['id_Dis']]=$sql->current()['nombre_Dis'];
				} else {
					$result[null]='';
				}
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