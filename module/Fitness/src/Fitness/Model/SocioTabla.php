<?php
namespace Fitness\Model;

use Zend\Db\TableGateway\TableGateway;
use Zend\Db\Adapter\Adapter;

use Fitness\Model\Entity\Socio;

class SocioTabla extends TableGateway
{
	public function __construct(Adapter $adapter = null, $databaseSchema = null, ResultSet $selectResultPrototype = null)
	{
		return parent::__construct('', $adapter, $databaseSchema,
			$selectResultPrototype);
	}
	public function insertaSocio(Socio $p, $xmltel)
	{
		$xml = new \DomDocument('1.0', 'UTF-8');

		$root = $xml->createElement('lista');
		$root = $xml->appendChild($root);
		if (is_array($xmltel))
			{
				foreach ($xmltel as $value)
				{
					$telefono=$xml->createElement('telefono');
					$telefono =$root->appendChild($telefono);
						if (isset($value['numeroTel'])) {
							$numero=$xml->createElement('numero',$value['numeroTel']);
							$numero =$telefono->appendChild($numero);

							$tipo=$xml->createElement('tipo',$value['tipoTel']);
							$tipo =$telefono->appendChild($tipo);

							$emergencia=$xml->createElement('emergencia',$value['emergenciaTel']);
							$emergencia =$telefono->appendChild($emergencia);

							$nombre=$xml->createElement('nombre',$value['nombreTel']);
							$nombre =$telefono->appendChild($nombre);

							$parentesco=$xml->createElement('parentesco',$value['parentescoTel']);
							$parentesco =$telefono->appendChild($parentesco);
						}
				}
				$xml->formatOutput = true;
				$xml->saveXML();
			}

		$var1=$p->getnumerodoc();
		$var2=$p->getdocumento();
		$var3=$p->getpaterno();
		$var4=$p->getmaterno();

		$var5=$p->getnombres();
		$var6=$p->getsexo();
		$var7=$p->getfechanac();
		$var8=$p->getemail();

		$var9=$p->getecivil();
		$var10=$p->getDistrito();
		$var11=$p->getDireccion();
		$var12=$p->getfechavisita();
		$var13=$p->getfecharegistro();

		$var14=$p->getfechainv();
		$var15=$p->getestado();
		$var16=$p->getreferido();
		$var17=$p->getempresa();

		$var18=$p->getpersonal();
		$var19=$xml->saveXML();

		// var_dump($p);
		$dbAdapter=$this->getAdapter();
		$stmt = $dbAdapter->createStatement();
		$stmt->prepare('CALL pa_insertaSocio(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,@msje)');
		$stmt->getResource()->bindParam(1, $var1);
		$stmt->getResource()->bindParam(2, $var2,\PDO::PARAM_INT);
		$stmt->getResource()->bindParam(3, $var3);
		$stmt->getResource()->bindParam(4, $var4);
		$stmt->getResource()->bindParam(5, $var5);
		$stmt->getResource()->bindParam(6, $var6,\PDO::PARAM_INT);
		$stmt->getResource()->bindParam(7, $var7);
		$stmt->getResource()->bindParam(8, $var8);
		$stmt->getResource()->bindParam(9, $var9,\PDO::PARAM_INT);
		$stmt->getResource()->bindParam(10, $var10,\PDO::PARAM_INT);
		$stmt->getResource()->bindParam(11, $var11);
		$stmt->getResource()->bindParam(12, $var12);
		$stmt->getResource()->bindParam(13, $var13);
		$stmt->getResource()->bindParam(14, $var14);
		$stmt->getResource()->bindParam(15, $var15);
		$stmt->getResource()->bindParam(16, $var16);
		$stmt->getResource()->bindParam(17, $var17,\PDO::PARAM_INT);
		$stmt->getResource()->bindParam(18, $var18,\PDO::PARAM_INT);
		$stmt->getResource()->bindParam(19, $var19);
		$resultado=$stmt->execute();

		$stmt2  = $dbAdapter->createStatement();
		$stmt2->prepare("SELECT @msje AS mensaje");
		$result = $stmt2->execute();
		$output = $result->current();
		return $output['mensaje'];
	}
	public function insertaSocioUsuario(Socio $p,$alias,$xmltel)
	{
		$xml = new \DomDocument('1.0', 'UTF-8');

		$root = $xml->createElement('lista');
		$root = $xml->appendChild($root);
		if (is_array($xmltel))
			{
				foreach ($xmltel as $value)
				{
					$telefono=$xml->createElement('telefono');
					$telefono =$root->appendChild($telefono);
						if (isset($value['numeroTel'])) {
							$numero=$xml->createElement('numero',$value['numeroTel']);
							$numero =$telefono->appendChild($numero);

							$tipo=$xml->createElement('tipo',$value['tipoTel']);
							$tipo =$telefono->appendChild($tipo);

							$emergencia=$xml->createElement('emergencia',$value['emergenciaTel']);
							$emergencia =$telefono->appendChild($emergencia);

							$nombre=$xml->createElement('nombre',$value['nombreTel']);
							$nombre =$telefono->appendChild($nombre);

							$parentesco=$xml->createElement('parentesco',$value['parentescoTel']);
							$parentesco =$telefono->appendChild($parentesco);
						}
				}
				$xml->formatOutput = true;
				$xml->saveXML();
			}

		$var1	=	$p->getNumerodoc();
		$var2	=	$p->getDocumento();
		$var3	=	$p->getPaterno();
		$var4	=	$p->getMaterno();
		$var5	=	$p->getNombres();
		$var6	=	$p->getSexo();
		$var7	=	$p->getFechanac();
		$var8	=	$p->getEmail();
		$var9	=	$p->getEcivil();
		$var10	=	$p->getFechavisita();
		$var11	=	$p->getFecharegistro();
		$var12	=	$p->getFechainv();
		$var13	=	$p->getEstado();
		$var14	=	$p->getReferido();
		$var15	=	$p->getEmpresa();
		$var16	=	$p->getPersonal();
		$var17	=	$alias;
		$var18	=	$xml->saveXML();

        // $result =	$this->adapter->query('call pa_insertaSocioUsuarios(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,@msje)',$datos);
		$dbAdapter=$this->getAdapter();
		$stmt = $dbAdapter->createStatement();
		$stmt->prepare('CALL pa_insertaSocioUsuarios(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,@msje)');
		$stmt->getResource()->bindParam(1, $var1);
		$stmt->getResource()->bindParam(2, $var2,\PDO::PARAM_INT);
		$stmt->getResource()->bindParam(3, $var3);
		$stmt->getResource()->bindParam(4, $var4);
		$stmt->getResource()->bindParam(5, $var5);
		$stmt->getResource()->bindParam(6, $var6,\PDO::PARAM_INT);
		$stmt->getResource()->bindParam(7, $var7);
		$stmt->getResource()->bindParam(8, $var8);
		$stmt->getResource()->bindParam(9, $var9,\PDO::PARAM_INT);
		$stmt->getResource()->bindParam(10, $var10);
		$stmt->getResource()->bindParam(11, $var11);
		$stmt->getResource()->bindParam(12, $var12);
		$stmt->getResource()->bindParam(13, $var13,\PDO::PARAM_INT);
		$stmt->getResource()->bindParam(14, $var14,\PDO::PARAM_INT);
		$stmt->getResource()->bindParam(15, $var15,\PDO::PARAM_INT);
		$stmt->getResource()->bindParam(16, $var16,\PDO::PARAM_INT);
		$stmt->getResource()->bindParam(17, $var17);
		$stmt->getResource()->bindParam(18, $var18);
		$resultado=$stmt->execute();

		$stmt2 = $dbAdapter->createStatement();
		$stmt2->prepare("SELECT @msje AS mensaje");
		$result = $stmt2->execute();
		$output = $result->current();
		return $output['mensaje'];
	}

