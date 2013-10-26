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

		$dbAdapter=$this->getAdapter();
		$stmt = $dbAdapter->createStatement();
		// `pa_insertaSocio`(''
		// 	 dni,tipodoc, pat, mat,
		//   nom,sexo,fechanac,mail,
		//   ecivil, distrito,dir,fevisita,feregis,
		//   feinvitacion,estado,referido,empresa,
		//   personal,xml, @@@msje ) 
		//   pa_insertaSocio(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,@a)
		//   pa_insertaSocio(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,@a)
		//   								(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,@a)
		  								
		$stmt->prepare('CALL pa_insertaSocio(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,@a)'); 
		
		// // $stmt->prepare('CALL pa_insertSocio (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,@a)'); 
		// // $stmt->getResource()->bindParam(':id', $id, \PDO::PARAM_INT); 
		
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
		$stmt->getResource()->bindParam(16, $var16,\PDO::PARAM_INT);
		$stmt->getResource()->bindParam(17, $var17,\PDO::PARAM_INT);
		$stmt->getResource()->bindParam(18, $var18,\PDO::PARAM_INT);
		$stmt->getResource()->bindParam(19, $var19);		
		$resultado=$stmt->execute();
        
		$resulta =   $this->adapter->query('SELECT @a as mensaje',Adapter::QUERY_MODE_EXECUTE);
		$datos	=	$resulta->toArray();
		return $datos[0]['mensaje'];
	}
	public function insertaSocioUsuario(Socio $p,$alias)
	{
		$datos=array(
				$p->getNumerodoc(),
				$p->getDocumento(),
				$p->getPaterno(),
				$p->getMaterno(),
				$p->getNombres(),
				$p->getSexo(),
				$p->getFechanac(),
				$p->getEmail(),
				$p->getTelefono(),
				$p->getMovil(),
				$p->getEmergencia(),
				$p->getEcivil(),
				$p->getFechavisita(),
				$p->getFecharegistro(),
				$p->getFechainv(),
				$p->getEstado(),
				$p->getReferido(),
				$p->getEmpresa(),
				$p->getPersonal(),
				$alias,
				
				);
        $result =	$this->adapter->query('call pa_insertaSocioUsuarios(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,@a)',$datos);
        $resulta =   $this->adapter->query('SELECT @a as mensaje',Adapter::QUERY_MODE_EXECUTE);
        $datos	=	$resulta->toArray();
		if (strcmp($datos[0]['mensaje'], null)==0){
				return "Socio Registrado.";
			}else{
				return $datos[0]['mensaje'];
			}
	}

	public function versocio($cmbsocio)
	{
		try{
			$var 		= array($cmbsocio);
			$sql 		=	$this->adapter->query('CALL pa_buscarsocio (?)',$var);
			$result		=	$sql->toArray();
			return $result;
		}catch(Zend_Exception $e){
			return $e->getMessage();
		}
	}
	public function listaEmpresas()
	{
		try{
			$sql 	=	$this->adapter->query('CALL pa_listarEmpresas',Adapter::QUERY_MODE_EXECUTE);
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
	public function buscaid()
	{
		$sql = $this->adapter->query('SELECT MAX( id_Soc +1 ) AS id FROM socio');
	}
}