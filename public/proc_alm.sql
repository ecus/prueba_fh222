DELIMITER $$

DROP PROCEDURE IF EXISTS `bdpruebas`.`pa_actualizaPersonal`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE  `bdpruebas`.`pa_actualizaPersonal`(
	IN id SMALLINT,IN dni CHAR(8),IN nom VARCHAR(45),IN pat VARCHAR(45),IN mat VARCHAR(45),IN fecha DATE,
	IN sexo TINYINT(1),IN dir VARCHAR(75),IN tcasa VARCHAR(10),IN tmov VARCHAR(10),IN mail VARCHAR(50),
	IN estado TINYINT(1),OUT msje VARCHAR(80))
BEGIN
	DECLARE m VARCHAR(80);
	UPDATE personal SET
		dni_per=dni,nombres_per=nom,apellidoPaterno_per=pat,apellidoMaterno_per=mat,fechaNacimiento_Per=fecha,
		sexo_Per=sexo,direccion_per=dir,telefonoCasa_per=tcasa,telefonoMovil_per=tmov,email_per=mail,estado_per=estado
	WHERE id_per=id;
	SET m='Datos del Personal Actualizado.';
	SELECT m INTO msje;
END $$

DELIMITER ;

DELIMITER $$

DROP PROCEDURE IF EXISTS `bdpruebas`.`pa_actualizaPersonalUsuario`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE  `bdpruebas`.`pa_actualizaPersonalUsuario`(
	IN id SMALLINT,IN dni CHAR(8),IN nom VARCHAR(45),IN pat VARCHAR(45),IN mat VARCHAR(45),IN fecha DATE,
	IN sexo TINYINT(1),IN dir VARCHAR(75),IN tcasa VARCHAR(10),IN tmov VARCHAR(10),IN mail VARCHAR(50),
	IN estado TINYINT(1),IN estadoUper TINYINT(1),OUT msje VARCHAR(80))
BEGIN
	DECLARE m VARCHAR(80);
	START TRANSACTION;
		UPDATE personal SET
			dni_per=dni,nombres_per=nom,apellidoPaterno_per=pat,apellidoMaterno_per=mat,fechaNacimiento_Per=fecha,
			sexo_Per=sexo,direccion_per=dir,telefonoCasa_per=tcasa,telefonoMovil_per=tmov,email_per=mail,estado_per=estado
		WHERE id_per=id;

		UPDATE UsuarioPersonal SET
			estado_UPer=estadoUper
		WHERE Personal_id_Per=id;

		SET m='Datos del Personal Actualizado.';
		SELECT m INTO msje;
	COMMIT;
END $$

DELIMITER ;

DELIMITER $$

DROP PROCEDURE IF EXISTS `bdpruebas`.`pa_actualizaSucursal`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE  `bdpruebas`.`pa_actualizaSucursal`(IN nombre VARCHAR(40),IN direccion VARCHAR(45),IN linea TINYINT,IN telefono CHAR(9),IN estado TINYINT(1),IN id TINYINT,OUT msje VARCHAR(80))
BEGIN
	UPDATE sucursal SET
		nombre_suc		=	nombre,
		direccion_suc	=	direccion,
		linea_suc		=	linea,
		telefono_suc	=	telefono,
		estado_suc		=	estado
	WHERE
		id_suc=id;
END $$

DELIMITER ;

DELIMITER $$

DROP PROCEDURE IF EXISTS `bdpruebas`.`pa_buscaPersonal`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE  `bdpruebas`.`pa_buscaPersonal`(IN dni CHAR(8))
BEGIN
	DECLARE existe SMALLINT;
	DECLARE codigo SMALLINT;
	SET existe = 0;
	SET codigo = 0;
	SELECT id_per INTO codigo FROM personal WHERE dni_per=dni;
	SELECT id_uper INTO existe FROM usuariopersonal WHERE personal_id_per=codigo;

	CASE existe
		WHEN 0 THEN
			SELECT
			apellidoMaterno_Per,apellidoPaterno_Per,direccion_Per,dni_Per,email_Per,
			estado_Per,fechaNacimiento_Per,id_Per,nombres_Per,sexo_Per,
			telefonoCasa_Per,telefonoMovil_Per
			FROM personal
			WHERE dni_per=dni
			LIMIT 1;
		ELSE
			SELECT
			personal.apellidoMaterno_Per,personal.apellidoPaterno_Per,personal.direccion_Per,personal.dni_Per,personal.email_Per,
			personal.estado_Per,personal.fechaNacimiento_Per,personal.id_Per,personal.nombres_Per,personal.sexo_Per,
			personal.telefonoCasa_Per,personal.telefonoMovil_Per,usuariopersonal.id_UPer,
			usuariopersonal.alias_UPer,usuariopersonal.estado_UPer
			FROM personal INNER JOIN usuariopersonal
			ON personal.id_per=usuariopersonal.personal_id_per
			WHERE personal.dni_per=dni
			LIMIT 1;
	END CASE;
END $$

DELIMITER ;

DELIMITER $$

DROP PROCEDURE IF EXISTS `bdpruebas`.`pa_buscarsocio`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE  `bdpruebas`.`pa_buscarsocio`(in nro char(11))
begin
select id_Soc,nombres_Soc from socio where documento_soc='nro';
end $$

DELIMITER ;

DELIMITER $$

DROP PROCEDURE IF EXISTS `bdpruebas`.`pa_ClienteInscripcion`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE  `bdpruebas`.`pa_ClienteInscripcion`(in dni varchar(11))
begin
SELECT soc.id_Soc,soc.documento_Soc,concat_ws(' ', apellidoPaterno_Soc, apellidoMaterno_Soc,nombres_Soc) as cliente,
inc.id_Ins,inc.fechaInicio_Ins
from socio soc
INNER JOIN inscripcion inc on soc.id_Soc = inc.Socio_id_Soc
where soc.documento_Soc = dni and inc.estado_Ins=1;
end $$

DELIMITER ;

DELIMITER $$

