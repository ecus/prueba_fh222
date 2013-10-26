<?php
namespace Fitness\Model;

use Zend\Db\ResultSet\ResultSet;
use Zend\Db\Adapter\Adapter;
use Zend\Db\Sql\Sql;
use Zend\Db;
use Zend\Db\Adapter\Driver\ConnectionInterface;
use Zend\Db\Adapter\Driver\StatementInterface;
use Zend\Db\Adapter\Driver\ResultInterface;
use Fitness\Model\Entity\Inscripcion;

class InscripcionTabla
{
	protected $adapter;
	public function __construct(Adapter $a)
	{
		$this->adapter=$a;
	}
	public function insertarinscripcion(Inscripcion $ins=NULL)
	{
		try
		{
			$var=array(
						$ins->getFechaInicio(),
						$ins->getFechaFin(),
						$ins->getSocio_id(),
						$ins->getServicio_id(),
						$ins->getPersonal_id()
					);
			$sql = $this->adapter->query('CALL pa_insertaInscripcion(?,?,?,?,?)',$var);
			$resulta =   $this->adapter->query('SELECT @msje as mensaje',Adapter::QUERY_MODE_EXECUTE);
	        $datos	=	$resulta->toArray();
			if (strcmp($datos[0]['mensaje'], null)==0){
				return "Socio Inscrito.";
			}else{
				return $datos[0]['mensaje'];
			}
		}catch(Zend_Exception $e){
			return $e->getMessage();
		}
	}
}
?>