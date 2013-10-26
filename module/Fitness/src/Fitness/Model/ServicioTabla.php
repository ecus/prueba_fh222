<?php
namespace Fitness\Model;

use Zend\Db\TableGateway\TableGateway;
use Zend\Db\Adapter\Adapter;
use Fitness\Model\Entity\Servicio;

class ServicioTabla extends TableGateway
{
	public function __construct(Adapter $adapter = null, $databaseSchema = null, ResultSet $selectResultPrototype = null)
	{
		return parent::__construct('', $adapter, $databaseSchema,
			$selectResultPrototype);
	}
	public function insertarServicio(servicio $ser=NULL,$datosXML,$sucXML)
	{
		try
		{
			$xml = new \DomDocument('1.0', 'UTF-8');

			$root = $xml->createElement('lista');
			$root = $xml->appendChild($root);

			if (is_array($datosXML))
			{
				foreach ($datosXML as $value)
				{
					$horario=$xml->createElement('horario');
					$horario =$root->appendChild($horario);

						$sucursal=$xml->createElement('sucursal',$value['sucursal']);
						$sucursal =$horario->appendChild($sucursal);

						$personal=$xml->createElement('personal',$value['personal']);
						$personal =$horario->appendChild($personal);

					if (is_array($value['detalle']))
					{
						foreach ($value['detalle'] as $val)
						{
							$detalle=$xml->createElement('detalle');
							$detalle =$horario->appendChild($detalle);
								$dia=$xml->createElement('dia',$val['dia']);
								$dia =$detalle->appendChild($dia);
								$ini=$xml->createElement('ini',$val['ini']);
								$ini =$detalle->appendChild($ini);
								$fin=$xml->createElement('fin',$val['fin']);
								$fin =$detalle->appendChild($fin);
						}
					}
				}
				$xml->formatOutput = true;
				$xml->saveXML();
			}

			$xmlSuc = new \DomDocument('1.0', 'UTF-8');

			$root = $xmlSuc->createElement('lista');
			$root = $xmlSuc->appendChild($root);

			foreach ($sucXML as $value)
			{
				$sucursal=$xmlSuc->createElement('sucursal',$value);
				$sucursal =$root->appendChild($sucursal);
			}
			$xmlSuc->formatOutput = true;
			$xmlSuc->saveXML();

			$var=array(
						$ser->getNombre_ser(),
						$ser->getMontoBase_ser(),
						$ser->getTipo_ser(),
						$ser->getDiasCupon_ser(),
						$ser->getFreezing_ser(),
						$ser->getMontoInicial_ser(),
						$ser->getfechaReg_ser(),
						$ser->getPromocion_ser(),
						$ser->getPersonal_id_per(),
						$xmlSuc->saveXML(),
						$xml->saveXML()
						);
			$var1=$ser->getNombre_ser();
			$var2=$ser->getMontoBase_ser();
			$var3=$ser->getTipo_ser();
			$var4=$ser->getDiasCupon_ser();
			$var5=$ser->getFreezing_ser();
			$var6=$ser->getMontoInicial_ser();
			$var7=$ser->getfechaReg_ser();
			$var8=$ser->getPromocion_ser();
			$var9=$ser->getPersonal_id_per();
			$var10=$xmlSuc->saveXML();
			$var11=$xml->saveXML();

			$dbAdapter=$this->getAdapter();
			$stmt = $dbAdapter->createStatement();
			$stmt->prepare('CALL pa_insertaServicioHorario(?,?,?,?,?,?,?,?,?,?,?,@msje)');
			$stmt->getResource()->bindParam(1, $var1);
			$stmt->getResource()->bindParam(2, $var2);
			$stmt->getResource()->bindParam(3, $var3,\PDO::PARAM_INT);
			$stmt->getResource()->bindParam(4, $var4,\PDO::PARAM_INT);
			$stmt->getResource()->bindParam(5, $var5,\PDO::PARAM_INT);
			$stmt->getResource()->bindParam(6, $var6);
			$stmt->getResource()->bindParam(7, $var7);
			$stmt->getResource()->bindParam(8, $var8,\PDO::PARAM_INT);
			$stmt->getResource()->bindParam(9, $var9,\PDO::PARAM_INT);
			$stmt->getResource()->bindParam(10, $var10);
			$stmt->getResource()->bindParam(11, $var11);
			$aux=$stmt->execute();
			// $stmt->getResource()->fetchAll(\PDO::FETCH_OBJ);
			$stmt->getResource()->closeCursor();
			$stmt2  = $dbAdapter->createStatement();
			$stmt2->prepare("SELECT @msje AS mensaje");
			$result = $stmt2->execute();
			$output = $result->current();
			return $output['mensaje'];
		}catch(Zend_Db_Adapter_Exception $e){
			return $e->getMessage();
		}catch (Zend_Exception $e) {
			return $e->getMessage();
		}
	}
///////
	public function insertarPlan(servicio $ser=NULL,$datosXML,$sucXML,$planXML)
	{
		try
		{
			$xml = new \DomDocument('1.0', 'UTF-8');

			$root = $xml->createElement('lista');
			$root = $xml->appendChild($root);

			if (is_array($datosXML))
			{
				foreach ($datosXML as $value)
				{
					$horario=$xml->createElement('horario');
					$horario =$root->appendChild($horario);

						$sucursal=$xml->createElement('sucursal',$value['sucursal']);
						$sucursal =$horario->appendChild($sucursal);

						$personal=$xml->createElement('personal',$value['personal']);
						$personal =$horario->appendChild($personal);

					if (is_array($value['detalle']))
					{
						foreach ($value['detalle'] as $val)
						{
							$detalle=$xml->createElement('detalle');
							$detalle =$horario->appendChild($detalle);
								$dia=$xml->createElement('dia',$val['dia']);
								$dia =$detalle->appendChild($dia);
								$ini=$xml->createElement('ini',$val['ini']);
								$ini =$detalle->appendChild($ini);
								$fin=$xml->createElement('fin',$val['fin']);
								$fin =$detalle->appendChild($fin);
							// var_dump($val);
						}
					}
				}
				$xml->formatOutput = true;
				$xml->saveXML();
			}

			$xmlSuc = new \DomDocument('1.0', 'UTF-8');

			$root = $xmlSuc->createElement('lista');
			$root = $xmlSuc->appendChild($root);

			foreach ($sucXML as $value)
			{
				$sucursal=$xmlSuc->createElement('sucursal',$value);
				$sucursal =$root->appendChild($sucursal);
			}

			$xmlSuc->formatOutput = true;
			$xmlSuc->saveXML();

			$xmlPlan = new \DomDocument('1.0', 'UTF-8');

			$root = $xmlPlan->createElement('lista');
			$root = $xmlPlan->appendChild($root);
			foreach ($planXML as $value)
			{
				$sucursal=$xmlPlan->createElement('servicio',$value);
				$sucursal =$root->appendChild($sucursal);
			}
			$xmlPlan->formatOutput = true;
			$xmlPlan->saveXML();

			$var=array(
						$ser->getNombre_ser(),
						$ser->getMontoBase_ser(),
						$ser->getTipo_ser(),
						$ser->getDiasCupon_ser(),
						$ser->getFreezing_ser(),
						$ser->getMontoInicial_ser(),
						$ser->getfechaReg_ser(),
						$ser->getPromocion_ser(),
						$ser->getTipoDuracion_ser(),
						$ser->getDuracion_ser(),
						$ser->getCuota_ser(),
						$ser->getPagoMaximo_ser(),
						$ser->getPersonal_id_per(),
						$xmlPlan->saveXML(),
						$xmlSuc->saveXML(),
						$xml->saveXML()
						);
			// print_r($var);

			// $var=array(
						$var1=$ser->getNombre_ser();
						$var2=$ser->getMontoBase_ser();
						$var3=$ser->getTipo_ser();
						$var4=$ser->getDiasCupon_ser();
						$var5=$ser->getFreezing_ser();
						$var6=$ser->getMontoInicial_ser();
						$var7=$ser->getfechaReg_ser();
						$var8=$ser->getPromocion_ser();
						$var9=$ser->getTipoDuracion_ser();
						$var10=$ser->getDuracion_ser();
						$var11=$ser->getCuota_ser();
						$var12=$ser->getPagoMaximo_ser();
						$var13=$ser->getPersonal_id_per();
						$var14=$xmlPlan->saveXML();
						$var15=$xmlSuc->saveXML();
						$var16=$xml->saveXML();
			// 			);
			$dbAdapter=$this->getAdapter();
			$stmt = $dbAdapter->createStatement();
			$stmt->prepare('CALL pa_insertaPlanHorarioB(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,@msje)');
			$stmt->getResource()->bindParam(1, $var1);
			$stmt->getResource()->bindParam(2, $var2);
			$stmt->getResource()->bindParam(3, $var3,\PDO::PARAM_INT);
			$stmt->getResource()->bindParam(4, $var4,\PDO::PARAM_INT);
			$stmt->getResource()->bindParam(5, $var5,\PDO::PARAM_INT);
			$stmt->getResource()->bindParam(6, $var6);
			$stmt->getResource()->bindParam(7, $var7);
			$stmt->getResource()->bindParam(8, $var8,\PDO::PARAM_INT);
			$stmt->getResource()->bindParam(9, $var9,\PDO::PARAM_INT);
			$stmt->getResource()->bindParam(10, $var10,\PDO::PARAM_INT);
			$stmt->getResource()->bindParam(11, $var11,\PDO::PARAM_INT);
			$stmt->getResource()->bindParam(12, $var12,\PDO::PARAM_INT);
			$stmt->getResource()->bindParam(13, $var13,\PDO::PARAM_INT);
			$stmt->getResource()->bindParam(14, $var14);
			$stmt->getResource()->bindParam(15, $var15);
			$stmt->getResource()->bindParam(16, $var16);
			$aux=$stmt->execute();
			$stmt2  = $dbAdapter->createStatement();
			$stmt2->prepare("SELECT @msje AS mensaje");
			$result = $stmt2->execute();
			$output = $result->current();
			return $output['mensaje'];
		}catch(Zend_Db_Adapter_Exception $e){
			throw $e;
		}
	}

