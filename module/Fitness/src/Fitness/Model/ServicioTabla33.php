<?php
namespace Fitness\Model;

use Zend\Db\Adapter\Adapter;
use Zend\Db\TableGateway\AbstractTableGateway;
use Zend\Db\Sql\Select;
use Fitness\Model\Entity\Servicio;
class ServicioTabla33 extends AbstractTableGateway
{
	public function __construct(Adapter $adapter = null, $databaseSchema = null) {
		$this->adapter = $adapter;
	}
	// public function insertarServicio(servicio $ser=NULL,$datosXML,$sucXML)
	// {
	// 	try
	// 	{
	// 		$xml = new \DomDocument('1.0', 'UTF-8');

	// 		$root = $xml->createElement('lista');
	// 		$root = $xml->appendChild($root);

	// 		if (is_array($datosXML))
	// 		{
	// 			foreach ($datosXML as $value)
	// 			{
	// 				$horario=$xml->createElement('horario');
	// 				$horario =$root->appendChild($horario);

	// 					$sucursal=$xml->createElement('sucursal',$value['sucursal']);
	// 					$sucursal =$horario->appendChild($sucursal);

	// 					$personal=$xml->createElement('personal',$value['personal']);
	// 					$personal =$horario->appendChild($personal);

	// 				if (is_array($value['detalle']))
	// 				{
	// 					foreach ($value['detalle'] as $val)
	// 					{
	// 						$detalle=$xml->createElement('detalle');
	// 						$detalle =$horario->appendChild($detalle);
	// 							$dia=$xml->createElement('dia',$val['dia']);
	// 							$dia =$detalle->appendChild($dia);
	// 							$ini=$xml->createElement('ini',$val['ini']);
	// 							$ini =$detalle->appendChild($ini);
	// 							$fin=$xml->createElement('fin',$val['fin']);
	// 							$fin =$detalle->appendChild($fin);
	// 						// var_dump($val);
	// 					}
	// 				}
	// 			}
	// 			$xml->formatOutput = true;
	// 			$xml->saveXML();
	// 		}

	// 		$xmlSuc = new \DomDocument('1.0', 'UTF-8');

	// 		$root = $xmlSuc->createElement('lista');
	// 		$root = $xmlSuc->appendChild($root);

	// 		foreach ($sucXML as $value)
	// 		{
	// 			$sucursal=$xmlSuc->createElement('sucursal',$value);
	// 			$sucursal =$root->appendChild($sucursal);
	// 		}
	// 		$xmlSuc->formatOutput = true;
	// 		$xmlSuc->saveXML();

	// 		$var=array(
	// 					$ser->getNombre_ser(),
	// 					$ser->getMontoBase_ser(),
	// 					$ser->getTipo_ser(),
	// 					$ser->getDiasCupon_ser(),
	// 					$ser->getFreezing_ser(),
	// 					$ser->getMontoInicial_ser(),
	// 					$ser->getfechaReg_ser(),
	// 					$ser->getPromocion_ser(),
	// 					$ser->getEmpresa_id_emp(),
	// 					$ser->getPersonal_id_per(),
	// 					$xmlSuc->saveXML(),
	// 					$xml->saveXML()
	// 					);
	// 		// var_dump($var);
	// 		$sql=$this->adapter->query('CALL pa_insertaServicioHorario(?,?,?,?,?,?,?,?,?,?,?,?,@msje)', $var);
	// 		// $sql->fetchAll(PDO::FETCH_ASSOC);
	// 		// $resulta=$this->adapter->query('SELECT @msje as mensaje',Adapter::QUERY_MODE_EXECUTE);
	// 		// $datos	=	$resulta->toArray();
	// 		// if (strcmp($datos[0]['mensaje'], null)==0){
	// 			return "Servicio Registrado.";
	// 		// }else{
	// 		// 	return $datos[0]['mensaje'];
	// 		// }
	// 	}catch(Zend_Db_Adapter_Exception $e){
	// 		return $e->getMessage();
	// 	}catch (Zend_Exception $e) {
	// 		return $e->getMessage();
	// 	}
	// }

	// public function insertarPlan(servicio $ser=NULL,$datosXML,$sucXML,$planXML)
	// {
	// 	try
	// 	{
	// 		$xml = new \DomDocument('1.0', 'UTF-8');

	// 		$root = $xml->createElement('lista');
	// 		$root = $xml->appendChild($root);

	// 		if (is_array($datosXML))
	// 		{
	// 			foreach ($datosXML as $value)
	// 			{
	// 				$horario=$xml->createElement('horario');
	// 				$horario =$root->appendChild($horario);

	// 					$sucursal=$xml->createElement('sucursal',$value['sucursal']);
	// 					$sucursal =$horario->appendChild($sucursal);

	// 					$personal=$xml->createElement('personal',$value['personal']);
	// 					$personal =$horario->appendChild($personal);

