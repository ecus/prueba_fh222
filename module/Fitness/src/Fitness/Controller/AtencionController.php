<?php
namespace Fitness\Controller;

use Zend\Mvc\Controller\AbstractActionController;
use Zend\View\Model\ViewModel;
use Zend\Db\ResultSet\ResultSet;
use Zend\Db\Adapter\Adapter;
use Zend\Db\Sql\Sql;

use Fitness\Form\Frmasistencia;
use Fitness\Form\frmEmpresa;
use Fitness\Form\Frmfreezing;
use Fitness\Form\frmInscripcion;
use Fitness\Form\Frmpago;
use Fitness\Form\frmsocio;

use Fitness\Model\Entity\Asistencia;
use Fitness\Model\Entity\Empresa;
use Fitness\Model\Entity\Freezing;
use Fitness\Model\Entity\Inscripcion;
use Fitness\Model\Entity\Pago;
use Fitness\Model\Entity\Personal;
use Fitness\Model\Entity\Plan;
use Fitness\Model\Entity\Servicio;
use Fitness\Model\Entity\Socio;
use Fitness\Model\Entity\Sucursal;

use Fitness\Model\AsistenciaTabla;
use Fitness\Model\CatalogoTabla;
use Fitness\Model\EmpresaTabla;
use Fitness\Model\FreezingTabla;
use Fitness\Model\InscripcionTabla;
use Fitness\Model\PagoTabla;
use Fitness\Model\PersonalTabla;
use Fitness\Model\PlanTabla;
use Fitness\Model\ServicioTabla;
use Fitness\Model\SocioTabla;
use Fitness\Model\SucursalTabla;


class AtencionController extends AbstractActionController
{
    public function indexAction()
    {
        $view = new ViewModel();
        // $this->layout('layout/atencion');
        return $view;
    }
//------------------------------------- FREEZING -------------------------------------
    public function freezingAction()
    {
        $this->dbAdapter=$this->getServiceLocator()->get('Zend\Db\Adapter');
        $tablaSuc   =   new SucursalTabla($this->dbAdapter);
        $listaSuc   =   $tablaSuc->listaSucursal();
        $pag        =   $this->getRequest()->getBaseUrl();
        $frmfree    =   new Frmfreezing('frmFreezing');
        //$frmPer->get("cmbSucursal")->setValueOptions($listaSuc);
        $var        =   array(
                "titulo"        =>  "Registro de Sucursal",
                "frmFreezing"   =>  $frmfree,
                "listaSuc"      =>  $listaSuc,
                "url"           =>  $pag
            );
        $view = new ViewModel($var);
        $this->layout('layout/atencion');
        return $view;
    }

    public function regfreeAction()
    {
        $request = $this->getRequest();
        $response = $this->getResponse();
        if ($request->isPost()) {
                $this->dbAdapter=$this->getServiceLocator()->get('Zend\Db\Adapter');
                $free       =   new Freezing();
                $freeTabla  =   new FreezingTabla($this->dbAdapter);
                $frm        =   $request->getPost();
                $free->setFechaReg($frm['dtpFechaReg']);
                $free->setCantDias($frm['txtDias']);
                $free->setComentario($frm['txtDetalle']);
                $free->setIdInscripcion($frm['txtIdInsc']);
                $free->setIdCliente($frm['txtIdCli']);
                $free->setIdPersonal($frm['txtIdPer']);
                $msje       =   $freeTabla->insertarFreezing($free);
                if (!$msje)
                    $response->setContent(\Zend\Json\Json::encode(array('response' => false)));
                else {
                    $response->setContent(\Zend\Json\Json::encode(array('response' => $msje)));

                }
        }
        return $response;
    }
    public function listaclienteAction()
    {
        $request            =   $this->getRequest();
        $response           =   $this->getResponse();
        $this->dbAdapter    =   $this->getServiceLocator()->get('Zend\Db\Adapter');
        $tablafree          =   new FreezingTabla($this->dbAdapter);
        $frm=$request->getpost();
        $dni=$frm['txtDni'];

        $listafree          =   $tablafree->verCliente($dni);
        $listafree          =   \Zend\Json\Json::encode($listafree);
        $response->setContent(\Zend\Json\Json::prettyPrint($listafree,array("indent" => " ")));
        return $response;
    }

//------------------------------------- ASISTENCIA -----------------------------------
            public function asistenciaAction()
                {
                    $this->dbAdapter=$this->getServiceLocator()->get('Zend\Db\Adapter');
                    $tablaSuc   =   new SucursalTabla($this->dbAdapter);
                    $listaSuc   =   $tablaSuc->listaSucursal();
                    $pag        =   $this->getRequest()->getBaseUrl();
                    $frmfree    =   new Frmasistencia('frmAsistencia');
                    //$frmPer->get("cmbSucursal")->setValueOptions($listaSuc);
                    $var        =   array(
                            "titulo"        =>  "Registro de Asistencia",
                            "frmAsistencia" =>  $frmfree,
                            "listaSuc"      =>  $listaSuc,
                            "url"           =>  $pag
                        );
                    $view = new ViewModel($var);
                    $this->layout('layout/atencion');
                    return $view;
                }

