jQuery(function($){
		var usuario			=	0;
        var distrito        =   -1;
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
        $('#cmbCiudad').change(function (){
            var ciudad = $(this).val();
            $('#barraDistrito').slideDown();
            $.post("lisciudad", {
                id  :   $(this).val()
            },function(data){
                if(data.response == false){
                    console.log('no se puede encontrar');
                }else{
                    // console.debug(data);
                    $('#cmbDistrito').find('option').remove().end();
                    var distritos = '<option value="">Seleccione...</option>';
                    $.each(data, function(index, val) {
                        // console.log(index+'=>'+val);
                        distritos += '<option value="'+index+'">'+val+'</option>';
                    });
                    $(cmbDistrito).html(distritos);
                    $('#barraDistrito').slideUp();
                    if ( distrito > 0 ) {
                        $('#cmbDistrito option[value="'+distrito+'"]').attr('selected', true);
                        distrito = 0;
                    };
                }
            }, 'json');
        });
        $('#btnRegSocio').on('click',function(event){
            if($("#frmSocio").valid()){
                if (usuario==0) {
                	var op 	="actsocio";
                } else{
                	var op 	="actusuariosocio";
                };
                $.post(op, {
                        txtId       : $(txtId).val(),
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
						// cmbsocio    : (optCliente.length>0)?$(optCliente).val():null,
						cmbempresa  : $(cmbempresa).val(),
						txtPersonal : $(txtPersonal).val(),
						cmbDistrito : $(cmbDistrito).val(),
                        telefonos   : listaNumeros,
                        txtUsuario  : $(txtUsuario).val(),
                        dtpFechaVisita      : $(dtpFechaVisita).val(),
                        dtpFechareg         : $(dtpFechareg).val(),
                        dtpFechaInvitacion  : $(dtpFechaInvitacion).val()
                    },function(data){
                        if(data.response == false){
                            console.log('no se puede registrar');
                        }else{
                            limpiaControles();
                            $("#msjeModal").empty().html(data.response);
                            $("#modalSocio").modal();
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
        $('#btnAgregaTel').on('click', function(event){
            event.preventDefault();
            if ($('#txtNumero').val().length<=10){
                var cantidad    =   $('#boxNumeros span').length;
                var numero      =   $('#txtNumero').val();
                var tipo        =   $('#cmbTipoCel').val();
                var infoTipo    =   $('#cmbTipoCel option[value="'+tipo+'"]').text();
                var etiqueta    =   '';
                if ($('#txtEmergencia').val()==0){
                    if (listaNumeros.length==0){
                        listaNumeros.push({
                                idnum      : 0,
                                numeroTel  : numero,
                                tipoTel    : tipo,
                                emergenciaTel:0,
                                nombreTel  :   null,
                                parentescoTel : null
                                });
                                contadorNumero  +=  1;
                                if (tipo<=1){
                                    // Fijo
                                    etiqueta=   '<span class="label label-default lblNumero ' + contadorNumero + ' col-12">'+ infoTipo + ' - ' + numero +'<a id="'+contadorNumero+'" class="btnClose close" data-dismiss="modal" aria-hidden="true">&times;</a></span>';
                                }else{
                                    if (tipo<=6){
                                        // Movil
                                        etiqueta=   '<span class="label label-info lblNumero ' + contadorNumero + ' col-12">'+ infoTipo + ' - ' + numero +'<a id="'+contadorNumero+'" class="btnClose close" data-dismiss="modal" aria-hidden="true">&times;</a></span>';
                                    };
                                };
                                limpiaTelefono();
                    }else{
                        $.each(listaNumeros, function(index,val){
                            if(JSON.stringify(val)==JSON.stringify({numeroTel : numero,tipoTel : tipo,emergenciaTel:0})) {
                                $('#msjeModal').empty().html('Número ya esta en lista.');
                                $('#modalSocio').modal('show');
                            }else{
                                contadorNumero  +=  1;
                                listaNumeros.push({
                                    idnum      : 0,
                                    numeroTel  : numero,
                                    tipoTel    : tipo,
                                    emergenciaTel:0,
                                    nombreTel  :   null,
                                    parentescoTel : null
                                });
                                if (tipo<=1){
                                    // Fijo
                                    etiqueta=   '<span class="label label-default lblNumero ' + contadorNumero + ' col-12">'+ infoTipo + ' - ' + numero +'<a id="'+contadorNumero+'" class="btnClose close" data-dismiss="modal" aria-hidden="true">&times;</a></span>';
                                }else{
                                    if (tipo<=6){
                                        // Movil
                                        etiqueta=   '<span class="label label-info lblNumero ' + contadorNumero + ' col-12">'+ infoTipo + ' - ' + numero +'<a id="'+contadorNumero+'" class="btnClose close" data-dismiss="modal" aria-hidden="true">&times;</a></span>';
                                    };
                                };
                                limpiaTelefono();
                                return false;
                            };
                        });
                    };
                }else{
                    var nombreTele   =   $('#txtNombreTel').val();
                    var parentesco   =   $('#txtParentesco').val();
                    // emergencia
                    emergencia=$('#txtEmergencia').val();
                    if (listaNumeros.length==0){
                        contadorNumero  +=  1;
                        etiqueta=   '<span class="label label-danger lblNumero ' + contadorNumero + ' col-12"><p>' + nombreTele + " => " + parentesco + " </p>" + infoTipo + ' - ' + numero +'<a id="'+contadorNumero+'" class="btnClose close" data-dismiss="modal" aria-hidden="true">&times;</a></span>';
                        listaNumeros.push({
                            idnum      : 0,
                            numeroTel  : numero,
                            tipoTel    : tipo,
                            emergenciaTel : emergencia,
                            nombreTel  :   nombreTele,
                            parentescoTel : parentesco
                        });
                        limpiaTelefono();
                    }else{
                        contadorNumero  +=  1;
                        if (nombreTele.length>0 && parentesco.length>0){
                            $.each(listaNumeros, function(index,val){
                                if(JSON.stringify(val)==JSON.stringify({numeroTel  : numero,tipoTel : tipo,emergenciaTel : emergencia, nombreTel  :   nombreTele,parentescoTel : parentesco })) {
                                    $('#msjeModal').empty().html('Número ya esta en lista.');
                                    $('#modalSocio').modal('show');
                                }else{
                                    etiqueta=   '<span class="label label-danger lblNumero ' + contadorNumero + ' col-12"><p>' + nombreTele + " => " + parentesco + " </p>" + infoTipo + ' - ' + numero +'<a id="'+contadorNumero+'" class="btnClose close" data-dismiss="modal" aria-hidden="true">&times;</a></span>';
                                    listaNumeros.push({
                                        idnum      : 0,
                                        numeroTel  : numero,
                                        tipoTel    : tipo,
                                        emergenciaTel : emergencia,
                                        nombreTel  :   nombreTele,
                                        parentescoTel : parentesco
                                    });
                                    limpiaTelefono();
                                };
                                return false;
                            });
                        }else{
                            $('#msjeModal').empty().html('Debe completar los campos de Nombre y parentesco');
                            $('#modalSocio').modal();
                        };
                    };
                };
                $('#boxNumeros').append(etiqueta);
                // console.debug(listaNumeros);
                //////
                $('.btnClose').on('click',function(event){
                    event.preventDefault();
                    var id  =   $(this).attr('id');
                    // $(this).parent('span').attr('class', id).detach();
                    $(this).parent('span').detach();
                    listaNumeros[id-1]=null;
                    // console.debug(listaNumeros);
                });
            };
        });
        $('#txtNumero').keypress(function(e) {
            if (e.which == 13 && $(this).val().length>=6 && $(this).val().length<=10 ) {
                $("#btnAgregaTel").click();
            }
        });
        $('#txtNombreTel').keypress(function(e) {
            if (e.which == 13 && $(this).val().length>=6 && $('#txtNumero').val().length<=10 ) {
                $("#btnAgregaTel").click();
            }
        });
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
            if(rpta=='Si'){
                if(nombre.length>0 && apellido.length>0){
                    $("#boxAcceso").slideDown();
                    $(optUsuario).val('1');
                    $(txtUsuario).attr('placeholder',user);
                    $(txtUsuario).val(user);
                    usuario	=	1;
                }else{
                    $('#msjeModal').empty().html('Debe completar los campos de Nombre y Apellido Paterno');
                    $('#modalSocio').modal();
                    usuario	=	0;
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
        function agregaTelefono (num) {
            // Socio_id_Soc: "2"
            // emergencia_Tel: "0"
            // id_Tel: "3"
            // nombreEmergencia_Tel: ""
            // numero_Tel: "227860"
            // parentesco_Tel: ""
            // tipo_tel: "1"
            if (num.numero_Tel.length<=10){
                var cantidad    =   $('#boxNumeros span').length;
                var idnum       =   num.id_Tel;
                var numero      =   num.numero_Tel;
                var tipo        =   num.tipo_tel;
                var infoTipo    =   $('#cmbTipoCel option[value="'+tipo+'"]').text();
                var etiqueta    =   '';
                if (num.emergencia_Tel==0){
                    if (listaNumeros.length==0){
                        listaNumeros.push({
                                idnum      : idnum,
                                numeroTel  : numero,
                                tipoTel    : tipo,
                                emergenciaTel:0,
                                nombreTel  :   null,
                                parentescoTel : null
                                });
                                contadorNumero  +=  1;
                                if (tipo<=1){
                                    // Fijo
                                    etiqueta=   '<span class="label label-default lblNumero ' + contadorNumero + ' col-12">'+ infoTipo + ' - ' + numero +'<a id="'+contadorNumero+'" class="btnClose close" data-dismiss="modal" aria-hidden="true">&times;</a></span>';
                                }else{
                                    if (tipo<=6){
                                        // Movil
                                        etiqueta=   '<span class="label label-info lblNumero ' + contadorNumero + ' col-12">'+ infoTipo + ' - ' + numero +'<a id="'+contadorNumero+'" class="btnClose close" data-dismiss="modal" aria-hidden="true">&times;</a></span>';
                                    };
                                };
                                // limpiaTelefono();
                    }else{
                        $.each(listaNumeros, function(index,val){
                            if(JSON.stringify(val)==JSON.stringify({numeroTel : numero,tipoTel : tipo,emergenciaTel:0})) {
                                $('#msjeModal').empty().html('Número ya esta en lista.');
                                $('#modalSocio').modal('show');
                            }else{
                                contadorNumero  +=  1;
                                listaNumeros.push({
                                    idnum      : idnum,
                                    numeroTel  : numero,
                                    tipoTel    : tipo,
                                    emergenciaTel:0,
                                    nombreTel  :   null,
                                    parentescoTel : null
                                });
                                if (tipo<=1){
                                    // Fijo
                                    etiqueta=   '<span class="label label-default lblNumero ' + contadorNumero + ' col-12">'+ infoTipo + ' - ' + numero +'<a id="'+contadorNumero+'" class="btnClose close" data-dismiss="modal" aria-hidden="true">&times;</a></span>';
                                }else{
                                    if (tipo<=6){
                                        // Movil
                                        etiqueta=   '<span class="label label-info lblNumero ' + contadorNumero + ' col-12">'+ infoTipo + ' - ' + numero +'<a id="'+contadorNumero+'" class="btnClose close" data-dismiss="modal" aria-hidden="true">&times;</a></span>';
                                    };
                                };
                                // limpiaTelefono();
                                return false;
                            };
                        });
                    };
                }else{
                    var nombreTele   =   num.nombreEmergencia_Tel;
                    var parentesco   =   num.parentesco_Tel;
                    // emergencia
                    emergencia=$('#txtEmergencia').val();
                    if (listaNumeros.length==0){
                        contadorNumero  +=  1;
                        etiqueta=   '<span class="label label-danger lblNumero ' + contadorNumero + ' col-12"><p>' + nombreTele + " => " + parentesco + " </p>" + infoTipo + ' - ' + numero +'<a id="'+contadorNumero+'" class="btnClose close" data-dismiss="modal" aria-hidden="true">&times;</a></span>';
                        listaNumeros.push({
                            idnum      : idnum,
                            numeroTel  : numero,
                            tipoTel    : tipo,
                            emergenciaTel : emergencia,
                            nombreTel  :   nombreTele,
                            parentescoTel : parentesco
                        });
                        limpiaTelefono();
                    }else{
                        contadorNumero  +=  1;
                        if (nombreTele.length>0 && parentesco.length>0){
                            $.each(listaNumeros, function(index,val){
                                if(JSON.stringify(val)==JSON.stringify({numeroTel  : numero,tipoTel : tipo,emergenciaTel : emergencia, nombreTel  :   nombreTele,parentescoTel : parentesco })) {
                                    $('#msjeModal').empty().html('Número ya esta en lista.');
                                    $('#modalSocio').modal('show');
                                }else{
                                    etiqueta=   '<span class="label label-danger lblNumero ' + contadorNumero + ' col-12"><p>' + nombreTele + " => " + parentesco + " </p>" + infoTipo + ' - ' + numero +'<a id="'+contadorNumero+'" class="btnClose close" data-dismiss="modal" aria-hidden="true">&times;</a></span>';
                                    listaNumeros.push({
                                        idnum      : idnum,
                                        numeroTel  : numero,
                                        tipoTel    : tipo,
                                        emergenciaTel : emergencia,
                                        nombreTel  :   nombreTele,
                                        parentescoTel : parentesco
                                    });
                                    limpiaTelefono();
                                };
                                return false;
                            });
                        }else{
                            $('#msjeModal').empty().html('Debe completar los campos de Nombre y parentesco');
                            $('#modalSocio').modal();
                        };
                    };
                };
                $('#boxNumeros').append(etiqueta);
                // console.debug(listaNumeros);
                //////
                $('.btnClose').on('click',function(event){
                    event.preventDefault();
                    var id  =   $(this).attr('id');
                    // $(this).parent('span').attr('class', id).detach();
                    $(this).parent('span').detach();
                    listaNumeros[id-1]=null;
                    // console.debug(listaNumeros);
                });
            };
        };
        function limpiaTelefono () {
            $("cmbTipoCel option:nth(0)").attr('selected', true);
            $(txtNumero).val('');
            $(txtParentesco).val('');
            $(txtNombreTel).val('');
            $("#boxInfoEmergencia").slideUp();
            $.each($('.btnEmergencia'), function() {
                if ($(this).text()=='No') {
                    $(this).click();
                };
            });
        };
        function limpiaControles(){
            $(txtDni).removeAttr('disabled');
            $(txtId).val('');
            $(txtEstado).val('');
            $(txtDni).val('');
            $(txtNombre).val('');
            $(txtApPaterno).val('');
            $(txtApMaterno).val('');
            $(dtpFechanac).val('');
            $(txtDireccion).val('');
            $(txtEmergencia).val('');
            $(txtSexo).val(0);
            $(txtEmail).val('');
            $(txtUsuario).val('');
            $("cmbSexo option:nth(0)").attr('selected', true);
            $("cmbecivil option:nth(0)").attr('selected', true);
            $("cmbCiudad option:nth(0)").attr('selected', true);
            $("cmbDistrito option:nth(0)").attr('selected', true);
            $("cmbempresa option:nth(0)").attr('selected', true);
            $("#btnSexo0").removeClass('active');
            $("#btnSexo1").removeClass('active');
            $("#btnEstado0").removeClass('active');
            $("#btnEstado1").removeClass('active');
            $("#btnUper0").removeClass('active');
            $("#btnUper1").removeClass('active');
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
                        oTable =$('#example').dataTable({
                                "bDestroy": true,
                                "aaData":data,
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
                                              { "bSortable": false,"sWidth": "1%", "aTargets": [ 0 ] }
                                            ],
                                "bPaginate": false,
                            });

                            $('#example tbody tr').each( function() {
                                var sTitle;
                                var nTds = $('td', this);
                                var id = $(nTds[0]).text();
                                $(nTds[0]).text("");
                                var botones='';
                                botones += '<a class="btnVerSocio" id="'+id+'"><i class="btn fa fa-pencil-square-o zf-green"></i></a>';
                                $(nTds[0]).append(botones);
                            });
                            $('.btnVerSocio').on('click', function(event) {
                                event.preventDefault();
                                listaNumeros = [];
                                $('#boxNumeros').html("");
                                var id =    $(this).attr('id');
                                $.post("versocio", {
                                            cmbsocio : id
                                        },
                                        function(data){
                                            if(data.response == false){
                                                console.log('no se puede registrar');
                                            }else{
                                                var soc     =   data['info'];
                                                var tel     =   data['numeros'];
                                                $(txtId).val(soc.id_Soc);
                                                $(txtDni).val(soc.documento_soc);
                                                $(txtNombre).val(soc.nombres_Soc);
                                                $(txtApPaterno).val(soc.apellidoMaterno_Soc);
                                                $(txtApMaterno).val(soc.apellidoPaterno_Soc);
                                                $(txtDireccion).val(soc.direccion_Soc);
                                                $(txtEmail).val(soc.email_Soc);
                                                $(lblPersonal).val(soc.Personal_id_Per);
                                                $(dtpFechanac).val(soc.fechaNacimiento_Soc);
                                                $('#cmbSexo option[value="'+soc.sexo_Soc+'"]').attr('selected', true);
                                                $('#cmbecivil option[value="'+soc.estadoCivil_Soc+'"]').attr('selected', true);
                                                $('#cmbCiudad option[value="'+soc.ciudad_Soc+'"]').attr('selected', true);
                                                distrito=soc.Distrito_id_Dis;
                                                $('#cmbCiudad').change();
                                                // $('#cmbDistrito option[value="'+soc.Distrito_id_Dis+'"]').attr('selected', true);
                                                $('#cmbDocumento option[value="'+soc.tipoDocumento_soc+'"]').attr('selected', true);
                                                $('#cmbestado option[value="'+soc.estado_Soc+'"]').attr('selected', true);
                                                $('#cmbempresa option[value="'+soc.empresa_id_emp+'"]').attr('selected', true);
                                                $(dtpFechaVisita).val(soc.fechaInvitacion_Soc);
                                                $(dtpFechareg).val(soc.fechaRegistro_Soc);
                                                $(dtpFechaInvitacion).val(soc.fechaVisita_Soc);
                                                $.each(tel, function () {
                                                    agregaTelefono( $(this)[0] );
                                                });
                                                console.debug(listaNumeros);
                                            }
                                            $("#barra").slideUp();
                                        }, 'json');
                            });
                        oTable =$('#example').dataTable({
                            "bDestroy": true,
                            "sPaginationType": "full_numbers",
                            "aLengthMenu": [[3], [3]],
                            "iDisplayLength": 3,
                            });
                    },'json');

                    $("#barra").slideUp();
    };
    listacliente();
    ////////////////////////// fin formulario personal //////////////////////////////
});