DROP PROCEDURE IF EXISTS `bdpruebas`.`pa_CliServicio`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE  `bdpruebas`.`pa_CliServicio`(in dni varchar(11))
begin
SELECT soc.id_Soc,soc.documento_Soc,concat_ws(' ', apellidoPaterno_Soc, apellidoMaterno_Soc,nombres_Soc) as cliente,
ser.id_Serv,ser.nombre_Serv,ser.montoBase_Serv
from socio soc
INNER JOIN inscripcion inc on soc.id_Soc = inc.Socio_id_Soc
inner join servicio ser on inc.Servicio_id_Serv = ser.id_Serv
where soc.documento_Soc = dni;
end $$

DELIMITER ;

DELIMITER $$

DROP PROCEDURE IF EXISTS `bdpruebas`.`pa_consolidadoPlan`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE  `bdpruebas`.`pa_consolidadoPlan`(IN id SMALLINT)
BEGIN

  DECLARE variable INT;
  SET variable=0;

  SELECT
    servicio.id_serv,servicio.nombre_serv,servicio.montoBase_serv,servicio.tipo_serv,servicio.diascupon_Serv,
    servicio.freezing_serv,servicio.montoinicial_Serv,DATE_FORMAT(servicio.fechaRegistro_serv,'%d/%m/%Y %r') as fechaRegistro_serv,
    servicio.promocion_serv,servicio.pagoMaximo_serv,servicio.tipoduracion_serv,
    servicio.duracion_serv,servicio.cuotasMaximo_serv,
    (SELECT nombre_serv FROM servicio WHERE id_serv=servicio.servicio_id_serv) as servicioBase_serv,
    (SELECT CONCAT(apellidoPaterno_Per,' ',apellidoMaterno_Per,', ' ,nombres_Per) FROM personal WHERE id_per=personal_id_per) as personal_serv
  FROM servicio
  WHERE id_Serv=id;

  SELECT
    tipoPromocion_DPromo,
    DATE_FORMAT(fechaInicio_DPromo,'%d/%m/%Y %r') as fechaInicio_DPromo,DATE_FORMAT(fechaFin_DPromo,'%d/%m/%Y %r') as fechaFin_DPromo,
    montoPromocion_DPromo,dias_DPromo,porcentaje_DPromo,
    empresaMin_DPromo,empresaMax_DPromo,horario_DPromo
  from detallepromocion
  where Servicio_id_Serv=id;

  SELECT s.nombre_suc FROM sucursal s INNER JOIN sucursalservicio ss ON s.id_suc=ss.Sucursal_id_Suc WHERE ss.Servicio_id_Serv=id;

  SELECT s.nombre_serv FROM servicio s INNER JOIN detalleservicio d ON s.id_serv=d.Servicio_id_Serv1 WHERE d.plan_id_serv=id;

  SELECT id_HSer,estado_HSer,
    (SELECT CONCAT(apellidoPaterno_Per,' ',apellidoMaterno_Per,', ' ,nombres_Per) FROM personal WHERE id_per=personal_id_per) as personal_HSer,
    (SELECT CONCAT(apellidoPaterno_Per,' ',apellidoMaterno_Per,', ' ,nombres_Per) FROM personal WHERE id_per=personal_Encargado) as encargado_HSer,
    (SELECT nombre_suc FROM sucursal WHERE id_suc=Sucursal_id_Suc) as sucursal_HServ
  FROM HorarioServicio
  WHERE servicio_id_serv=id;

  SELECT id_DHServ,dia_DHServ,horaInicio_DHServ,horaFin_DHServ,HorarioServicio_id_HSer
  FROM detalleHorarioServicio d
  INNER JOIN
    (SELECT id_HSer
    FROM HorarioServicio
    WHERE servicio_id_serv=id) as aux
  ON d.HorarioServicio_id_HSer=aux.id_HSer;
END $$

DELIMITER ;

DELIMITER $$

DROP PROCEDURE IF EXISTS `bdpruebas`.`pa_desactivarSucursal`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE  `bdpruebas`.`pa_desactivarSucursal`(IN id TINYINT,OUT msje VARCHAR(80))
BEGIN
	DECLARE existe TINYINT;
	DECLARE m VARCHAR(80);
	SET existe=0;
	SELECT Sucursal_id_Suc INTO existe FROM Sala WHERE Sucursal_id_Suc=id;
	SELECT Sucursal_id_Suc INTO existe FROM Pago WHERE Sucursal_id_Suc=id;
	SELECT Sucursal_id_Suc INTO existe FROM Asistencia WHERE Sucursal_id_Suc=id;
	SELECT Sucursal_id_Suc INTO existe FROM SucursalServicio WHERE Sucursal_id_Suc=id;

	CASE existe
		WHEN 0 THEN
			DELETE FROM sucursal WHERE id_suc=id;
		ELSE
			BEGIN
				UPDATE sucursal SET
					estado_suc		=	0
				WHERE
					id_suc=id;
				SET m = 'No se puede eliminar, ya que otros registros dependen de esta Informacion!';
				SELECT m INTO msje;
			END;
	END CASE;
END $$

DELIMITER ;

DELIMITER $$

DROP PROCEDURE IF EXISTS `bdpruebas`.`pa_insertaAsistencia`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE  `bdpruebas`.`pa_insertaAsistencia`(in fecReg datetime, in fecIng datetime, in idIns int, in idSoc smallint,in idPer smallint,in idSuc tinyint,out msje varchar(80))
begin
  declare id int default 0;
  select id_Asis INTO id from asistencia where fechaIngreso_Asis=fecIng and Socio_id_Soc=idSoc;

  CASE
    WHEN id = 0 THEN
      insert into asistencia(id_Asis,fechaRegistro_asis,fechaIngreso_asis,Inscripcion_id_Ins,Socio_id_Soc,Personal_id_Per,Sucursal_id_Suc)
      values(fecReg,fecIng,idIns,idSoc,idPer,idSuc);
      set msje:= 'Asistencia Registrada';
    WHEN id > 0 THEN
      SET msje:= 'La fecha de ingreso indicada ya se registró con anterioridad.';
  END CASE;
end $$

DELIMITER ;

DELIMITER $$

DROP PROCEDURE IF EXISTS `bdpruebas`.`pa_insertaInscripcion`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE  `bdpruebas`.`pa_insertaInscripcion`(IN ini DATE,IN fin DATE, IN socio SMALLINT,IN servicio SMALLINT,IN personal SMALLINT,OUT msje VARCHAR(80))
BEGIN
  INSERT INTO inscripcion (fechaInicio_Ins,fechaFin_Ins,Socio_id_Soc,Servicio_id_Serv,Personal_id_Per)
  VALUES (ini,fin,socio,servicio,personal);
  SET  msje:= 'Socio Registrado';