	public function listaServicioBase()
	{
		try{
			$dbAdapter=$this->getAdapter();
			$stmt = $dbAdapter->createStatement();
			$stmt->prepare('CALL pa_listaServicioBase()');
			$sql=$stmt->execute();
			while ($sql->next()) {
				$result[$sql->current()['id_Serv']]=$sql->current()['nombre_Serv'];
			}
			return $result;
		}catch(Zend_Exception $e){
			throw $e;
		}
	}
//
	public function listaServicio()
	{
		try {
			$dbAdapter=$this->getAdapter();
			$stmt = $dbAdapter->createStatement();
			$stmt->prepare('CALL pa_listaServicio()');
			$sql=$stmt->execute();
			while ($sql->next()) {
				$result[$sql->current()['id_Serv']]=$sql->current()['nombre_Serv'];
			}
			return $result;
		} catch (Exception $e) {
			throw $e;
		}
	}
//
	public function resumenServicio($id)
	{
		try{
			$contenedor=array();
			$dbAdapter=$this->getAdapter();
			$stmt = $dbAdapter->createStatement();
			$stmt->prepare('CALL pa_consolidadoPlan(:id)');
			$stmt->getResource()->bindParam(':id', $id, \PDO::PARAM_INT);
			$resultado=$stmt->execute();
			//// info basica del servicio o plan
			$info=$stmt->getResource()->fetchAll(\PDO::FETCH_OBJ);
			if (count($info)>0) {
				$contenedor['info']=$info[0];
			}
			$stmt->getResource()->nextRowset();
			//// info de promo
			$promo=$stmt->getResource()->fetchAll(\PDO::FETCH_OBJ);
			if (count($promo)>0) {
				$contenedor['promo']=$promo[0];
			}
			$stmt->getResource()->nextRowset();
			//// info de sucursal
			$sucursal=$stmt->getResource()->fetchAll(\PDO::FETCH_OBJ);
			if (count($sucursal)>0) {
				$contenedor['sucursal']=$sucursal;
			}
			$stmt->getResource()->nextRowset();
			//// info de servicios
			$serv=$stmt->getResource()->fetchAll(\PDO::FETCH_OBJ);
			if (count($serv)>0) {
				$contenedor['serv']=$serv;
			}
			$stmt->getResource()->nextRowset();
			//// info de horario
			$horario=$stmt->getResource()->fetchAll(\PDO::FETCH_OBJ);
			if (count($horario)>0) {
				$contenedor['horario']=$horario;
			}
			$stmt->getResource()->nextRowset();
			//// info de detalle Horario
			$dHora=$stmt->getResource()->fetchAll(\PDO::FETCH_OBJ);
			if (count($dHora)>0) {
				// var_dump($dHora);
				$contenedor['dHora']=$dHora;
			}
			// var_dump($contenedor);
			$stmt->getResource()->closeCursor();
			return $contenedor;
		}catch(Zend_Exception $e){
			return $e->getMessage();
		}
	}

}




// I answer myself, maybe it's wil work to someone.

// public function listaServicio()
// {
// $stmt = $dbAdapter->createStatement();
// $stmt->prepare('CALL sp_proc(:id)');
// $id=15;
// $stmt->getResource()->bindParam(':id', $id, \PDO::PARAM_INT);
// $resultado=$stmt->execute();
// $result1=$stmt->getResource()->fetchAll(\PDO::FETCH_OBJ);
// var_dump($result1);
// $stmt->getResource()->nextRowset();
// $result2=$stmt->getResource()->fetchAll(\PDO::FETCH_OBJ);
// var_dump($result2);
// $stmt->getResource()->closeCursor();
// }
