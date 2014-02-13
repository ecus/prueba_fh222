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


    $('#btnConsultar').on('click',function(event){
        var boton = $(this).children('i');
        boton.removeClass('fa-search');
        boton.addClass('fa-spinner fa-spin');
        $.post("buscasocio", {
            cmbsocio:$(txtDni).val()
        },function(data){
            if(data.response == false){
                console.log('no se puede registrar');
            }else{
                var socio     =    data[0];
                if (socio) {
                    $(txtCliente).val(socio.nombres_Soc);
                }else{
                    muestraMensaje('modalIns', 'msjeModal', 'No se encontró resultados.');
                };
                boton.removeClass('fa-spinner fa-spin');
                boton.addClass('fa-search');
            };
        }, 'json');
    });
    function limpiaControles () {
        limpiaControlesBasico();
    }
});