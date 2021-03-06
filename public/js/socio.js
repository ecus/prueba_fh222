jQuery(function($){
		var usuario			=	0;
        var contadorNumero	=	0;
        var listaNumeros	=	[];
        $('.detalle').slideUp();
        $('#boxInfoEmergencia').slideUp();
        $('#boxAcceso').slideUp();
        $('#barraDistrito').slideUp();
        $("#frmSocio").validate({
            debug: true,
            rules: {
                        cmbestado:{
                            required: true,
                        },
                        txtDni:{
                            required: true,
                            digits: true,
                            minlength:8,
                            maxlength:8
                        },
                        cmbDocumento:{
                            required: true,
                            digits: true,
                        },
                        txtNombre:{
                            required: true
                        },
                        txtApPaterno:{
                            required: true
                        },
                        txtApMaterno:{
                            required: true
                        },
                        cmbSexo:{
                            required: true,
                        },
                        cmbecivil:{
                            required: true,
                        },
                        cmbCiudad:{
                            required: true,
                        },
                        cmbDistrito:{
                            required: true,
                        },
                        txtDireccion :{
                            required: true
                        },
                        txtEmail :{
                            email: true
                        },
                        dtpFechanac :{
                            required: true,
                            date: true
                        },
                    },
            messages:{
                        cmbestado:{
                            required:'<span class="label label-warning">Debe Elegir una opcion.</span>'
                        },
                        txtDni:{
                            required: '<span class="label label-warning">Campo Obligatorio</span>',
                            digits: '<span class="label label-warning">Solo numeros</span>',
                            minlength:'<span class="label label-warning">DNI debe contar con 8 digitos</span>',
                            maxlength:'<span class="label label-warning">DNI debe contar con 8 digitos</span>',
                        },
                        cmbDocumento:{
                            required:'<span class="label label-warning">Debe Elegir una opcion.</span>'
                        },
                        txtNombre:{
                            required: '<span class="label label-warning">Campo Obligatorio</span>'
                        },
                        txtApPaterno:{
                            required: '<span class="label label-warning">Campo Obligatorio</span>'
                        },
                        txtApMaterno:{
                            required: '<span class="label label-warning">Campo Obligatorio</span>'
                        },
                        cmbSexo:{
                            required:'<span class="label label-warning">Debe Elegir una opcion.</span>'
                        },
                        cmbecivil:{
                            required:'<span class="label label-warning">Debe Elegir una opcion.</span>'
                        },
                        cmbCiudad:{
                            required:'<span class="label label-warning">Debe Elegir una opcion.</span>'
                        },
                        cmbDistrito:{
                            required:'<span class="label label-warning">Debe Elegir una opcion.</span>'
                        },
                        txtDireccion :{
                            required: '<span class="label label-warning">Campo Obligatorio</span>'
                        },
                        txtEmail :{
                            email: '<span class="label label-warning">Ingrese formato de email valido</span>'
                        },
                        dtpFechanac :{
                            required:'<span class="label label-warning">Campo Obligatorio</span>',
                            date: '<span class="label label-warning">Error en formato de fecha</span>'
                        }
                    }
        });
        $('#cmbCiudad').change(function(){
            var ciudad = $(this).val();
            $('#barraDistrito').slideDown();
            $.post("lisciudad", {
                id  :   $(this).val()
            },function(data){
                if(data.response == false){
                    console.log('no se puede encontrar');
                }else{
                    // elimina listado de distritos actual
                    $('#cmbDistrito').find('option').remove().end();
                    var distritos = '<option value="">Seleccione...</option>';

                    // crea listado de distritos actual
                    $.each(data, function(index, val) {
                        distritos += '<option value="'+index+'">'+val+'</option>';
                    });
                    $(cmbDistrito).html(distritos);
                    $('#barraDistrito').slideUp();
                }
            }, 'json');
        });

        $('#btnAgregaTel').on('click', function(event) {
            event.preventDefault();
            var cantidad    =   $('#boxNumeros span').length;
            var numero      =   $('#txtNumero').val();
            var tipo        =   $('#cmbTipoCel').val();
            var infoTipo    =   $('#cmbTipoCel option[value="'+tipo+'"]').text();
            var nombreTele  =   ($('#txtNombreTel').val())?$('#txtNombreTel').val():null;
            var parentesco  =   ($('#txtParentesco').val())?$('#txtParentesco').val():null;
            var emergencia  =   $('#txtEmergencia').val();
            // var etiqueta    =   '';
            if (agendaSinNumeros) {
                contadorNumero  +=  1;
                agregaNumero(listaNumeros,numero, tipo, null, null, null);
            }else{
                contadorNumero  +=  1;
                var objetoNumero = {
                    numeroTel  : numero, tipoTel : tipo,
                    emergenciaTel : emergencia, nombreTel  :   nombreTele, parentescoTel : parentesco
                    };
                if (verificaNumeroEnAgenda(listaNumeros , objetoNumero)) {
                    agregaNumero(listaNumeros,numero, tipo, null, null, null);
                };
            };
            agregaEtiqueta( tipo, contadorNumero, infoTipo, numero, nombreTele, parentesco , emergencia , listaNumeros);
            limpiaTelefono();
        });

        $('#btnRegSocio').on('click',function(event){
            if($("#frmSocio").valid()){
                if (usuario==0) {
                    var accion  ="regsocio";
                } else{
                    var accion  ="regusuariosocio";
                };
                $.post(accion, {
                        cmbestado   : $(cmbestado).val(),
                        cmbDocumento: $(cmbDocumento).val(),
                        txtDni      : $(txtDni).val(),
                        txtNombre   : $(txtNombre).val(),
                        txtApPaterno: $(txtApPaterno).val(),
                        txtApMaterno: $(txtApMaterno).val(),
                        dtpFechanac : $(dtpFechanac).val(),
                        cmbSexo     : $(cmbSexo).val(),
                        cmbecivil   : $(cmbecivil).val(),
                        txtEmail    : $(txtEmail).val(),
                        txtDireccion: $(txtDireccion).val(),
                        cmbsocio    : referido,
                        cmbempresa  : $(cmbempresa).val(),
                        txtPersonal : $(txtPersonal).val(),
                        cmbDistrito : $(cmbDistrito).val(),
                        telefonos   : listaNumeros,
                        txtSucursal : $(txtSucursal).val(),
                        txtUsuario  :$(txtUsuario).val(),
                    },function(data){
                        if(data.response == false){
                            console.log('no se puede registrar');
                        }else{
                            limpiaControles();
                            muestraMensaje(modalSocio, msjeModal, data.response);
                            // $("#msjeModal").empty().html(data.response);
                            // $("#modalSocio").modal();
                        }
                        $("#barra").slideUp();
                    }, 'json');
            }else{
                console.log("mal");
            };
        });

        $('#btnbuscaSocio').on('click',function(event){
                $.post("buscasocio", {
                        cmbsocio:$(cmbsocio).val()
                    },
                    function(data){
                        if(data.response == false){
                            console.log('no se puede registrar');
                        }else{
                            var suc     =    data[0];
                              console.debug(suc);
                              $(cmbsocio).val(suc.id_Soc);
                        }
                        $("#barra").slideUp();
                    }, 'json');
                    console.log("no entro");
        });

        $('#txtNumero').keypress(function(e) {
            if (e.which == 13 && $(this).val().length>=6 && $(this).val().length<=10 ) {
                $("#btnAgregaTel").click();
            }
        })
        $('#txtNombreTel').keypress(function(e) {
            if (e.which == 13 && $(this).val().length>=6 && $('#txtNumero').val().length<=10 ) {
                $("#btnAgregaTel").click();
            }
        })
        $('.btnEmergencia').on('click',function(event){
            var opcion  =   $.trim($(this).text());
            if (opcion=='Si'){
                $('#boxInfoEmergencia').slideDown();
                $('#txtEmergencia').val("1");
            }else{
                $('#boxInfoEmergencia').slideUp();
                $('#txtEmergencia').val("0");
            };
        });
        $('.btnUper').on('click',function(event){
            // $(txtEstadoUPer).val($(this).attr('id').charAt($(this).attr('id').length-1));
            var x=$(this).find('input').attr('id');
            $(txtEstadoUPer).val(x.charAt(x.length-1));
        });
        $('.btnEstado').on('click',function(event){
            var x=$(this).find('input').attr('id');
            $(txtEstado).val(x.charAt(x.length-1));
        });
        $('.btnAccesos').on('click',function(event){
            // var rpta     =  $(this).html();
            var rpta     =  $(this).text();
            var nombre   =  $(txtNombre).val();
            var apellido =  $(txtApPaterno).val().replace(" ","");
            var user     =  crearNombre();
            console.log(rpta);
            if(rpta=='Si'){
                // if(nombre!='' && apellido!=''){
                if(nombre.length>0 && apellido.length>0){
                    $("#boxAcceso").slideDown();
                    $(optUsuario).val('1');
                    $(txtUsuario).attr('placeholder',user);
                    $(txtUsuario).val(user);
                    usuario =   1;
                }else{
                    $('#msjeModal').empty().html('Debe completar los campos de Nombre y Apellido Paterno');
                    $('#modalSocio').modal();
                    usuario =   0;
                    // $("#boxAcceso").slideDown();
                }
            }else{
                $(optUsuario).val('0');
                $("#boxAcceso").slideUp();
            }
        });

        function crearNombre(){
            var nombre   =  $(txtNombre).val();
            var apellido =  $(txtApPaterno).val().replace(" ","");
            var user     =  nombre.charAt(0) + apellido;
            $(txtUsuario).attr('placeholder',user.toLowerCase());
            $(txtUsuario).val(user.toLowerCase());
            return user.toLowerCase();
        };
        function limpiaTelefono () {
            $("#cmbTipoCel option:nth(0)").attr('selected', true);
            $(txtNumero).val('');
            $(txtParentesco).val('');
            $(txtNombreTel).val('');
            $("#boxInfoEmergencia").slideUp();
            $.each($('.btnEmergencia'), function() {
                if ($(this).text()=='No') {
                    $(this).click();
                };
            });
        }
        function limpiaControles(){
            limpiaControlesBasico();
            $(txtDni).removeAttr('disabled');
            $(txtSexo).val(0);
            $("#btnSexo0").addClass('active');
            $("#boxEstado").slideUp();
            $("#boxAcceso").slideUp();
            $('#btnRegPersonal').attr('title',"Registrar");
            $('#btnRegPersonal').attr('value',"Registrar");
            $.each($('#btnClose'), function() {
                $(this).click();
            });
            limpiaTelefono();
        };

    function listacliente(){
        var control     =   "referirlistasocio";
        $('#tablaTitulo').empty().html("Listado de Clientes");
        $("#barra").slideDown();
        $.post(control, {
            },function(data){
                if (data.length>0) {
                    crearTabla(data);
                    configuracionAdicional();
                };
            $("#barra").slideUp();
        },'json');
    };

    function crearTabla (datos) {
        oTable =$('#example').dataTable({
            "bDestroy": true,
            "aaData":datos,
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
                            { "mData": "documento_soc" },
                            { "mData": "cliente" }
                        ],
            "aoColumnDefs": [
                          { "sWidth": "1%", "aTargets": [ 0 ] }
                        ],
            "bPaginate": false,
        });

        crearControles();
    }

    function crearControles () {
        $('#example tbody tr').each( function() {
            var sTitle;
            var nTds = $('td', this);
            var id = $(nTds[0]).text();
            $(nTds[0]).text("");
            var botones='<div class="btn-group">';
            botones += '<input type="radio" name="optCliente" id="optCliente" value="'+id+'" />';
            $(nTds[0]).append(botones);
        });
    }

    function configuracionAdicional () {
        oTable =$('#example').dataTable({
            "bDestroy": true,
            "sPaginationType": "full_numbers",
            // "aLengthMenu": [[5, 10, 15, -1], [5, 10, 15, "All"]],
            "aLengthMenu": [[3], [3]],
            "iDisplayLength": 3,
            });
    }

    function verificaReferido () {
        var referido;
        if ($('#optCliente').length>0) {
            referido=$("input[name='optCliente']:checked").val();
        } else{
            referido= null;
        }
        return referido;
    }

    function agregaNumero (agenda, numero, tipo, emergencia, nombre, parentesco) {
        agenda.push({
            numeroTel       : numero,
            tipoTel         : tipo,
            txtEmergencia   : emergencia,
            nombreTel       : nombre,
            parentescoTel   : parentesco
        });
    };

    function verificaNumeroEnAgenda (agenda, numero) {
        var encontrado;
        $.each(agenda, function(index,val){
            if(JSON.stringify(val)==JSON.stringify(numero)) {
                encontrado = true;
            }else{
                encontrado = false;
            };
        });
        return encontrado;
    };

    function agendaSinNumeros (agenda) {
        if (agenda.length==0) {
            return true;
        }else{
            return false;
        }
    };

    function creaEventoEliminarNumero(agenda){
        $('.btnClose').on('click',function(event){
            event.preventDefault();
            var id  =   $(this).attr('id');
            // $(this).parent('span').attr('class', id).detach();
            $(this).parent('span').detach();
            agenda[id-1]=null;
            console.debug(listaNumeros);
        });
    };

    function agregaEtiqueta (tipo, contador, descripcion, numero, nombre, parentesco, emergencia, agenda) {
        var maxFijo = 1;
        var maxMovil = 6;
        if (emergencia == 0) {
            if (tipo<=maxFijo){
                etiqueta=   '<span class="label label-default lblNumero ' + contador + ' col-12">'+ descripcion + ' - ' + numero +'<a id="'+contador+'" class="btnClose close" data-dismiss="modal" aria-hidden="true">&times;</a></span>';
            }else{
                if (tipo<=maxMovil){
                    etiqueta=   '<span class="label label-info lblNumero ' + contador + ' col-12">'+ descripcion + ' - ' + numero +'<a id="'+contador+'" class="btnClose close" data-dismiss="modal" aria-hidden="true">&times;</a></span>';
                };
            };
        }else{
            etiqueta=   '<span class="label label-danger lblNumero ' + contador + ' col-12"><p>' + nombre + " => " + parentesco + " </p>" + descripcion + ' - ' + numero +'<a id="'+contador+'" class="btnClose close" data-dismiss="modal" aria-hidden="true">&times;</a></span>';
        };
        $('#boxNumeros').append(etiqueta);
        creaEventoEliminarNumero( agenda );
    };


    listacliente();
    ////////////////////////// fin formulario personal //////////////////////////////
});