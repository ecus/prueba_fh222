jQuery(function($) {
    var oTable;
    var giRedraw = false;
    var auxId;
        $('#frmFreezing').validate({
            debug: true,
            rules: {
                        txtDias: {
                            required: true,
                        },
                        dtpFechaReg: {
                            required: true,
                        },
                        txtIdPer: {
                            required: true,
                            digits: true,
                        },
                        txtIdCli: {
                            required:true
                        },
                         txtIdInsc: {
                            required:true
                        },
                        txtDetalle: {
                            required:true
                        }
                    },
            messages:{
                        txtDias:{
                            required: '<span class="label label-warning">Campo Obligatorio</span>'
                        },
                        dtpFechaReg:{
                            required: '<span class="label label-warning">Campo Obligatorio</span>'
                        },
                        txtIdPer :{
                            required: '<span class="label label-warning">Campo Obligatorio</span>',
                            digits: '<span class="label label-warning">Solo numeros</span>',
                            
                        },
                        txtIdCli: {
                            required:'<span class="label label-warning">Campo Obligatorio</span>'
                        },
                         txtIdInsc: {
                            required:'<span class="label label-warning">Campo Obligatorio</span>'
                        },
                        txtDetalle:{
                            required: '<span class="label label-warning">Campo Obligatorio</span>'
                        }
                    },
        });

      //  $("#boxEstados").slideUp();

       /* $('.btnLista').on('click',function(event){
            var control     =   $(this).attr('id');
            listasucursal(control);
        });*/


        function limpiaControles(){
            $('#btnlimpiar').attr('title',"Actualizar");
            $('#btnlimpiar').attr('value',"Registrar");
           // $("#boxEstados").slideUp();
            // $(txtPersonal).val("");
            $(txtCliente).val("");
            $(txtDni).val("");
            $(dtpFechaInsc).val("");
            $(txtDias).val("");
            $(txtDetalle).val("");
            $(dtpFechaReg).val("");
            $(txtIdPer).val("");
            $(txtIdCli).val("");
            $(txtIdInsc).val("");
           // $('#cmbLinea option[value=""]').attr("selected", true);
        };

        $('.nav-tabs').button();

        $("#btnRegFreezing").on('click',function(event){
             var accion =$(this).attr('value');
             if(accion=='Registrar'){
                if($("#frmFreezing").valid()){
                 // $("#barra").slideDown(); 
                   $.post("regfree",{
                  //  console.log('no se puede registrar');
                        dtpFechaReg: $(dtpFechaReg).val(),
                        txtDias: $(txtDias).val(),
                        txtDetalle: $(txtDetalle).val(),
                        txtIdInsc:$(txtIdInsc).val(),
                        txtIdCli:$(txtIdCli).val(),
                        txtIdPer:$(txtIdPer).val()
                   },
                   function(data){
                        if(data.response==false){
                            console.log('no se puede registrar');
                        }else{
                            limpiaControles();
                            $("#msjeModal").empty().html(data.response);
                            $("#modalFreezing").modal();
                            }
                   },'json'); 
                }
             }
        });
             $('#btnConsultar').on('click',function(event){
                $.post("listacliente", {
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
                            $(txtIdInsc).val(suc.id_Ins );
                            $(dtpFechaInsc).val(suc.fechaInicio_Ins);
                        }
                        $("#barra").slideUp();
                    }, 'json');
                           
                });
                $('#btnRegFreezing').attr('title',"Actualizar Sucursal");
                $('#btnRegFreezing').attr('value',"Registrar");
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