END $$

DELIMITER ;

DELIMITER $$

DROP PROCEDURE IF EXISTS `bdpruebas`.`pa_insertaPersonal`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE  `bdpruebas`.`pa_insertaPersonal`(
	IN dni CHAR(8),IN nom VARCHAR(45),IN pat VARCHAR(45),IN mat VARCHAR(45),IN fecha DATE, IN sexo TINYINT(1),IN dir VARCHAR(75),
	IN tcasa VARCHAR(10),IN tmov VARCHAR(10),IN mail VARCHAR(50),
	OUT msje VARCHAR(80))
BEGIN
	DECLARE existe SMALLINT;
	DECLARE codigo SMALLINT;
	DECLARE m VARCHAR(80);
	DECLARE persona VARCHAR(150);
	SET existe = 0;
	SELECT id_per INTO existe FROM personal WHERE dni_per=dni;
	CASE existe
		WHEN 0 THEN
			INSERT INTO personal
			(	dni_per,nombres_per,apellidoPaterno_per,apellidoMaterno_per,fechaNacimiento_Per,
				sexo_Per,direccion_per,telefonoCasa_per,telefonoMovil_per,email_per)
			VALUES (
				dni,nom,pat,mat,fecha,
				sexo,dir,tcasa,tmov,mail);
      SET m=CONCAT('Datos Registrados.');
			SELECT m INTO msje;
		ELSE
			SELECT CONCAT(apellidoPaterno_per,' ',apellidoMaterno_per,', ',nombres_per) INTO persona FROM personal WHERE dni_per=dni;
			SET m=CONCAT('DNI Registrado antes para: ',persona);
			SELECT m INTO msje;
	END CASE;
END $$

DELIMITER ;

DELIMITER $$

DROP PROCEDURE IF EXISTS `bdpruebas`.`pa_insertaPersonalUsuario`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE  `bdpruebas`.`pa_insertaPersonalUsuario`(
	IN dni CHAR(8),IN nom VARCHAR(45),IN pat VARCHAR(45),IN mat VARCHAR(45),IN fecha DATE, IN sexo TINYINT(1),IN dir VARCHAR(75),
	IN tcasa VARCHAR(10),IN tmov VARCHAR(10),IN mail VARCHAR(50),IN alias VARCHAR(20),IN clave CHAR(60),
	OUT msje VARCHAR(80))
BEGIN
	DECLARE existe SMALLINT;
	DECLARE codigo SMALLINT;
	DECLARE m VARCHAR(80);
	DECLARE persona VARCHAR(150);
	DECLARE cantidad TINYINT;
	SET existe = 0;
	SET cantidad = 0;
	SELECT id_per INTO existe FROM personal WHERE dni_per=dni;
	SELECT COUNT(alias_uper) INTO cantidad FROM usuariopersonal WHERE alias_uper=alias;

	CASE cantidad
		WHEN 0 THEN
			SET alias=alias;
		ELSE
			SET cantidad=cantidad+1;
			SET alias=CONCAT(alias,cantidad);
	END CASE;
	CASE existe
		WHEN 0 THEN
			START TRANSACTION;
				INSERT INTO personal
				(	dni_per,nombres_per,apellidoPaterno_per,apellidoMaterno_per,fechaNacimiento_Per,
					sexo_Per,direccion_per,telefonoCasa_per,telefonoMovil_per,email_per)
				VALUES (
					dni,nom,pat,mat,fecha,
					sexo,dir,tcasa,tmov,mail);
				SELECT MAX(LAST_INSERT_ID(id_per)) INTO codigo FROM personal;
				INSERT INTO UsuarioPersonal
				(	alias_UPer,clave_UPer,Personal_id_Per	)	VALUES
				(	alias,clave,codigo	);
        SET m=CONCAT('Datos Registrados. ID de usuario: ', alias);
  			SELECT m INTO msje;
			COMMIT;
		ELSE
			SELECT CONCAT(apellidoPaterno_per,' ',apellidoMaterno_per,', ',nombres_per) INTO persona FROM personal WHERE dni_per=dni;
			SET m=CONCAT('DNI Registrado antes para: ',persona);
			SELECT m INTO msje;
	END CASE;
END $$

DELIMITER ;

DELIMITER $$

DROP PROCEDURE IF EXISTS `bdpruebas`.`pa_insertaPlanHorario`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE  `bdpruebas`.`pa_insertaPlanHorario`(
  IN nombre VARCHAR(45), IN mBase DECIMAL(6,2), IN tipo TINYINT(1), IN cupon TINYINT(4),
	IN freezing TINYINT(4), IN mInicial DECIMAL(6,2), IN fecha DATETIME,IN promo TINYINT(1),
	IN empresa TINYINT(3), IN personalReg SMALLINT,IN xmlServ TEXT, IN xmlSuc TEXT,IN xml TEXT,OUT msje VARCHAR(80))
BEGIN
  DECLARE m VARCHAR(80);
--  para servicio
	DECLARE serv SMALLINT;
	DECLARE horaServ SMALLINT;

--  para plan
	DECLARE d INT DEFAULT 1;
	DECLARE servicio SMALLINT;
	DECLARE dmax INT DEFAULT 0;

--  para horarios
	DECLARE i INT DEFAULT 1;
	DECLARE personal TINYINT;
	DECLARE sucursal TINYINT;
	DECLARE nmax INT DEFAULT 0;

--  para detalle horario
	DECLARE j int DEFAULT 1;
	DECLARE ini TIME;
	DECLARE fin TIME;
	DECLARE dia CHAR(1);
	DECLARE mmax int DEFAULT 0;

