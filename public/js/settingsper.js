jQuery(function($) {
	$('#btnRegSettingsPer').on('click', function(event) {
		event.preventDefault();
		if( $(txtClave).val().length > 0){
			$('#barra').slideDown();
			$.post('verificaclaveper', {
				txtId : $(txtId).val(),
				txtClave : $(txtClave).val()
			},function(data){
				if (data.response) {
					if( $(txtClaveConfirma).val().length > 0 && $(txtClaveNueva).val().length > 0){
						if ( $('#txtClaveConfirma').val() != $('#txtClaveNueva').val() ){
							$('#msjeModal').empty().html('Claves no coinciden!');
							$('#modalSettingsPer').modal();
							$('#txtClaveConfirma').val('');
							$('#txtClaveConfirma').focus();
						}else{
							$('#barra').slideDown();
							$.post('actualizaper',{
								txtId		:$(txtId).val(),
								txtDni		:$(txtDni).val(),
								dtpFechaNac	:$(dtpFechaNac).val(),
								txtDireccion:$(txtDireccion).val(),
								txtTelCasa	:$(txtTelCasa).val(),
								txtTelMovil :$(txtTelMovil).val(),
								txtEmail	:$(txtEmail).val(),
								txtClave	:$(txtClaveConfirma).val(),
							}, function(data) {
								// console.debug(data);
								$('#barra').slideUp();
								$('#msjeModal').empty().html(data.response);
								$('#modalSettingsPer').modal();
							},'json');
						};
					}else{
						if( $(txtClaveConfirma).val().length == 0 && $(txtClaveNueva).val().length == 0){
							$('#barra').slideDown();
							$.post('actualizaper',{
								txtId		:$(txtId).val(),
								txtDni		:$(txtDni).val(),
								dtpFechaNac	:$(dtpFechaNac).val(),
								txtDireccion:$(txtDireccion).val(),
								txtTelCasa	:$(txtTelCasa).val(),
								txtTelMovil :$(txtTelMovil).val(),
								txtEmail	:$(txtEmail).val(),
								txtClave	:$(txtClave).val(),
							}, function(data) {
								// console.debug(data);
								$('#barra').slideUp();
								$('#msjeModal').empty().html(data.response);
								$('#modalSettingsPer').modal();
							},'json');
						}else{
							$('#msjeModal').empty().html('Claves a cambiar no coinciden!');
							$('#modalSettingsPer').modal();
							$('#barra').slideUp();
						};
					};
				}else{
					$('#msjeModal').empty().html('Clave incorrecta!');
					$('#modalSettingsPer').modal();
					$('#barra').slideUp();
				};
			},'json');
		}else{
			$('#msjeModal').empty().html('Debe ingresar su Clave!');
			$('#modalSettingsPer').modal();
		};
	});
	$('#txtClaveConfirma').on('keyup', function(event) {
		if ( $(this).val() == $('#txtClaveNueva').val() ){
			$('#txtClaveNueva').parent('.input-group').addClass('has-success');
			$(this).parent('.input-group').addClass('has-success');
		}else{
			$('#txtClaveNueva').parent('.input-group').removeClass('has-success');
			$(this).parent('.input-group').removeClass('has-success');
			$('#txtClaveNueva').parent('.input-group').addClass('has-error');
			$(this).parent('.input-group').addClass('has-error');
		};
	});
	$('#txtClaveConfirma').on('focusout', function(event) {
		if ( $(this).val() != $('#txtClaveNueva').val() ){
			$('#msjeModal').empty().html('Claves no coinciden!');
			$('#modalSettingsPer').modal();
			$('#txtClaveConfirma').val('');
			$('#txtClaveConfirma').focus();
		};
	});
	function cargaDatos () {
		$.post('verpersonal', {
			txtId : $(txtId).val()
		},function(data){
			var per = data.response;
			$(txtApellidos).val(per.apellidoPaterno_Per + ' ' + per.apellidoMaterno_Per);
			$(txtNombres).val(per.nombres_Per);
			$(txtDireccion).val(per.direccion_Per);
			$(txtDni).val(per.dni_Per);
			$(txtTelCasa).val(per.telefonoCasa_Per);
			$(txtTelMovil).val(per.telefonoMovil_Per);
			$(txtEmail).val(per.email_Per);
			$(dtpFechaNac).val(per.fechaNacimiento_Per);
			$(txtNombres).attr('disabled', 'true');
			$(txtApellidos).attr('disabled', 'true');
			$('#barra').slideUp();
			// per.estado_Per
			// per.id_Per
			// per.sexo_Per
		},'json');
	};
	cargaDatos();
});