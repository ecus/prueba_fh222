jQuery(function($) {
	var oTable;
	var giRedraw	=	false;
	var auxId;
	$('.nav-tabs').button();
	$("#btnSexo0").parent('label').addClass('active');
	$("#frmPersonal").validate({
			debug: true,
			rules: {
						txtDni:{
							required: true,
							digits: true,
							minlength:8,
							maxlength:8
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
						txtDireccion :{
							required: true
						},
						txtTelMovil :{
							digits: true,
							minlength:9,
							maxlength:9
						},
						txtTelCasa :{
							digits: true,
							minlength:6
						},
						txtEmail :{
							email: true
						},
						dtpFecha :{
							required: true,
							date: true
						},
						cmbSucursal :{
							required: true,
						},
						cmbCargo :{
							required: true,
						}
					},
			messages:{
						txtDni:{
							required: '<span class ="label label-warning">Campo Obligatorio</span>',
							digits: '<span class   ="label label-warning">Solo numeros</span>',
							minlength:'<span class ="label label-warning">DNI debe contar con 8 digitos</span>',
							maxlength:'<span class ="label label-warning">DNI debe contar con 8 digitos</span>',
						},
						txtNombre:{
							required: '<span class ="label label-warning">Campo Obligatorio</span>'
						},
						txtApPaterno:{
							required: '<span class ="label label-warning">Campo Obligatorio</span>'
						},
						txtApMaterno:{
							required: '<span class ="label label-warning">Campo Obligatorio</span>'
						},
						txtDireccion :{
							required: '<span class ="label label-warning">Campo Obligatorio</span>'
						},
						txtTelMovil :{
							digits: '<span class   ="label label-warning">Solo numeros</span>',
							minlength:'<span class ="label label-warning">Debe contar con 9 digitos</span>',
							maxlength:'<span class ="label label-warning">Debe contar con 9 digitos</span>'
						},
						txtTelCasa :{
							required: '<span class ="label label-warning">Campo Obligatorio</span>',
							digits: '<span class   ="label label-warning">Solo numeros</span>'
						},
						txtEmail :{
							email: '<span class ="label label-warning">Ingrese formato de email valido</span>'
						},
						dtpFecha :{
							required:'<span class ="label label-warning">Campo Obligatorio</span>',
							date: '<span class    ="label label-warning">Error en formato de fecha</span>'
						},
						cmbSucursal:{
							required: '<span class ="label label-warning">Seleccione una Opcion</span>'
						},
						cmbCargo :{
							required: '<span class ="label label-warning">Seleccione una Opcion</span>'
						},
					}
		});
	$("#barra").slideUp();
	$('#btnRegPersonal').on('click',function(event){
		var textoBoton    =	$(this).attr('value');
		if($(frmPersonal).valid()){
				$("#barra").slideDown();
				var user      =  crearNombre();
				var operacion = verifica($("#optUsuario").val(),textoBoton);
				$.post(operacion, {
						txtId		:($(txtId).val())?$(txtId).val():0,
						txtEstado	:($(txtEstado).val())?$(txtEstado).val():0,

						txtDni		:$(txtDni).val(),
						txtNombre	:$(txtNombre).val(),
						txtApPaterno:$(txtApPaterno).val(),
						txtApMaterno:$(txtApMaterno).val(),
						dtpFecha	:$(dtpFecha).val(),
						txtSexo		:$(txtSexo).val(),
						txtDireccion:$(txtDireccion).val(),
						txtTelCasa	:$(txtTelCasa).val(),
						txtTelMovil	:$(txtTelMovil).val(),
						txtEmail	:$(txtEmail).val(),
						cmbSucursal	:$(cmbSucursal).val(),
						cmbCargo	:$(cmbCargo).val(),

						txtUsuario	:($(txtUsuario).val())?$(txtUsuario).val():0,
						txtEstadoUPer:($(txtEstadoUPer).val())?$(txtEstadoUPer).val():0
				},function(data){
						if(data.response == false){
							console.log('no se puede registrar');
						}else{
							limpiaControles();
							$("#msjeModal").empty().html(data.response);
							$("#modalPersonal").modal();
						}
						$("#barra").slideUp();
				}, 'json');
		}else{
			console.log("mal");
		};
	});

	function verifica (regUsuario,textoBoton) {
		var tipoOperacion = textoBoton.substr(0,3).toLowerCase();
		var accion = (regUsuario==0)?tipoOperacion+"personal":tipoOperacion+"userpersonal";
		return accion;
	};
	$('#prueba').on('click',function(event) {
		// console.debug($('input[name ="preferencias[]"]:checked').val());
		console.debug($('#pre > label.active').find('input[name ="preferencias[]"]'));
		console.log($('input[name ="preferencias[]"]').val());
	});
	/*
	$('.btn-group .btn').click(function() {
	// var parent = $(this).find('input').attr('checked', 'true');;
	// console.debug(parent);
	// $(parent).find('input').val($(this).text());
	});
	*/

	$('.btnSexo').on('click',function(event){
		// $(txtSexo).val($(this).attr('id').charAt($(this).attr('id').length-1));
		var id =$(this).find('input').attr('id');
		$(txtSexo).val(id.charAt(id.length-1));
	});
	$('.btnUper').on('click',function(event){
		// $(txtEstadoUPer).val($(this).attr('id').charAt($(this).attr('id').length-1));
		var id =$(this).find('input').attr('id');
		$(txtEstadoUPer).val(id.charAt(id.length-1));
	});
	$('.btnEstado').on('click',function(event){
		var id =$(this).find('input').attr('id');
		$(txtEstado).val(id.charAt(id.length-1));
	});
	$('.btnAccesos').on('click',function(event){
		var respuesta=  $(this).html();
		var nombre   =  $(txtNombre).val();
		var apellido =  $(txtApPaterno).val().replace(" ","");
		var user     =  crearNombre();
		if (respuesta == 'Si') {
			if(nombre !='' && apellido!=''){
				$("#boxAcceso").slideDown();
				$(optUsuario).val('1');
				$(txtUsuario).attr('placeholder',user);
				$(txtUsuario).val(user);
			}else{
				$('#msjeModal').empty().html('Debe completar los campos de Nombre y Apellido Paterno');
				$('#modalPersonal').modal();
			}
		}else{
			$(optUsuario).val('0');
			$("#boxAcceso").slideUp();
		}
	});
	$('#btnBuscar').on('click',function(event){
		var aux	=	$(txtDni).val();
		$('#barra').slideDown('slow/400/fast');
		if(aux.length	==	8){
			$.post('buscapersonal',{
				txtDni: aux
			},function(data){
				if(data.response == false){
					console.log('no se puede registrar');
				}else{
					// limpiaControles();
					var arreglo	 =	data.response;
					if(arreglo.length ==1){
						$("#boxAcceso").slideUp();
						$("#boxEstado").slideUp();
						$("#msjeModal").empty().html(data.response);
						$("#modalPersonal").modal();
					}else{
						$(txtId).val(arreglo.id_Per);
						$(txtEstado).val(arreglo.estado_Per);
						$(txtDni).val(arreglo.dni_Per);
						$(txtNombre).val(arreglo.nombres_Per);
						$(txtApPaterno).val(arreglo.apellidoPaterno_Per);
						$(txtApMaterno).val(arreglo.apellidoMaterno_Per);
						$(dtpFecha).val(arreglo.fechaNacimiento_Per);
						$(txtSexo).val(arreglo.sexo_Per);
						$(txtDireccion).val(arreglo.direccion_Per);
						$(txtTelCasa).val(arreglo.telefonoCasa_Per);
						$(txtTelMovil).val(arreglo.telefonoMovil_Per);
						$(txtEmail).val(arreglo.email_Per);
						$(txtEstadoUPer).val(arreglo.estado_UPer);
						$("#cmbSucursal option[value='"+arreglo.sucursal_id_suc+"']").attr("selected","selected");
						$("#cmbCargo option[value='"+arreglo.cargo_Per+"']").attr("selected","selected");
						$("#btnEstado0").parent('label').removeClass('active');
						$("#btnEstado1").parent('label').removeClass('active');
						$("#btnUper0").parent('label').removeClass('active');
						$("#btnUper1").parent('label').removeClass('active');
						$("#btnSexo0").parent('label').removeClass('active');
						$("#btnSexo1").parent('label').removeClass('active');
						$("#btnSexo"+arreglo.sexo_Per).parent('label').addClass('active');
						$("#btnEstado"+arreglo.estado_Per).parent('label').addClass('active');
						$("#btnUper"+arreglo.estado_UPer).parent('label').addClass('active');
						// console.log(arreglo);
						if(arreglo.alias_UPer !=null){
							$("#boxAcceso").slideDown();
							$(txtUsuario).val(arreglo.alias_UPer);
							$(optUsuario).val("1");
						}else{
							$("#boxAcceso").slideUp();
							$(optUsuario).val("0");
						}
						// $(".btnSexo#"+arreglo.estado_Per).addClass('active');
						$("#boxEstado").slideDown();
						$('#btnRegPersonal').attr('title',"Actualizar Datos");
						$('#btnRegPersonal').attr('value',"Actualizar Datos");
						$("#txtDni").attr('disabled','disabled');
						$('#barra').slideUp('slow/400/fast');
					}
				}
			},'json');
		}
	});

	$('#btnCancelar').on('click',function(event){
		limpiaControles();
	});
	$("#boxEstado").slideUp();
	$("#boxFoto").slideUp();
	$("#boxAcceso").slideUp();
	/*function limpiaControles () {
		$('input[type="text"]').val('');
		$('input[type="date"]').val('');
		$('select').find('option:nth(0)').attr("selected","selected");
		$('select[multiple="multiple"]').find('option:nth(0)').attr("selected","selected");
	}*/
	function limpiaControles(){
		limpiaControlesBasico();
		$(txtSexo).val(0);
		$(txtDni).removeAttr('disabled');
		$('#btnRegPersonal').attr('title',"Registrar");
		$('#btnRegPersonal').attr('value',"Registrar");
		$("#btnSexo0").parent('label').addClass('active');
		$("#boxEstado").slideUp();
		$("#boxAcceso").slideUp();
/*
		$("#btnEstado0").parent('label').removeClass('active');
		$("#btnEstado1").parent('label').removeClass('active');
		$("#btnUper0").parent('label').removeClass('active');
		$("#btnUper1").parent('label').removeClass('active');
		$("#btnSexo1").parent('label').removeClass('active');
*/
	};
	function crearNombre(){
		var nombre	=	$(txtNombre).val();
		var apellido=	$(txtApPaterno).val().replace(" ","");
		var user	=	nombre.charAt(0) + apellido;
		$(txtUsuario).attr('placeholder',user.toLowerCase());
		$(txtUsuario).val(user.toLowerCase());
		return	user.toLowerCase();
	};
});