<?php
namespace Fitness\Model;

use Zend\Db\ResultSet\ResultSet;
use Zend\Db\Adapter\Adapter;
use Zend\Db\Sql\Sql;
use Zend\Db;
use Zend\Db\Adapter\Driver\ConnectionInterface;
use Zend\Db\Adapter\Driver\StatementInterface;
use Zend\Db\Adapter\Driver\ResultInterface;
use Fitness\Model\Entity\DetalleServicio;

class PlanTabla
{
	protected $adapter;
	public function __construct(Adapter $a)
	{
		$this->adapter=$a;
	}
	public function insertarServicio(servicio $ser=NULL)
	{
		try
		{
			$var=array(
						$ser->getNombre_ser(),
						$ser->getMontoBase_ser(),
						$ser->getTipo_ser(),
						$ser->getDiasCupon_ser(),
						$ser->getFreezing_ser(),
						$ser->getMontoInicial_ser(),
						$ser->getfechaReg_ser(),
						$ser->getPromocion_ser(),
						$ser->getEmpresa_id_emp(),
						$ser->getPersonal_id_per()
						);
			$sql = $this->adapter->query('CALL pa_insertaServicio (?,?,?,?,?,?,?,?,?;?,@msje)',$var);
			$resulta =   $this->adapter->query('SELECT @msje as mensaje',Adapter::QUERY_MODE_EXECUTE);
	        $datos	=	$resulta->toArray();
			if (strcmp($datos[0]['mensaje'], null)==0){
				return "Servicio Registrado.";
			}else{
				return $datos[0]['mensaje'];
			}
		}catch(Zend_Exception $e){
			return $e->getMessage();
		}
	}
}
?>