            public function activolistaclienteAction()
            {
                $request            =   $this->getRequest();
                $response           =   $this->getResponse();
                $this->dbAdapter    =   $this->getServiceLocator()->get('Zend\Db\Adapter');
                $tablaAsis          =   new AsistenciaTabla($this->dbAdapter);
                $listaAsis          =   $tablaAsis->listaClienteActivo();
                $listaAsis          =   \Zend\Json\Json::encode($listaAsis);
                $response->setContent(\Zend\Json\Json::prettyPrint($listaAsis,array("indent" => " ")));
                return $response;
            }
            public function verserviciosAction()
            {
                $request            =   $this->getRequest();
                $response           =   $this->getResponse();
                $this->dbAdapter    =   $this->getServiceLocator()->get('Zend\Db\Adapter');
                $tablaAsis          =   new AsistenciaTabla($this->dbAdapter);
                $frm=$request->getpost();
                $id=$frm['id'];

                $listaAsis          =   $tablaAsis->verServicios($id);
                $listaAsis          =   \Zend\Json\Json::encode($listaAsis);
                $response->setContent(\Zend\Json\Json::prettyPrint($listaAsis,array("indent" => " ")));
                return $response;
            }
            public function regasisAction()
            {
                $request = $this->getRequest();
                $response = $this->getResponse();
                if ($request->isPost()) {
                $this->dbAdapter=$this->getServiceLocator()->get('Zend\Db\Adapter');
                $asis       =   new Asistencia();
                $asisTabla  =   new AsistenciaTabla($this->dbAdapter);
                $frm        =   $request->getPost();
                $asis->setFechaReg($frm['dtpFechaReg']);
                $asis->setFechaIng($frm['dtpFechaIng']);
                $asis->setidIns($frm['txtidIns']);
                //$asis->setidHS($frm['txtidHS']);
                $asis->setidCli($frm['txtidCli']);
                $asis->setidPer($frm['txtidPer']);
                $asis->setidSuc($frm['txtidSuc']);
                $msje       =   $asisTabla->insertarAsistencia($asis);
                if (!$msje)
                    $response->setContent(\Zend\Json\Json::encode(array('response' => false)));
                else {
                    $response->setContent(\Zend\Json\Json::encode(array('response' => $msje)));

                    }
                }
                return $response;
            }

//------------------------------------- PAGO -----------------------------------------
    public function pagoAction()
    {
        $this->dbAdapter=$this->getServiceLocator()->get('Zend\Db\Adapter');
        $tablaSuc   =   new SucursalTabla($this->dbAdapter);
        $listaSuc   =   $tablaSuc->listaSucursal();
        $pag        =   $this->getRequest()->getBaseUrl();
        $frmpago    =   new Frmpago('frmPago');
        //$frmPer->get("cmbSucursal")->setValueOptions($listaSuc);
        $var        =   array(
                "titulo"        =>  "Registro de Pagos",
                "frmPago"       =>  $frmpago,
                "listaSuc"      =>  $listaSuc,
                "url"           =>  $pag
            );
        $view = new ViewModel($var);
        $this->layout('layout/atencion');
        return $view;
    }