--  para sucursal Servicio
	DECLARE s int DEFAULT 1;
	DECLARE dSuc TINYINT;
	DECLARE smax int DEFAULT 0;

	START TRANSACTION;
		-- id_Serv
		INSERT INTO servicio
		(	nombre_Serv,montoBase_Serv,tipo_Serv,diasCupon_Serv,
			freezing_Serv,montoInicial_Serv,fechaRegistro_Serv,
			promocion_Serv, empresa_id_emp, Personal_id_Per)
		VALUES
		(	nombre,mBase,tipo,cupon,
			freezing,mInicial,fecha,
			promo,empresa,personalReg);

		SELECT MAX(LAST_INSERT_ID(id_Serv)) INTO serv FROM servicio;

    -- Detalle de Plan Servicio
    SET dmax:=ExtractValue(xmlSuc, 'count(lista/servicio)');
    WHILE d<=dmax DO
      SET servicio:=ExtractValue(xmlSuc, 'lista/servicio[$d]');
				INSERT INTO detalleservicio
        (Plan_id_Serv, Servicio_id_Serv1)
        VALUES
        (serv,servicio);
      SET d=d+1;
    END WHILE;

    -- Fin Plan Servicio --

    -- Detalle de Sucursal Servicio
    SET smax:=ExtractValue(xmlSuc, 'count(lista/sucursal)');
    WHILE s<=smax DO
      SET dSuc:=ExtractValue(xmlSuc, 'lista/sucursal[$s]');
				INSERT INTO sucursalservicio
        (Sucursal_id_Suc, Servicio_id_Serv)
        VALUES
        (dSuc,serv);
      SET s=s+1;
    END WHILE;

    -- Fin Sucursal Servicio --


		SET @aaa = xml;
		--  para horarios
		SET nmax:=ExtractValue(@aaa, 'count(lista/horario)');

		WHILE i<=nmax DO
			SET personal:=ExtractValue(@aaa, 'lista/horario[$i]/personal');
			SET sucursal:=ExtractValue(@aaa, 'lista/horario[$i]/sucursal');

			INSERT INTO horarioservicio
			(Servicio_id_Serv, Personal_id_Per, Personal_Encargado, Sucursal_id_Suc)
			VALUES
			(serv,personalReg,personal,sucursal);

			SELECT MAX(LAST_INSERT_ID(id_HSer)) INTO horaServ FROM horarioservicio;

			--  para detalle horario
			SET mmax:=ExtractValue(@aaa, 'count(lista/horario[$i]/detalle)');

			WHILE j<=mmax DO
				SET ini:=ExtractValue(@aaa, 'lista/horario[$i]/detalle[$j]/ini');
				SET fin:=ExtractValue(@aaa, 'lista/horario[$i]/detalle[$j]/fin');
				SET dia:=ExtractValue(@aaa, 'lista/horario[$i]/detalle[$j]/dia');

				INSERT INTO detallehorarioservicio
				(dia_DHServ, horaInicio_DHServ, horaFin_DHServ, HorarioServicio_id_HSer)
				VALUES
				(dia,ini,fin,horaServ);

				SET j=j+1;
			END WHILE;

			SET mmax=0;
			-- termina detalle horario
			SET i=i+1;

	    END WHILE;

    SET msje:='Servicio Regitrado con exito.';
    COMMIT;

END $$

DELIMITER ;

DELIMITER $$

DROP PROCEDURE IF EXISTS `bdpruebas`.`pa_insertaPlanHorarioB`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE  `bdpruebas`.`pa_insertaPlanHorarioB`(
  IN nombre VARCHAR(45), IN mBase DECIMAL(6,2), IN tipo TINYINT(1), IN cupon TINYINT(4),
	IN freezing TINYINT(4), IN mInicial DECIMAL(6,2), IN fecha DATETIME,IN promo TINYINT(1),
	IN tipoDuracion TINYINT,IN duracion TINYINT, IN cuotas TINYINT, IN pagoMax TINYINT, IN personalReg SMALLINT,IN xmlServ TEXT, IN xmlSuc TEXT,IN xml TEXT,OUT msje VARCHAR(80))
BEGIN
  DECLARE m VARCHAR(80);
--  para servicio
	DECLARE serv SMALLINT;
	DECLARE horaServ SMALLINT;

--  para plan
	DECLARE d INT DEFAULT 1;
	DECLARE servicioAux SMALLINT;
	DECLARE dmax INT DEFAULT 0;

--  para horarios
	DECLARE i INT DEFAULT 1;
	DECLARE personal TINYINT;
	DECLARE sucursal TINYINT;
	DECLARE nmax INT DEFAULT 0;

--  para detalle horario
	DECLARE j int DEFAULT 1;
	DECLARE ini TIME;
	DECLARE fin TIME;
	DECLARE dia CHAR(1);
	DECLARE mmax int DEFAULT 0;

--  para sucursal Servicio
	DECLARE s int DEFAULT 1;
	DECLARE dSuc TINYINT;
	DECLARE smax int DEFAULT 0;

	START TRANSACTION;
		-- id_Serv
		INSERT INTO servicio
		(	nombre_Serv,montoBase_Serv,tipo_Serv,diasCupon_Serv,
			freezing_Serv,montoInicial_Serv,fechaRegistro_Serv,
			promocion_Serv, tipoDuracion_Serv,duracion_Serv,
      cuotasMaximo_Serv,pagoMaximo_Serv, Personal_id_Per)
		VALUES
		(	nombre,mBase,tipo,cupon,
			freezing,mInicial,fecha,
			promo,tipoDuracion,duracion,
      cuotas,pagoMax,personalReg);

		SELECT MAX(LAST_INSERT_ID(id_Serv)) INTO serv FROM servicio;

    -- Detalle de Plan Servicio
    SET dmax:=ExtractValue(xmlServ, 'count(lista/servicio)');
    WHILE d<=dmax DO
      SET servicioAux:=ExtractValue(xmlServ, 'lista/servicio[$d]');
				INSERT INTO detalleservicio
        (Plan_id_Serv, Servicio_id_Serv1)
        VALUES
        (serv,servicioAux);
      SET d=d+1;
    END WHILE;

    -- Fin Plan Servicio --

    -- Detalle de Sucursal Servicio
    SET smax:=ExtractValue(xmlSuc, 'count(lista/sucursal)');
    WHILE s<=smax DO
      SET dSuc:=ExtractValue(xmlSuc, 'lista/sucursal[$s]');
				INSERT INTO sucursalservicio
        (Sucursal_id_Suc, Servicio_id_Serv)
        VALUES
        (dSuc,serv);
      SET s=s+1;
    END WHILE;

    -- Fin Sucursal Servicio --


		SET @aaa = xml;
		--  para horarios
		SET nmax:=ExtractValue(@aaa, 'count(lista/horario)');

		WHILE i<=nmax DO
			SET personal:=ExtractValue(@aaa, 'lista/horario[$i]/personal');
			SET sucursal:=ExtractValue(@aaa, 'lista/horario[$i]/sucursal');

			INSERT INTO horarioservicio
			(Servicio_id_Serv, Personal_id_Per, Personal_Encargado, Sucursal_id_Suc)
			VALUES
			(serv,personalReg,personal,sucursal);

			SELECT MAX(LAST_INSERT_ID(id_HSer)) INTO horaServ FROM horarioservicio;

			--  para detalle horario
			SET mmax:=ExtractValue(@aaa, 'count(lista/horario[$i]/detalle)');

			WHILE j<=mmax DO
				SET ini:=ExtractValue(@aaa, 'lista/horario[$i]/detalle[$j]/ini');
				SET fin:=ExtractValue(@aaa, 'lista/horario[$i]/detalle[$j]/fin');
				SET dia:=ExtractValue(@aaa, 'lista/horario[$i]/detalle[$j]/dia');

				INSERT INTO detallehorarioservicio
				(dia_DHServ, horaInicio_DHServ, horaFin_DHServ, HorarioServicio_id_HSer)
				VALUES
				(dia,ini,fin,horaServ);

				SET j=j+1;
			END WHILE;

			SET mmax=0;
			-- termina detalle horario
			SET i=i+1;

	    END WHILE;

    SET msje:='Plan Registrado con exito.';
    COMMIT;

