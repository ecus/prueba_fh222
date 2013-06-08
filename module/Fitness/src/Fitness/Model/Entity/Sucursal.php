<?php
namespace Fitness\Model\Entity;

use Zend\Db\ResultSet\ResultSet;
use Zend\Db\Adapter\Adapter;
use Zend\Db\Sql\Sql;
use Zend\Db;
use Zend\Db\Adapter\Driver\ConnectionInterface;
use Zend\Db\Adapter\Driver\StatementInterface;
use Zend\Db\Adapter\Driver\ResultInterface;
class Sucursal
{
	private $id;
	private $display;
	private $ubicacion;
	private $telefono;
	private $adapter;
	public function __construct($datos=array(),Adapter $adapter=null)
	{
		$this->id		=	$datos['id'];
		$this->display	=	$datos['display'];
		$this->ubicacion=	$datos['ubicacion'];
		$this->telefono	=	$datos['telefono'];
		$this->adapter	=	$adapter;
	}
	public function getData()
	{
		$array=array(
			'id'		=>	$this->id,
			'display'	=>	$this->display,
			'ubicacion'	=>	$this->ubicacion,
			'telefono'	=>	$this->telefono
			);
		return $array;
	}
	public function insertaSucursal($datos=array())
	{
		$dis=$datos->display;
		$ubi=$datos->ubicacion;
		if (strcmp($datos->telefono, '')==0) {
			$tel=NULL;
		}else{
			$tel=$datos->telefono;
		}
		$var=array($dis,$ubi,$tel);
		$sql = $datos->adapter->query('CALL pa_insertaSucursal (?,?,?)',$var);
		return 'Sucursal Registrada con exito...!';
	}
	public function listaSucursal($datos=array())
	{
		$sql 	=	$datos->adapter->query('CALL pa_listaSucursal',Adapter::QUERY_MODE_EXECUTE);
		$result	=	$sql->toArray();
		return $result;
	}
}
?>