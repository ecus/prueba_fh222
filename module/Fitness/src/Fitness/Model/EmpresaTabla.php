<?php
namespace Fitness\Model;

use Zend\Db\ResultSet\ResultSet;
use Zend\Db\Adapter\Adapter;
use Zend\Db\Sql\Sql;
use Zend\Db;
use Zend\Db\Adapter\Driver\ConnectionInterface;
use Zend\Db\Adapter\Driver\StatementInterface;
use Zend\Db\Adapter\Driver\ResultInterface;
use Fitness\Model\Entity\Empresa;

class Empresatabla
{
	protected $adapter;
	public function __construct(Adapter $a)
	{
		$this->adapter=$a;
	}
	public function insertarEmpresa(Empresa $emp=NULL)
	{
		try
		{
			$var=array(
					$emp->getNombre_Em()
					);
			$sql = $this->adapter->query('CALL pa_insertaEmpresa (?,@msje)',$var);
			$resulta =   $this->adapter->query('SELECT @msje as mensaje',Adapter::QUERY_MODE_EXECUTE);
	        $datos	=	$resulta->toArray();
			if (strcmp($datos[0]['mensaje'], null)==0){
				return "Empresa Registrada.";
			}else{
				return $datos[0]['mensaje'];
			}
		}catch(Zend_Exception $e){
			return $e->getMessage();
		}
	}
	public function actualizarEmpresa(Empresa $emp=NULL)
	{
		try
		{
			$var=array(
						$emp->getNombre_Em(),
					);
			$sql = $this->adapter->query('CALL pa_actualizaEmpresa(?,?)',$var);
			return 'Empresa Actualizada';
		}catch(Zend_Exception $e){
			return $e->getMessage();
		}
	}
	public function listaEmpresa()
	{
		try{
			$sql 	=	$this->adapter->query('CALL pa_listaEmpresa',Adapter::QUERY_MODE_EXECUTE);
			// $result	=	$sql->toArray();
			$result	=	array();
			foreach ($sql->toArray() as $value) {
				$result[$value['id_emp']]=$value['nombre_emp'];
			}
			return $result;
		}catch(Zend_Exception $e){
			return $e->getMessage();
		}
	}
	public function leeEmpresa($id)
	{
		try{
			$var		=	array($id);
			$sql 		= $this->adapter->query('CALL pa_leeEmpresa (?)',$var);
			$result		=	$sql->toArray();
			return $result;
		}catch(Zend_Exception $e){
			return $e->getMessage();
		}
	}
	
}
?>