jQuery(function($){
	var duracion	=['Dia(s)','Semana(s)','Quincena(s)','Mes(es)'];
	var tipo		=['Servicio Base','Plan'];
	var tipoDuracion=['Fin de Mes','No definido'];
	var tipoPromo	=['Precio','Empresa','Porcentual','Dias'];
	var diasSemana = new Array();
	diasSemana['L'] = "Lunes";
	diasSemana['M'] = "Martes";
	diasSemana['W'] = "Miercoles";
	diasSemana['J'] = "Jueves";
	diasSemana['V'] = "Viernes";
	diasSemana['S'] = "Sabado";
	diasSemana['D'] = "Domingo";
	$('.tipoPromolbl').hide();
	$('.boxReporte').hide();
	$('.horaPromo').hide();
	$('.base').hide();
	$('#boxContenido').slideUp();
	$('#barra').slideUp();
	$('#btnBuscar').on('click',function(event){
		console.log($(cmbServicio).val());
		$('#barra').slideDown();
		$.post("resumenserv",{
			cmbServicio        :$(cmbServicio).val()
		}, function(data) {
			if (data.response == false){
				console.log ('No se encontro plan.');
			}else{
				console.debug(data);
				var info	=	data['info'];
				var promo	=	data['promo'];
				var serv	=	data['serv'];
				var sucursal=	data['sucursal'];
				var horario	=	data['horario'];
				var dHora	=	data['dHora'];
				console.debug(promo);
				if(info){
					$('#boxInfo').show();
					// console.debug(info);
					$('#lblTipo').empty().html(tipo[info.tipo_serv]);
					$('#lblNombre').empty().html(info.nombre_serv);
					$('#lblPrecio').empty().html(info.montoBase_serv);
					$('#lblCupon').empty().html(info.diascupon_Serv);
					$('#lblFreezing').empty().html(info.freezing_serv);
					$('#lblVigencia').empty().html(info.duracion_serv + ' ' + duracion[info.tipoduracion_serv]);
					$('#lblCuota').empty().html((info.cuotasMaximo_serv==0)?'No se permite Fraccionamiento':info.cuotasMaximo_serv);
					$('#lblMontoInicial').empty().html((info.montoinicial_Serv)?info.montoinicial_Serv:'No se permite Fraccionamiento');
					$('#lblPeriodo').empty().html(tipoDuracion[info.pagoMaximo_serv]);
					// $('#lblFechaRegServ').empty().html(info.fechaRegistro_serv.substring(0,10));
					$('#lblFechaRegServ').empty().html(info.fechaRegistro_serv);
					$('#lblPromo').empty().html((info.promocion_serv==0)?'Plan o Servicio Regular':'Plan o Servicio Promocional');
					// $('#').empty().html(info.id_serv);
					if (info.servicioBase_serv){
						$('.base').show();
						$('#lblServicioBase').empty().html(info.servicioBase_serv);
					};
					$('#lblPersonalRegServ').empty().html(info.personal_serv);
				};
				if(promo){
					$('#boxPromo').show();
					$('#lblTipoPromo').empty().html(tipoPromo[promo.tipoPromocion_DPromo-1]);
					$('#lblPeriodoPromo').empty().html(promo.fechaInicio_DPromo + ' - ' + promo.fechaFin_DPromo);
					// console.log(promo.tipoPromocion_DPromo);
					// switch (promo.tipoPromocion_DPromo){
					if(promo.tipoPromocion_DPromo==1){
						console.log(promo.tipoPromocion_DPromo);
						$('label[for="lblDsctoPrecio"]').show();
						$('#lblDsctoPrecio').show();
						$('#lblDsctoPrecio').empty().html('S/. '+promo.montoPromocion_DPromo);
					}else if(promo.tipoPromocion_DPromo==2){
						console.log(promo.tipoPromocion_DPromo);
						$('label[for="lblDsctoEmpresa"]').show();
						$('#lblDsctoEmpresa').show();
						$('#lblDsctoEmpresa').empty().html('S/. '+promo.montoPromocion_DPromo);
						// $('#').empty().html(promo.empresaMax_DPromo);
						// $('#').empty().html(promo.empresaMin_DPromo);
					}else if(promo.tipoPromocion_DPromo==3){
						console.log(promo.tipoPromocion_DPromo);
						$('label[for="lblDsctoPorcentual"]').show();
						$('#lblDsctoPorcentual').show();
						$('#lblDsctoPorcentual').empty().html(promo.porcentaje_DPromo+' %');
					}else if(promo.tipoPromocion_DPromo==3){
						console.log(promo.tipoPromocion_DPromo);
						$('label[for="lblDsctoDias"]').show();
						$('#lblDsctoDias').show();
						$('#lblDsctoDias').empty().html(promo.dias_DPromo+' Días.');
					};
					if(promo.horario_DPromo==1){
						$('.horaPromo').show();
						$('label[for="lblHorarioPromo"]').show();
						$('#lblHorarioPromo').empty().html('Si.');
					}else{
						$('.horaPromo').show();
						$('label[for="lblHorarioPromo"]').show();
						$('#lblHorarioPromo').empty().html('No.');
					};
				};
				if(sucursal){
					$('#boxSucursal').show();
					$('#boxSucursal').empty();
					$('#boxSucursal').append('<legend>Sucursales que cuentan con este servicio</legend>');
					$.each(sucursal, function() {
						$('#boxSucursal').append('<li>'+$(this)[0].nombre_suc+'</li>');
					});
					$('#boxSucursal').append('<br /><br />');
				};
				if(horario){
					$('#boxHorario').show();
					$('#boxHorario').empty();
					var contador	=	0;
					$.each(horario, function() {
						// console.debug($(this));
						var id_hora	=	$(this)[0].id_HSer;
						// console.log(contador);
						var horarioInfo	=	'<div class="col-12 col-sm-3 col-lg-3 accordion-group"><br />';
						horarioInfo	=	horarioInfo + '<legend>Horario ' + (contador+1) + '</legend>';
						horarioInfo	=	horarioInfo + '<label for="lblTrainer'+contador+'">Trainer: </label><p id="lblTrainer'+contador+'">'+$(this)[0].encargado_HSer+'</p>';
						horarioInfo	=	horarioInfo + '<label for="lblSucursalHora">Sucursal: </label><p id="lblSucursalHora">'+$(this)[0].sucursal_HServ+'</p>';
						horarioInfo	=	horarioInfo + '<label for="lblHorarioInfo">Registrado por: </label><p id="lblHorarioInfo">'+$(this)[0].personal_HSer+'</p>';
						horarioInfo	=	horarioInfo + '<label for="lblHorarioEstado">Estado: </label><p id="lblHorarioEstado">'+(($(this)[0].estado_HSer==0)?'Activo':'Inactivo')+'</p>';
						if(dHora){
							var detalle = '<div class="col-12">';
							detalle	= detalle+	'<legend>Dias</legend>';
							$.each(dHora, function(){
								if($(this)[0].HorarioServicio_id_HSer==id_hora){
									// console.debug($(this));
									detalle	= detalle+	'<p>'+diasSemana[$(this)[0].dia_DHServ] +': '+$(this)[0].horaInicio_DHServ + ' - ' + $(this)[0].horaFin_DHServ+'</p>';
									// horarioInfo = horarioInfo + detalle;
								};
							});
								detalle	= detalle + '</div>';
								horarioInfo = horarioInfo + detalle;
						horarioInfo	=	horarioInfo + '</div>';
						$('#boxHorario').append(horarioInfo);
						contador+=1;
						};
					});
				};
				if(serv){
					$('#boxServicios').show();
					$('#boxServicios').empty();
					$('#boxServicios').append('<legend>Servicios Incluidos</legend>');
					$.each(serv, function() {
						$('#boxServicios').append('<li>'+$(this)[0].nombre_serv+'</li>');
					});
					$('#boxServicios').append('<br /><br />');
				};
				$('#barra').slideUp();
				$('#boxContenido').slideDown();
			}
		},'json');
	});
});