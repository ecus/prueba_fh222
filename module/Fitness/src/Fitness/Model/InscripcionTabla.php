<?php
namespace Fitness\Model;

use Zend\Db\TableGateway\TableGateway;
use Zend\Db\Adapter\Adapter;
use Fitness\Model\Entity\Inscripcion;

class InscripcionTabla extends TableGateway
{
	protected $adapter;
	public function __construct(Adapter $adapter = null, $databaseSchema = null, ResultSet $selectResultPrototype = null)
	{
		return parent::__construct('', $adapter, $databaseSchema,
			$selectResultPrototype);
	}
	public function insertarinscripcion(Inscripcion $ins=NULL)
	{
		try
		{
			// $var=array(
			$var1	=	$ins->getFechaInicio();
			$var2	=	$ins->getFechaFin();
			$var3	=	$ins->getSocio_id();
			$var4	=	$ins->getServicio_id();
			$var5	=	$ins->getPersonal_id();
					// );
			// $sql = $this->adapter->query('CALL pa_insertaInscripcion(?,?,?,?,?)',$var);
			$dbAdapter=$this->getAdapter();
			$stmt = $dbAdapter->createStatement();
			$stmt->prepare('CALL pa_insertaInscripcion(?,?,?,?,?,@msje)');
			$stmt->getResource()->bindParam(1, $var1);
			$stmt->getResource()->bindParam(2, $var2);
			$stmt->getResource()->bindParam(3, $var3,\PDO::PARAM_INT);
			$stmt->getResource()->bindParam(4, $var4,\PDO::PARAM_INT);
			$stmt->getResource()->bindParam(5, $var5,\PDO::PARAM_INT);
			$aux=$stmt->execute();
			$stmt->getResource()->closeCursor();

			$stmt2  = $dbAdapter->createStatement();
			$stmt2->prepare("SELECT @msje AS mensaje");
			$result = $stmt2->execute();
			$output = $result->current();
			return $output['mensaje'];
		}catch(Zend_Exception $e){
			return $e->getMessage();
		}
	}
}
?>