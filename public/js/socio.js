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
            console.log(ciudad);
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
                        console.log(index+'=>'+val);
                        distritos += '<option value="'+index+'">'+val+'</option>';
                    });
                    $(cmbDistrito).html(distritos);
                    $('#barraDistrito').slideUp();
                }
            }, 'json');
        });
        $('#btnRegSocio').on('click',function(event){
            if($("#frmSocio").valid()){
                console.log("paso");
                if (usuario==0) {
                	var op 	="regsocio";
                } else{
                	var op 	="regusuariosocio";
                };
                $.post(op, {
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
						cmbsocio    : $(cmbsocio).val(),
						cmbempresa  : $(cmbempresa).val(),
						txtPersonal : $(txtPersonal).val(),
						cmbDistrito : $(cmbDistrito).val(),
                        telefonos   : listaNumeros,
                        txtUsuario  :$(txtUsuario).val(),
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
        $('#btnRegUsSocio').on('click',function(event){
            if($("#frmSocio").valid()){
                $.post("regusuariosocio", {
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
						cmbsocio    : $(cmbsocio).val(),
						cmbempresa  : $(cmbempresa).val(),
						txtPersonal : $(txtPersonal).val(),
						cmbDistrito : $(cmbDistrito).val(),
                        txtUsuario  :$(txtUsuario).val(),
                        telefonos   : listaNumeros
                    },function(data){
                        if(data.response == false){
                            console.log('no se puede registrar');
                        }else{
                            limpiaControles();
                            $("#msjeModal").empty().html(data.response);
                            $("#modalSocio").modal();
                           // listasucursal('A');
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
                    }else{
                        $.each(listaNumeros, function(index,val){
                            if(JSON.stringify(val)==JSON.stringify({numeroTel : numero,tipoTel : tipo,emergenciaTel:0})) {
                                $('#msjeModal').empty().html('Número ya esta en lista.');
                                $('#modalSocio').modal('show');
                            }else{
                                contadorNumero  +=  1;
                                listaNumeros.push({
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
                            numeroTel  : numero,
                            tipoTel    : tipo,
                            emergenciaTel : emergencia,
                            nombreTel  :   nombreTele,
                            parentescoTel : parentesco
                        });
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
                                        numeroTel  : numero,
                                        tipoTel    : tipo,
                                        emergenciaTel : emergencia,
                                        nombreTel  :   nombreTele,
                                        parentescoTel : parentesco
                                    });
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
                console.debug(listaNumeros);
                //////
                $('.btnClose').on('click',function(event){
                    event.preventDefault();
                    var id  =   $(this).attr('id');
                    // $(this).parent('span').attr('class', id).detach();
                    $(this).parent('span').detach();
                    listaNumeros[id-1]=null;
                    console.debug(listaNumeros);
                });
            };
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
        function limpiaControles(){
            $(txtDni).removeAttr('disabled');
            $(txtId).val('');
            $(txtEstado).val('');
            $(txtDni).val('');
            $(txtNombre).val('');
            $(txtApPaterno).val('');
            $(txtApMaterno).val('');
            $(dtpFechanac).val('');
            $(txtSexo).val(0);
            $(txtEmail).val('');
            $(txtUsuario).val('');
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
        };
        ////////////////////////// fin formulario personal //////////////////////////////

  });