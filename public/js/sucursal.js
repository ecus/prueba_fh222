jQuery(function($) {
    var oTable;
    var giRedraw = false;
    var auxId;

        $('.nav-tabs').button();

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

        $('#btnRegSucursal').on('click',function(event){
            var accion    =   $(this).attr('value');
            if (accion=='Registrar'){
                /////para registrar
                if ($("#frmSucursal").valid()) {
                    $("#barra").slideDown();
                    $.post("regsucursal", {
                        txtDisplay: $(txtDisplay).val(),
                        txtUbicacion: $(txtUbicacion).val(),
                        txtTelefono:$(txtTelefono).val(),
                        cmbLinea:$(cmbLinea).val()
                    },function(data){
                        respuestaRegistro(data);
                    }, 'json');
                };
            }else{
                /////para actualizar
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
                        respuestaRegistro(data);
                    }, 'json');
                };
                $('#btnRegSucursal').attr('title',"Actualizar Sucursal");
                $('#btnRegSucursal').attr('value',"Registrar");
            };
        });

        function listasucursal ( modo ) {
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

            $.post(control,{
                },function(data){

                    creaTabla(data);
                    creaBotones();
                    $("#barra").slideUp();
                    creaEventos();

                }, 'json');
        };

        function creaBotones (){
            $('#example tbody tr').each( function() {
                // var sTitle;
                var celdas = $('td', this);
                var id = $(celdas[3]).text();
                $(celdas[3]).text("");
                var botones='<div class="btn-group">';
                botones += '<a class="btn btn-gym btnAccion" id="'+id+'" title="Editar"><i class="fa fa-edit"></i></a>';
                botones +='<a class="btn btn-gym btnAccion" id="'+id+'" title="Inactiva"><i class="fa fa-eraser"></i></a>';
                botones +='</div>';
                $(celdas[3]).append(botones);
            } );
        };

        function creaEventos () {
            $('.btnAccion').on('click',function(event){
                    auxId= $(this).attr("id");
                    // var accion   =  "";
                    if ($(this).attr("title")=="Editar"){
                        /////////// LEER SUCURSAL para editar ///////////
                        $("#barra").slideDown();
                        $.post( "leesucursal", {
                            id: $(this).attr("id"),
                        },function(data){
                            if(data.response == false){
                                console.log('no se puede registrar');
                            }else{
                                $("#boxEstados").slideDown();
                                var sucursal     =    data[0];
                                $(txtDisplay).val(sucursal.nombre_suc);
                                $(txtUbicacion).val(sucursal.direccion_suc);
                                $(txtTelefono).val(sucursal.telefono_suc);
                                $(txtEstado).val(sucursal.estado_suc );
                                $(txtId).val(sucursal.id_suc);
                                $("#0").removeClass("active");
                                $("#1").removeClass("active");
                                $("#"+sucursal.estado_suc.toString()).addClass("active");
                                $('#cmbLinea option[value="'+sucursal.linea_suc+'"]').attr("selected", true);
                                $('#btnRegSucursal').attr('title',"Actualizar Sucursal");
                                $('#btnRegSucursal').attr('value',"Actualizar Sucursal");
                            }
                            $("#barra").slideUp();
                        }, 'json');
                    }else{
                        $("#modalAccion").modal();
                    };

                    eventoEliminar();
            });
        };

        function creaTabla ( data ){
            oTable =$('#example').dataTable({
                "bDestroy": true,
                "aaData":data,
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
                });
        };

        function eventoEliminar () {
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
        };

        function limpiaControles () {
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

        function respuestaRegistro ( data ){
            if(data.response == false){
                console.log('no se puede registrar');
            }else{
                limpiaControles();
                $("#msjeModal").empty().html(data.response);
                $("#modalSucursal").modal();
                listasucursal('A');
            }
            $("#barra").slideUp();
        };

        listasucursal('A');
});

// function fnGetSelected( oTableLocal )
//     {
//         var aReturn = new Array();
//         var aTrs = oTableLocal.fnGetNodes();

//         for ( var i=0 ; i<aTrs.length ; i++ )
//         {
//             if ( $(aTrs[i]).hasClass('row_selected') )
//             {
//                 aReturn.push( aTrs[i] );
//             }
//         }

//         return aReturn;
//     }