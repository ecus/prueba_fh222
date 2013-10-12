<?php
namespace Fitness\Model;

use Zend\Db\ResultSet\ResultSet;
use Zend\Db\Adapter\Adapter;
use Zend\Db\Sql\Sql;
use Zend\Db;
use Zend\Db\Adapter\Driver\ConnectionInterface;
use Zend\Db\Adapter\Driver\StatementInterface;
use Zend\Db\Adapter\Driver\ResultInterface;
use Fitness\Model\Entity\Personal;

class PersonalTabla
{
	protected $adapter;
	public function __construct(Adapter $a)
	{
		$this->adapter=$a;
	}
	public function insertarPersonal(Personal $per)
	{
		$datos=array(
				$per->getDni(),
				$per->getNombre(),
				$per->getApPaterno(),
				$per->getApMaterno(),
				$per->getFechaNac(),
				$per->getSexo(),
				$per->getDireccion_per(),
				$per->getTelfCasa_per(),
				$per->getTelfMovil_per(),
				$per->getEmail_per()
				);
        $result =	$this->adapter->query('CALL pa_insertaPersonal(?,?,?,?,?,?,?,?,?,?,@a)',$datos);
        $resulta =   $this->adapter->query('SELECT @a as mensaje',Adapter::QUERY_MODE_EXECUTE);
        $datos	=	$resulta->toArray();
		if (strcmp($datos[0]['mensaje'], null)==0){
				return "Personal Registrado.";
			}else{
				return $datos[0]['mensaje'];
			}
	}
	public function insertarPersonalUsuario(Personal $per,$alias)
	{
		$datos=array(
				$per->getDni(),
				$per->getNombre(),
				$per->getApPaterno(),
				$per->getApMaterno(),
				$per->getFechaNac(),
				$per->getSexo(),
				$per->getDireccion_per(),
				$per->getTelfCasa_per(),
				$per->getTelfMovil_per(),
				$per->getEmail_per(),
				$alias
				);
        $result =	$this->adapter->query('CALL pa_insertaPersonalUsuario(?,?,?,?,?,?,?,?,?,?,?,@a)',$datos);
        $resulta =   $this->adapter->query('SELECT @a as mensaje',Adapter::QUERY_MODE_EXECUTE);
        $datos	=	$resulta->toArray();
		if (strcmp($datos[0]['mensaje'], null)==0){
				return "Personal Registrado.";
			}else{
				return $datos[0]['mensaje'];
			}
	}
	public function actualizarPersonalUsuario(Personal $per,$estado)
	{
		$datos=array(
				$per->getId(),
				$per->getDni(),
				$per->getNombre(),
				$per->getApPaterno(),
				$per->getApMaterno(),
				$per->getFechaNac(),
				$per->getSexo(),
				$per->getDireccion_per(),
				$per->getTelfCasa_per(),
				$per->getTelfMovil_per(),
				$per->getEmail_per(),
				$per->getEstado(),
				$estado
				);
        $result =	$this->adapter->query('CALL pa_actualizaPersonalUsuario(?,?,?,?,?,?,?,?,?,?,?,?,?,@a)',$datos);
        $resulta =   $this->adapter->query('SELECT @a as mensaje',Adapter::QUERY_MODE_EXECUTE);
        $datos	=	$resulta->toArray();
		return $datos[0]['mensaje'];
	}
	public function actualizarPersonal(Personal $per,$alias)
	{
		$datos=array(
				$per->getId(),
				$per->getDni(),
				$per->getNombre(),
				$per->getApPaterno(),
				$per->getApMaterno(),
				$per->getFechaNac(),
				$per->getSexo(),
				$per->getDireccion_per(),
				$per->getTelfCasa_per(),
				$per->getTelfMovil_per(),
				$per->getEmail_per(),
				$per->getEstado()
				);
        $result =	$this->adapter->query('CALL pa_actualizaPersonal(?,?,?,?,?,?,?,?,?,?,?,?,@a)',$datos);
        $resulta =   $this->adapter->query('SELECT @a as mensaje',Adapter::QUERY_MODE_EXECUTE);
        $datos	=	$resulta->toArray();
		return $datos[0]['mensaje'];
	}
	public function buscaPersonal($dni)
	{
		$datos	=	array($dni);
        $resulta=	$this->adapter->query('CALL pa_buscaPersonal(?)',$datos);
        $datos	=	$resulta->toArray();
		if ($datos== null){
				return "No se encontro ningun registro con el valor ingresado.";
			}else{
				return $datos;
			}
	}
	public function generaUsuario(Personal $p)
	{
		var_dump($p);
	}
	public function listaPersonal()
	{
		$sql 	=	$this->adapter->query('CALL pa_listaPersonal',Adapter::QUERY_MODE_EXECUTE);
		// $result	=	$sql->toArray();
		$result	=	array();
		foreach ($sql->toArray() as $value) {
			$result[$value['id_per']]=$value['apellidoPaterno_Per']. ' '.$value['apellidoMaterno_Per'].', '.$value['nombres_per'];
		}
		return $result;
	}
}
?>