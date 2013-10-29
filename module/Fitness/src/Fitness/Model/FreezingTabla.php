<?php
namespace Fitness\Model;

use Zend\Db\TableGateway\TableGateway;
use Zend\Db\Adapter\Adapter;
use Fitness\Model\Entity\Freezing;

class FreezingTabla extends TableGateway
{
	public function __construct(Adapter $adapter = null, $databaseSchema = null, ResultSet $selectResultPrototype = null)
	{
		return parent::__construct('', $adapter, $databaseSchema,
			$selectResultPrototype);
	}
	public function insertarFreezing(Freezing $f)
	{
		$var1	=	$f->getFechaReg();
		$var2	=	$f->getCantDias();
		$var3	=	$f->getComentario();
		$var4	=	$f->getIdInscripcion();
		$var5	=	$f->getIdCliente();
		$var6	=	$f->getIdPersonal();

		$dbAdapter=$this->getAdapter();
		$stmt = $dbAdapter->createStatement();
		$stmt->prepare('CALL pa_InsertarFreezing (?,?,?,?,?,?)');
		$stmt->getResource()->bindParam(1, $var1);
		$stmt->getResource()->bindParam(2, $var2);
		$stmt->getResource()->bindParam(3, $var3);
		$stmt->getResource()->bindParam(4, $var4,\PDO::PARAM_INT);
		$stmt->getResource()->bindParam(5, $var5,\PDO::PARAM_INT);
		$stmt->getResource()->bindParam(6, $var6,\PDO::PARAM_INT);
		$stmt->execute();
		$stmt->getResource()->closeCursor();

		$stmt2	=	$dbAdapter->createStatement();
		$stmt2->prepare("SELECT @msje AS mensaje");
		$result	=	$stmt2->execute();
		$output	=	$result->current();
		return $output['mensaje'];
	}
	public function verCliente($dni)
	{
		try{
			$dbAdapter	=	$this->getAdapter();
			$stmt		=	$dbAdapter->createStatement();
			$stmt->prepare('CALL pa_ClienteInscripcion(?)');
			$stmt->getResource()->bindParam(1, $dni);
			$stmt->execute();
			$info		=	$stmt->getResource()->fetchAll(\PDO::FETCH_OBJ);
			return $info;
		}catch(Zend_Exception $e){
			return $e->getMessage();
		}
	}
}
?>