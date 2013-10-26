jQuery(function($) {
    var oTable;
    var giRedraw = false;
    var auxId;
        $('#frmPago').validate({
            debug: true,
            rules: {
                        cmbMoneda: {
                            required: true,
                        },
                        cmbPago: {
                            required: true,
                        },
                        cmbConcepto: {
                            required: true,
                            digits: true,
                        },
                        cmbEstado: {
                            required:true
                        },
                         dtpFechaReg: {
                            required:true
                        },
                        dtpFechaPago: {
                            required:true
                        }
                    },
            messages:{
                        cmbMoneda:{
                            required: '<span class="label label-warning">Campo Obligatorio</span>'
                        },
                        cmbPago:{
                            required: '<span class="label label-warning">Campo Obligatorio</span>'
                        },
                        cmbConcepto :{
                            required: '<span class="label label-warning">Campo Obligatorio</span>',
                           // digits: '<span class="label label-warning">Solo numeros</span>',
                            
                        },
                        cmbEstado: {
                            required:'<span class="label label-warning">Campo Obligatorio</span>'
                        },
                         dtpFechaReg: {
                            required:'<span class="label label-warning">Campo Obligatorio</span>'
                        },
                        dtpFechaPago:{
                            required: '<span class="label label-warning">Campo Obligatorio</span>'
                        }
                    },
        });

        function limpiaControles(){
            $('#btnlimpiar').attr('title',"Actualizar");
            $('#btnlimpiar').attr('value',"Registrar");
           
            $(txtDni).val("");
            $(txtCliente).val("");
            $(txtServicio).val("");
            $(txtPago).val("");
            $(dtpFechaReg).val("");
            $(dtpFechaPago).val("");
            $(cmbMoneda).val("");
            $(cmbPago).val("");
            $(cmbConcepto).val("");
            $(cmbEstado).val("");
            $(txtIdPer).val("");
            $(txtIdCli).val("");
            $(txtIdSer).val("");
            $(txtIdSuc).val("");
            $(txtIdCta).val("");
            
        };

        $('.nav-tabs').button();

        $("#btnRegPago").on('click',function(event){
             var accion =$(this).attr('value');
             if(accion=='Registrar'){
                if($("#frmPago").valid()){
                 // $("#barra").slideDown(); 
                   $.post("regPago",{
                  //  console.log('no se puede registrar');
                        dtpFechaReg: $(dtpFechaReg).val(),
                        dtpFechaPago: $(dtpFechaPago).val(),
                        txtPago: $(txtPago).val(),
                        cmbMoneda:$(cmbMoneda).val(),
                        cmbPago:$(cmbPago).val(),
                        cmbConcepto:$(cmbConcepto).val(),
                        cmbEstado: $(cmbEstado).val(),
                        txtIdSer: $(txtIdSer).val(),
                        txtIdCta: $(txtIdCta).val(),
                        txtIdPer:$(txtIdPer).val(),
                        txtIdSuc:$(txtIdSuc).val(),
                        txtIdCli:$(txtIdCli).val()
                   },
                   function(data){
                        if(data.response==false){
                            console.log('no se puede registrar');
                        }else{
                            limpiaControles();
                            $("#msjeModal").empty().html(data.response);
                            $("#modalPago").modal();
                            }
                   },'json'); 
                }
             }
        });
             $('#btnConsultar').on('click',function(event){
                $.post("buscacliente", {
                        txtDni:$(txtDni).val()
                    },
                    function(data){
                        if(data.response == false){
                            console.log('no se puede registrar');
                        }else{
                            var suc     =    data[0];
                              console.debug(suc);
                              $(txtIdCli).val(suc.id_Soc);
                              $(txtDni).val(suc.documento_Soc);
                              $(txtCliente).val(suc.cliente);
                              $(txtIdSer).val(suc.id_Serv );
                              $(txtServicio).val(suc.nombre_Serv);
                              $(txtPago).val(suc.montoBase_Serv);

                        }
                        $("#barra").slideUp();
                    }, 'json');
                           
                });
                $('#btnRegPago').attr('title',"Actualizar Sucursal");
                $('#btnRegPago').attr('value',"Registrar");
            
        });
           
function fnGetSelected( oTableLocal )
    {
        var aReturn = new Array();
        var aTrs = oTableLocal.fnGetNodes();

        for ( var i=0 ; i<aTrs.length ; i++ )
        {
            if ( $(aTrs[i]).hasClass('row_selected') )
            {
                aReturn.push( aTrs[i] );
            }
        }

        return aReturn;
    }
