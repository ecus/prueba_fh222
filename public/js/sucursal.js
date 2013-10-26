jQuery(function($) {
    var oTable;
    var giRedraw = false;
    var auxId;
        $("#0").on('click',function(event) {
            $(txtEstado).val($(this).attr('id'));
        });

        $("#1").on('click',function(event) {
            $(txtEstado).val($(this).attr('id'));
        });

        $("#frmSucursal").validate({
            debug: true,
            rules: {
                        txtDisplay: {
                            required: true,
                        },
                        txtUbicacion: {
                            required: true,
                        },
                        txtTelefono: {
                            required: true,
                            digits: true,
                            minlength:6
                        },
                        cmbLinea: {
                            required:true
                        }
                    },
            messages:{
                        txtDisplay:{
                            required: '<span class="label label-warning">Campo Obligatorio</span>'
                        },
                        txtUbicacion:{
                            required: '<span class="label label-warning">Campo Obligatorio</span>'
                        },
                        txtTelefono :{
                            required: '<span class="label label-warning">Campo Obligatorio</span>',
                            digits: '<span class="label label-warning">Solo numeros</span>',
                            minlength: '<span class="label label-warning">minimo 6 caracteres</span>'
                        },
                        cmbLinea: {
                            required:'<span class="label label-warning">Debe Elegir una sucursal</span>'
                        }
                    },
        });

        $("#boxEstados").slideUp();

        $('.btnLista').on('click',function(event){
            var control     =   $(this).attr('id');
            listasucursal(control);
        });

        $("#btnCancelar").on('click',function(event){
            limpiaControles();
        });
        function limpiaControles(){
            $('#btnRegSucursal').attr('title',"Actualizar Sucursal");
            $('#btnRegSucursal').attr('value',"Registrar");
            $("#boxEstados").slideUp();
            $(txtDisplay).val("");
            $(txtUbicacion).val("");
            $(txtTelefono).val("");
            $(txtEstado).val("");
            $(txtId).val("");
            $('#cmbLinea option[value=""]').attr("selected", true);
        };

        $('.nav-tabs').button();

        $('#btnRegSucursal').on('click',function(event){
            var accion    =   $(this).attr('value');
            if (accion=='Registrar'){
                if ($("#frmSucursal").valid()) {
                    $("#barra").slideDown();
                    $.post("regsucursal", {
                        txtDisplay: $(txtDisplay).val(),
                        txtUbicacion: $(txtUbicacion).val(),
                        txtTelefono:$(txtTelefono).val(),
                        cmbLinea:$(cmbLinea).val()
                    },function(data){
                        if(data.response == false){
                            console.log('no se puede registrar');
                        }else{
                            limpiaControles();
                            $("#msjeModal").empty().html(data.response);
                            $("#modalSucursal").modal();
                            listasucursal('A');
                        }
                        $("#barra").slideUp();
                    }, 'json');
                };
            }else{
                if ($("#frmSucursal").valid()) {
                    $("#barra").slideDown();
                    $.post("actsucursal", {
                        txtDisplay  : $(txtDisplay).val(),
                        txtUbicacion: $(txtUbicacion).val(),
                        txtTelefono : $(txtTelefono).val(),
                        txtEstado   : $(txtEstado).val(),
                        txtId       : $(txtId).val(),
                        cmbLinea    : $(cmbLinea).val()
                    },function(data){
                        if(data.response == false){
                            console.log('no se puede registrar');
                        }else{
                            limpiaControles();
                            $("#msjeModal").empty().html(data.response);
                            $("#modalSucursal").modal();
                            listasucursal('A');
                        }
                        $("#barra").slideUp();
                    }, 'json');
                };
                $('#btnRegSucursal').attr('title',"Actualizar Sucursal");
                $('#btnRegSucursal').attr('value',"Registrar");
            };
        });

            // $("barra").slideDown();
        function listasucursal (modo) {
            $("#barra").slideDown();
            if (modo=="T"){
                var control     =   "listasucursal";
                $('#tablaTitulo').empty().html("Listado Total");
            }else{
                if(modo=="A"){
                    var control     =   "activolistasucursal";
                    $('#tablaTitulo').empty().html("Listado de Sucursales Activas");
                }
                else{
                    var control     =   "inactivolistasucursal";
                    $('#tablaTitulo').empty().html("Listado de Sucursales Inactivas");
                };
            };
            $.post(control, {
                },function(data){
                        oTable =$('#example').dataTable({
                            "bDestroy": true,
                            "aaData":data,
                            // "bScrollCollapse": true,
                            // "sPaginationType": "full_numbers",
                            "bPaginate": false,
                            "bAutoWidth": false,
                            "oLanguage": {
                                "sLengthMenu": "Mostrar _MENU_ elementos",
                                "sZeroRecords": "No se encontro el valor ingresado",
                                "sInfo": "_START_ a _END_ de _TOTAL_ elementos",
                                "sInfoEmpty": "0 a 0 de 0 elementos",
                                "sInfoFiltered": "(_MAX_ filtrados del total de elementos)",
                                "sSearch":"Buscar: "
                            },
                            // "asStripeClasses": [ 'strip1', 'strip2', 'strip3' ],
                            "aoColumns": [
                                            { "mData": "nombre_suc" },
                                            { "mData": "direccion_suc" },
                                            { "mData": "telefono_suc" },
                                            { "mData": "id_suc" }
                                        ],
                            "aoColumnDefs": [
                                          { "sWidth": "25%", "aTargets": [ 0 ] },
                                          { "sWidth": "45%", "aTargets": [ 1 ] },
                                          { "sWidth": "18%", "aTargets": [ 2 ] },
                                          { "sWidth": "12%", "aTargets": [ 3 ] },
                                        ],
                            // "iDisplayLength": -1,
                            // "aLengthMenu": [[-1], [ "All"]]
                            });
                        $("#barra").slideUp();
                        $('#example tbody tr').each( function() {
                            var sTitle;
                            var nTds = $('td', this);
                            var id = $(nTds[3]).text();
                            $(nTds[3]).text("");
                            var botones='<div class="btn-group">';
                            botones += '<a class="btn btn-gym btnAccion" id="'+id+'" title="Editar"><i class="icon-edit"></i></a>';
                            botones +='<a class="btn btn-gym btnAccion" id="'+id+'" title="Inactiva"><i class="icon-eraser"></i></a>';
                            botones +='</div>';
                            $(nTds[3]).append(botones);
                        } );
                        $('.btnAccion').on('click',function(event){
                                auxId= $(this).attr("id");
                                var accion   =  "";
                                if ($(this).attr("title")=="Editar"){
                                    /////////// LEER SUCURSAL ///////////
                                    $("#barra").slideDown();
                                    $.post( "leesucursal", {
                                        id: $(this).attr("id"),
                                    },function(data){
                                        if(data.response == false){
                                            console.log('no se puede registrar');
                                        }else{
                                            $("#boxEstados").slideDown();
                                            var suc     =    data[0];
                                            $(txtDisplay).val(suc.nombre_suc);
                                            $(txtUbicacion).val(suc.direccion_suc);
                                            $(txtTelefono).val(suc.telefono_suc);
                                            $(txtEstado).val(suc.estado_suc );
                                            $(txtId).val(suc.id_suc);
                                            $("#0").removeClass("active");
                                            $("#1").removeClass("active");
                                            $("#"+suc.estado_suc.toString()).addClass("active");
                                            $('#cmbLinea option[value="'+suc.linea_suc+'"]').attr("selected", true);
                                            $('#btnRegSucursal').attr('title',"Actualizar Sucursal");
                                            $('#btnRegSucursal').attr('value',"Actualizar Sucursal");
                                        }
                                        $("#barra").slideUp();
                                    }, 'json');
                                }else{
                                    $("#modalAccion").modal();
                                };
                                $("#btnEliminar").on('click',function(event){
                                    /////////// LEER SUCURSAL ///////////
                                    $("#barra").slideDown();
                                    $.post("desactivasucursal", {
                                        txtId:      auxId
                                    },function(data){
                                        if(data.response == false){
                                            console.log('no se puede registrar');
                                        }else{
                                            $("#modalAccion").modal('hide');
                                            $("#msjeModal").empty().html(data);
                                            $("#modalSucursal").modal();
                                            limpiaControles();
                                            listasucursal('I');
                                        }
                                        $("#barra").slideUp();
                                    }, 'json');
                                });
                        });
                }, 'json');
        }

        listasucursal('A');
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