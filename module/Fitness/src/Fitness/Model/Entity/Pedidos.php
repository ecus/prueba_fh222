<?php
namespace Fitness\Model\Entity;

use Zend\Db\TableGateway\TableGateway;
use Zend\Db\Adapter\Adapter;

class Pedidos extends TableGateway
{
	public function __construct(Adapter $adapter = null, $databaseSchema = null, ResultSet $selectResultPrototype = null)
	{
		// return parent::__construct('nombre de Tabla', $adapter, $databaseSchema, $selectResultPrototype);
		return parent::__construct('personal', $adapter, $databaseSchema, $selectResultPrototype);
	}
	public function listaPedidos()
	{
		$datos	=	$this->select();
		return $datos->toArray();
	}
	public function leePersonal($pk)
	{
		$id  =  (string) $pk;
        $rowset = $this->select(array('id_per' => $id));
        $row = $rowset->current();
        if (!$row) {
            throw new \Exception("Could not find row $id");
        }
        return $row;
	}
}