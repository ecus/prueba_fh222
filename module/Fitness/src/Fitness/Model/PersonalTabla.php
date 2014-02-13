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
	public function insertarPersonal(Personal $per)
	{
		$var1	=	$per->getDni();
		$var2	=	$per->getNombre();
		$var3	=	$per->getApPaterno();
		$var4	=	$per->getApMaterno();
		$var5	=	$per->getFechaNac();
		$var6	=	$per->getSexo();
		$var7	=	$per->getDireccion_per();
		$var8	=	$per->getTelfCasa_per();
		$var9	=	$per->getTelfMovil_per();
		$var10	=	$per->getEmail_per();
		$var11	=	$per->getSucursal();
		$var12	=	$per->getCargo();

		$dbAdapter=$this->getAdapter();
		$stmt = $dbAdapter->createStatement();
		// $stmt->prepare('CALL pa_insertaPersonal(?,?,?,?,?,?,?,?,?,?,@msje)');
		$stmt->prepare('CALL pa_insertaPersonal(?,?,?,?,?,?,?,?,?,?,?,?,@msje)');
		$stmt->getResource()->bindParam(1, $var1);
		$stmt->getResource()->bindParam(2, $var2);
		$stmt->getResource()->bindParam(3, $var3);
		$stmt->getResource()->bindParam(4, $var4);
		$stmt->getResource()->bindParam(5, $var5);
		$stmt->getResource()->bindParam(6, $var6,\PDO::PARAM_INT);
		$stmt->getResource()->bindParam(7, $var7);
		$stmt->getResource()->bindParam(8, $var8);
		$stmt->getResource()->bindParam(9, $var9);
		$stmt->getResource()->bindParam(10, $var10);
		$stmt->getResource()->bindParam(11, $var11,\PDO::PARAM_INT);
		$stmt->getResource()->bindParam(12, $var12,\PDO::PARAM_INT);
		$stmt->execute();
		$stmt2  = $dbAdapter->createStatement();
		$stmt2->prepare("SELECT @msje AS mensaje");
		$result = $stmt2->execute();
		$output = $result->current();
		return $output['mensaje'];
	}
	public function insertarPersonalUsuario(Personal $per)
	{
		$bcrypt			= 	new Bcrypt();

		$var1	=	$per->getDni();
		$var2	=	$per->getNombre();
		$var3	=	$per->getApPaterno();
		$var4	=	$per->getApMaterno();
		$var5	=	$per->getFechaNac();
		$var6	=	$per->getSexo();
		$var7	=	$per->getDireccion_per();
		$var8	=	$per->getTelfCasa_per();
		$var9	=	$per->getTelfMovil_per();
		$var10	=	$per->getEmail_per();
		$var11	=	$per->getSucursal();
		$var12	=	$per->getCargo();
		$var13	=	$per->getUser();
		$var14	=	$bcrypt->create($var3);

		$dbAdapter=$this->getAdapter();
		$stmt = $dbAdapter->createStatement();
		// $stmt->prepare('CALL pa_insertaPersonalUsuario(?,?,?,?,?,?,?,?,?,?,?,?,@msje)');
		$stmt->prepare('CALL pa_insertaPersonalUsuario(?,?,?,?,?,?,?,?,?,?,?,?,?,?,@msje)');
		$stmt->getResource()->bindParam(1, $var1);
		$stmt->getResource()->bindParam(2, $var2);
		$stmt->getResource()->bindParam(3, $var3);
		$stmt->getResource()->bindParam(4, $var4);
		$stmt->getResource()->bindParam(5, $var5);
		$stmt->getResource()->bindParam(6, $var6,\PDO::PARAM_INT);
		$stmt->getResource()->bindParam(7, $var7);
		$stmt->getResource()->bindParam(8, $var8);
		$stmt->getResource()->bindParam(9, $var9);
		$stmt->getResource()->bindParam(10, $var10);
		$stmt->getResource()->bindParam(11, $var11,\PDO::PARAM_INT);
		$stmt->getResource()->bindParam(12, $var12,\PDO::PARAM_INT);
		$stmt->getResource()->bindParam(13, $var13);
		$stmt->getResource()->bindParam(14, $var14);
		$stmt->execute();

		$stmt2	=	$dbAdapter->createStatement();
		$stmt2->prepare("SELECT @msje AS mensaje");
		$result =	$stmt2->execute();
		$output =	$result->current();
		return $output['mensaje'];
	}
	public function actualizarPersonal(Personal $per)
	{
		$var1	=	$per->getId();
		$var2	=	$per->getDni();
		$var3	=	$per->getNombre();
		$var4	=	$per->getApPaterno();
		$var5	=	$per->getApMaterno();
		$var6	=	$per->getFechaNac();
		$var7	=	$per->getSexo();
		$var8	=	$per->getDireccion_per();
		$var9	=	$per->getTelfCasa_per();
		$var10	=	$per->getTelfMovil_per();
		$var11	=	$per->getEmail_per();
		$var12	=	$per->getSucursal();
		$var13	=	$per->getCargo();
		$var14	=	$per->getEstado();

		$dbAdapter=$this->getAdapter();
		$stmt = $dbAdapter->createStatement();
		// $stmt->prepare('CALL pa_actualizaPersonal(?,?,?,?,?,?,?,?,?,?,?,?,@msje)');
		$stmt->prepare('CALL pa_actualizaPersonal(?,?,?,?,?,?,?,?,?,?,?,?,?,?,@msje)');
		$stmt->getResource()->bindParam(1, $var1);
		$stmt->getResource()->bindParam(2, $var2);
		$stmt->getResource()->bindParam(3, $var3);
		$stmt->getResource()->bindParam(4, $var4);
		$stmt->getResource()->bindParam(5, $var5);
		$stmt->getResource()->bindParam(6, $var6);
		$stmt->getResource()->bindParam(7, $var7,\PDO::PARAM_INT);
		$stmt->getResource()->bindParam(8, $var8);
		$stmt->getResource()->bindParam(9, $var9);
		$stmt->getResource()->bindParam(10, $var10);
		$stmt->getResource()->bindParam(11, $var11);
		$stmt->getResource()->bindParam(12, $var12,\PDO::PARAM_INT);
		$stmt->getResource()->bindParam(13, $var13,\PDO::PARAM_INT);
		$stmt->getResource()->bindParam(14, $var14,\PDO::PARAM_INT);
		$stmt->execute();

		$stmt2	=	$dbAdapter->createStatement();
		$stmt2->prepare("SELECT @msje AS mensaje");
		$result =	$stmt2->execute();
		$output =	$result->current();
		return $output['mensaje'];
	}
	public function actualizarPersonalUsuario(Personal $per,$estado)
	{
		$var1	=	$per->getId();
		$var2	=	$per->getDni();
		$var3	=	$per->getNombre();
		$var4	=	$per->getApPaterno();
		$var5	=	$per->getApMaterno();
		$var6	=	$per->getFechaNac();
		$var7	=	$per->getSexo();
		$var8	=	$per->getDireccion_per();
		$var9	=	$per->getTelfCasa_per();
		$var10	=	$per->getTelfMovil_per();
		$var11	=	$per->getEmail_per();
		$var12	=	$per->getSucursal();
		$var13	=	$per->getCargo();
		$var14	=	$per->getEstado();
		$var15	=	$estado;



		$dbAdapter=$this->getAdapter();
		$stmt = $dbAdapter->createStatement();
		// $stmt->prepare('CALL pa_actualizaPersonalUsuario(?,?,?,?,?,?,?,?,?,?,?,?,?,@msje)');
		$stmt->prepare('CALL pa_actualizaPersonalUsuario(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,@msje)');
		$stmt->getResource()->bindParam(1, $var1);
		$stmt->getResource()->bindParam(2, $var2);
		$stmt->getResource()->bindParam(3, $var3);
		$stmt->getResource()->bindParam(4, $var4);
		$stmt->getResource()->bindParam(5, $var5);
		$stmt->getResource()->bindParam(6, $var6);
		$stmt->getResource()->bindParam(7, $var7,\PDO::PARAM_INT);
		$stmt->getResource()->bindParam(8, $var8);
		$stmt->getResource()->bindParam(9, $var9);
		$stmt->getResource()->bindParam(10, $var10);
		$stmt->getResource()->bindParam(11, $var11);
		$stmt->getResource()->bindParam(12, $var12,\PDO::PARAM_INT);
		$stmt->getResource()->bindParam(13, $var13,\PDO::PARAM_INT);
		$stmt->getResource()->bindParam(14, $var14,\PDO::PARAM_INT);
		$stmt->getResource()->bindParam(15, $var15,\PDO::PARAM_INT);
		$stmt->execute();

		$stmt2	=	$dbAdapter->createStatement();
		$stmt2->prepare("SELECT @msje AS mensaje");
		$result =	$stmt2->execute();
		$output =	$result->current();
		return $output['mensaje'];
	}
	public function buscaPersonal($dni)
	{
		try {
			$dbAdapter	=	$this->getAdapter();
			$stmt		=	$dbAdapter->createStatement();
			$stmt->prepare('CALL pa_buscaPersonal(?)');
			$stmt->getResource()->bindParam(1, $dni);
			$stmt->execute();
			$info		=	$stmt->getResource()->fetchAll(\PDO::FETCH_OBJ);
			return $info[0];
		} catch (Exception $e) {
			throw $e;
		}
	}
	public function verPersonal($dni)
	{
		try {
			$dbAdapter	=	$this->getAdapter();
			$stmt		=	$dbAdapter->createStatement();
			$stmt->prepare('CALL pa_verPersonal(?)');
			$stmt->getResource()->bindParam(1, $dni);
			$stmt->execute();
			$info		=	$stmt->getResource()->fetchAll(\PDO::FETCH_OBJ);
			return $info[0];
		} catch (Exception $e) {
			throw $e;
		}
	}
	public function verificaClave($per)
	{
		try {
			$var1		=	$per->getId();
			$var2		=	$per->getClave();

			$dbAdapter	=	$this->getAdapter();
			$stmt		=	$dbAdapter->createStatement();
			$stmt->prepare('CALL pa_verificaClavePersonal(?)');
			$stmt->getResource()->bindParam(1, $var1);
			$stmt->execute();
			$info		=	$stmt->getResource()->fetchAll(\PDO::FETCH_OBJ);

			$bcrypt			= 	new Bcrypt();

			if($bcrypt->verify($var2,$info[0]->clave_UPer)) {
				return true;
			}else{
				return false;
			}
		} catch (Exception $e) {
			throw $e;
		}
	}
	/*
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
			$salida[$sql->current()['id_per']]	=	$sql->current()['apellidoPaterno_Per'].' '.$sql->current()['apellidoMaterno_Per'].', '.$sql->current()['nombres_per'];
		}
		return $salida;
	}
	public function loginPersonal($nombre,$clave)
	{
		try {
			$dbAdapter	=	$this->getAdapter();
			$stmt		=	$dbAdapter->createStatement();
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

				if($bcrypt->verify($clave,$claveSegura)) {
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
	public function actualizaDatosPersonal($per)
	{
		try {
			$dbAdapter	=	$this->getAdapter();

			$bcrypt			= 	new Bcrypt();

			$var1	=	$per->getId();
			$var2	=	$per->getDni();
			$var3	=	$per->getFechaNac();
			$var4	=	$per->getDireccion_per();
			$var5	=	$per->getTelfCasa_per();
			$var6	=	$per->getTelfMovil_per();
			$var7	=	$per->getEmail_per();
			$var8	=	$bcrypt->create($per->getClave());

			$dbAdapter=$this->getAdapter();
			$stmt = $dbAdapter->createStatement();
			$stmt->prepare('CALL pa_actualizaDatosPersonal(?,?,?,?,?,?,?,?,@msje)');
			$stmt->getResource()->bindParam(1, $var1);
			$stmt->getResource()->bindParam(2, $var2);
			$stmt->getResource()->bindParam(3, $var3);
			$stmt->getResource()->bindParam(4, $var4);
			$stmt->getResource()->bindParam(5, $var5);
			$stmt->getResource()->bindParam(6, $var6);
			$stmt->getResource()->bindParam(7, $var7);
			$stmt->getResource()->bindParam(8, $var8);
			$stmt->execute();

			$stmt2	=	$dbAdapter->createStatement();
			$stmt2->prepare("SELECT @msje AS mensaje");
			$result =	$stmt2->execute();
			$output =	$result->current();
			return $output['mensaje'];
		} catch (Exception $e) {
			throw $e;
		}
	}
}