    public function buscaclienteAction()
    {
        $request            =   $this->getRequest();
        $response           =   $this->getResponse();
        $this->dbAdapter    =   $this->getServiceLocator()->get('Zend\Db\Adapter');
        $tablapago          =   new PagoTabla($this->dbAdapter);
        $frm=$request->getpost();
        $dni=$frm['txtDni'];

        $listapago          =   $tablapago->verCliente($dni);
        $listapago          =   \Zend\Json\Json::encode($listapago);
        $response->setContent(\Zend\Json\Json::prettyPrint($listapago,array("indent" => " ")));
        return $response;
    }
            public function regpagoAction()
            {
                $request = $this->getRequest();
                $response = $this->getResponse();
                if ($request->isPost()) {
                        $this->dbAdapter=$this->getServiceLocator()->get('Zend\Db\Adapter');
                        $pago       =   new Pago();
                        $pagoTabla  =   new PagoTabla($this->dbAdapter);
                        $frm        =   $request->getPost();
                        $pago->setFechaRegPago($frm['dtpFechaReg']);
                        $pago->setFechaPago($frm['dtpFechaPago']);
                        $pago->setTotal($frm['txtPago']);
                        $pago->setMoneda($frm['cmbMoneda']);
                        $pago->setFormaPago($frm['cmbPago']);
                        $pago->setConPago($frm['cmbConcepto']);
                        $pago->setEstado($frm['cmbEstado']);
                        $pago->setidServicio($frm['txtIdSer']);
                        $pago->setidCuenta($frm['txtIdCta']);
                        $pago->setidPer($frm['txtIdPer']);
                        $pago->setidSucursal($frm['txtIdSuc']);
                        $pago->setidCliente($frm['txtIdCli']);
                        $msje       =   $pagoTabla->insertarPago($pago);
                        if (!$msje)
                            $response->setContent(\Zend\Json\Json::encode(array('response' => false)));
                        else {
                            $response->setContent(\Zend\Json\Json::encode(array('response' => $msje)));

                        }
                }
                return $response;
            }

//------------------------------------- SOCIO ----------------------------------------
    public function socioAction()
    {
        $this->dbAdapter=$this->getServiceLocator()->get('Zend\Db\Adapter');
        $tablaSuc   =   new SucursalTabla($this->dbAdapter);
        $tablaPer   =   new PersonalTabla($this->dbAdapter);
        $tablaCat   =   new CatalogoTabla($this->dbAdapter);
        $listaPer   =   $tablaPer->listaPersonal();
        $listaSuc   =   $tablaSuc->listaSucursal();
        $listaCiu   =   $tablaCat->listaCiudad();
        // $listaDis   =   $tablaCat->listaDistrito(0);
        $pag        =   $this->getRequest()->getBaseUrl();
        $frmsoc     =   new frmsocio('frmSocio');
        $frmsoc->get("cmbpersonal")->setValueOptions($listaPer);
        $frmsoc->get("cmbCiudad")->setValueOptions($listaCiu);
        $frmsoc->get("cmbDistrito")->setValueOptions(array(''=>'Debe Elegir Ciudad.'));
        //$frmsoc-> get("cmbempresa")=setValueOptions($listaSuc);
        $var        =   array(
                "titulo"        =>  "Registro de Socio",
                "frmSocio"      =>  $frmsoc,
                "listaSuc"      =>  $listaSuc,
                "url"           =>  $pag
            );
        $view = new ViewModel($var);
        $this->layout('layout/atencion');
        return $view;
    }

    public function lisciudadAction()
    {
        $request            =   $this->getRequest();
        $response           =   $this->getResponse();
        $this->dbAdapter    =   $this->getServiceLocator()->get('Zend\Db\Adapter');
        $tablaCat           =   new CatalogoTabla($this->dbAdapter);
        $frm=$request->getpost();
        $id=$frm['id'];
        $listaCiu           =   $tablaCat->listaDistrito($id);
        $listaCiu           =   \Zend\Json\Json::encode($listaCiu);
        $response->setContent(\Zend\Json\Json::prettyPrint($listaCiu,array("indent" => " ")));
        return $response;
    }

