<?php
namespace Fitness\Model;

use Zend\Db\TableGateway\TableGateway;
use Zend\Db\Adapter\Adapter;
use Fitness\Model\Entity\Asistencia;

class AsistenciaTabla extends TableGateway
{
	public function __construct(Adapter $adapter = null, $databaseSchema = null, ResultSet $selectResultPrototype = null)
	{
		return parent::__construct('', $adapter, $databaseSchema,
			$selectResultPrototype);
	}

	public function insertarAsistencia(Asistencia $f)
	{
		// $datos=array(
		$var1	=	$f->getFechaReg();
		$var2	=	$f->getFechaIng();
		$var3	=	$f->getidIns();
		// $var1	=	$f->getidHS(),//id de horario servici;
		$var4	=	$f->getidCli();
		$var5	=	$f->getidPer();
		$var6	=	$f->getidSuc();//id de sucursa;
				// );

		$dbAdapter=$this->getAdapter();
		$stmt = $dbAdapter->createStatement();
		$stmt->prepare('CALL pa_insertaAsistencia(?,?,?,?,?,?,@msje)');
		$stmt->getResource()->bindParam(1, $var1);
		$stmt->getResource()->bindParam(2, $var2);
		$stmt->getResource()->bindParam(3, $var3,\PDO::PARAM_INT);
		$stmt->getResource()->bindParam(4, $var4,\PDO::PARAM_INT);
		$stmt->getResource()->bindParam(5, $var5,\PDO::PARAM_INT);
		$stmt->getResource()->bindParam(6, $var6,\PDO::PARAM_INT);
		$stmt->execute();
		// $stmt->getResource()->closeCursor();

		$stmt2  = $dbAdapter->createStatement();
		$stmt2->prepare("SELECT @msje AS mensaje");
		$result = $stmt2->execute();
		$output = $result->current();
		return $output['mensaje'];

        // $result =	$this->adapter->query('CALL pa_insertAsistencia(?,?,?,?,?,?)',$datos);
	}

	public function listaClienteActivo()
	{
		// try{
		// 	$sql 		=	$this->adapter->query('CALL pa_ListaSociosActivos',Adapter::QUERY_MODE_EXECUTE);
		// 	$result		=	$sql->toArray();
		// 	return $result;

		// }catch(Zend_Exception $e){
		// 	return $e->getMessage();
		// }
		try {
			$dbAdapter	=	$this->getAdapter();
			$stmt		=	$dbAdapter->createStatement();
			$stmt->prepare('CALL pa_ListaSociosActivos()');
			$stmt->execute();
			$info		=	$stmt->getResource()->fetchAll(\PDO::FETCH_OBJ);
			return $info;
			// var_dump($info);
		} catch (Exception $e) {
			throw $e;
		}
	}

	//----------------------------------------
	public function verServicios($id)
	{
		try{
			$dbAdapter	=	$this->getAdapter();
			$stmt		=	$dbAdapter->createStatement();
			$stmt->prepare('CALL pa_leeSocio(?)');
			$stmt->getResource()->bindParam(1, $id);
			$stmt->execute();
			$info		=	$stmt->getResource()->fetchAll(\PDO::FETCH_OBJ);
			return $info;
		}catch(Zend_Exception $e){
			return $e->getMessage();
		}
	}


}
?>