END $$

DELIMITER ;

DELIMITER $$

DROP PROCEDURE IF EXISTS `bdpruebas`.`pa_InsertarFreezing`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE  `bdpruebas`.`pa_InsertarFreezing`(in FecReg datetime,in dias tinyint,in coment varchar(150),in idInsc int, in idSoc smallint,in idPer int)
begin
DECLARE cod smallint;
	SELECT (COALESCE( MAX( id_Free ) , 0 ) +1) INTO cod FROM freezing;
start transaction;
insert into freezing(id_Free,fechaRegistro_free,cantidadDias_free,descripcion_free,Inscripcion_id_Ins,
Socio_id_Soc,Personal_id_Per)
values(cod,FecReg,dias,coment,idInsc,idSoc,idPer);

UPDATE inscripcion insc SET insc.estado_Ins = 0 WHERE insc.Socio_id_Soc = idSoc;
commit;
end $$

DELIMITER ;

DELIMITER $$

DROP PROCEDURE IF EXISTS `bdpruebas`.`pa_InsertarPago`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE  `bdpruebas`.`pa_InsertarPago`(in FecReg datetime,in FecPago datetime,in pago decimal(6,2),in moneda tinyint,in forma tinyint, in concepto tinyint,
                                 in estado tinyint(1),in idSer smallint, in idCta int, in idPer smallint,in idSuc tinyint, in idSoc smallint)
begin
DECLARE cod int;
	SELECT (COALESCE( MAX( id_Pago ) , 0 ) +1) INTO cod FROM pago;

insert into pago(id_Pago,fechaRegistro_Pago,fechaPago_Pago,monto_Pago,moneda_pago,forma_Pago,concepto_Pago,estado_Pago,Servicio_id_Serv,
Cuenta_id_Cuenta,Personal_id_Per,Sucursal_id_Suc,Socio_id_Soc)
values(cod,FecReg,FecPago,pago,moneda,forma,concepto,estado,idSer,idCta,idPer,idSuc,idSoc);

end $$

DELIMITER ;

DELIMITER $$

DROP PROCEDURE IF EXISTS `bdpruebas`.`pa_insertaServicioHorario`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE  `bdpruebas`.`pa_insertaServicioHorario`(IN nombre VARCHAR(45), IN mBase DECIMAL(6,2), IN tipo TINYINT(1), IN cupon TINYINT(4),
	IN freezing TINYINT(4), IN mInicial DECIMAL(6,2), IN fecha DATETIME,IN promo TINYINT(1),
	IN personalReg SMALLINT, IN xmlSuc TEXT,IN xml TEXT,OUT msje VARCHAR(80))
BEGIN
  DECLARE m VARCHAR(80);
--  para servicio
	DECLARE serv SMALLINT;
	DECLARE horaServ SMALLINT;
--  para horarios
	DECLARE i INT DEFAULT 1;
	DECLARE personal TINYINT;
	DECLARE sucursal TINYINT;
	DECLARE nmax INT DEFAULT 0;

--  para detalle horario
	DECLARE j int DEFAULT 1;
	DECLARE ini TIME;
	DECLARE fin TIME;
	DECLARE dia CHAR(1);
	DECLARE mmax int DEFAULT 0;

--  para sucursal Servicio
	DECLARE s int DEFAULT 1;
	DECLARE dSuc TINYINT;
	DECLARE smax int DEFAULT 0;

	START TRANSACTION;
		-- id_Serv
		INSERT INTO servicio
		(	nombre_Serv,montoBase_Serv,tipo_Serv,diasCupon_Serv,
			freezing_Serv,montoInicial_Serv,fechaRegistro_Serv,
			promocion_Serv,  Personal_id_Per)
		VALUES
		(	nombre,mBase,tipo,cupon,
			freezing,mInicial,fecha,
			promo,personalReg);

		SELECT MAX(LAST_INSERT_ID(id_Serv)) INTO serv FROM servicio;

    -- Detalle de Sucursal Servicio
    SET smax:=ExtractValue(xmlSuc, 'count(lista/sucursal)');
    WHILE s<=smax DO
      SET dSuc:=ExtractValue(xmlSuc, 'lista/sucursal[$s]');
        select dSuc,serv;
				INSERT INTO sucursalservicio
        (Sucursal_id_Suc, Servicio_id_Serv)
        VALUES
        (dSuc,serv);
      SET s=s+1;
    END WHILE;

    -- Fin Sucursal Servicio --


		SET @aaa = xml;
		--  para horarios
		SET nmax:=ExtractValue(@aaa, 'count(lista/horario)');

		WHILE i<=nmax DO
			SET personal:=ExtractValue(@aaa, 'lista/horario[$i]/personal');
			SET sucursal:=ExtractValue(@aaa, 'lista/horario[$i]/sucursal');

			INSERT INTO horarioservicio
			(Servicio_id_Serv, Personal_id_Per, Personal_Encargado, Sucursal_id_Suc)
			VALUES
			(serv,personalReg,personal,sucursal);

			SELECT MAX(LAST_INSERT_ID(id_HSer)) INTO horaServ FROM horarioservicio;

			--  para detalle horario
			SET mmax:=ExtractValue(@aaa, 'count(lista/horario[$i]/detalle)');

			WHILE j<=mmax DO
				SET ini:=ExtractValue(@aaa, 'lista/horario[$i]/detalle[$j]/ini');
				SET fin:=ExtractValue(@aaa, 'lista/horario[$i]/detalle[$j]/fin');
				SET dia:=ExtractValue(@aaa, 'lista/horario[$i]/detalle[$j]/dia');

				INSERT INTO detallehorarioservicio
				(dia_DHServ, horaInicio_DHServ, horaFin_DHServ, HorarioServicio_id_HSer)
				VALUES
				(dia,ini,fin,horaServ);

				SET j=j+1;
			END WHILE;

			SET mmax=0;
			-- termina detalle horario
			SET i=i+1;

	    END WHILE;

    SET m='Servicio Regitrado con exito.';
    SELECT m INTO msje;
    COMMIT;

