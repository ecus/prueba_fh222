<?php
namespace Fitness\Model;

use Zend\Db\TableGateway\TableGateway;
use Zend\Db\Adapter\Adapter;
use Fitness\Model\Entity\Pago;

class PagoTabla extends TableGateway
{
	public function __construct(Adapter $adapter = null, $databaseSchema = null, ResultSet $selectResultPrototype = null)
	{
		return parent::__construct('', $adapter, $databaseSchema,
			$selectResultPrototype);
	}
	public function insertarPago(Pago $p)
	{
		$var1	=	$p->getFechaRegPago();
		$var2	=	$p->getFechaPago();
		$var3	=	$p->getTotal();
		$var4	=	$p->getMoneda();
		$var5	=	$p->getFormaPago();
		$var6	=	$p->getConPago();
		$var7	=	$p->getEstado();
		$var8	=	$p->getidServicio();
		$var9	=	$p->getidCuenta();
		$var10	=	$p->getidPer();
		$var11	=	$p->getidSucursal();
		$var12	=	$p->getidCliente();

		$dbAdapter=$this->getAdapter();
		$stmt = $dbAdapter->createStatement();
		$stmt->prepare('CALL pa_InsertarPago (?,?,?,?,?,?,?,?,?,?,?,?)');
		$stmt->getResource()->bindParam(1, $var1);
		$stmt->getResource()->bindParam(2, $var2);
		$stmt->getResource()->bindParam(3, $var3);
		$stmt->getResource()->bindParam(4, $var4,\PDO::PARAM_INT);
		$stmt->getResource()->bindParam(5, $var5,\PDO::PARAM_INT);
		$stmt->getResource()->bindParam(6, $var6,\PDO::PARAM_INT);
		$stmt->getResource()->bindParam(7, $var7,\PDO::PARAM_INT);
		$stmt->getResource()->bindParam(8, $var8,\PDO::PARAM_INT);
		$stmt->getResource()->bindParam(9, $var9,\PDO::PARAM_INT);
		$stmt->getResource()->bindParam(10, $var10,\PDO::PARAM_INT);
		$stmt->getResource()->bindParam(11, $var11,\PDO::PARAM_INT);
		$stmt->getResource()->bindParam(12, $var12,\PDO::PARAM_INT);
		$stmt->execute();
		$stmt->getResource()->closeCursor();

		$stmt2	=	$dbAdapter->createStatement();
		$stmt2->prepare("SELECT @msje AS mensaje");
		$result	=	$stmt2->execute();
		$output	=	$result->current();
		return $output['mensaje'];
	}
	public function verCliente($dni)
	{
		try{
			$dbAdapter	=	$this->getAdapter();
			$stmt		=	$dbAdapter->createStatement();
			$stmt->prepare('CALL pa_ClienteInscripcion(?)');
			$stmt->getResource()->bindParam(1, $dni);
			$stmt->execute();
			$info		=	$stmt->getResource()->fetchAll(\PDO::FETCH_OBJ);
			return $info;
		}catch(Zend_Exception $e){
			return $e->getMessage();
		}
	}

}
?>