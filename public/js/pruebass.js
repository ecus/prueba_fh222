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

        function agregaEtiqueta (tipo, contador, descripcion, numero, nombre, parentesco, agenda) {
            var maxFijo = 1;
            var maxMovil = 6;
            if (tipo<=maxFijo){
                etiqueta=   '<span class="label label-default lblNumero ' + contador + ' col-12">'+ descripcion + ' - ' + numero +'<a id="'+contador+'" class="btnClose close" data-dismiss="modal" aria-hidden="true">&times;</a></span>';
            }else{
                if (tipo<=maxMovil){
                    etiqueta=   '<span class="label label-info lblNumero ' + contador + ' col-12">'+ descripcion + ' - ' + numero +'<a id="'+contador+'" class="btnClose close" data-dismiss="modal" aria-hidden="true">&times;</a></span>';
                }else{
                    etiqueta=   '<span class="label label-danger lblNumero ' + contador + ' col-12"><p>' + nombre + " => " + parentesco + " </p>" + descripcion + ' - ' + numero +'<a id="'+contador+'" class="btnClose close" data-dismiss="modal" aria-hidden="true">&times;</a></span>';
                };
            };
            $('#boxNumeros').append(etiqueta);
            creaEventoEliminarNumero( agenda );
        };


        $('#btnAgregaTel').on('click', function(event) {
            event.preventDefault();
            var cantidad    =   $('#boxNumeros span').length;
            var numero      =   $('#txtNumero').val();
            var tipo        =   $('#cmbTipoCel').val();
            var infoTipo    =   $('#cmbTipoCel option[value="'+tipo+'"]').text();
            var nombreTele  =   ($('#txtNombreTel').val())?$('#txtNombreTel').val():null;
            var parentesco  =   ($('#txtParentesco').val())?$('#txtParentesco').val():null;
            // var etiqueta    =   '';
            if (agendaSinNumeros) {
                contadorNumero  +=  1;
                agregaNumero(listaNumeros,numero, tipo, null, null, null);
                agregaEtiqueta( tipo, contadorNumero, infoTipo, numero, parentesco, listaNumeros);
            }else{
                contadorNumero  +=  1;
                var objetoNumero = {
                    numeroTel  : numero, tipoTel : tipo,
                    emergenciaTel : emergencia, nombreTel  :   nombreTele, parentescoTel : parentesco 
                    };
                if (verificaNumeroEnAgenda(listaNumeros , objetoNumero)) {
                    agregaNumero(listaNumeros,numero, tipo, null, null, null);
                    agregaEtiqueta( tipo, contadorNumero, infoTipo, numero, parentesco, listaNumeros);
                };
            };
        });

/*        function numeroValido (control) {
            var maximoCaracteres = 10;
            if (control.val().length<= maximoCaracteres){
                return true;
            }else{
                return false;
            }
        };*/
/*        $('#btnAgregaTel').on('click', function(event){
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
                                limpiaTelefono();
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
                                if(JSON.stringify(val)==JSON.stringify(
                                    {numeroTel  : numero,tipoTel : tipo,emergenciaTel : emergencia, nombreTel  :   nombreTele,parentescoTel : parentesco })) {
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
                    console.debug(listaNumeros);
                });
            };
        });*/