	// 				if (is_array($value['detalle']))
	// 				{
	// 					foreach ($value['detalle'] as $val)
	// 					{
	// 						$detalle=$xml->createElement('detalle');
	// 						$detalle =$horario->appendChild($detalle);
	// 							$dia=$xml->createElement('dia',$val['dia']);
	// 							$dia =$detalle->appendChild($dia);
	// 							$ini=$xml->createElement('ini',$val['ini']);
	// 							$ini =$detalle->appendChild($ini);
	// 							$fin=$xml->createElement('fin',$val['fin']);
	// 							$fin =$detalle->appendChild($fin);
	// 						// var_dump($val);
	// 					}
	// 				}
	// 			}
	// 			$xml->formatOutput = true;
	// 			$xml->saveXML();
	// 		}

	// 		$xmlSuc = new \DomDocument('1.0', 'UTF-8');

	// 		$root = $xmlSuc->createElement('lista');
	// 		$root = $xmlSuc->appendChild($root);

	// 		foreach ($sucXML as $value)
	// 		{
	// 			$sucursal=$xmlSuc->createElement('sucursal',$value);
	// 			$sucursal =$root->appendChild($sucursal);
	// 		}

	// 		$xmlSuc->formatOutput = true;
	// 		$xmlSuc->saveXML();

	// 		$xmlPlan = new \DomDocument('1.0', 'UTF-8');

	// 		$root = $xmlPlan->createElement('lista');
	// 		$root = $xmlPlan->appendChild($root);

	// 		foreach ($sucXML as $value)
	// 		{
	// 			$sucursal=$xmlPlan->createElement('servicio',$value);
	// 			$sucursal =$root->appendChild($sucursal);
	// 		}
	// 		$xmlPlan->formatOutput = true;
	// 		$xmlPlan->saveXML();

	// 		$var=array(
	// 					$ser->getNombre_ser(),
	// 					$ser->getMontoBase_ser(),
	// 					$ser->getTipo_ser(),
	// 					$ser->getDiasCupon_ser(),
	// 					$ser->getFreezing_ser(),
	// 					$ser->getMontoInicial_ser(),
	// 					$ser->getfechaReg_ser(),
	// 					$ser->getPromocion_ser(),
	// 					$ser->getTipoDuracion_ser(),
	// 					$ser->getDuracion_ser(),
	// 					$ser->getCuota_ser(),
	// 					$ser->getPagoMaximo_ser(),
	// 					$ser->getPersonal_id_per(),
	// 					$xmlPlan->saveXML(),
	// 					$xmlSuc->saveXML(),
	// 					$xml->saveXML()
	// 					);
	// 		// var_dump($var);
	// 		$sql=$this->adapter->query('CALL pa_insertaPlanHorarioB(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,@msje)', $var);
	// 		// $sql->fetchAll(PDO::FETCH_ASSOC);
	// 		// $resulta=$this->adapter->query('SELECT @msje as mensaje',Adapter::QUERY_MODE_EXECUTE);
	// 		// $datos	=	$resulta->toArray();
	// 		// if (strcmp($datos[0]['mensaje'], null)==0){
	// 			return "Plan Registrado.";
	// 		// }else{
	// 		// 	return $datos[0]['mensaje'];
	// 		// }
	// 	}catch(Zend_Db_Adapter_Exception $e){
	// 		throw $e;
	// 	}
	// }

	// public function listaServicioBase()
	// {
	// 	try{
	// 		$sql 	=	$this->adapter->query('CALL pa_listaServicioBase',Adapter::QUERY_MODE_EXECUTE);
	// 		// $result	=	$sql->toArray();
	// 		$result	=	array();
	// 		foreach ($sql->toArray() as $value) {
	// 			$result[$value['id_Serv']]=$value['nombre_Serv'];
	// 		}
	// 		return $result;
	// 	}catch(Zend_Exception $e){
	// 		throw $e;	
	// 	}
	// }
	public function listaServicio()
	{
		try{
			// $sql 	=	$this->adapter->query('CALL pa_consolidadoPlan(15)',Adapter::QUERY_MODE_EXECUTE);
			// echo '<br /><br /><br />';
			// var_dump($sql->toArray());
			// $sql 	=	$this->adapter->query('CALL pa_listaServicio',Adapter::QUERY_MODE_EXECUTE);
			// // $result	=	$sql->toArray();
			// $result	=	array();
			// foreach ($sql->toArray() as $value) {
			// 	$result[$value['id_Serv']]=$value['nombre_Serv'];
			// }
			// return $result;
			// 
			
			$driver = $this->dbAdapter->getDriver();
			$connection = $driver->getConnection();

			$result = $connection->execute('CALL pa_consolidadoPlan(15)');
			$statement = $result->getResource();

			// Result set 1
			$resultSet1 = $statement->fetchAll(PDO::FETCH_OBJ);
			$datos = $statement-->fetchAll(PDO::FETCH_ASSOC);
			var_dump($resultSet1);
			foreach ($resultSet1 as $row) {
				// Using \PDO::FETCH_OBJ with the fetchAll() method gives us a stdClass with the columns as properties
				$something = $row->some_column;
			}

			// Result set 2
			$statement->nextRowSet(); // Advance to the second result set
			$resultSet2 = $statement->fetchAll(\PDO::FETCH_OBJ);
			var_dump($resultSet2);

			// foreach ($resultSet2 as $row) {
			// 	/* Do something */
			// }

		}catch(Zend_Exception $e){
			return $e->getMessage();
		}
	}

	
}
?>