    public function regsocioAction()
    {
        $request = $this->getRequest();
        $response = $this->getResponse();
        if ($request->isPost()) {
                $this->dbAdapter=$this->getServiceLocator()->get('Zend\Db\Adapter');
                $soc        =   new Socio;
                $socTabla   =   new SocioTabla($this->dbAdapter);
                $frm        =   $request->getPost();
                $soc->setnumerodoc($frm['txtDni']);
                $soc->setdocumento($frm['cmbDocumento']);
                $soc->setpaterno($frm['txtApPaterno']);
                $soc->setmaterno($frm['txtApMaterno']);
                
                $soc->setnombres($frm['txtNombre']);
                $soc->setsexo($frm['cmbSexo']);
                $soc->setfechanac($frm['dtpFechanac']);
                $soc->setemail($frm['txtEmail']);
                
                $soc->setecivil($frm['cmbecivil']);
                $soc->setDistrito($frm['cmbDistrito']);
                $soc->setDireccion($frm['txtDireccion']);

                switch ($frm['cmbestado']) {
                    case 1:
                        // 1: INVITADO
                        $fecha  = date('Y-m-d');
                        $soc->setfechavisita(null);
                        $soc->setfecharegistro(null);
                        $soc->setfechainv($fecha);
                        break;
                    case 2:
                        // 2: VISITA
                        $fecha  = date('Y-m-d');
                        $soc->setfechavisita($fecha);
                        $soc->setfecharegistro(null);
                        $soc->setfechainv(null);
                        break;
                    case 3:
                        // 3: RECUPERACION
                        $fecha  = date('Y-m-d');
                        $soc->setfechavisita(null);
                        $soc->setfecharegistro($fecha);
                        $soc->setfechainv(null);
                        break;
                    case 4:
                        // 4: BECADO
                        $fecha  = date('Y-m-d');
                        $soc->setfechavisita(null);
                        $soc->setfecharegistro($fecha);
                        $soc->setfechainv(null);
                        break;
                    
                    default:
                        // 0:SOCIO
                        $fecha  = date('Y-m-d');
                        $soc->setfechavisita(null);
                        $soc->setfecharegistro($fecha);
                        $soc->setfechainv(null);
                        break;
                }
                
                $soc->setestado($frm['cmbestado']);
                $soc->setreferido(($frm['cmbsocio']=='')?null:$frm['cmbsocio']);
                $soc->setempresa(($frm['cmbempresa']=='')?null:$frm['cmbempresa']);
                
                $soc->setpersonal(($frm['cmbpersonal']=='')?null:$frm['cmbpersonal']);
                $xmltel=$frm['telefonos'];

                $msje       =   $socTabla->insertaSocio($soc,$xmltel);
                if (!$msje)
                    $response->setContent(\Zend\Json\Json::encode(array('response' => false)));
                else {
                    $response->setContent(\Zend\Json\Json::encode(array('response' => $msje)));
                }
        }
        return $response;
    }
    public function regusuariosocioAction()
    {
        $request = $this->getRequest();
        $response = $this->getResponse();
        if ($request->isPost()) {
        $this->dbAdapter=$this->getServiceLocator()->get('Zend\Db\Adapter');
                $soc        =   new Socio;
                $socTabla   =   new SocioTabla($this->dbAdapter);
                $frm        =   $request->getPost();
                $soc->setpaterno($frm['txtApPaterno']);
                $soc->setmaterno($frm['txtApMaterno']);
                $soc->setnombres($frm['txtNombre']);
                $soc->setfechanac($frm['dtpFechanac']);
                $soc->setemail($frm['txtEmail']);
                $soc->settelefono($frm['txtTelCasa']);
                $soc->setmovil($frm['txtTelMovil']);
                $soc->setemergencia($frm['txtTelemergencia']);
                $soc->setecivil($frm['cmbecivil']);
                $soc->setfechavisita($frm['1985-10-11']);
                $soc->setfecharegistro($frm['1985-10-11']);
                $soc->setfechainv($frm['dtpFechaInvitacion']);
                $soc->setreferido($frm['cmbsocio']);
                $soc->setempresa($frm['cmbempresa']);
                $soc->setdocumento($frm['cmbDocumento']);
                $soc->setnumerodoc($frm['txtDni']);
                $soc->setsexo($frm['cmbSexo']);
                $soc->setpersonal($frm['cmbpersonal']);
                $soc->setestado($frm['cmbestado']);
                $alias      =   $frm['txtUsuario'];
                

                $msje= $socTabla->insertaSocioUsuario($soc,$alias);
                
                if (!$msje)
                    $response->setContent(\Zend\Json\Json::encode(array('response' => false)));
                else {
                    $response->setContent(\Zend\Json\Json::encode(array('response' => $msje)));
                }
                }
        return $response; 
    }