END $$

DELIMITER ;

DELIMITER $$

DROP PROCEDURE IF EXISTS `bdpruebas`.`pa_insertaSocio`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE  `bdpruebas`.`pa_insertaSocio`(IN dni CHAR(11),in tipodoc tinyint, IN pat VARCHAR(45), IN mat VARCHAR(45),
  IN nom VARCHAR(45),in sexo tinyint(1),in fechanac date,in mail varchar(50),in ecivil tinyint, in distrito tinyint(3),
  IN dir varchar(50),in fevisita date,in feregis date,
  in feinvitacion date,in estado tinyint,in referido smallint,in empresa tinyint,in personal smallint,
  IN xml TEXT,OUT msje VARCHAR(80) )
BEGIN
  DECLARE d smallint;
  DECLARE soc smallint;
	DECLARE m VARCHAR(80);
	DECLARE j int DEFAULT 1;
  DECLARE numero char(10);
  DECLARE tipo tinyint;
  DECLARE emergencia tinyint(1);
  DECLARE nombreEmergencia varchar(35);
  DECLARE parentesco varchar(15);
	DECLARE mmax int DEFAULT 0;

  START TRANSACTION;
    SET d=0;

	  SELECT  id_soc INTO d FROM socio WHERE documento_soc=dni;

	  IF d=0 THEN
		  INSERT INTO socio (documento_soc,tipoDocumento_soc,apellidoPaterno_soc,apellidoMaterno_soc,nombres_Soc,sexo_Soc,
      fechaNacimiento_Soc,email_Soc,estadoCivil_Soc,direccion_Soc,Distrito_id_Dis,
      fechaVisita_Soc,fechaRegistro_Soc,fechaInvitacion_Soc,estado_Soc,Socio_Referido,empresa_id_emp,Personal_id_Per)
      VALUES (dni,tipodoc,pat,mat,nom,sexo,fechanac,mail,ecivil,dir,distrito,fevisita,feregis,feinvitacion,
      estado,referido,empresa,personal);

      SELECT MAX(LAST_INSERT_ID(id_Soc)) INTO soc FROM socio;

      --  para telefonos
			SET mmax:=ExtractValue(xml, 'count(lista/telefono)');

			WHILE j<=mmax DO
				SET numero:=ExtractValue(xml, 'lista/telefono[$j]/numero');
				SET tipo:=ExtractValue(xml, 'lista/telefono[$j]/tipo');
				SET emergencia:=ExtractValue(xml, 'lista/telefono[$j]/emergencia');
        SET nombreEmergencia:=ExtractValue(xml, 'lista/telefono[$j]/nombre');
        SET parentesco:=ExtractValue(xml, 'lista/telefono[$j]/parentesco');

        INSERT INTO telefono
        (numero_Tel, tipo_tel, emergencia_Tel, nombreEmergencia_Tel, parentesco_Tel, Socio_id_Soc)
        VALUES
        (numero,tipo,emergencia,nombreEmergencia,parentesco,soc);

				SET j=j+1;
			END WHILE;

			SET mmax=0;

      SET m= CONCAT(nom, ' ', pat, ' se Registró en el sistema.');
		  SELECT m INTO msje;
  	ELSE
	  	SET m='La persona ya fue Registrada..!! (DNI Registrado)';
		  SELECT m INTO msje;
  	END IF;
  COMMIT;
END $$

DELIMITER ;

DELIMITER $$

DROP PROCEDURE IF EXISTS `bdpruebas`.`pa_insertaSocioUsuarios`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE  `bdpruebas`.`pa_insertaSocioUsuarios`(
	IN dni CHAR(11),in tipodoc tinyint,IN pat VARCHAR(45),IN mat VARCHAR(45),IN nom VARCHAR(45),in sexo tinyint(1),
 	 in fechanac date,in mail varchar(50),
  	in ecivil tinyint,in fevisita date,in feregis date,in feinvitacion date,in estado tinyint,
 	 in referido smallint,in empresa tinyint,in personal smallint,in alias char(15),in xml text,OUT msje VARCHAR(80))
