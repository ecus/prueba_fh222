<?php
namespace Fitness\Model;

use Zend\Db\ResultSet\ResultSet;
use Zend\Db\Adapter\Adapter;
use Zend\Db\Sql\Sql;
use Zend\Db;
use Zend\Db\Adapter\Driver\ConnectionInterface;
use Zend\Db\Adapter\Driver\StatementInterface;
use Zend\Db\Adapter\Driver\ResultInterface;
use Fitness\Model\Entity\Asistencia;

class AsistenciaTabla
{
	protected $adapter;
	public function __construct(Adapter $a)
	{
		$this->adapter=$a;
	}
	
	public function insertarAsistencia(Asistencia $f)
	{
		$datos=array(
				
				$f->getFechaReg(),
				$f->getFechaIng(),
				$f->getidIns(),
				//$f->getidHS(),//id de horario servicio
				$f->getidCli(),
				$f->getidPer(),
				$f->getidSuc()//id de sucursal
				);
		
        $result =	$this->adapter->query('CALL pa_insertAsistencia(?,?,?,?,?,?)',$datos);
        //AQUI COMO CONTROLAR EL MENSAJE YA QUE EN EL SCRIPT NO ENVIO NINGUN MENSAJE
        $resulta =   $this->adapter->query('SELECT @a as mensaje',Adapter::QUERY_MODE_EXECUTE);
        $datos	=	$resulta->toArray();
		if (strcmp($datos[0]['mensaje'], null)==0){
				return "Asistencia Registrado.";
			}else{
				return $datos[0]['mensaje'];
			}
	}
	
	public function listaClienteActivo()
	{
		try{
			$sql 		=	$this->adapter->query('CALL pa_ListaSociosActivos',Adapter::QUERY_MODE_EXECUTE);
			$result		=	$sql->toArray();
			return $result;

		}catch(Zend_Exception $e){
			return $e->getMessage();
		}
	}

	//----------------------------------------
	public function verServicios($txtidCli)
	{
		try{
			$var 		= array($txtidCli);
			$sql 		=	$this->adapter->query('CALL pa_leeSocio (?)',$var);
			$result		=	$sql->toArray();
			return $result;
		}catch(Zend_Exception $e){
			return $e->getMessage();
		}
	}
	
		
}
?>