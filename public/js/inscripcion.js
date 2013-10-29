jQuery(function($) {
    var oTable;
    var giRedraw = false;
    var auxId;

        $("#frmInscripcion").validate({
            debug: true,
            rules: {
                        dtpFechaIni: {
                            required: true
                        },
                        dtpFechaFin: {
                            required: true
                        },
                        cmbEstado: {
                            required: true
                        },
                        cmbTipo: {
                            required:true
                        },
                        cmbServicio: {
                            required:true
                        }
                    },
            messages:{
                        dtpFechaIni:{
                            required: '<span class="label label-warning">Campo Obligatorio</span>'
                        },
                        dtpFechaFin:{
                            required: '<span class="label label-warning">Campo Obligatorio</span>'
                        },
                        cmbEstado: {
                            required:'<span class="label label-warning">Debe Elegir un Estado</span>'
                        },
                         cmbTipo: {
                            required:'<span class="label label-warning">Debe Elegir un Tipo</span>'
                        },
                         cmbServicio: {
                            required:'<span class="label label-warning">Debe Elegir un Servicio</span>'
                        }
                    },
        });



function listacliente(){
        var control     =   "listasocios";
                    $('#tablaTitulo').empty().html("Listado de Clientes");
                    $("#barra").slideDown();
          $.post(control, {
                },function(data){
                     console.debug(data);
                        oTable =$('#example').dataTable({
                            "bDestroy": true,
                            "aaData":data,
                            // "bScrollCollapse": true,
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
                                            { "mData": "id_Soc" },
                                            { "mData": "cliente" }
                                        ],
                            "aoColumnDefs": [
                                          { "sWidth": "1%", "aTargets": [ 0 ] }
                                        ],
                            "bPaginate": false,
                            // "sPaginationType": "full_numbers",
                            // "aLengthMenu": [[5, 10, 15, -1], [5, 10, 15, "All"]],
                            // "iDisplayLength": 5,
                            });

                            $('#example tbody tr').each( function() {
                                var sTitle;
                                var nTds = $('td', this);
                                var id = $(nTds[0]).text();
                                $(nTds[0]).text("");
                                var botones='<div class="btn-group">';
                                botones += '<input type="radio" name="optCliente" id="optCliente" value="'+id+'" />';
                                $(nTds[0]).append(botones);
                            });
                        oTable =$('#example').dataTable({
                            "bDestroy": true,
                            "sPaginationType": "full_numbers",
                            "aLengthMenu": [[5, 10, 15, -1], [5, 10, 15, "All"]],
                            "iDisplayLength": 5,
                            });

                        $('#btnRegInscripcion').on('click',function(event){
                            var accion    =   $(this).attr('value');
                            console.log($(':input:checked').val());
                            if (accion=='Registrar'){
                                if ($("#frmInscripcion").valid()) {
                                    $("#barra").slideDown();
                                    $.post("reginscripcion", {
                                        dtpFechaIni : $(dtpFechaIni).val(),
                                        dtpFechaFin : $(dtpFechaFin).val(),
                                        cmbServicio : $(cmbServicio).val(),
                                        txtPersonal : $(txtPersonal).val(),
                                        optCliente  : $(':input:checked').val(),
                                    },function(data){
                                        if(data.response == false){
                                            console.log('no se puede registrar');
                                        }else{
                                            // limpiaControles();
                                            $("#msjeModal").empty().html(data.response);
                                            $("#modalIns").modal();
                                            // listasucursal('A');
                                        }
                                        $("#barra").slideUp();
                                    }, 'json');
                                };
                            }
                        });

                    },'json');

                    $("#barra").slideUp();


    };
    listacliente();
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