BEGIN
	DECLARE existe SMALLINT;
	DECLARE codigo SMALLINT;
	DECLARE m VARCHAR(80);
	DECLARE socios VARCHAR(150);
	DECLARE cantidad TINYINT;

  DECLARE j int DEFAULT 1;
  DECLARE numero char(10);
  DECLARE tipo tinyint;
  DECLARE emergencia tinyint(1);
  DECLARE nombreEmergencia varchar(35);
  DECLARE parentesco varchar(15);
	DECLARE mmax int DEFAULT 0;

	SET existe = 0;
	SET cantidad = 0;
	SELECT id_Soc INTO existe FROM socio WHERE documento_soc=dni;
	SELECT COUNT(alias_user) INTO cantidad FROM usuariosocio WHERE alias_user=alias;

	CASE cantidad
		WHEN 0 THEN
			SET alias=alias;
		ELSE
			SET cantidad=cantidad+1;
			SET alias=CONCAT(alias,cantidad);
	END CASE;
	CASE existe
		WHEN 0 THEN
			START TRANSACTION;
				INSERT INTO socio
				(	documento_soc,tipoDocumento_soc,apellidoPaterno_soc,apellidoMaterno_soc,nombres_Soc,sexo_Soc,
					fechaNacimiento_Soc,email_Soc,estadoCivil_Soc,
					fechaVisita_Soc,fechaRegistro_Soc,fechaInvitacion_Soc,estado_Soc,Socio_Referido,empresa_id_emp,Personal_id_Per)
				VALUES (dni,tipodoc,pat,mat,nom,sexo,fechanac,mail,ecivil,fevisita,feregis,feinvitacion,
					estado,referido,empresa,personal);
				
				SELECT MAX(LAST_INSERT_ID(id_Soc)) INTO codigo FROM socio;

      --  para telefonos
			SET mmax:=ExtractValue(xml, 'count(lista/telefono)');

			WHILE j<=mmax DO
				SET numero:=ExtractValue(xml, 'lista/telefono[$j]/numero');
				SET tipo:=ExtractValue(xml, 'lista/telefono[$j]/tipo');
				SET emergencia:=ExtractValue(xml, 'lista/telefono[$j]/emergencia');
        SET nombreEmergencia:=ExtractValue(xml, 'lista/telefono[$j]/nombre');
        SET parentesco:=ExtractValue(xml, 'lista/telefono[$j]/parentesco');

        INSERT INTO telefono
        (numero_Tel, tipo_tel, emergencia_Tel, nombreEmergencia_Tel, parentesco_Tel, Socio_id_Soc)
        VALUES
        (numero,tipo,emergencia,nombreEmergencia,parentesco,codigo);

				SET j=j+1;
			END WHILE;

			SET mmax=0;

				INSERT INTO usuariosocio
				(	alias_user,clave_user,Socio_id_Soc	)	VALUES
				(	alias,md5(pat),codigo	);
      SET  msje:= CONCAT(nom, ' ', pat, ' se Registró en el sistema.');
			COMMIT;
		ELSE
			SELECT CONCAT(apellidoPaterno_Soc,' ',apellidoMaterno_Soc,', ',nombres_Soc) INTO socios FROM socio WHERE documento_soc=dni;
			SET m=CONCAT('DNI Registrado antes para: ',socios);
			SELECT m INTO msje;
	END CASE;
END $$

DELIMITER ;

DELIMITER $$

DROP PROCEDURE IF EXISTS `bdpruebas`.`pa_insertaSucursal`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE  `bdpruebas`.`pa_insertaSucursal`(IN nombre VARCHAR(40),IN direccion VARCHAR(45),IN linea TINYINT,IN telefono CHAR(9),OUT msje VARCHAR(80))
BEGIN
	DECLARE aux TINYINT;
	DECLARE m VARCHAR(80);
	SET aux=0;
	SELECT id_suc INTO aux FROM sucursal WHERE nombre_suc = nombre;
	CASE aux
		WHEN 0 THEN
			INSERT INTO sucursal (nombre_suc,direccion_suc,linea_suc,telefono_suc) VALUES (nombre,direccion,linea,telefono);
		ELSE
			BEGIN
				SET m = 'Ya existe una sucursal Registrada con ese nombre';
				SELECT m INTO msje;
			END;
	END CASE;
END $$

DELIMITER ;

DELIMITER $$

DROP PROCEDURE IF EXISTS `bdpruebas`.`pa_insertSocio`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE  `bdpruebas`.`pa_insertSocio`(IN dni CHAR(11),in tipodoc tinyint,IN pat VARCHAR(45),IN mat VARCHAR(45),IN nom VARCHAR(45),in sexo tinyint(1),
  in fechanac date,in mail varchar(50),IN tcasa VARCHAR(10),IN tmov VARCHAR(10),IN temer VARCHAR(10),
  in ecivil tinyint,in fevisita date,in feregis date,in feinvitacion date,in estado tinyint,
  in referido smallint,in empresa tinyint,in personal smallint,OUT msje VARCHAR(80))
BEGIN
	DECLARE d smallint;
	DECLARE m VARCHAR(80);
        set d=0;
	SELECT  id_soc INTO d FROM socio WHERE documento_soc=dni;

	IF d=0 THEN
		INSERT INTO socio (documento_soc,tipoDocumento_soc,apellidoPaterno_soc,apellidoMaterno_soc,nombres_Soc,sexo_Soc,
  fechaNacimiento_Soc,email_Soc,telefonoCasa_Soc,telefonoMovil_Soc,telefonoEmergencia_Soc,estadoCivil_Soc,
  fechaVisita_Soc,fechaRegistro_Soc,fechaInvitacion_Soc,estado_Soc,Socio_Referido,empresa_id_emp,Personal_id_Per)
VALUES (dni,tipodoc,pat,mat,nom,sexo,fechanac,mail,tcasa,tmov,temer,ecivil,fevisita,feregis,feinvitacion,
estado,referido,empresa,personal);
		SET m= CONCAT(nom, ' ', pat, ' se Registro en el sistema con ID: ', d ,' ..!!');
		SELECT m INTO msje;
	ELSE
		SET m='La persona ya fue Registrada..!! (DNI Registrado)';
		SELECT m INTO msje;
	END IF;
END $$

DELIMITER ;

DELIMITER $$

DROP PROCEDURE IF EXISTS `bdpruebas`.`pa_leeSocio`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE  `bdpruebas`.`pa_leeSocio`(IN id smallint)
BEGIN
	SELECT id_Ins,nombre_Serv
from socio soc
inner join inscripcion inc on soc.id_Soc=inc.Socio_id_Soc
inner join servicio ser on inc.Servicio_id_Serv=ser.id_Serv
WHERE id_Soc=id and inc.estado_Ins=1 and inc.tipo_Ins=0;
END $$

DELIMITER ;

DELIMITER $$

DROP PROCEDURE IF EXISTS `bdpruebas`.`pa_leeSucursal`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE  `bdpruebas`.`pa_leeSucursal`(IN id TINYINT)
BEGIN
	SELECT id_suc,nombre_suc,direccion_suc,linea_suc,telefono_suc,estado_suc FROM sucursal WHERE id_suc=id LIMIT 1;
END $$