    public function buscasocioAction()
    {
        $request            =   $this->getRequest();
        $response           =   $this->getResponse();
        $this->dbAdapter    =   $this->getServiceLocator()->get('Zend\Db\Adapter');
        $tablasocio         =   new SocioTabla($this->dbAdapter);
        $frm=$request->getpost();
        $dni=$frm['cmbsocio'];

        $listasocio             =   $tablasocio->versocio($dni);
        $listasocio         =   \Zend\Json\Json::encode($listasocio);
        $response->setContent(\Zend\Json\Json::prettyPrint($listasocio,array("indent" => " ")));
        return $response;
    }
    public function buscaidAction()
    {

    }

//------------------------------------- EMPRESA --------------------------------------
    public function empresaAction()
    {
        $frmEmp     =   new FrmEmpresa('frmEmpresa');
        $var        =   array(
                "titulo"        =>  "Registro de Empresa",
                "frmEmpresa"    =>  $frmEmp
            );
        $view = new ViewModel($var);
        $this->layout('layout/atencion');
        return $view;
    }
    public function regempresaAction()
    {
        $request = $this->getRequest();
        $response = $this->getResponse();
        if ($request->isPost()) {
                $this->dbAdapter=$this->getServiceLocator()->get('Zend\Db\Adapter');
                $emp        =   new Empresa();
                $empTabla   =   new EmpresaTabla($this->dbAdapter);
                $frm        =   $request->getPost();
                $emp->setNombre_Em($frm['txtNombre']);
                $msje       =   $empTabla->insertarEmpresa($emp);
                if (!$msje)
                    $response->setContent(\Zend\Json\Json::encode(array('response' => false)));
                else {
                    $response->setContent(\Zend\Json\Json::encode(array('response' => $msje)));

                }
        }
        return $response;
    }

//------------------------------------- INSCRIPCION-----------------------------------
    public function inscripcionAction()
    {
        $this->dbAdapter=$this->getServiceLocator()->get('Zend\Db\Adapter');
        $tablaServ  =   new ServicioTabla($this->dbAdapter);
        $frmins     =   new frmInscripcion('frmInscripcion');
        $listaServ  =   $tablaServ->listaServicio();
        $frmins->get("cmbServicio")->setValueOptions($listaServ);
        $var        =   array(
                "titulo"        =>  "Registro de Inscripcion",
                "frmInscripcion"    =>  $frmins
            );
        $view = new ViewModel($var);
        $this->layout('layout/atencion');
        return $view;
    }

    public function reginscripcionAction()
    {
        $request = $this->getRequest();
        $response = $this->getResponse();
        if ($request->isPost()) {
                $this->dbAdapter=$this->getServiceLocator()->get('Zend\Db\Adapter');
                $ins        =   new Inscripcion();
                $insTabla   =   new InscripcionTabla($this->dbAdapter);
                $frm        =   $request->getPost();
                $ins->setFechaInicio($frm['dtpFechaIni']);
                $ins->setFechaFin($frm['dtpFechaFin']);
                $ins->setSocio_id($frm['optCliente']);
                $ins->setServicio_id($frm['cmbServicio']);
                $ins->setPersonal_id($frm['txtPersonal']);
                $msje       =   $insTabla->insertarinscripcion($ins);
                if (!$msje)
                    $response->setContent(\Zend\Json\Json::encode(array('response' => false)));
                else {
                    $response->setContent(\Zend\Json\Json::encode(array('response' => $msje)));

                }
        }
        return $response;
    }

}