	public function versocio($socio)
	{
		try {
			$dbAdapter	=	$this->getAdapter();
			$stmt		=	$dbAdapter->createStatement();
			$stmt->prepare('CALL pa_buscarsocio(?)');
			$stmt->getResource()->bindParam(1, $socio);
			$stmt->execute();
			$info		=	$stmt->getResource()->fetchAll(\PDO::FETCH_OBJ);
			return $info[0];
		} catch (Exception $e) {
			throw $e;
		}
	}
	public function listaSocio()
	{
		try {
			$dbAdapter	=	$this->getAdapter();
			$stmt		=	$dbAdapter->createStatement();
			$stmt->prepare('CALL pa_listaSocio()');
			$stmt->execute();
			$info		=	$stmt->getResource()->fetchAll(\PDO::FETCH_OBJ);
			return $info;
		} catch (Exception $e) {
			throw $e;
		}
	}
	public function listaEmpresas()
	{
		try{
			$dbAdapter	=	$this->getAdapter();
			$stmt		=	$dbAdapter->createStatement();
			$stmt->prepare('CALL pa_listarEmpresas()');
			$sql		=	$stmt->execute();
			while ($sql->next()) {
				$salida[$sql->current()['id_emp']]	=	$sql->current()['nombre_emp'];
			}
			return $salida;
		}catch(Zend_Exception $e){
			return $e->getMessage();
		}
	}
	public function buscaid()
	{
		$dbAdapter	=	$this->getAdapter();
		$sql =$dbAdapter->query('SELECT MAX( id_Soc +1 ) AS id FROM socio');
	}
}