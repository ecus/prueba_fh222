jQuery(function($){
    var oTable;
    var giRedraw = false;
    var auxId;
     $('#frmAsistencia').validate({
            debug: true,
            rules: {
                        dtpFechaIng: {
                            required: true,
                        },
                    },
            messages:{

                        dtpFechaIng:{
                            required: '<span class="label label-warning">Campo Requerido</span>'
                        },

                    },
        });
     function limpiaControles(){
            $('#btnlimpiar').attr('title',"Actualizar");
            $('#btnlimpiar').attr('value',"Registrar");
           // $("#boxEstados").slideUp();
            // $(txtPersonal).val("");
            //$(dtpFechaReg).val("");
            $('#boxServicios').empty();
            $(dtpFechaIng).val("");
            $(txtidIns).val("");
            $(txtidCli).val("");
            //$(txtidPer).val("");
           // $(txtidSuc).val("");
            // $(txtIdPer).val("");
            // $(txtIdCli).val("");
            // $(txtIdInsc).val("");
           // $('#cmbLinea option[value=""]').attr("selected", true);
        };
    $('#btnRegAsistencia').attr('title',"Actualizar Asistencia");
    $('#btnRegAsistencia').attr('value',"Registrar");
    //--------------------------
         $('.nav-tabs').button();

        $("#btnRegAsistencia").on('click',function(event){
             var accion =$(this).attr('value');
             if(accion=='Registrar'){
                if($("#frmAsistencia").valid()){
                 // $("#barra").slideDown();
                   $.post("regasis",{
                  //  console.log('no se puede registrar');

                        dtpFechaReg: $(dtpFechaReg).val(),
                        dtpFechaIng: $(dtpFechaIng).val(),
                        txtidIns:    $(txtidIns).val(),
                        txtidHS:     $(txtidHS).val(),
                        txtidCli:    $(txtidCli).val(),
                        txtidPer:    $(txtidPer).val(),
                        txtidSuc:    $(txtidSuc).val()
                },
                   function(data){
                        if(data.response==false){
                            console.log('no se puede registrar');
                        }else{
                             limpiaControles();
                            $("#msjeModal").empty().html(data.response);
                            $("#modalAsistencia").modal();
                            }
                   },'json');
                }
             }
        });
    //--------------------------

    $("#barra").slideUp();
    function listacliente(){
        var control     =   "activolistacliente";
                    $('#tablaTitulo').empty().html("Listado de Clientes");
                    $("#barra").slideDown();
          $.post(control, {
                },function(data){
                     console.debug(data);
                        oTable =$('#example').dataTable({
                            "bDestroy": true,
                            "aaData":data,
                            // "bScrollCollapse": true,
                            "sPaginationType": "full_numbers",
                            "aLengthMenu": [[5, 10, 15, -1], [5, 10, 15, "All"]],
                            "iDisplayLength": 5,
                            // "bPaginate": false,
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
                                            { "mData": "documento_soc" },
                                            { "mData": "cliente" },
                                            { "mData": "id_Soc" }
                                        ],
                            "aoColumnDefs": [
                                          { "sWidth": "1%", "aTargets": [ 0 ] }
                                        ],
                          });

                            $('#example tbody tr').each( function() {
                              var sTitle;
                              var nTds = $('td', this);
                              var id = $(nTds[2]).text();
                              $(nTds[2]).text("");
                              var botones='<div class="btn-group">';
                              botones += '<a class="btn btn-primary btnAccion" id="'+id+'" title="Editar"><i class="icon-edit"></i></a>';
                              $(nTds[2]).append(botones);
                            });
                            $('.btnAccion').on('click',function(event){
                                auxId= $(this).attr("id");
                                var accion="";
                                if($(this).attr("title")=="Editar"){
                                 $(txtidCli).val(auxId);
                                 $("#barra").slideDown();

                                 $.post("verservicios",{
                                    id: $(this).attr("id"),
                                  },function(data){
                                     if(data.response == false){
                                            console.log('no tiene sevicios registrados...');
                                      }else{

                                                   console.debug(data);
                                               var suc     =    data;
                                               var tabla="<table>";
                                                      tabla+="<thead>";
                                                          tabla+="<td>Nombre</td>";
                                                          tabla+="<td>Seleccionar</td>";
                                                      tabla+="</thead>";
                                                    tabla+="<tbody>";
                                                $.each(data,function(){
                                                   var dat=$(this)[0];
                                                   tabla+='<tr>';
                                                   tabla+='<td>'+dat.nombre_Serv+'</td>';
                                                   tabla+='<td><a class="btn btn-primary btnSelect" title="Click" id='+dat.id_Ins + '>Click</a></td>';
                                                    tabla+='</tr>';
                                                });
                                                    tabla+='</tbody> </table>';
                                                   $('#boxServicios').empty().append(tabla);
                                                   $("#barra").slideUp();
                                            };
                                    $('.btnSelect').on('click',function(event){
                                      console.log('vjgbnhhhhhhhhhhhhhhhhhhhhh');
                                      auxId= $(this).attr("id");
                                      var accion="";
                                      if($(this).attr("title")=="Click"){
                                         $(txtidIns).val(auxId);
                                      };
                                    });
                                   }, 'json');
                                };
                            });
                            ////Jjjj
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