DELIMITER ;

DELIMITER $$

DROP PROCEDURE IF EXISTS `bdpruebas`.`pa_listaCiudad`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE  `bdpruebas`.`pa_listaCiudad`()
BEGIN
  SELECT id_Ciu, nombre_Ciu FROM ciudad;
END $$

DELIMITER ;

DELIMITER $$

DROP PROCEDURE IF EXISTS `bdpruebas`.`pa_listaDistrito`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE  `bdpruebas`.`pa_listaDistrito`(IN id tinyint)
BEGIN
  SELECT id_Dis, nombre_Dis, Ciudad_id_Ciu FROM distrito WHERE Ciudad_id_Ciu = id;
END $$

DELIMITER ;

DELIMITER $$

DROP PROCEDURE IF EXISTS `bdpruebas`.`pa_listaEmpresa`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE  `bdpruebas`.`pa_listaEmpresa`()
BEGIN
  SELECT id_emp,nombre_emp FROM empresa;
END $$

DELIMITER ;

DELIMITER $$

DROP PROCEDURE IF EXISTS `bdpruebas`.`pa_listaPersonal`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE  `bdpruebas`.`pa_listaPersonal`()
BEGIN
  SELECT id_per, nombres_per,apellidoMaterno_Per,apellidoPaterno_Per FROM personal WHERE estado_per=1;
END $$

DELIMITER ;

DELIMITER $$

DROP PROCEDURE IF EXISTS `bdpruebas`.`pa_listaPlan`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE  `bdpruebas`.`pa_listaPlan`()
begin
  SELECT id_Serv,nombre_Serv FROM servicio WHERE tipo_Serv=1;
end $$

DELIMITER ;

DELIMITER $$

DROP PROCEDURE IF EXISTS `bdpruebas`.`pa_listaServicio`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE  `bdpruebas`.`pa_listaServicio`()
begin
  SELECT id_Serv,nombre_Serv FROM servicio;
end $$

DELIMITER ;

DELIMITER $$

DROP PROCEDURE IF EXISTS `bdpruebas`.`pa_listaServicioBase`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE  `bdpruebas`.`pa_listaServicioBase`()
BEGIN
  SELECT id_Serv, nombre_Serv FROM servicio WHERE tipo_serv=0 AND estado_Serv=1;
END $$

DELIMITER ;

DELIMITER $$

DROP PROCEDURE IF EXISTS `bdpruebas`.`pa_listaSocio`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE  `bdpruebas`.`pa_listaSocio`()
BEGIN
select id_Soc,concat(apellidoPaterno_Soc, ' ' , apellidoMaterno_Soc, ', ',nombres_Soc) as cliente,documento_soc
from socio;
END $$

DELIMITER ;

DELIMITER $$

DROP PROCEDURE IF EXISTS `bdpruebas`.`pa_ListaSociosActivos`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE  `bdpruebas`.`pa_ListaSociosActivos`()
begin
select id_Soc,concat_ws(' ', apellidoPaterno_Soc, apellidoMaterno_Soc,nombres_Soc) as cliente,documento_soc
from socio soc
INNER JOIN inscripcion inc on soc.id_Soc = inc.Socio_id_Soc
where soc.estado_Soc=0 and inc.estado_Ins=1 and inc.tipo_Ins=0;
end $$

DELIMITER ;

DELIMITER $$

DROP PROCEDURE IF EXISTS `bdpruebas`.`pa_listaSucursal`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE  `bdpruebas`.`pa_listaSucursal`()
BEGIN
	SELECT id_suc,nombre_suc,direccion_suc,linea_suc,telefono_suc,estado_suc FROM sucursal;
END $$

DELIMITER ;

DELIMITER $$

DROP PROCEDURE IF EXISTS `bdpruebas`.`pa_listaSucursalActivo`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE  `bdpruebas`.`pa_listaSucursalActivo`()
BEGIN
	SELECT id_suc,nombre_suc,direccion_suc,linea_suc,telefono_suc,estado_suc FROM sucursal WHERE estado_suc=1;
END $$

DELIMITER ;

DELIMITER $$

DROP PROCEDURE IF EXISTS `bdpruebas`.`pa_listaSucursalInactivo`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE  `bdpruebas`.`pa_listaSucursalInactivo`()
BEGIN
	SELECT id_suc,nombre_suc,direccion_suc,linea_suc,telefono_suc,estado_suc FROM sucursal WHERE estado_suc=0;
END $$

DELIMITER ;

DELIMITER $$

DROP PROCEDURE IF EXISTS `bdpruebas`.`pa_loginPersonal`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE  `bdpruebas`.`pa_loginPersonal`(IN nombre VARCHAR(20))
BEGIN
  DECLARE id INT DEFAULT 0;
  DECLARE per INT DEFAULT 0;
  DECLARE estado INT DEFAULT 0;
  DECLARE msje VARCHAR(150);

  SELECT id_UPer INTO id FROM usuariopersonal WHERE alias_UPer=nombre;
  CASE
		WHEN id=0 THEN
      SET msje:='No se encontró coincidencias con el usuario ingresado.';
      SELECT msje;
		WHEN id>0 THEN

      SELECT estado_UPer INTO estado FROM usuariopersonal WHERE id_UPer=id;

      CASE WHEN estado=0 THEN
          SET msje:='El usuario ingresado no se encuentra activo (comuniquese con el administrador del sistema).';
            SELECT msje;
          WHEN estado>0 THEN
             SELECT Personal_id_Per, clave_UPer FROM usuariopersonal WHERE id_UPer=id;
      END CASE;

  END CASE;

END $$

DELIMITER ;

DELIMITER $$

DROP PROCEDURE IF EXISTS `bdpruebas`.`pa_loginPersonalId`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE  `bdpruebas`.`pa_loginPersonalId`(IN id INT)
BEGIN
    SELECT
		  personal.apellidoMaterno_Per,personal.apellidoPaterno_Per,personal.nombres_Per,
      personal.sexo_Per,personal.id_per,usuariopersonal.id_UPer,usuariopersonal.alias_UPer
    FROM personal INNER JOIN usuariopersonal
    ON personal.id_per=usuariopersonal.personal_id_per
    WHERE usuariopersonal.personal_id_per=id
	  LIMIT 1;
END $$

DELIMITER ;