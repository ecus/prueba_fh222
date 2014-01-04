jQuery(function($){
	$(".collapse").collapse();
	$('#btnBuscaPlan').on('click',function(event){
            var boton = $(this).children('i');
			$('#datosPlan').removeAttr('disabled');
            limpiaControles();
            boton.removeClass('fa-search');
            boton.addClass('fa-spinner fa-spin');
            if ($(cmbPlanBase).val()) {
                $.post("resumenplan",{
                    cmbPlanBase :   $(cmbPlanBase).val(),
                }, function(data) {
                    if (data.response == false){
                        console.log ('No se puede registrar');
                    }else{
                        info    =   data.info;
                        suc     =   data.sucursal;
                        serv    =   data.serv;
                        $(txtNombre).val(info.nombre_serv);
                        $(txtMonto).val(Math.floor(info.montoBase_serv));
                        $(txtDuracion).val(info.duracion_serv);
                        $(txtdiasCupon).val(info.diascupon_Serv);
                        $(txtfreezing).val(info.freezing_serv);
                        $(txtMontoIni).val(Math.floor(info.montoinicial_Serv));
                        $(txtCuotaMax).val(info.cuotasMaximo_serv);
                        $(chkLimite).val(info.pagoMaximo_serv);
                        $(chkLimite).prop('checked', true);
                        $("#btnVigencia"+info.tipoduracion_serv).val(1);
                        $("#btnVigencia"+info.tipoduracion_serv).parent("label").addClass('active');
                        $.each(suc, function() {
                            var nombre = $(this)[0].nombre_suc;
                            $.each($("#lstSucursal option"), function() {
                                   if ($(this).text()==nombre) {
                                        $(this).attr('selected', 'selected');
                                   };
                              });
                        });
                        $.each(serv, function() {
                            var nombre = $(this)[0].nombre_serv;
                            $.each($("#lstServicios option"), function() {
                                   if ($(this).text()==nombre) {
                                        $(this).attr('selected', 'selected');
                                   };
                              });
                        });
                        boton.removeClass('fa-spinner fa-spin');
                        boton.addClass('fa-search');
                        $('#datosPlan').attr('disabled', true);
                    }
                },'json');
            } else{
                $("#msjeModal").empty().html("Selecione un plan de referencia.");
                $("#modalServicio").modal();
                boton.removeClass('fa-spinner fa-spin');
                boton.addClass('fa-search');
            };
	});
    $('#btnRegPlan').on('click', function(event) {
        event.preventDefault();
        var datos;
        var accion = '';
        console.log($('#cmbPlanBase').val());
        if ( $('#cmbPlanBase').val() > 0 ) {
            accion = 'regpromobase';
            datos = {
                cmbTipoPro      :$(cmbTipoPro).val(),
                txtPersonal     :$(txtPersonal).val(),
                cmbPlanBase     :$(cmbPlanBase).val(),
                dtpFechaIni     :$(dtpFechaIni).val(),
                dtpFechaFin     :$(dtpFechaFin).val(),
                txtMontoPro     :$(txtMontoPro).val(),
                txtdiasPro      :$(txtdiasPro).val(),
                txtPorcentaje   :$(txtPorcentaje).val(),
                txtEmpresaMin   :$(txtEmpresaMin).val(),
                txtEmpresaMax   :$(txtEmpresaMax).val()
            };
        } else{
            accion = 'regpromo';
            datos = {
                cmbTipoPro      :$(cmbTipoPro).val(),
                txtMonto        :$(txtMonto).val(),
                txtTipo         :$(txtTipo).val(),
                txtNombre       :$(txtNombre).val(),
                txtdiasCupon    :$(txtdiasCupon).val(),
                txtfreezing     :$(txtfreezing).val(),
                txtMontoIni     :$(txtMontoIni).val(),
                dtpFecha        :$(dtpFecha).val(),
                txtTipoDuracion :$(txtTipoDuracion).val(),
                txtCuotaMax     :$(txtCuotaMax).val(),
                txtDuracion     :$(txtDuracion).val(),
                lstSucursal     :$(lstSucursal).val(),
                lstServicios    :$(lstServicios).val(),
                txtPersonal     :$(txtPersonal).val(),
                chkLimite       :($(chkLimite).attr('checked'))?1:0,
                dtpFechaIni     :$(dtpFechaIni).val(),
                dtpFechaFin     :$(dtpFechaFin).val(),
                txtMontoPro     :$(txtMontoPro).val(),
                txtdiasPro      :$(txtdiasPro).val(),
                txtPorcentaje   :$(txtPorcentaje).val(),
                txtEmpresaMin   :$(txtEmpresaMin).val(),
                txtEmpresaMax   :$(txtEmpresaMax).val()
            };
        };
        $.post(accion,
            datos
        ,function(data){
            console.debug(data.response);
        },'json');
    });
	$('#dtpFechaFin').on('focus', function(event) {
		event.preventDefault();
		if ( $('#dtpFechaIni').val().length > 0 ) {
			$(this).attr('min', $('#dtpFechaIni').val());
		} else{
			$("#msjeModal").empty().html('Debe Llenar la fecha de incio, para editar esta fecha.');
			$("#modalServicio").modal();
		};
	});
	$('#dtpFechaFin').on('focusout', function(event) {
		event.preventDefault();
		if ( $('#dtpFechaIni').val() > $(this).val() ) {
			$("#msjeModal").empty().html('Fecha debe ser mayor o igual a la fecha de inicio.');
			$("#modalServicio").modal();
		};
	});
    function limpiaControles () {
        $('#dtpFechaIni').val('');
        $('#dtpFechaFin').val('');
        $('#txtMontoPro').val('');
        $('#txtdiasPro').val('');
        $('#txtPorcentaje').val('');
        $('#txtEmpresaMin').val('');
        $('#txtEmpresaMax').val('');
        $('#btnCancelar').click();
        $.each($("#lstServicios option"), function() {
                $(this).removeAttr('selected');
        });
        $.each($("#lstSucursal option"), function() {
                $(this).removeAttr('selected');
        });
    };
});