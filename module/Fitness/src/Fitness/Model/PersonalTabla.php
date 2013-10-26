<?php
namespace Fitness\Model;

use Zend\Db\Adapter\Adapter;
use Zend\Crypt\Password\Bcrypt;
use Zend\Db\TableGateway\TableGateway;

use Fitness\Model\Entity\Personal;

class PersonalTabla extends TableGateway
{
	public function __construct(Adapter $adapter = null, $databaseSchema = null, ResultSet $selectResultPrototype = null)
	{
		return parent::__construct('', $adapter, $databaseSchema,
			$selectResultPrototype);
	}
	/*
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
	*/
	public function listaPersonal()
	{
		$dbAdapter	=	$this->getAdapter();
		$stmt 		=	$dbAdapter->createStatement();
		$stmt->prepare('CALL pa_listaPersonal()');
		$sql		=	$stmt->execute();
		while ($sql->next()) {
			// $result[$sql->current()['id_Serv']]=$sql->current()['nombre_Serv'];
			$salida[$sql->current()['id_per']]	=	$sql->current()['apellidoPaterno_Per'].' '.$sql->current()['apellidoMaterno_Per'].', '.$sql->current()['nombres_per'];
		}
		// var_dump($salida);
		return $salida;
	}
	public function loginPersonal($nombre,$clave)
	{
		try {
			$dbAdapter	=	$this->getAdapter();
			$stmt 		=	$dbAdapter->createStatement();
			$stmt->prepare('CALL pa_loginPersonal(?)');
			$stmt->getResource()->bindParam(1, $nombre);
			$stmt->execute();
			$result		=	$stmt->getResource()->fetchAll(\PDO::FETCH_OBJ);
			$salida		=	$result[0];
			$stmt->getResource()->closeCursor();

			if (isset($salida->msje)) {
				$msje	=	array('msje'=>$salida->msje);
				return	(object) $msje;
			} else {
				$bcrypt			= 	new Bcrypt();
				$id				=	$salida->Personal_id_Per;
				$claveSegura	=	$salida->clave_UPer;

				if($bcrypt->verify($clave, $claveSegura)) {
					$stmt2		= $dbAdapter->createStatement();
					$stmt2->prepare("CALL pa_loginPersonalId(?)");
					$stmt2->getResource()->bindParam(1, $id);
					$stmt2->execute();
					$result2	=	$stmt2->getResource()->fetchAll(\PDO::FETCH_OBJ);
					$salida2	=	$result2[0];
					$stmt2->getResource()->closeCursor();
					return $salida2;
				}else{
					$msje		=	array('msje'=>"Clave Incorrecta.\n");
					return	(object) $msje;
				}
			}
		} catch (Exception $e) {
			throw $e;
		}
	}
}
?>