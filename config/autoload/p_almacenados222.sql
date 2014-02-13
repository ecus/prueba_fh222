DELIMITER $$

DROP PROCEDURE IF EXISTS `bdpruebas`.`pa_actualizaDatosPersonal`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE  `bdpruebas`.`pa_actualizaDatosPersonal`(
	IN id SMALLINT,IN dni CHAR(8),IN fecha DATE,
  IN dir VARCHAR(75),IN tcasa VARCHAR(10),IN tmov VARCHAR(10),
  IN mail VARCHAR(50),IN clave VARCHAR(60),
  OUT msje VARCHAR(80))
BEGIN
	DECLARE m VARCHAR(80);
  START TRANSACTION;
	  UPDATE personal SET
		  dni_per=dni,fechaNacimiento_Per=fecha,
		  direccion_per=dir,telefonoCasa_per=tcasa,telefonoMovil_per=tmov,
      email_per=mail
  	WHERE id_per=id;
    UPDATE usuariopersonal SET
      clave_UPer=clave
    WHERE Personal_id_Per=id;
  	SET m='Datos Actualizados.';
	  SELECT m INTO msje;
  COMMIT;
END $$

DELIMITER ;

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
  SET msje:='Sucursal Actualizada.';
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
select id_Soc,nombres_Soc from socio where documento_soc=nro;
end $$

DELIMITER ;

DELIMITER $$

DROP PROCEDURE IF EXISTS `bdpruebas`.`pa_ClienteInscripcion`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE  `bdpruebas`.`pa_ClienteInscripcion`(in dni varchar(11))
BEGIN
  SELECT soc.id_Soc,soc.documento_Soc,CONCAT(soc.apellidoPaterno_Soc,' ', soc.apellidoMaterno_Soc,', ',soc.nombres_Soc) as cliente,
  inc.id_Ins,inc.fechaInicio_Ins, serv.freezing_Serv
  FROM socio soc
  INNER JOIN inscripcion inc ON soc.id_Soc = inc.Socio_id_Soc
  INNER JOIN servicio serv ON inc.Servicio_id_Serv=serv.id_Serv
  WHERE soc.documento_Soc = dni AND inc.estado_Ins=1;
END $$

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
-- SELECT Sucursal_id_Suc INTO existe FROM Pago WHERE Sucursal_id_Suc=id;
	SELECT Sucursal_id_Suc INTO existe FROM Asistencia WHERE Sucursal_id_Suc=id;
	SELECT Sucursal_id_Suc INTO existe FROM SucursalServicio WHERE Sucursal_id_Suc=id;

	CASE WHEN existe = 0 THEN
  			DELETE FROM sucursal WHERE id_suc=id;
        SET m = 'Sucursal  Eliminada.';
  			SELECT m INTO msje;
		  WHEN existe > 0 THEN
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

DROP PROCEDURE IF EXISTS `bdpruebas`.`pa_editaSocio`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE  `bdpruebas`.`pa_editaSocio`(IN id INT, IN dni CHAR(11),in tipodoc tinyint, IN pat VARCHAR(45), IN mat VARCHAR(45),
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
  DECLARE idnum int;

  START TRANSACTION;

			UPDATE socio SET
				id_Soc=id, documento_soc=dni, tipoDocumento_soc=tipodoc,
				apellidoPaterno_Soc=pat, apellidoMaterno_Soc=mat, nombres_Soc=nom,
				sexo_Soc=sexo, fechaNacimiento_Soc=fechanac, estadoCivil_Soc=ecivil,
				direccion_Soc=dir, Distrito_id_Dis=distrito, email_Soc=mail,
				fechaVisita_Soc=fevisita, fechaRegistro_Soc=feregis, fechaInvitacion_Soc=feinvitacion,
				estado_Soc=estado, Socio_Referido=referido, empresa_id_emp=empresa,
				Personal_id_Per=personal
			WHERE id_Soc=id;

			SET mmax:=ExtractValue(xml, 'count(lista/telefono)');

			WHILE j<=mmax DO
				SET idnum:=ExtractValue(xml, 'lista/telefono[$j]/idnum');
				SET numero:=ExtractValue(xml, 'lista/telefono[$j]/numero');
				SET tipo:=ExtractValue(xml, 'lista/telefono[$j]/tipo');
				SET emergencia:=ExtractValue(xml, 'lista/telefono[$j]/emergencia');
		        SET nombreEmergencia:=ExtractValue(xml, 'lista/telefono[$j]/nombre');
		        SET parentesco:=ExtractValue(xml, 'lista/telefono[$j]/parentesco');

				IF idnum=0 THEN
					INSERT INTO telefono
					(numero_Tel, tipo_tel, emergencia_Tel, nombreEmergencia_Tel, parentesco_Tel, Socio_id_Soc)
					VALUES
					(numero,tipo,emergencia,nombreEmergencia,parentesco,id);
				END IF;

				SET j=j+1;
			END WHILE;

			SET mmax=0;

			SET m= CONCAT('Se Actualizaron los datos de ', nom, ' ', pat,  '  en el sistema.');
			SELECT m INTO msje;

  COMMIT;
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
CREATE DEFINER=`root`@`localhost` PROCEDURE  `bdpruebas`.`pa_insertaInscripcion`(IN ini DATE,IN fin DATE, IN socio SMALLINT,IN servicio SMALLINT,IN personal SMALLINT,IN tipo TINYINT ,OUT msje VARCHAR(80))
BEGIN
  DECLARE id INT DEFAULT 0;
  DECLARE cantidad INT DEFAULT 0;
  DECLARE fecha CHAR(15);
  SELECT id_Ins INTO id FROM inscripcion WHERE Socio_id_Soc=socio;

  CASE
    WHEN id=0 THEN
      INSERT INTO inscripcion (fechaInicio_Ins,fechaFin_Ins,Socio_id_Soc,Servicio_id_Serv,Personal_id_Per,tipo_Ins)
      VALUES (ini,fin,socio,servicio,personal,tipo);
      SET  msje:= 'Socio Inscrito';
    WHEN id>0 THEN
      SELECT DATEDIFF(DATE(NOW()),fechaFin_Ins) INTO cantidad FROM inscripcion WHERE id_Ins=id;
      CASE
        WHEN cantidad=0 THEN
          INSERT INTO inscripcion (fechaInicio_Ins,fechaFin_Ins,Socio_id_Soc,Servicio_id_Serv,Personal_id_Per,tipo_Ins)
          VALUES (ini,fin,socio,servicio,personal,tipo);
          SET  msje:= 'Socio Inscrito';
        WHEN cantidad<=5 THEN
          SELECT DATE_ADD( NOW(),INTERVAL cantidad DAY) INTO fecha;
          SET  msje:= CONCAT('El socio, ya esta inscrito en un plan y le quedan ',cantidad,' días, se sugiere registrarlo con esta fecha esta de incio: ', fecha );
        WHEN cantidad>5 THEN
          SET  msje:= CONCAT('El socio, ya esta inscrito en un plan y le quedan ',cantidad,' días');
      END CASE;
  END CASE;
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
	IN tipoDuracion TINYINT,IN duracion TINYINT, IN cuotas TINYINT, IN pagoMax TINYINT, IN personalReg SMALLINT, IN planBase SMALLINT,IN xmlServ TEXT, IN xmlSuc TEXT,IN xml TEXT,OUT msje VARCHAR(80))
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
      cuotasMaximo_Serv,pagoMaximo_Serv, Personal_id_Per,Servicio_id_Serv)
		VALUES
		(	nombre,mBase,tipo,cupon,
			freezing,mInicial,fecha,
			promo,tipoDuracion,duracion,
      cuotas,pagoMax,personalReg,planBase);

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

DROP PROCEDURE IF EXISTS `bdpruebas`.`pa_insertaPlanHorarioC`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE  `bdpruebas`.`pa_insertaPlanHorarioC`(
  IN nombre VARCHAR(45), IN mBase DECIMAL(6,2), IN tipo TINYINT(1), IN cupon TINYINT(4),
	IN freezing TINYINT(4), IN mInicial DECIMAL(6,2), IN fecha DATETIME,IN promo TINYINT(1),
	IN tipoDuracion TINYINT,IN duracion TINYINT, IN cuotas TINYINT, IN pagoMax TINYINT, IN personalReg SMALLINT, IN planBase SMALLINT,IN xmlServ TEXT, IN xmlSuc TEXT,IN xml TEXT,OUT msje VARCHAR(80))
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
      cuotasMaximo_Serv,pagoMaximo_Serv, Personal_id_Per,Servicio_id_Serv)
		VALUES
		(	nombre,mBase,tipo,cupon,
			freezing,mInicial,fecha,
			promo,tipoDuracion,duracion,
      cuotas,pagoMax,personalReg,planBase);

	  CASE
		  WHEN planBase > 0 THEN
        UPDATE servicio SET estado_Serv = 0 WHERE id_serv=planBase;
	  END CASE;

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

DROP PROCEDURE IF EXISTS `bdpruebas`.`pa_insertaPromo`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE  `bdpruebas`.`pa_insertaPromo`(
  IN nombre VARCHAR(45), IN mBase DECIMAL(6,2), IN tipo TINYINT(1), IN cupon TINYINT(4),
	IN freezing TINYINT(4), IN mInicial DECIMAL(6,2), IN fecha DATETIME,IN promo TINYINT(1),
	IN tipoDuracion TINYINT,IN duracion TINYINT, IN cuotas TINYINT, IN pagoMax TINYINT,
  IN personalReg SMALLINT, IN planBase SMALLINT,IN xmlServ TEXT,
  IN xmlSuc TEXT,OUT msje VARCHAR(80))
BEGIN
  DECLARE m VARCHAR(80);
--  para servicio
	DECLARE serv SMALLINT;
	DECLARE horaServ SMALLINT;

--  para plan
	DECLARE d INT DEFAULT 1;
	DECLARE servicioAux SMALLINT;
	DECLARE dmax INT DEFAULT 0;

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
      cuotasMaximo_Serv,pagoMaximo_Serv, Personal_id_Per,Servicio_id_Serv)
		VALUES
		(	nombre,mBase,tipo,cupon,
			freezing,mInicial,fecha,
			promo,tipoDuracion,duracion,
      cuotas,pagoMax,personalReg,planBase);

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

    SET msje:='Plan Registrado con exito.';
    COMMIT;

END $$

DELIMITER ;

DELIMITER $$

DROP PROCEDURE IF EXISTS `bdpruebas`.`pa_insertaPromoBase`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE  `bdpruebas`.`pa_insertaPromoBase`(
	IN base SMALLINT(5), IN tipo TINYINT(4) ,IN fechaInicio DATE,
	IN fechaFin DATE,IN monto DECIMAL(6,2) ,IN dias TINYINT(4),
	IN porcentaje FLOAT ,IN min TINYINT(4),IN max TINYINT(4),
	IN horario TINYINT(1), IN per SMALLINT(5),OUT msje VARCHAR(80))
BEGIN
	DECLARE serv SMALLINT;
	START TRANSACTION;
		INSERT INTO servicio(
			nombre_Serv, montoBase_Serv,
			tipo_Serv, diasCupon_Serv, freezing_Serv,
			montoInicial_Serv, fechaRegistro_Serv, promocion_Serv,
			empresa_id_emp, Personal_id_Per, Servicio_id_Serv,
			estado_Serv, tipoDuracion_Serv, duracion_Serv,
			cuotasMaximo_Serv, pagoMaximo_Serv)

			(SELECT
				nombre_Serv, montoBase_Serv,
				tipo_Serv, diasCupon_Serv, freezing_Serv,
				montoInicial_Serv, fechaRegistro_Serv, 1,
				empresa_id_emp, per, Servicio_id_Serv,
				estado_Serv, tipoDuracion_Serv, duracion_Serv,
				cuotasMaximo_Serv, pagoMaximo_Serv
			FROM servicio
			WHERE id_Serv = base
			);

		SELECT MAX(LAST_INSERT_ID(id_Serv)) INTO serv FROM servicio;

		INSERT INTO detallepromocion (
			Servicio_id_Serv,
			tipoPromocion_DPromo,fechaInicio_DPromo,fechaFin_DPromo,
			montoPromocion_DPromo,dias_DPromo,porcentaje_DPromo,
			empresaMin_DPromo,empresaMax_DPromo,horario_DPromo)
		VALUES (
			base,
			tipo,fechaInicio,fechaFin,
			monto,dias,porcentaje,
			min,max,horario
			);

		INSERT INTO detalleservicio
			(Servicio_id_Serv1,Plan_id_Serv)
			(
			SELECT Servicio_id_Serv1,serv
			FROM detalleservicio WHERE Plan_id_Serv = base);

		INSERT INTO sucursalservicio
			(Sucursal_id_Suc, Servicio_id_Serv)
			(
			SELECT Sucursal_id_Suc, serv
			FROM sucursalservicio WHERE Servicio_id_Serv=base);

    SET msje:='Promocion Registrada con exito.';
	COMMIT;
END $$

DELIMITER ;

DELIMITER $$

DROP PROCEDURE IF EXISTS `bdpruebas`.`pa_InsertarFreezing`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE  `bdpruebas`.`pa_InsertarFreezing`(in FecReg datetime,in dias tinyint,in coment varchar(150),in idInsc int, in idSoc smallint,in idPer int,OUT msje VARCHAR(80))
begin
DECLARE cod smallint;
	SELECT (COALESCE( MAX( id_Free ) , 0 ) +1) INTO cod FROM freezing;
  start transaction;
    insert into freezing(id_Free,fechaRegistro_free,cantidadDias_free,descripcion_free,Inscripcion_id_Ins,
    Socio_id_Soc,Personal_id_Per)
    values(cod,FecReg,dias,coment,idInsc,idSoc,idPer);

    UPDATE inscripcion insc SET insc.estado_Ins = 0 WHERE insc.Socio_id_Soc = idSoc;
    SET msje:='Freezing registrado.';
  commit;
end $$

DELIMITER ;

DELIMITER $$

DROP PROCEDURE IF EXISTS `bdpruebas`.`pa_InsertarPago`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE  `bdpruebas`.`pa_InsertarPago`(in FecReg datetime,in FecPago datetime,in pago decimal(6,2),in moneda tinyint,in forma tinyint, in concepto tinyint,
                                 in estado tinyint(1),in idSer smallint, in idCta int, in idPer smallint,in idSuc tinyint, in idSoc smallint,out msje varchar(80))
begin
DECLARE cod int;
	SELECT (COALESCE( MAX( id_Pago ) , 0 ) +1) INTO cod FROM pago;

  insert into pago(id_Pago,fechaRegistro_Pago,fechaPago_Pago,monto_Pago,moneda_pago,forma_Pago,concepto_Pago,estado_Pago,Servicio_id_Serv,
  Cuenta_id_Cuenta,Personal_id_Per,Sucursal_id_Suc,Socio_id_Soc)
  values(cod,FecReg,FecPago,pago,moneda,forma,concepto,estado,idSer,idCta,idPer,idSuc,idSoc);

  SET msje:= 'Pago Registrado.';
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

      SET m= CONCAT(nom, ' ', pat, ' se Registró en el sistema con el id: ',soc );
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
      SET  msje:= CONCAT(nom, ' ', pat, ' se Registró en el sistema con el id.', codigo);
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
      SET m = 'Sucursal Registrada.';
      SELECT m INTO msje;
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

DROP PROCEDURE IF EXISTS `bdpruebas`.`pa_ListaSociosReferir`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE  `bdpruebas`.`pa_ListaSociosReferir`()
begin
select id_Soc,concat(apellidoPaterno_Soc, ' ', apellidoMaterno_Soc,', ', nombres_Soc) as cliente,documento_soc
from socio;
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

DELIMITER $$

DROP PROCEDURE IF EXISTS `bdpruebas`.`pa_verificaClavePersonal`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE  `bdpruebas`.`pa_verificaClavePersonal`(IN id INT)
BEGIN
  SELECT clave_UPer FROM usuariopersonal WHERE Personal_id_Per=id;
END $$

DELIMITER ;

DELIMITER $$

DROP PROCEDURE IF EXISTS `bdpruebas`.`pa_verPersonal`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE  `bdpruebas`.`pa_verPersonal`(IN id INT)
BEGIN
  SELECT * FROM personal WHERE id_Per=id;
END $$

DELIMITER ;

DELIMITER $$

DROP PROCEDURE IF EXISTS `bdpruebas`.`pa_verSocio`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE  `bdpruebas`.`pa_verSocio`(IN id INT)
BEGIN
  SELECT
	  id_Soc, documento_soc, tipoDocumento_soc, apellidoPaterno_Soc,
	  apellidoMaterno_Soc, nombres_Soc, sexo_Soc, fechaNacimiento_Soc,
	  estadoCivil_Soc, direccion_Soc, Distrito_id_Dis, email_Soc,
	  fechaVisita_Soc, fechaRegistro_Soc, fechaInvitacion_Soc,
	  estado_Soc,(SELECT d.Ciudad_id_Ciu FROM distrito d WHERE d.id_Dis=Distrito_id_Dis) AS ciudad_Soc,
	  (SELECT CONCAT(s.apellidoPaterno_Soc,' ',s.apellidoMaterno_Soc, ', ',s.nombres_Soc) FROM socio s WHERE id_Soc = Socio_Referido) as Socio_Referido,
	  empresa_id_emp,
	  (SELECT CONCAT(p.apellidoPaterno_Per,' ',p.apellidoMaterno_Per, ', ',p.nombres_Per) FROM personal p WHERE id_Per = Personal_id_Per) as Personal_id_Per
  FROM socio WHERE id_Soc=id;

  SELECT * FROM telefono WHERE Socio_id_Soc=id;
END $$

DELIMITER ;

--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

-- phpMyAdmin SQL Dump
-- version 3.5.1
-- http://www.phpmyadmin.net
--
-- Servidor: localhost
-- Tiempo de generación: 28-01-2014 a las 09:48:26
-- Versión del servidor: 5.5.24-log
-- Versión de PHP: 5.4.3

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de datos: `bdpruebas`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `pa_actualizaDatosPersonal`(
	IN id SMALLINT,IN dni CHAR(8),IN fecha DATE,
  IN dir VARCHAR(75),IN tcasa VARCHAR(10),IN tmov VARCHAR(10),
  IN mail VARCHAR(50),IN clave VARCHAR(60),
  OUT msje VARCHAR(80))
BEGIN
	DECLARE m VARCHAR(80);
  START TRANSACTION;
	  UPDATE personal SET
		  dni_per=dni,fechaNacimiento_Per=fecha,
		  direccion_per=dir,telefonoCasa_per=tcasa,telefonoMovil_per=tmov,
      email_per=mail
  	WHERE id_per=id;
    UPDATE usuariopersonal SET
      clave_UPer=clave
    WHERE Personal_id_Per=id;
  	SET m='Datos Actualizados.';
	  SELECT m INTO msje;
  COMMIT;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pa_actualizaPersonal`(
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
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pa_actualizaPersonalUsuario`(
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
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pa_actualizaSucursal`(IN nombre VARCHAR(40),IN direccion VARCHAR(45),IN linea TINYINT,IN telefono CHAR(9),IN estado TINYINT(1),IN id TINYINT,OUT msje VARCHAR(80))
BEGIN
	UPDATE sucursal SET
		nombre_suc		=	nombre,
		direccion_suc	=	direccion,
		linea_suc		=	linea,
		telefono_suc	=	telefono,
		estado_suc		=	estado
	WHERE
		id_suc=id;
  SET msje:='Sucursal Actualizada.';
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pa_buscaPersonal`(IN dni CHAR(8))
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
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pa_buscarsocio`(in nro char(11))
begin
select id_Soc,nombres_Soc from socio where documento_soc=nro;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pa_ClienteInscripcion`(in dni varchar(11))
BEGIN
  SELECT soc.id_Soc,soc.documento_Soc,CONCAT(soc.apellidoPaterno_Soc,' ', soc.apellidoMaterno_Soc,', ',soc.nombres_Soc) as cliente,
  inc.id_Ins,inc.fechaInicio_Ins, serv.freezing_Serv
  FROM socio soc
  INNER JOIN inscripcion inc ON soc.id_Soc = inc.Socio_id_Soc
  INNER JOIN servicio serv ON inc.Servicio_id_Serv=serv.id_Serv
  WHERE soc.documento_Soc = dni AND inc.estado_Ins=1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pa_CliServicio`(in dni varchar(11))
begin
SELECT soc.id_Soc,soc.documento_Soc,concat_ws(' ', apellidoPaterno_Soc, apellidoMaterno_Soc,nombres_Soc) as cliente,
ser.id_Serv,ser.nombre_Serv,ser.montoBase_Serv
from socio soc
INNER JOIN inscripcion inc on soc.id_Soc = inc.Socio_id_Soc
inner join servicio ser on inc.Servicio_id_Serv = ser.id_Serv
where soc.documento_Soc = dni;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pa_consolidadoPlan`(IN id SMALLINT)
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
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pa_desactivarSucursal`(IN id TINYINT,OUT msje VARCHAR(80))
BEGIN
	DECLARE existe TINYINT;
	DECLARE m VARCHAR(80);
	SET existe=0;
	SELECT Sucursal_id_Suc INTO existe FROM Sala WHERE Sucursal_id_Suc=id;
-- SELECT Sucursal_id_Suc INTO existe FROM Pago WHERE Sucursal_id_Suc=id;
	SELECT Sucursal_id_Suc INTO existe FROM Asistencia WHERE Sucursal_id_Suc=id;
	SELECT Sucursal_id_Suc INTO existe FROM SucursalServicio WHERE Sucursal_id_Suc=id;

	CASE WHEN existe = 0 THEN
  			DELETE FROM sucursal WHERE id_suc=id;
        SET m = 'Sucursal  Eliminada.';
  			SELECT m INTO msje;
		  WHEN existe > 0 THEN
	  		BEGIN
		  		UPDATE sucursal SET
			  		estado_suc		=	0
				  WHERE
					  id_suc=id;
  				SET m = 'No se puede eliminar, ya que otros registros dependen de esta Informacion!';
	  			SELECT m INTO msje;
		  	END;
	END CASE;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pa_editaSocio`(IN id INT, IN dni CHAR(11),in tipodoc tinyint, IN pat VARCHAR(45), IN mat VARCHAR(45),
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
  DECLARE idnum int;

  START TRANSACTION;

			UPDATE socio SET
				id_Soc=id, documento_soc=dni, tipoDocumento_soc=tipodoc,
				apellidoPaterno_Soc=pat, apellidoMaterno_Soc=mat, nombres_Soc=nom,
				sexo_Soc=sexo, fechaNacimiento_Soc=fechanac, estadoCivil_Soc=ecivil,
				direccion_Soc=dir, Distrito_id_Dis=distrito, email_Soc=mail,
				fechaVisita_Soc=fevisita, fechaRegistro_Soc=feregis, fechaInvitacion_Soc=feinvitacion,
				estado_Soc=estado, Socio_Referido=referido, empresa_id_emp=empresa,
				Personal_id_Per=personal
			WHERE id_Soc=id;

			SET mmax:=ExtractValue(xml, 'count(lista/telefono)');

			WHILE j<=mmax DO
				SET idnum:=ExtractValue(xml, 'lista/telefono[$j]/idnum');
				SET numero:=ExtractValue(xml, 'lista/telefono[$j]/numero');
				SET tipo:=ExtractValue(xml, 'lista/telefono[$j]/tipo');
				SET emergencia:=ExtractValue(xml, 'lista/telefono[$j]/emergencia');
		        SET nombreEmergencia:=ExtractValue(xml, 'lista/telefono[$j]/nombre');
		        SET parentesco:=ExtractValue(xml, 'lista/telefono[$j]/parentesco');

				IF idnum=0 THEN
					INSERT INTO telefono
					(numero_Tel, tipo_tel, emergencia_Tel, nombreEmergencia_Tel, parentesco_Tel, Socio_id_Soc)
					VALUES
					(numero,tipo,emergencia,nombreEmergencia,parentesco,id);
				END IF;

				SET j=j+1;
			END WHILE;

			SET mmax=0;

			SET m= CONCAT('Se Actualizaron los datos de ', nom, ' ', pat,  '  en el sistema.');
			SELECT m INTO msje;

  COMMIT;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pa_insertaAsistencia`(in fecReg datetime, in fecIng datetime, in idIns int, in idSoc smallint,in idPer smallint,in idSuc tinyint,out msje varchar(80))
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
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pa_insertaInscripcion`(IN ini DATE,IN fin DATE, IN socio SMALLINT,IN servicio SMALLINT,IN personal SMALLINT,IN tipo TINYINT ,OUT msje VARCHAR(80))
BEGIN
  DECLARE id INT DEFAULT 0;
  DECLARE cantidad INT DEFAULT 0;
  DECLARE fecha CHAR(15);
  SELECT id_Ins INTO id FROM inscripcion WHERE Socio_id_Soc=socio;

  CASE
    WHEN id=0 THEN
      INSERT INTO inscripcion (fechaInicio_Ins,fechaFin_Ins,Socio_id_Soc,Servicio_id_Serv,Personal_id_Per,tipo_Ins)
      VALUES (ini,fin,socio,servicio,personal,tipo);
      SET  msje:= 'Socio Inscrito';
    WHEN id>0 THEN
      SELECT DATEDIFF(DATE(NOW()),fechaFin_Ins) INTO cantidad FROM inscripcion WHERE id_Ins=id;
      CASE
        WHEN cantidad=0 THEN
          INSERT INTO inscripcion (fechaInicio_Ins,fechaFin_Ins,Socio_id_Soc,Servicio_id_Serv,Personal_id_Per,tipo_Ins)
          VALUES (ini,fin,socio,servicio,personal,tipo);
          SET  msje:= 'Socio Inscrito';
        WHEN cantidad<=5 THEN
          SELECT DATE_ADD( NOW(),INTERVAL cantidad DAY) INTO fecha;
          SET  msje:= CONCAT('El socio, ya esta inscrito en un plan y le quedan ',cantidad,' días, se sugiere registrarlo con esta fecha esta de incio: ', fecha );
        WHEN cantidad>5 THEN
          SET  msje:= CONCAT('El socio, ya esta inscrito en un plan y le quedan ',cantidad,' días');
      END CASE;
  END CASE;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pa_insertaPersonal`(
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
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pa_insertaPersonalUsuario`(
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
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pa_insertaPlanHorario`(
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

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pa_insertaPlanHorarioB`(
  IN nombre VARCHAR(45), IN mBase DECIMAL(6,2), IN tipo TINYINT(1), IN cupon TINYINT(4),
	IN freezing TINYINT(4), IN mInicial DECIMAL(6,2), IN fecha DATETIME,IN promo TINYINT(1),
	IN tipoDuracion TINYINT,IN duracion TINYINT, IN cuotas TINYINT, IN pagoMax TINYINT, IN personalReg SMALLINT, IN planBase SMALLINT,IN xmlServ TEXT, IN xmlSuc TEXT,IN xml TEXT,OUT msje VARCHAR(80))
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
      cuotasMaximo_Serv,pagoMaximo_Serv, Personal_id_Per,Servicio_id_Serv)
		VALUES
		(	nombre,mBase,tipo,cupon,
			freezing,mInicial,fecha,
			promo,tipoDuracion,duracion,
      cuotas,pagoMax,personalReg,planBase);

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

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pa_insertaPlanHorarioC`(
  IN nombre VARCHAR(45), IN mBase DECIMAL(6,2), IN tipo TINYINT(1), IN cupon TINYINT(4),
	IN freezing TINYINT(4), IN mInicial DECIMAL(6,2), IN fecha DATETIME,IN promo TINYINT(1),
	IN tipoDuracion TINYINT,IN duracion TINYINT, IN cuotas TINYINT, IN pagoMax TINYINT, IN personalReg SMALLINT, IN planBase SMALLINT,IN xmlServ TEXT, IN xmlSuc TEXT,IN xml TEXT,OUT msje VARCHAR(80))
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
      cuotasMaximo_Serv,pagoMaximo_Serv, Personal_id_Per,Servicio_id_Serv)
		VALUES
		(	nombre,mBase,tipo,cupon,
			freezing,mInicial,fecha,
			promo,tipoDuracion,duracion,
      cuotas,pagoMax,personalReg,planBase);

	  CASE
		  WHEN planBase > 0 THEN
        UPDATE servicio SET estado_Serv = 0 WHERE id_serv=planBase;
	  END CASE;

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

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pa_insertaPromo`(
  IN nombre VARCHAR(45), IN mBase DECIMAL(6,2), IN tipo TINYINT(1), IN cupon TINYINT(4),
	IN freezing TINYINT(4), IN mInicial DECIMAL(6,2), IN fecha DATETIME,IN promo TINYINT(1),
	IN tipoDuracion TINYINT,IN duracion TINYINT, IN cuotas TINYINT, IN pagoMax TINYINT,
  IN personalReg SMALLINT, IN planBase SMALLINT,IN xmlServ TEXT,
  IN xmlSuc TEXT,OUT msje VARCHAR(80))
BEGIN
  DECLARE m VARCHAR(80);
--  para servicio
	DECLARE serv SMALLINT;
	DECLARE horaServ SMALLINT;

--  para plan
	DECLARE d INT DEFAULT 1;
	DECLARE servicioAux SMALLINT;
	DECLARE dmax INT DEFAULT 0;

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
      cuotasMaximo_Serv,pagoMaximo_Serv, Personal_id_Per,Servicio_id_Serv)
		VALUES
		(	nombre,mBase,tipo,cupon,
			freezing,mInicial,fecha,
			promo,tipoDuracion,duracion,
      cuotas,pagoMax,personalReg,planBase);

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

    SET msje:='Plan Registrado con exito.';
    COMMIT;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pa_insertaPromoBase`(
	IN base SMALLINT(5), IN tipo TINYINT(4) ,IN fechaInicio DATE,
	IN fechaFin DATE,IN monto DECIMAL(6,2) ,IN dias TINYINT(4),
	IN porcentaje FLOAT ,IN min TINYINT(4),IN max TINYINT(4),
	IN horario TINYINT(1), IN per SMALLINT(5),OUT msje VARCHAR(80))
BEGIN
	DECLARE serv SMALLINT;
	START TRANSACTION;
		INSERT INTO servicio(
			nombre_Serv, montoBase_Serv,
			tipo_Serv, diasCupon_Serv, freezing_Serv,
			montoInicial_Serv, fechaRegistro_Serv, promocion_Serv,
			empresa_id_emp, Personal_id_Per, Servicio_id_Serv,
			estado_Serv, tipoDuracion_Serv, duracion_Serv,
			cuotasMaximo_Serv, pagoMaximo_Serv)

			(SELECT
				nombre_Serv, montoBase_Serv,
				tipo_Serv, diasCupon_Serv, freezing_Serv,
				montoInicial_Serv, fechaRegistro_Serv, 1,
				empresa_id_emp, per, Servicio_id_Serv,
				estado_Serv, tipoDuracion_Serv, duracion_Serv,
				cuotasMaximo_Serv, pagoMaximo_Serv
			FROM servicio
			WHERE id_Serv = base
			);

		SELECT MAX(LAST_INSERT_ID(id_Serv)) INTO serv FROM servicio;

		INSERT INTO detallepromocion (
			Servicio_id_Serv,
			tipoPromocion_DPromo,fechaInicio_DPromo,fechaFin_DPromo,
			montoPromocion_DPromo,dias_DPromo,porcentaje_DPromo,
			empresaMin_DPromo,empresaMax_DPromo,horario_DPromo)
		VALUES (
			base,
			tipo,fechaInicio,fechaFin,
			monto,dias,porcentaje,
			min,max,horario
			);

		INSERT INTO detalleservicio
			(Servicio_id_Serv1,Plan_id_Serv)
			(
			SELECT Servicio_id_Serv1,serv
			FROM detalleservicio WHERE Plan_id_Serv = base);

		INSERT INTO sucursalservicio
			(Sucursal_id_Suc, Servicio_id_Serv)
			(
			SELECT Sucursal_id_Suc, serv
			FROM sucursalservicio WHERE Servicio_id_Serv=base);

    SET msje:='Promocion Registrada con exito.';
	COMMIT;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pa_InsertarFreezing`(in FecReg datetime,in dias tinyint,in coment varchar(150),in idInsc int, in idSoc smallint,in idPer int,OUT msje VARCHAR(80))
begin
DECLARE cod smallint;
	SELECT (COALESCE( MAX( id_Free ) , 0 ) +1) INTO cod FROM freezing;
  start transaction;
    insert into freezing(id_Free,fechaRegistro_free,cantidadDias_free,descripcion_free,Inscripcion_id_Ins,
    Socio_id_Soc,Personal_id_Per)
    values(cod,FecReg,dias,coment,idInsc,idSoc,idPer);

    UPDATE inscripcion insc SET insc.estado_Ins = 0 WHERE insc.Socio_id_Soc = idSoc;
    SET msje:='Freezing registrado.';
  commit;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pa_InsertarPago`(in FecReg datetime,in FecPago datetime,in pago decimal(6,2),in moneda tinyint,in forma tinyint, in concepto tinyint,
                                 in estado tinyint(1),in idSer smallint, in idCta int, in idPer smallint,in idSuc tinyint, in idSoc smallint,out msje varchar(80))
begin
DECLARE cod int;
	SELECT (COALESCE( MAX( id_Pago ) , 0 ) +1) INTO cod FROM pago;

  insert into pago(id_Pago,fechaRegistro_Pago,fechaPago_Pago,monto_Pago,moneda_pago,forma_Pago,concepto_Pago,estado_Pago,Servicio_id_Serv,
  Cuenta_id_Cuenta,Personal_id_Per,Sucursal_id_Suc,Socio_id_Soc)
  values(cod,FecReg,FecPago,pago,moneda,forma,concepto,estado,idSer,idCta,idPer,idSuc,idSoc);

  SET msje:= 'Pago Registrado.';
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pa_insertaServicioHorario`(IN nombre VARCHAR(45), IN mBase DECIMAL(6,2), IN tipo TINYINT(1), IN cupon TINYINT(4),
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

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pa_insertaSocio`(IN dni CHAR(11),in tipodoc tinyint, IN pat VARCHAR(45), IN mat VARCHAR(45),
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

      SET m= CONCAT(nom, ' ', pat, ' se Registró en el sistema con el id: ',soc );
		  SELECT m INTO msje;
  	ELSE
	  	SET m='La persona ya fue Registrada..!! (DNI Registrado)';
		  SELECT m INTO msje;
  	END IF;
  COMMIT;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pa_insertaSocioUsuarios`(
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
      SET  msje:= CONCAT(nom, ' ', pat, ' se Registró en el sistema con el id.', codigo);
			COMMIT;
		ELSE
			SELECT CONCAT(apellidoPaterno_Soc,' ',apellidoMaterno_Soc,', ',nombres_Soc) INTO socios FROM socio WHERE documento_soc=dni;
			SET m=CONCAT('DNI Registrado antes para: ',socios);
			SELECT m INTO msje;
	END CASE;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pa_insertaSucursal`(IN nombre VARCHAR(40),IN direccion VARCHAR(45),IN linea TINYINT,IN telefono CHAR(9),OUT msje VARCHAR(80))
BEGIN
	DECLARE aux TINYINT;
	DECLARE m VARCHAR(80);
	SET aux=0;
	SELECT id_suc INTO aux FROM sucursal WHERE nombre_suc = nombre;
	CASE aux
		WHEN 0 THEN
			INSERT INTO sucursal (nombre_suc,direccion_suc,linea_suc,telefono_suc) VALUES (nombre,direccion,linea,telefono);
      SET m = 'Sucursal Registrada.';
      SELECT m INTO msje;
		ELSE
			BEGIN
				SET m = 'Ya existe una sucursal Registrada con ese nombre';
				SELECT m INTO msje;
			END;
	END CASE;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pa_insertSocio`(IN dni CHAR(11),in tipodoc tinyint,IN pat VARCHAR(45),IN mat VARCHAR(45),IN nom VARCHAR(45),in sexo tinyint(1),
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
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pa_leeSocio`(IN id smallint)
BEGIN
	SELECT id_Ins,nombre_Serv
from socio soc
inner join inscripcion inc on soc.id_Soc=inc.Socio_id_Soc
inner join servicio ser on inc.Servicio_id_Serv=ser.id_Serv
WHERE id_Soc=id and inc.estado_Ins=1 and inc.tipo_Ins=0;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pa_leeSucursal`(IN id TINYINT)
BEGIN
	SELECT id_suc,nombre_suc,direccion_suc,linea_suc,telefono_suc,estado_suc FROM sucursal WHERE id_suc=id LIMIT 1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pa_listaCiudad`()
BEGIN
  SELECT id_Ciu, nombre_Ciu FROM ciudad;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pa_listaDistrito`(IN id tinyint)
BEGIN
  SELECT id_Dis, nombre_Dis, Ciudad_id_Ciu FROM distrito WHERE Ciudad_id_Ciu = id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pa_listaEmpresa`()
BEGIN
  SELECT id_emp,nombre_emp FROM empresa;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pa_listaPersonal`()
BEGIN
  SELECT id_per, nombres_per,apellidoMaterno_Per,apellidoPaterno_Per FROM personal WHERE estado_per=1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pa_listaPlan`()
begin
  SELECT id_Serv,nombre_Serv FROM servicio WHERE tipo_Serv=1;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pa_listaServicio`()
begin
  SELECT id_Serv,nombre_Serv FROM servicio;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pa_listaServicioBase`()
BEGIN
  SELECT id_Serv, nombre_Serv FROM servicio WHERE tipo_serv=0 AND estado_Serv=1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pa_listaSocio`()
BEGIN
select id_Soc,concat(apellidoPaterno_Soc, ' ' , apellidoMaterno_Soc, ', ',nombres_Soc) as cliente,documento_soc
from socio;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pa_ListaSociosActivos`()
begin
select id_Soc,concat_ws(' ', apellidoPaterno_Soc, apellidoMaterno_Soc,nombres_Soc) as cliente,documento_soc
from socio soc
INNER JOIN inscripcion inc on soc.id_Soc = inc.Socio_id_Soc
where soc.estado_Soc=0 and inc.estado_Ins=1 and inc.tipo_Ins=0;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pa_ListaSociosReferir`()
begin
select id_Soc,concat(apellidoPaterno_Soc, ' ', apellidoMaterno_Soc,', ', nombres_Soc) as cliente,documento_soc
from socio;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pa_listaSucursal`()
BEGIN
	SELECT id_suc,nombre_suc,direccion_suc,linea_suc,telefono_suc,estado_suc FROM sucursal;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pa_listaSucursalActivo`()
BEGIN
	SELECT id_suc,nombre_suc,direccion_suc,linea_suc,telefono_suc,estado_suc FROM sucursal WHERE estado_suc=1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pa_listaSucursalInactivo`()
BEGIN
	SELECT id_suc,nombre_suc,direccion_suc,linea_suc,telefono_suc,estado_suc FROM sucursal WHERE estado_suc=0;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pa_loginPersonal`(IN nombre VARCHAR(20))
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

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pa_loginPersonalId`(IN id INT)
BEGIN
    SELECT
		  personal.apellidoMaterno_Per,personal.apellidoPaterno_Per,personal.nombres_Per,
      personal.sexo_Per,personal.id_per,usuariopersonal.id_UPer,usuariopersonal.alias_UPer
    FROM personal INNER JOIN usuariopersonal
    ON personal.id_per=usuariopersonal.personal_id_per
    WHERE usuariopersonal.personal_id_per=id
	  LIMIT 1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pa_verificaClavePersonal`(IN id INT)
BEGIN
  SELECT clave_UPer FROM usuariopersonal WHERE Personal_id_Per=id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pa_verPersonal`(IN id INT)
BEGIN
  SELECT * FROM personal WHERE id_Per=id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pa_verSocio`(IN id INT)
BEGIN
  SELECT
	  id_Soc, documento_soc, tipoDocumento_soc, apellidoPaterno_Soc,
	  apellidoMaterno_Soc, nombres_Soc, sexo_Soc, fechaNacimiento_Soc,
	  estadoCivil_Soc, direccion_Soc, Distrito_id_Dis, email_Soc,
	  fechaVisita_Soc, fechaRegistro_Soc, fechaInvitacion_Soc,
	  estado_Soc,(SELECT d.Ciudad_id_Ciu FROM distrito d WHERE d.id_Dis=Distrito_id_Dis) AS ciudad_Soc,
	  (SELECT CONCAT(s.apellidoPaterno_Soc,' ',s.apellidoMaterno_Soc, ', ',s.nombres_Soc) FROM socio s WHERE id_Soc = Socio_Referido) as Socio_Referido,
	  empresa_id_emp,
	  (SELECT CONCAT(p.apellidoPaterno_Per,' ',p.apellidoMaterno_Per, ', ',p.nombres_Per) FROM personal p WHERE id_Per = Personal_id_Per) as Personal_id_Per
  FROM socio WHERE id_Soc=id;

  SELECT * FROM telefono WHERE Socio_id_Soc=id;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `asistencia`
--

CREATE TABLE IF NOT EXISTS `asistencia` (
  `id_Asis` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fechaRegistro_asis` datetime NOT NULL,
  `fechaIngreso_asis` datetime NOT NULL,
  `Inscripcion_id_Ins` int(11) NOT NULL,
  `HorarioServicio_id_HSer` int(10) unsigned DEFAULT NULL,
  `Socio_id_Soc` smallint(5) unsigned NOT NULL,
  `Personal_id_Per` smallint(5) unsigned NOT NULL,
  `Sucursal_id_Suc` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`id_Asis`),
  KEY `fk_Asistencia_Inscripcion1_idx` (`Inscripcion_id_Ins`),
  KEY `fk_Asistencia_HorarioServicio1_idx` (`HorarioServicio_id_HSer`),
  KEY `fk_Asistencia_Socio1_idx` (`Socio_id_Soc`),
  KEY `fk_Asistencia_Personal1_idx` (`Personal_id_Per`),
  KEY `fk_Asistencia_Sucursal1_idx` (`Sucursal_id_Suc`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `caja`
--

CREATE TABLE IF NOT EXISTS `caja` (
  `id_Caja` int(11) NOT NULL AUTO_INCREMENT,
  `fechaIni_Caja` datetime NOT NULL,
  `fechaFin_Caja` datetime DEFAULT NULL,
  `observacion_Caja` varchar(200) COLLATE utf8_spanish_ci DEFAULT NULL,
  `Personal_id_Per` smallint(5) unsigned NOT NULL,
  `Sucursal_id_Suc` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`id_Caja`),
  KEY `fk_Caja_Personal1_idx` (`Personal_id_Per`),
  KEY `fk_Caja_Sucursal1_idx` (`Sucursal_id_Suc`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cita`
--

CREATE TABLE IF NOT EXISTS `cita` (
  `id_Cita` int(11) NOT NULL,
  `tipo_Cita` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '0: Nutricionista\\n1: Fisioterapeuta',
  `fecha_cita` date NOT NULL,
  `hora_cita` time NOT NULL,
  `estado_Cita` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '0: Pendiente\\n1: Atendida\\n2: Anulada\\n',
  `Personal_id_Per` smallint(5) unsigned NOT NULL,
  `Personal_Atendio` smallint(5) unsigned NOT NULL,
  `Inscripcion_id_Ins` int(11) NOT NULL,
  PRIMARY KEY (`id_Cita`),
  KEY `fk_Cita_Personal1_idx` (`Personal_id_Per`),
  KEY `fk_Cita_Personal2_idx` (`Personal_Atendio`),
  KEY `fk_Cita_Inscripcion1_idx` (`Inscripcion_id_Ins`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ciudad`
--

CREATE TABLE IF NOT EXISTS `ciudad` (
  `id_Ciu` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `nombre_Ciu` varchar(30) COLLATE utf8_spanish_ci NOT NULL,
  PRIMARY KEY (`id_Ciu`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci AUTO_INCREMENT=3 ;

--
-- Volcado de datos para la tabla `ciudad`
--

INSERT INTO `ciudad` (`id_Ciu`, `nombre_Ciu`) VALUES
(1, 'Chiclayo'),
(2, 'Piura');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `comprobante`
--

CREATE TABLE IF NOT EXISTS `comprobante` (
  `id_Comp` smallint(6) unsigned zerofill NOT NULL,
  `nroSerie_Comp` smallint(6) unsigned zerofill NOT NULL,
  `numero_Comp` smallint(6) unsigned zerofill NOT NULL,
  `monto_Comp` decimal(5,2) unsigned zerofill NOT NULL,
  `tipo_Comp` tinyint(1) unsigned zerofill NOT NULL,
  `formaPago_Comp` tinyint(4) NOT NULL,
  `fecha_Comp` datetime NOT NULL,
  `fechaRegistro_Comp` datetime NOT NULL,
  `estado_Comp` tinyint(1) unsigned zerofill NOT NULL DEFAULT '0' COMMENT '0: Emitida\\n1: Anulada',
  `Caja_id_Caja` int(11) NOT NULL,
  `Socio_id_Soc` smallint(5) unsigned NOT NULL,
  `Cuenta_id_Cuenta` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_Comp`),
  KEY `fk_Comprobante_Caja1_idx` (`Caja_id_Caja`),
  KEY `fk_Comprobante_Socio1_idx` (`Socio_id_Soc`),
  KEY `fk_Comprobante_Cuenta1_idx` (`Cuenta_id_Cuenta`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `condicion`
--

CREATE TABLE IF NOT EXISTS `condicion` (
  `id_Con` tinyint(3) unsigned NOT NULL,
  `nombre_Con` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `TipoCondicion_id_TCon` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`id_Con`),
  KEY `fk_Condicion_TipoCondicion1_idx` (`TipoCondicion_id_TCon`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `contrato`
--

CREATE TABLE IF NOT EXISTS `contrato` (
  `id_Cont` smallint(6) NOT NULL,
  `fechaInicio_Cont` date NOT NULL,
  `fechaFin_Cont` date DEFAULT NULL,
  `tipo_Cont` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '0:Regular\\n1:Nombrado',
  `estado_Cont` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '0: Activo\\n1: Inactivo',
  `sueldo_Cont` smallint(6) NOT NULL,
  `tipoSueldo_Cont` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '0: Full time\\n1: Part time\\n2: Horas',
  `tipoPago_Cont` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '0: Mensual\\n1: Quincenal',
  `diaPago_Cont` tinyint(3) unsigned NOT NULL COMMENT 'Fecha de pago ',
  `Personal_id_Per` smallint(5) unsigned NOT NULL,
  PRIMARY KEY (`id_Cont`),
  KEY `fk_Contrato_Personal1_idx` (`Personal_id_Per`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cuenta`
--

CREATE TABLE IF NOT EXISTS `cuenta` (
  `id_Cuenta` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `tipo_cuenta` tinyint(4) NOT NULL COMMENT '0:Visa\\n1:MasterCard\\n2:DinnersClub ',
  `banco_cuenta` varchar(45) COLLATE utf8_spanish_ci NOT NULL,
  `moneda_cuenta` varchar(45) COLLATE utf8_spanish_ci NOT NULL COMMENT '0: Soles\\n1: Dolares\\n2: Euros',
  `estado_cuenta` tinyint(1) NOT NULL DEFAULT '1' COMMENT '0: Inactivo\\n1: Activo',
  PRIMARY KEY (`id_Cuenta`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cuota`
--

CREATE TABLE IF NOT EXISTS `cuota` (
  `id_Cuo` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fecha_Cuo` datetime NOT NULL,
  `monto_Cuo` decimal(6,2) NOT NULL,
  `resto_Cuo` decimal(6,2) DEFAULT NULL,
  `Inscripcion_id_Ins` int(11) NOT NULL,
  `Socio_id_Soc` smallint(5) unsigned NOT NULL,
  `Personal_id_Per` smallint(5) unsigned NOT NULL,
  PRIMARY KEY (`id_Cuo`),
  KEY `fk_Cuota_Inscripcion1_idx` (`Inscripcion_id_Ins`),
  KEY `fk_Cuota_Socio1_idx` (`Socio_id_Soc`),
  KEY `fk_Cuota_Personal1_idx` (`Personal_id_Per`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detallecomprobante`
--

CREATE TABLE IF NOT EXISTS `detallecomprobante` (
  `id_DComp` int(11) NOT NULL,
  `concepto_DComp` tinyint(4) NOT NULL,
  `precio_DComp` varchar(45) COLLATE utf8_spanish_ci NOT NULL,
  `Comprobante_id_Comp` smallint(6) unsigned zerofill NOT NULL,
  `Cuota_id_Cuo` int(10) unsigned DEFAULT NULL,
  `Servicio_id_Serv` smallint(5) unsigned DEFAULT NULL,
  PRIMARY KEY (`id_DComp`),
  KEY `fk_DetalleComprobante_Comprobante1_idx` (`Comprobante_id_Comp`),
  KEY `fk_DetalleComprobante_Cuota1_idx` (`Cuota_id_Cuo`),
  KEY `fk_DetalleComprobante_Servicio1_idx` (`Servicio_id_Serv`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalledieta`
--

CREATE TABLE IF NOT EXISTS `detalledieta` (
  `id_DDiet` int(11) NOT NULL,
  `dia_DDiet` tinyint(3) unsigned NOT NULL,
  `descripcion_DDiet` varchar(250) COLLATE utf8_spanish_ci NOT NULL,
  `tipo_DDiet` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '0: Desayuno\\n1: media mañana\\n2: almuerzo\\n3: lonche\\n4: cena',
  `Dieta_id_Diet` int(11) NOT NULL,
  PRIMARY KEY (`id_DDiet`),
  KEY `fk_DetalleDieta_Dieta1_idx` (`Dieta_id_Diet`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalleejercicio`
--

CREATE TABLE IF NOT EXISTS `detalleejercicio` (
  `Programa_id_Prog` int(10) unsigned NOT NULL,
  `Ejercicio_id_Ejer` tinyint(3) unsigned NOT NULL,
  `series_DEjer` tinyint(3) unsigned NOT NULL COMMENT 'cantidad de series(conjunto de repeticiones)\\n',
  `repeticiones_DEjer` tinyint(3) unsigned NOT NULL COMMENT 'cantidad de veces que se repite un ejercicio',
  PRIMARY KEY (`Programa_id_Prog`,`Ejercicio_id_Ejer`),
  KEY `fk_DetalleEjercicio_Ejercicio1_idx` (`Ejercicio_id_Ejer`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalleestiramiento`
--

CREATE TABLE IF NOT EXISTS `detalleestiramiento` (
  `Programa_id_Prog` int(10) unsigned NOT NULL,
  `Ejercicio_id_Ejer` tinyint(3) unsigned NOT NULL,
  `observacion_DEst` varchar(100) COLLATE utf8_spanish_ci DEFAULT NULL,
  PRIMARY KEY (`Programa_id_Prog`,`Ejercicio_id_Ejer`),
  KEY `fk_detalleEstiramiento_Ejercicio1_idx` (`Ejercicio_id_Ejer`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalleevaluacion`
--

CREATE TABLE IF NOT EXISTS `detalleevaluacion` (
  `Evaluacion_id_Eva` varchar(45) COLLATE utf8_spanish_ci NOT NULL,
  `Condicion_id_Con` tinyint(3) unsigned NOT NULL,
  `descripcion_DEva` varchar(45) COLLATE utf8_spanish_ci NOT NULL,
  PRIMARY KEY (`Evaluacion_id_Eva`,`Condicion_id_Con`),
  KEY `fk_DetalleEvaluacion_Condicion1_idx` (`Condicion_id_Con`),
  KEY `fk_DetalleEvaluacion_Evaluacion1_idx` (`Evaluacion_id_Eva`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detallefactor`
--

CREATE TABLE IF NOT EXISTS `detallefactor` (
  `Factor_id_Fac` tinyint(4) NOT NULL,
  `Socio_id_Soc` smallint(5) unsigned NOT NULL,
  `respuesta_DFac` tinyint(1) unsigned NOT NULL COMMENT '0: No\\n1: Si',
  `observacion_DFac` varchar(100) COLLATE utf8_spanish_ci NOT NULL,
  PRIMARY KEY (`Factor_id_Fac`,`Socio_id_Soc`),
  KEY `fk_DetalleFactor_Factor1_idx` (`Factor_id_Fac`),
  KEY `fk_DetalleFactor_Socio1_idx` (`Socio_id_Soc`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detallehorarioservicio`
--

CREATE TABLE IF NOT EXISTS `detallehorarioservicio` (
  `id_DHServ` smallint(6) NOT NULL AUTO_INCREMENT,
  `dia_DHServ` char(1) COLLATE utf8_spanish_ci NOT NULL COMMENT 'L: Lunes\\nM: Martes\\nW: Miercoles\\nJ: Jueves\\nV: Viernes\\nS: Sabado\\nD: Domingo',
  `horaInicio_DHServ` time NOT NULL,
  `horaFin_DHServ` time NOT NULL,
  `HorarioServicio_id_HSer` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_DHServ`),
  KEY `fk_DetalleHorarioServicio_HorarioServicio1_idx` (`HorarioServicio_id_HSer`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detallemeta`
--

CREATE TABLE IF NOT EXISTS `detallemeta` (
  `Entrenamiento_id_Ent` smallint(5) unsigned NOT NULL,
  `pregunta_id_pre` int(11) NOT NULL,
  PRIMARY KEY (`Entrenamiento_id_Ent`,`pregunta_id_pre`),
  KEY `fk_DetalleMeta_pregunta1_idx` (`pregunta_id_pre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalleobservacion`
--

CREATE TABLE IF NOT EXISTS `detalleobservacion` (
  `Socio_id_Soc` smallint(5) unsigned NOT NULL,
  `pregunta_id_pre` int(11) NOT NULL,
  `opcion_id_op` tinyint(3) unsigned NOT NULL,
  `texto_obs` varchar(70) COLLATE utf8_spanish_ci DEFAULT NULL,
  PRIMARY KEY (`Socio_id_Soc`,`pregunta_id_pre`),
  KEY `fk_DetalleObservacion_Socio1_idx` (`Socio_id_Soc`),
  KEY `fk_DetalleObservacion_pregunta1_idx` (`pregunta_id_pre`),
  KEY `fk_DetalleObservacion_opcion1_idx` (`opcion_id_op`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detallepromocion`
--

CREATE TABLE IF NOT EXISTS `detallepromocion` (
  `Servicio_id_Serv` smallint(5) unsigned NOT NULL,
  `tipoPromocion_DPromo` tinyint(4) NOT NULL COMMENT '1: Precio\\n2: Empresa\\n3: Porcentual\\n4: Dias',
  `fechaInicio_DPromo` datetime NOT NULL,
  `fechaFin_DPromo` datetime NOT NULL,
  `montoPromocion_DPromo` decimal(6,2) DEFAULT NULL,
  `dias_DPromo` tinyint(4) DEFAULT NULL,
  `porcentaje_DPromo` float DEFAULT NULL,
  `empresaMin_DPromo` tinyint(4) DEFAULT NULL COMMENT 'cantidad minima para convenios',
  `empresaMax_DPromo` tinyint(4) DEFAULT NULL COMMENT 'cantidad maxima para convenios',
  `horario_DPromo` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '0:No\\n1:Si\\nverificar si hereda horarios del plan base o es promocion para hoario especifico',
  PRIMARY KEY (`Servicio_id_Serv`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `detallepromocion`
--

INSERT INTO `detallepromocion` (`Servicio_id_Serv`, `tipoPromocion_DPromo`, `fechaInicio_DPromo`, `fechaFin_DPromo`, `montoPromocion_DPromo`, `dias_DPromo`, `porcentaje_DPromo`, `empresaMin_DPromo`, `empresaMax_DPromo`, `horario_DPromo`) VALUES
(6, 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0.00', 0, 0, 0, 0, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalleservicio`
--

CREATE TABLE IF NOT EXISTS `detalleservicio` (
  `Plan_id_Serv` smallint(5) unsigned NOT NULL,
  `Servicio_id_Serv1` smallint(5) unsigned NOT NULL,
  `vigencia` tinyint(1) NOT NULL DEFAULT '1' COMMENT '0: Inactivo\\n1: Activo',
  PRIMARY KEY (`Plan_id_Serv`,`Servicio_id_Serv1`),
  KEY `fk_DetalleServicio_Servicio2_idx` (`Servicio_id_Serv1`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `detalleservicio`
--

INSERT INTO `detalleservicio` (`Plan_id_Serv`, `Servicio_id_Serv1`, `vigencia`) VALUES
(6, 1, 1),
(6, 2, 1),
(6, 3, 1),
(6, 4, 1),
(6, 5, 1),
(7, 1, 1),
(7, 2, 1),
(7, 3, 1),
(8, 1, 1),
(8, 2, 1),
(8, 3, 1),
(8, 4, 1),
(8, 5, 1),
(9, 1, 1),
(9, 2, 1),
(9, 3, 1),
(9, 4, 1),
(9, 5, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detallezona`
--

CREATE TABLE IF NOT EXISTS `detallezona` (
  `Zona_id_Zona` tinyint(3) unsigned NOT NULL,
  `Programa_id_Prog` int(10) unsigned NOT NULL,
  PRIMARY KEY (`Zona_id_Zona`,`Programa_id_Prog`),
  KEY `fk_DetalleZona_Programa1_idx` (`Programa_id_Prog`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `dieta`
--

CREATE TABLE IF NOT EXISTS `dieta` (
  `id_Diet` int(11) NOT NULL,
  `fecha_Diet` date NOT NULL,
  `fechaRevision_Diet` date DEFAULT NULL COMMENT 'Registra fecha considerada para proxima cita.',
  `observacion_Diet` varchar(250) COLLATE utf8_spanish_ci DEFAULT NULL,
  `estado_Diet` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '0: Inactivo\\n1: Activo',
  `Cita_id_Cita` int(11) NOT NULL,
  PRIMARY KEY (`id_Diet`),
  KEY `fk_Dieta_Cita1_idx` (`Cita_id_Cita`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `distrito`
--

CREATE TABLE IF NOT EXISTS `distrito` (
  `id_Dis` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `nombre_Dis` varchar(30) COLLATE utf8_spanish_ci NOT NULL,
  `Ciudad_id_Ciu` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`id_Dis`),
  KEY `fk_Distrito_Ciudad1_idx` (`Ciudad_id_Ciu`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci AUTO_INCREMENT=7 ;

--
-- Volcado de datos para la tabla `distrito`
--

INSERT INTO `distrito` (`id_Dis`, `nombre_Dis`, `Ciudad_id_Ciu`) VALUES
(1, 'Chiclayo', 1),
(2, 'José Leonardo Ortiz', 1),
(3, 'La Victoria', 1),
(4, 'Piura', 2),
(6, 'Sullana', 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ejercicio`
--

CREATE TABLE IF NOT EXISTS `ejercicio` (
  `id_Ejer` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `nombre_Ejer` varchar(45) COLLATE utf8_spanish_ci NOT NULL,
  `descripcion_Ejer` varchar(100) COLLATE utf8_spanish_ci DEFAULT NULL,
  `tipo_Ejer` tinyint(3) unsigned NOT NULL COMMENT '0: Calentamiento\\n1: Ejercicio\\n2: Estiramiento',
  `Zona_id_Zona` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`id_Ejer`),
  KEY `fk_Ejercicio_Zona1_idx` (`Zona_id_Zona`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empresa`
--

CREATE TABLE IF NOT EXISTS `empresa` (
  `id_emp` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `nombre_emp` varchar(45) COLLATE utf8_spanish_ci NOT NULL,
  PRIMARY KEY (`id_emp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `entrenamiento`
--

CREATE TABLE IF NOT EXISTS `entrenamiento` (
  `id_Ent` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `fechaRegistro_Ent` date NOT NULL,
  `descripcion_Ent` varchar(100) COLLATE utf8_spanish_ci DEFAULT NULL COMMENT 'anotaciones que se tendran en cuenta',
  `estado_Ent` tinyint(1) NOT NULL DEFAULT '1' COMMENT '0: Inactivvo\\n1: Activo',
  `Inscripcion_id_Ins` int(11) NOT NULL,
  `Personal_id_Per` smallint(5) unsigned NOT NULL,
  PRIMARY KEY (`id_Ent`),
  KEY `fk_Entrenamiento_Inscripcion1_idx` (`Inscripcion_id_Ins`),
  KEY `fk_Entrenamiento_Personal1_idx` (`Personal_id_Per`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `evaluacion`
--

CREATE TABLE IF NOT EXISTS `evaluacion` (
  `id_Eva` varchar(45) COLLATE utf8_spanish_ci NOT NULL,
  `Ficha_id_Fic` int(11) NOT NULL,
  `Cita_id_Cita` int(11) NOT NULL,
  `fecha_Eva` date NOT NULL,
  `observacion_Eva` varchar(300) COLLATE utf8_spanish_ci DEFAULT NULL,
  PRIMARY KEY (`id_Eva`),
  KEY `fk_Evaluacion_Cita1_idx` (`Cita_id_Cita`),
  KEY `fk_Evaluacion_Ficha1_idx` (`Ficha_id_Fic`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `factor`
--

CREATE TABLE IF NOT EXISTS `factor` (
  `id_Fac` tinyint(4) NOT NULL,
  `nombre_Fac` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `tipo_Fac` tinyint(1) unsigned NOT NULL COMMENT '0: si-no\\n1: si-no_observacion',
  PRIMARY KEY (`id_Fac`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ficha`
--

CREATE TABLE IF NOT EXISTS `ficha` (
  `id_Fic` int(11) NOT NULL,
  `fechaReg_Fic` date NOT NULL,
  `ocupacion_Fic` varchar(45) COLLATE utf8_spanish_ci DEFAULT NULL,
  `deporte_Fic` varchar(45) COLLATE utf8_spanish_ci DEFAULT NULL,
  `tiempoDeporte_Fic` varchar(25) COLLATE utf8_spanish_ci DEFAULT NULL,
  `transnocha_Fic` tinyint(1) unsigned NOT NULL COMMENT '0: No\\n1: Si',
  `tiempoEntrenamiento_Fic` tinyint(3) unsigned DEFAULT NULL COMMENT 'numero de veces a la smeana que entrenara(1 vez, 2 veces)',
  `horaEntrenamiento_Fic` tinyint(3) unsigned NOT NULL COMMENT '0: Mañana\\n1: tarde\\n2: Noche',
  `observacion_Eva` varchar(350) COLLATE utf8_spanish_ci DEFAULT NULL,
  `Socio_id_Soc` smallint(5) unsigned NOT NULL,
  PRIMARY KEY (`id_Fic`),
  KEY `fk_Ficha_Socio1_idx` (`Socio_id_Soc`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `freezing`
--

CREATE TABLE IF NOT EXISTS `freezing` (
  `id_Free` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `fechaRegistro_free` datetime NOT NULL,
  `cantidadDias_free` tinyint(3) unsigned NOT NULL,
  `descripcion_free` varchar(150) COLLATE utf8_spanish_ci DEFAULT NULL,
  `Inscripcion_id_Ins` int(11) NOT NULL,
  `Socio_id_Soc` smallint(5) unsigned NOT NULL,
  `Personal_id_Per` smallint(5) unsigned NOT NULL,
  PRIMARY KEY (`id_Free`),
  KEY `fk_Freezing_Inscripcion1_idx` (`Inscripcion_id_Ins`),
  KEY `fk_Freezing_Socio1_idx` (`Socio_id_Soc`),
  KEY `fk_Freezing_Personal1_idx` (`Personal_id_Per`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `horariopersonal`
--

CREATE TABLE IF NOT EXISTS `horariopersonal` (
  `DetalleHorarioServicio_id_DHServ` smallint(6) NOT NULL,
  `Contrato_id_Cont` smallint(6) NOT NULL,
  KEY `fk_HorarioPersonal_DetalleHorarioServicio1_idx` (`DetalleHorarioServicio_id_DHServ`),
  KEY `fk_HorarioPersonal_Contrato1_idx` (`Contrato_id_Cont`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `horarioservicio`
--

CREATE TABLE IF NOT EXISTS `horarioservicio` (
  `id_HSer` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fechaUnica_HSer` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '0: Programacion Regular\\n1: Evento',
  `dia_HSer` char(1) COLLATE utf8_spanish_ci DEFAULT NULL,
  `fechaProgramada_HSer` date DEFAULT NULL,
  `horaInicio_HSer` time DEFAULT NULL,
  `horaFin_HSer` time DEFAULT NULL,
  `estado_HSer` bit(1) NOT NULL,
  `Servicio_id_Serv` smallint(5) unsigned NOT NULL,
  `Personal_id_Per` smallint(5) unsigned NOT NULL,
  `Personal_Trainer` smallint(5) unsigned NOT NULL,
  `Sala_id_Sala` tinyint(4) NOT NULL,
  PRIMARY KEY (`id_HSer`),
  KEY `fk_HorarioServicio_Servicio1_idx` (`Servicio_id_Serv`),
  KEY `fk_HorarioServicio_Personal2_idx` (`Personal_id_Per`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `inscripcion`
--

CREATE TABLE IF NOT EXISTS `inscripcion` (
  `id_Ins` int(11) NOT NULL AUTO_INCREMENT,
  `fechaInicio_Ins` date NOT NULL,
  `fechaFin_Ins` date NOT NULL,
  `estado_Ins` tinyint(4) NOT NULL DEFAULT '1' COMMENT '0: Inactivo\\n1: Activo\\n2: Suspendido',
  `tipo_Ins` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0: REGULAR\\n1: INVITADO \\n2: Becado\\n3: Recuperación',
  `Socio_id_Soc` smallint(5) unsigned NOT NULL,
  `Servicio_id_Serv` smallint(5) unsigned NOT NULL,
  `Personal_id_Per` smallint(5) unsigned NOT NULL,
  `Inscripcion_id_Ins` int(11) DEFAULT NULL,
  `Sucursal_id_Suc` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`id_Ins`),
  KEY `fk_Inscripcion_Socio1_idx` (`Socio_id_Soc`),
  KEY `fk_Inscripcion_Servicio1_idx` (`Servicio_id_Serv`),
  KEY `fk_Inscripcion_Personal1_idx` (`Personal_id_Per`),
  KEY `fk_Inscripcion_Inscripcion1_idx` (`Inscripcion_id_Ins`),
  KEY `fk_Inscripcion_Sucursal1_idx` (`Sucursal_id_Suc`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `opcion`
--

CREATE TABLE IF NOT EXISTS `opcion` (
  `id_op` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `texto_op` varchar(45) COLLATE utf8_spanish_ci NOT NULL,
  `pregunta_id_pre` int(11) NOT NULL,
  PRIMARY KEY (`id_op`),
  KEY `fk_opcion_pregunta1_idx` (`pregunta_id_pre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `personal`
--

CREATE TABLE IF NOT EXISTS `personal` (
  `id_Per` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `dni_Per` char(8) COLLATE utf8_spanish_ci NOT NULL,
  `apellidoPaterno_Per` varchar(35) COLLATE utf8_spanish_ci NOT NULL,
  `apellidoMaterno_Per` varchar(35) COLLATE utf8_spanish_ci NOT NULL,
  `nombres_Per` varchar(35) COLLATE utf8_spanish_ci NOT NULL,
  `fechaNacimiento_Per` date NOT NULL,
  `sexo_Per` tinyint(1) NOT NULL,
  `direccion_Per` varchar(45) COLLATE utf8_spanish_ci DEFAULT NULL,
  `telefonoCasa_Per` char(9) COLLATE utf8_spanish_ci DEFAULT NULL,
  `telefonoMovil_Per` char(9) COLLATE utf8_spanish_ci DEFAULT NULL,
  `email_Per` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  `cargo_Per` tinyint(3) unsigned NOT NULL DEFAULT '3' COMMENT '0: Director\\n1: Gerente\\n2: Coordinador\\n3: Counter\\n4: Evaluador\\n5: Trainer',
  `estado_Per` tinyint(4) NOT NULL DEFAULT '1' COMMENT '0: Inactivo\\n1: Activo\\n2: Vacaciones',
  `Sucursal_id_Suc` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`id_Per`),
  KEY `fk_Personal_Sucursal1_idx` (`Sucursal_id_Suc`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci AUTO_INCREMENT=5 ;

--
-- Volcado de datos para la tabla `personal`
--

INSERT INTO `personal` (`id_Per`, `dni_Per`, `apellidoPaterno_Per`, `apellidoMaterno_Per`, `nombres_Per`, `fechaNacimiento_Per`, `sexo_Per`, `direccion_Per`, `telefonoCasa_Per`, `telefonoMovil_Per`, `email_Per`, `cargo_Per`, `estado_Per`, `Sucursal_id_Suc`) VALUES
(1, '45733856', 'Urrutia', 'Santamaría', 'Erik', '1989-05-04', 0, 'Juan vizcardo 178', '074273545', '958903956', 'e_urrutia@outlook.com', 3, 1, 0),
(2, '45217893', 'Ñáñez', 'Rentería', 'Claudia', '1989-05-04', 1, 'Pedro Ruiz #110', '228099', '971340470', 'claudia17@outlook.com', 3, 1, 0),
(4, '15932578', 'Rentería', 'Cervantes', 'Rossana del Carmen', '1985-09-08', 1, 'Los Incas 148- La Victoria', '228099', '971340470', 'chana_2002@hotmail.com', 3, 1, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pregunta`
--

CREATE TABLE IF NOT EXISTS `pregunta` (
  `id_pre` int(11) NOT NULL AUTO_INCREMENT,
  `texto_pre` varchar(100) COLLATE utf8_spanish_ci NOT NULL,
  `tipo_pre` tinyint(3) unsigned NOT NULL COMMENT '0: Pregunta\\n1: Observacion\\n2: Meta',
  `Alternativas_pre` tinyint(1) NOT NULL DEFAULT '1' COMMENT '0: No\\n1: Si',
  `tipoAlternativa_pre` tinyint(1) NOT NULL COMMENT '0: Opcional\\n1: Multiple\\n',
  `estado_pre` tinyint(1) NOT NULL COMMENT 'Depende de estado se muestra o no\\n0: Inactivo\\n1: Activo',
  PRIMARY KEY (`id_pre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `programa`
--

CREATE TABLE IF NOT EXISTS `programa` (
  `id_Prog` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fechaInicio_Prog` date NOT NULL,
  `vigencia_Prog` tinyint(3) unsigned NOT NULL COMMENT 'duracion de programa',
  `descripcion_Prog` varchar(100) COLLATE utf8_spanish_ci DEFAULT NULL,
  `estado_Prog` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0: Inactivo\\n1: Activo',
  `Entrenamiento_id_Ent` smallint(5) unsigned NOT NULL,
  PRIMARY KEY (`id_Prog`),
  KEY `fk_Programa_Entrenamiento1_idx` (`Entrenamiento_id_Ent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `respuesta`
--

CREATE TABLE IF NOT EXISTS `respuesta` (
  `id_Rpta` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `pregunta_id_pre` int(11) NOT NULL,
  `opcion_id_op` tinyint(3) unsigned DEFAULT NULL,
  `texto_rpta` varchar(100) COLLATE utf8_spanish_ci DEFAULT NULL,
  `Socio_id_Soc` smallint(5) unsigned NOT NULL,
  PRIMARY KEY (`id_Rpta`),
  KEY `fk_Respuesta_pregunta1_idx` (`pregunta_id_pre`),
  KEY `fk_Respuesta_opcion1_idx` (`opcion_id_op`),
  KEY `fk_Respuesta_Socio1_idx` (`Socio_id_Soc`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sala`
--

CREATE TABLE IF NOT EXISTS `sala` (
  `id_Sala` tinyint(4) NOT NULL,
  `nombre_Sala` varchar(45) COLLATE utf8_spanish_ci NOT NULL,
  `descripcion_Sala` varchar(45) COLLATE utf8_spanish_ci DEFAULT NULL,
  `Sucursal_id_Suc` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`id_Sala`),
  KEY `fk_Sala_Sucursal1_idx` (`Sucursal_id_Suc`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `servicio`
--

CREATE TABLE IF NOT EXISTS `servicio` (
  `id_Serv` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `nombre_Serv` varchar(45) COLLATE utf8_spanish_ci NOT NULL COMMENT 'nombre para indentificar el servicio',
  `montoBase_Serv` decimal(6,2) DEFAULT NULL COMMENT 'Precio Total',
  `tipo_Serv` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0: Servicio Base\\n1: Plan\\n2: Nutricion\\n3: Musculacion',
  `diasCupon_Serv` tinyint(3) unsigned DEFAULT NULL COMMENT 'Dias que puede traer a un invitado',
  `freezing_Serv` tinyint(3) unsigned DEFAULT NULL COMMENT 'Dias de licencia para faltar(se congela la inscripcion)',
  `montoInicial_Serv` decimal(6,2) DEFAULT NULL COMMENT 'pago minimo para separar inscripcion',
  `fechaRegistro_Serv` datetime NOT NULL,
  `promocion_Serv` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0: Sin Promocion\\n1: Con Promocion',
  `empresa_id_emp` tinyint(3) unsigned DEFAULT NULL,
  `Personal_id_Per` smallint(5) unsigned NOT NULL,
  `Servicio_id_Serv` smallint(5) unsigned DEFAULT NULL,
  `estado_Serv` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '0:Inactivo\\n1:Activo',
  `tipoDuracion_Serv` tinyint(3) unsigned DEFAULT '3' COMMENT '0:dias\\n1:semanas\\n2:quincenal\\n3:mensual',
  `duracion_Serv` tinyint(3) unsigned DEFAULT '1',
  `cuotasMaximo_Serv` tinyint(3) unsigned DEFAULT '0' COMMENT 'maximos de cutoas a fraccionar',
  `pagoMaximo_Serv` tinyint(1) unsigned DEFAULT '0' COMMENT '1: maximo fin de mes\\n0: mas de un mes',
  PRIMARY KEY (`id_Serv`),
  KEY `fk_Servicio_empresa1_idx` (`empresa_id_emp`),
  KEY `fk_Servicio_Personal1_idx` (`Personal_id_Per`),
  KEY `fk_Servicio_Servicio1_idx` (`Servicio_id_Serv`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci AUTO_INCREMENT=10 ;

--
-- Volcado de datos para la tabla `servicio`
--

INSERT INTO `servicio` (`id_Serv`, `nombre_Serv`, `montoBase_Serv`, `tipo_Serv`, `diasCupon_Serv`, `freezing_Serv`, `montoInicial_Serv`, `fechaRegistro_Serv`, `promocion_Serv`, `empresa_id_emp`, `Personal_id_Per`, `Servicio_id_Serv`, `estado_Serv`, `tipoDuracion_Serv`, `duracion_Serv`, `cuotasMaximo_Serv`, `pagoMaximo_Serv`) VALUES
(1, 'Musculacion', '0.00', 0, 0, 0, '0.00', '2013-09-09 00:00:00', 0, NULL, 1, NULL, 1, 3, 1, 0, 0),
(2, 'Cycling', '0.00', 0, 0, 0, '0.00', '2013-09-09 00:00:00', 0, NULL, 1, NULL, 1, 3, 1, 0, 0),
(3, 'Clases Grupales', '0.00', 0, 0, 0, '0.00', '2013-09-09 00:00:00', 0, NULL, 1, NULL, 1, 3, 1, 0, 0),
(4, 'Evaluación Física', '0.00', 0, 0, 0, '0.00', '2013-09-09 00:00:00', 0, NULL, 1, NULL, 1, 3, 1, 0, 0),
(5, 'Nutri-Fit', '0.00', 0, 0, 0, '0.00', '2013-09-09 00:00:00', 0, NULL, 1, NULL, 1, 3, 1, 0, 0),
(6, 'Plan 3 meses', '350.00', 1, 0, 3, '100.00', '2013-10-26 00:00:00', 0, NULL, 1, NULL, 1, 3, 3, 3, 0),
(7, 'Plan 3 meses', '300.00', 1, 0, 3, '100.00', '2013-11-04 00:00:00', 0, NULL, 1, 6, 1, 3, 3, 3, 1),
(8, 'Plan 3 meses', '350.00', 1, 0, 3, '100.00', '2013-10-26 00:00:00', 0, NULL, 1, NULL, 1, 3, 3, 3, 0),
(9, 'Plan 3 meses', '350.00', 1, 0, 3, '100.00', '2013-10-26 00:00:00', 1, NULL, 1, NULL, 1, 3, 3, 3, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `serviciosala`
--

CREATE TABLE IF NOT EXISTS `serviciosala` (
  `Servicio_id_Serv` smallint(5) unsigned NOT NULL,
  `Sala_id_Sala` tinyint(4) NOT NULL,
  PRIMARY KEY (`Servicio_id_Serv`,`Sala_id_Sala`),
  KEY `fk_ServicioSala_Sala1_idx` (`Sala_id_Sala`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `socio`
--

CREATE TABLE IF NOT EXISTS `socio` (
  `id_Soc` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `documento_soc` char(11) COLLATE utf8_spanish_ci NOT NULL,
  `tipoDocumento_soc` tinyint(4) NOT NULL DEFAULT '0' COMMENT '0: DNI\\n1: Carnet de extranjeria',
  `apellidoPaterno_Soc` varchar(35) COLLATE utf8_spanish_ci NOT NULL,
  `apellidoMaterno_Soc` varchar(35) COLLATE utf8_spanish_ci NOT NULL,
  `nombres_Soc` varchar(35) COLLATE utf8_spanish_ci NOT NULL,
  `sexo_Soc` tinyint(1) NOT NULL COMMENT '0: Masculino\\n1: Femenino',
  `fechaNacimiento_Soc` date NOT NULL,
  `estadoCivil_Soc` tinyint(4) NOT NULL DEFAULT '0' COMMENT '0: Soltero\\n1: Casado\\n2: Viudo\\n3: Divorciado',
  `direccion_Soc` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  `Distrito_id_Dis` tinyint(3) unsigned DEFAULT NULL,
  `email_Soc` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  `fechaVisita_Soc` date DEFAULT NULL,
  `fechaRegistro_Soc` date DEFAULT NULL,
  `fechaInvitacion_Soc` date DEFAULT NULL,
  `estado_Soc` tinyint(4) NOT NULL DEFAULT '0' COMMENT '0:SOCIO\\n1: INVITADO\\n2: VISITA\\n3: RECUPERACION\\n4: BECADO',
  `Socio_Referido` smallint(5) unsigned DEFAULT NULL,
  `empresa_id_emp` tinyint(3) unsigned DEFAULT NULL,
  `Personal_id_Per` smallint(5) unsigned NOT NULL,
  PRIMARY KEY (`id_Soc`),
  KEY `fk_Socio_Socio1_idx` (`Socio_Referido`),
  KEY `fk_Socio_empresa1_idx` (`empresa_id_emp`),
  KEY `fk_Socio_Personal1_idx` (`Personal_id_Per`),
  KEY `fk_Socio_Distrito1_idx` (`Distrito_id_Dis`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci AUTO_INCREMENT=89 ;

--
-- Volcado de datos para la tabla `socio`
--

INSERT INTO `socio` (`id_Soc`, `documento_soc`, `tipoDocumento_soc`, `apellidoPaterno_Soc`, `apellidoMaterno_Soc`, `nombres_Soc`, `sexo_Soc`, `fechaNacimiento_Soc`, `estadoCivil_Soc`, `direccion_Soc`, `Distrito_id_Dis`, `email_Soc`, `fechaVisita_Soc`, `fechaRegistro_Soc`, `fechaInvitacion_Soc`, `estado_Soc`, `Socio_Referido`, `empresa_id_emp`, `Personal_id_Per`) VALUES
(1, '45657896', 1, 'ñañez', 'renteria', 'claudia', 2, '1988-07-17', 0, 'Pedro Ruiz 110', 1, 'claudia17@outlook.com', NULL, '2013-11-06', NULL, 0, NULL, NULL, 1),
(2, '45733856', 1, 'santamaría', 'urrutia', 'erik', 1, '1989-05-04', 0, 'calle 123', 1, 'e_urrutia@outlook.com', NULL, '2013-11-06', NULL, 0, NULL, NULL, 1),
(3, '00000001', 1, 'Paredes', 'Alegre', 'Juan Francisco', 1, '1985-10-07', 0, 'Calle Struss #660', 1, 'juan_paredes86@hotmail.com', NULL, '2013-11-06', NULL, 0, NULL, NULL, 2),
(4, '00000002', 1, 'padilla', 'zarango', 'luis fernando', 1, '1991-05-05', 0, 'carretera pimentel km 08', 1, 'fernandopadilla_1@hotmail.com', NULL, '2013-11-06', NULL, 0, NULL, NULL, 2),
(5, '00000003', 1, 'fernandez', 'cruzado', 'angela blanca', 2, '1990-02-16', 0, 'pasaje anca 130', 1, '', NULL, '2013-11-06', NULL, 0, NULL, NULL, 2),
(6, '00000004', 1, 'muñoz', 'bendezu', 'sando', 1, '1975-05-19', 0, 'calle elias aguirre 1156', 1, '', NULL, '2013-11-06', NULL, 0, NULL, NULL, 2),
(7, '00000005', 1, 'gonzales', 'villarreal', 'miryan', 2, '1967-05-20', 1, 'paul harris 1173', 1, '', NULL, '2013-11-06', NULL, 0, NULL, NULL, 2),
(8, '00000006', 1, 'gonzales', 'villarreal', 'jenhy', 2, '1969-10-07', 1, 'paul harris 1173', 1, '', NULL, '2013-11-06', NULL, 0, NULL, NULL, 2),
(9, '00000007', 1, 'gonzales', 'villarreal', 'maria elizabeth', 2, '1962-10-07', 1, 'paul harris 1173', 1, '', NULL, '2013-11-06', NULL, 0, NULL, NULL, 2),
(10, '00000008', 1, 'sayan', 'odar', 'sofia', 2, '1979-03-24', 0, 'alfonso ugarte 093 dpt 401 ', 1, '', NULL, '2013-11-06', NULL, 0, NULL, NULL, 2),
(11, '00000010', 1, 'diaz', 'cueva', 'jhon jairo', 1, '1990-05-01', 0, 'precursores 170', 1, '', NULL, '2013-11-07', NULL, 0, NULL, NULL, 2),
(12, '00000009', 1, 'diaz', 'cueva', 'jorge', 1, '1995-05-12', 0, 'calle arizola 001', 1, '', NULL, '2013-11-07', NULL, 0, NULL, NULL, 2),
(13, '00000011', 1, 'velazco ', 'oviedo', 'carol', 2, '1988-01-05', 0, 'urb. el amauta maz b. lt 17', 1, '', NULL, '2013-11-07', NULL, 0, NULL, NULL, 2),
(14, '00000012', 1, 'silva', 'lizana', 'gustavo', 1, '1995-07-20', 0, 'pedro ruiz 401m', 1, '', NULL, '2013-11-07', NULL, 0, NULL, NULL, 2),
(15, '00000013', 1, 'castro ', 'mejia', 'carolyn fabiola', 2, '1989-06-23', 0, 'teatro 153 urb las brisas', 1, '', NULL, '2013-11-07', NULL, 0, NULL, NULL, 2),
(16, '00000014', 1, 'burga ', 'guzman', 'maria claudia', 2, '1995-02-08', 0, 'juan cuglievan 1219 interior 6', 1, '', NULL, '2013-11-07', NULL, 0, NULL, NULL, 2),
(17, '00000015', 1, 'santacruz', 'godos', 'ana lucia', 2, '1995-05-20', 0, '24 de julio 286', 1, '', NULL, '2013-11-07', NULL, 0, NULL, NULL, 2),
(18, '00000016', 1, 'tapia', 'vargas', 'mary cristhie', 2, '1989-05-29', 0, 'urb los cedros de la pradera lt 23 mz a', 1, '', NULL, '2013-11-07', NULL, 0, NULL, NULL, 2),
(19, '00000017', 1, 'lindo ', 'rangel', 'yessenia', 2, '1996-07-17', 0, 'mz c lt 14 espiga de oro las brisas', 1, '', NULL, '2013-11-07', NULL, 0, NULL, NULL, 2),
(20, '00000018', 1, 'rojas', 'alvis', 'erlita', 2, '1973-12-10', 0, 'nicolas de ayllon 724', 1, '', NULL, '2013-11-07', NULL, 0, NULL, NULL, 2),
(21, '00000019', 1, 'grandez', 'arce', 'glori', 2, '1950-05-20', 1, 'residencial magisterial mz u3 lt 7', 1, '', NULL, '2013-11-07', NULL, 0, NULL, NULL, 2),
(22, '00000020', 1, 'cassinelli', 'montero', 'stephanie', 2, '1990-01-15', 0, 'los cartuchos 130 fco. villarreal', 1, '', NULL, '2013-11-07', NULL, 0, NULL, NULL, 2),
(23, '00000021', 1, 'de los santos', 'guerrero', 'karina carolina ', 2, '1985-07-20', 0, 'quinta maria km 765 carretera reque', 1, 'karinadls20@hotmail.com', NULL, '2013-11-11', NULL, 0, NULL, NULL, 2),
(24, '00000022', 1, 'merino', 'varias', 'paul renato', 1, '1991-06-17', 0, 'res. pascual saco 7c3', 1, 'merino4c@hotmail.com', NULL, '2013-11-11', NULL, 0, NULL, NULL, 2),
(25, '00000023', 1, 'elera', 'vela', 'luis tomas', 1, '1965-01-14', 1, 'los gladiolos 338 urb los parques', 1, 'luiseleravela@hotmail.com', NULL, '2013-11-11', NULL, 0, NULL, NULL, 2),
(26, '00000024', 1, 'hurtado', 'cerna', 'jannina miluska', 2, '1979-11-23', 0, 'res.jockey block j 203', 1, 'milushkah_cerna@hotmail.com', NULL, '2013-11-11', NULL, 0, NULL, NULL, 2),
(27, '00000025', 1, 'ballena', 'bances ', 'rosa', 2, '1990-10-08', 0, 'luis gonzales 1381', 1, 'diana_bsc@hotmail.com', NULL, '2013-11-11', NULL, 0, NULL, NULL, 2),
(28, '00000026', 1, 'rojas', 'rojas', 'janinne del carmen ', 2, '1982-12-05', 0, 'call.daniel a.carrion 331 lambayeque', 1, 'janin_182@hotmail.com', NULL, '2013-11-11', NULL, 0, NULL, NULL, 2),
(29, '00000027', 1, 'cruzado', 'rodas', 'maria esther ', 2, '1985-09-25', 0, 'calle orfebres 353 la victoria', 1, '', NULL, '2013-11-12', NULL, 0, NULL, NULL, 2),
(30, '00000028', 1, 'cruz', 'cordova', 'monica', 2, '1983-05-25', 0, 'urb. las palmas mz b lt 18', 1, '', NULL, '2013-11-12', NULL, 0, NULL, NULL, 2),
(31, '00000029', 1, 'aguilar', 'wan', 'kiara', 2, '1990-09-09', 0, 'educacion 139 urb. san luis', 1, '', NULL, '2013-11-12', NULL, 0, NULL, NULL, 2),
(32, '00000030', 1, 'montenegro', 'galvez', 'mariela haydee', 2, '1994-12-16', 0, 'urb. san luis calle los alumnos 171', 1, 'marigalvez.16@gmail.com', NULL, '2013-11-12', NULL, 0, NULL, NULL, 2),
(33, '00000031', 1, 'guerrero', 'barsallo', 'cristian belisario', 1, '1980-07-16', 0, 'loreto 287 urb. los parques', 1, '', NULL, '2013-11-12', NULL, 0, NULL, NULL, 2),
(34, '00000032', 1, 'huatay', 'calle', 'leyla', 2, '1994-07-24', 0, 'urb. santa angela mz e lt 18', 1, 'leyliz@hotmail.com', NULL, '2013-11-12', NULL, 0, NULL, NULL, 2),
(35, '00000033', 1, 'seminario ', 'vega', 'oswaldo', 1, '1979-12-09', 0, 'calle las magnolias 525 urb. los parques', 1, 'oswaldo_s79@hotmail.com', NULL, '2013-11-12', NULL, 0, NULL, NULL, 2),
(36, '00000034', 1, 'quispe', 'salazar', 'giselle briseth', 2, '1996-05-06', 0, 'manuel maria izaga 918', 1, 'fi_11_mayo@hotmail.com', NULL, '2013-11-12', NULL, 0, NULL, NULL, 2),
(37, '00000035', 1, 'guerrero ', 'ñopo', 'lorenzo elias', 1, '1976-11-24', 0, 'calle mariscal castilla 300', 1, 'lorenzog2001@hotmail.com', NULL, '2013-11-12', NULL, 0, NULL, NULL, 2),
(38, '00000036', 1, 'farias', 'seminario', 'marisol del pilar', 2, '1995-05-17', 0, 'florencio 129 primavera 4ta etapa', 1, 'marisolseminario8@hotmail.com', NULL, '2013-11-13', NULL, 0, NULL, NULL, 2),
(39, '00000037', 1, 'seminario', 'chamay', 'yuliana violeta ', 2, '1984-06-03', 0, 'av. las americas 289', 1, '', NULL, '2013-11-13', NULL, 0, NULL, NULL, 2),
(40, '00000038', 1, 'atoche', 'perez', 'mirian fabiana', 2, '1994-01-02', 0, 'mz x lt 01 las delicias', 1, 'fabianacamila.28@hotmail.com', NULL, '2013-11-13', NULL, 0, NULL, NULL, 2),
(41, '00000039', 1, 'olivos', 'lozada', 'darwin', 1, '1994-01-02', 0, 'calle san juan 220', 1, '', NULL, '2013-11-13', NULL, 0, NULL, NULL, 2),
(42, '00000040', 1, 'villalobos', 'peralta', 'karla', 2, '1995-07-21', 0, 'saenz pena 1590', 1, 'kasofiavp@hotmail.com', NULL, '2013-11-13', NULL, 0, NULL, NULL, 2),
(43, '00000041', 1, 'valderrama', 'colchado', 'edsson vladimir', 1, '1990-03-07', 0, 'ca. luis la puerta 397 urb remigio silva', 1, 'edson_17_4@hotmail.com', NULL, '2013-11-13', NULL, 0, NULL, NULL, 2),
(44, '00000042', 1, 'saavedra', 'barreto', 'cinthya', 1, '1992-04-14', 0, 'lora y lora 584', 1, '', NULL, '2013-11-13', NULL, 0, NULL, NULL, 2),
(45, '00000043', 1, 'cervera', 'davila', 'marilu', 2, '1967-10-01', 0, 'monterrico mz 1 lt 4', 1, '', NULL, '2013-11-15', NULL, 0, NULL, NULL, 2),
(46, '00000044', 1, 'yampufe', 'salazar', 'mariana', 2, '1985-05-14', 0, 'libertad 200 pto. eten', 1, 'mariam14135@hotmail.com', NULL, '2013-11-15', NULL, 0, NULL, NULL, 2),
(47, '00000045', 1, 'vilchez', 'zamora', 'hugo', 1, '1961-10-23', 1, 'lora y cordero 877-1', 1, '', NULL, '2013-11-15', NULL, 0, NULL, NULL, 2),
(48, '00000046', 1, 'coronel', 'mendoza', 'milagritos elizabeth', 2, '1978-10-18', 0, 'sinai mz j lt 07 urb miraflores II etapa', 1, 'miyel30@hotmail.com', NULL, '2013-11-15', NULL, 0, NULL, NULL, 2),
(49, '00000047', 1, 'rojas ', 'rojas', 'elva rosa', 2, '1990-03-08', 0, 'calle daniel a. carrion 331 lambayeque', 1, 'elva-rojas1@hotmail.com', NULL, '2013-11-15', NULL, 0, NULL, NULL, 2),
(50, '00000048', 1, 'davila', 'barturen', 'cristian', 1, '1993-07-21', 0, 'espiga de oro mz.c lt 09 las brisas', 1, 'c.davila@grupomurwil.com', NULL, '2013-11-15', NULL, 0, NULL, NULL, 2),
(51, '45126687', 1, 'barrueto ', 'guerrero', 'mario alonso', 1, '1988-05-06', 0, 'residencial bolognesi', 1, 'mario.1608@hotmail.com', NULL, '2013-11-15', NULL, 0, NULL, NULL, 2),
(52, '00000049', 1, 'mechan ', 'arroyo', 'isis del pilar', 2, '1983-08-31', 0, 'calle incanato 526 j.l.o', 1, 'isisdelpilar_83@hotmail.com', NULL, '2013-11-15', NULL, 0, NULL, NULL, 2),
(53, '00000050', 1, 'flores', 'capuñay', 'ana', 2, '1988-01-23', 0, 'av grau 401', 1, '', NULL, '2013-11-15', NULL, 0, NULL, NULL, 2),
(54, '45963946', 1, 'velasquez', 'angeles', 'cinthya', 2, '1989-10-12', 0, 'las margaritas 320 sta. victoria', 1, 'cinthy96@hotmail.com', NULL, '2013-11-15', NULL, 0, NULL, NULL, 2),
(55, '00000051', 1, 'portilla', 'muñoz', 'jorge', 1, '1979-05-15', 0, 'av. salaverry sn erfap dpto 41-42', 1, 'coco_portilla74@hotmail.com', NULL, '2013-11-15', NULL, 0, NULL, NULL, 2),
(56, '00000052', 1, 'suyon', 'galvez', 'carina jesus', 2, '1984-05-02', 0, 'colombia 1101 j.l.o', 1, 'carina183@hotmail.com', NULL, '2013-11-15', NULL, 0, NULL, NULL, 2),
(57, '00000053', 1, 'gayoso', 'cubas', 'cynthia jeanette', 2, '1985-01-06', 0, 'saturno 157 santa elena', 1, 'cynthitagayoso@hotmail.com', NULL, '2013-11-15', NULL, 0, NULL, NULL, 2),
(58, '00000054', 1, 'acosta', 'farfan', 'yessica liliana', 2, '1979-10-24', 1, 'loreto 287', 1, '', NULL, '2013-11-18', NULL, 0, NULL, NULL, 2),
(59, '47101541', 1, 'sanchez', 'murga', 'frank', 1, '1992-06-20', 0, 'los incas 879', 1, 'frank_murga@hotmail.com', NULL, '2013-11-18', NULL, 0, NULL, NULL, 2),
(60, '16793700', 1, 'culqui', 'carrasco', 'juanita', 2, '1977-11-26', 1, 'mz a lt 19 urb. santa angela', 1, 'jjcielo@hotmail.com', NULL, '2013-11-18', NULL, 0, NULL, NULL, 2),
(61, '16449937', 1, 'unyen', 'linares', 'beatriz', 2, '1961-04-07', 1, 'los rosales 480 sta. victoria', 1, 'vattymar@hotmail.com', NULL, '2013-11-18', NULL, 0, NULL, NULL, 2),
(62, '00000055', 1, 'lopez', 'ayasta', 'jessica', 2, '1990-02-05', 0, 'los naranjos 299 urb. caja de deposito', 1, 'je_katherin52@hotmail.com', NULL, '2013-11-20', NULL, 0, NULL, NULL, 2),
(63, '40034174', 1, 'BAZAN', 'CHERO', 'MILAGROS DEL PILAR', 2, '1978-10-15', 1, 'MZ. N LT. 01 URB. LAS PALMAS', 1, 'nayosmi@hotmail.com', NULL, '2013-11-21', NULL, 0, NULL, NULL, 2),
(64, '00000056', 1, 'TAFUR', 'SANCHEZ', 'JESSICA MASSIEL', 2, '1979-03-19', 0, 'AV. SAN MARTIN  S.N POMALCA', 1, '', NULL, '2013-11-21', NULL, 0, NULL, NULL, 2),
(65, '00000057', 1, 'ORTEGA', 'CARRANZA', 'ROSA MARIA', 2, '1987-06-27', 0, 'PEDRO RUIZ 1360 SAN JUAN', 1, 'rosma_oc@hotmail.com', NULL, '2013-11-21', NULL, 0, NULL, NULL, 2),
(66, '00000058', 1, 'BELLIDO', 'CABRERA', 'HENRY', 1, '1988-08-31', 0, 'AV. BELAUNDE TERRY 676 URB. LA PRIMAVERA', 1, 'henry-bc88@hotmail.com', NULL, '2013-11-21', NULL, 0, NULL, NULL, 2),
(67, '00000059', 1, 'MORENO', 'RUIZ', 'MARIA YSABEL', 2, '1973-08-09', 0, 'URB. MONTERICO MZ B LT 6', 1, 'marimo73@gmail.com', NULL, '2013-11-21', NULL, 0, NULL, NULL, 2),
(68, '16699710', 1, 'CARRANZA', 'MECHAN', 'SONIA', 2, '1974-01-12', 0, 'AV. ESPANA 840 J.L.O', 1, 'socame12@hotmail.com', NULL, '2013-11-21', NULL, 0, NULL, NULL, 2),
(69, '00000060', 1, 'NAVARRO', 'BURGOS', 'MARIALENY DE JESUS', 2, '1984-04-14', 0, '8 DE OCTUBRE 216 INT 02 LAMBAYEQUE', 1, '', NULL, '2013-11-22', NULL, 0, NULL, NULL, 2),
(70, '46856068', 1, 'RODAS', 'APAZA', 'CECILIA', 2, '1985-11-03', 0, 'CALLE SAN PEDRO 260', 1, 'ceci_650@hotmail.com', NULL, '2013-11-22', NULL, 0, NULL, NULL, 2),
(71, '00000061', 1, 'FENCO', 'CHUMAN', 'SHEILLA LIDIA', 2, '1981-08-18', 0, 'AV. SANTOS DUMONT 327 P.J. MURO', 1, 'aquisheillali@hotmail.com', NULL, '2013-11-23', NULL, 0, NULL, NULL, 2),
(72, '00000062', 1, 'SILVA', 'CAMACACHE', 'SARA', 2, '1989-09-16', 0, 'BLOCK 11 Nro.1113 TUMAN', 1, 'sara_gapsu@hotmail.com', NULL, '2013-11-23', NULL, 0, NULL, NULL, 2),
(73, '00000063', 1, 'SVERKO', 'CASTRO', 'VADJAN MILENKO', 1, '1973-09-29', 0, 'C. CONDOR CUNCA 154 URB. LOS LIBERTADORES', 1, 'milenkosverko@msn.com', NULL, '2013-11-23', NULL, 0, NULL, NULL, 2),
(74, '00000064', 1, 'DIEZ', 'CERDAN', 'LUCIA', 2, '1986-05-17', 0, 'SAN ANTONIO MZ K LT 12 POMALCA', 1, 'natuska_5_5@hotmail.com', NULL, '2013-11-23', NULL, 0, NULL, NULL, 2),
(75, '00000065', 1, 'MONCHON', 'JULCA', 'JANNINA ARACELI', 2, '1987-04-09', 0, 'CALLE LIMA 87 POMALCA', 1, 'nina9487@hotmail.com', NULL, '2013-11-23', NULL, 0, NULL, NULL, 2),
(76, '16689027', 1, 'ALFARO', 'LA TORRE', 'SILVIA', 2, '1971-05-01', 0, 'LOS CLAVELES 120 STA. VICTORIA', 1, '', NULL, '2013-11-23', NULL, 0, NULL, NULL, 2),
(77, '00000066', 1, 'AGUINAGA', 'MERINO', 'HEBERT', 1, '1980-06-27', 0, 'AV. CAJAMARCA 284 JOSE OLAYA', 1, 'madh27@hotmail.com', NULL, '2013-11-23', NULL, 0, NULL, NULL, 2),
(78, '00000067', 1, 'TORRES', 'SAAVEDRA', 'GRACE', 2, '1988-06-20', 0, 'SAN SALVADOR 196 LUJAN', 1, 'gravir_xx@hotmail.com', NULL, '2013-11-23', NULL, 0, NULL, NULL, 2),
(79, '00000068', 1, 'CELIS', 'BARDALES', 'ROLDAN', 1, '1972-10-25', 0, 'MZ A LT 8 SAN BARTOLO', 1, 'roldancelis@hotmail.com', NULL, '2013-11-23', NULL, 0, NULL, NULL, 2),
(80, '00000069', 1, 'ANGELES', 'LIZA', 'HERLINDA', 2, '1965-06-15', 0, 'LAS MARGARITAS 320 STA. VICTORIA', 1, '', NULL, '2013-11-23', NULL, 0, NULL, NULL, 2),
(81, '00000070', 1, 'VELASQUEZ', 'ANGELES', 'LINDA', 2, '1997-04-10', 0, 'LAS MARGARITAS 320 STA. VICTORIA', 1, 'jelinne104@hoymsil.com', NULL, '2013-11-23', NULL, 0, NULL, NULL, 2),
(82, '16792232', 1, 'CUBAS', 'CHAVARRY', 'KETTY ELIZABETH', 2, '1977-10-29', 0, 'MANCO CAPAC 653 SAN JUAN', 1, 'kettycubas@hotmail.com', NULL, '2013-11-23', NULL, 0, NULL, NULL, 2),
(83, '00000071', 1, 'BERNABE', 'BARRETO', 'MARIE ANTOVANNET', 2, '1999-06-16', 0, 'ANDALUCIA 137 URB SAN JUAN', 1, 'mabb1999@hotmail.com', NULL, '2013-11-23', NULL, 0, NULL, NULL, 2),
(84, '00000072', 1, 'BERNABE', 'CARRILLO', 'ANA PATRICIA', 2, '1970-11-01', 0, 'DOMINGO ELIAS 410 URB. REMIGIO SILVA', 1, '', NULL, '2013-11-23', NULL, 0, NULL, NULL, 2),
(85, '00000073', 1, 'DIAZ', 'PEREYRA', 'FELICIDAD', 2, '1986-12-17', 0, 'AV.ANGAMOS 140 DPTO.302', 1, 'felicidad_1786@live.com', NULL, '2013-11-23', NULL, 0, NULL, NULL, 2),
(86, '00000074', 1, 'RODRIGUEZ', 'VERA', 'CAROL ', 2, '1994-08-05', 0, 'URB. LA FLORIDA MZ L LT 18', 1, 'yessenia_05@hotmail.com', NULL, '2013-11-23', NULL, 0, NULL, NULL, 2),
(87, '46690199', 1, 'ORLANDINI', 'SUAREZ', 'NASH', 2, '1990-09-18', 0, 'AV. NACIONALISMO 669 URB LAS BRISAS', 1, 'orlandinisua@hotmail.com', NULL, '2013-11-23', NULL, 0, NULL, NULL, 2),
(88, '45217893', 1, 'renteria', 'ñañez', 'claudia', 2, '1988-07-17', 0, 'Pedro Ruiz 110', 1, 'claudia17@outlook.com', NULL, '2013-11-06', NULL, 0, NULL, NULL, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sucursal`
--

CREATE TABLE IF NOT EXISTS `sucursal` (
  `id_Suc` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `nombre_Suc` varchar(40) COLLATE utf8_spanish_ci NOT NULL COMMENT 'Se mostrara en todos los formularios',
  `direccion_Suc` varchar(45) COLLATE utf8_spanish_ci NOT NULL COMMENT 'direccion de sucursal',
  `telefono_Suc` char(9) COLLATE utf8_spanish_ci DEFAULT NULL COMMENT 'telefono Fijo de sucursal',
  `linea_Suc` tinyint(4) DEFAULT NULL COMMENT '0: Fitness House\\n1: Go Fit',
  `estado_Suc` tinyint(1) NOT NULL DEFAULT '1' COMMENT '0:Inactivo\\n1:Activo',
  PRIMARY KEY (`id_Suc`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci COMMENT='Locales ' AUTO_INCREMENT=7 ;

--
-- Volcado de datos para la tabla `sucursal`
--

INSERT INTO `sucursal` (`id_Suc`, `nombre_Suc`, `direccion_Suc`, `telefono_Suc`, `linea_Suc`, `estado_Suc`) VALUES
(1, 'Villarreal', 'Av. Libertad # 855 - Urb. Federico Villarreal', '270226', 0, 1),
(2, 'Torres Paz', 'Calle Torres Paz # 175', '231854', 0, 1),
(3, 'Piura', 'calle lima#450 centro', '223355', 1, 0),
(4, 'Sullana', 'calle bolivar #260 2° piso- centro', '508980', 0, 1),
(5, 'Bolivar', 'Av. Salaverry #1714 Urb. 03 de Octubre', '455689', 0, 0),
(6, 'Satelite', 'Calle ABC 123', '225566', 0, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sucursalservicio`
--

CREATE TABLE IF NOT EXISTS `sucursalservicio` (
  `Sucursal_id_Suc` tinyint(3) unsigned NOT NULL,
  `Servicio_id_Serv` smallint(5) unsigned NOT NULL,
  PRIMARY KEY (`Sucursal_id_Suc`,`Servicio_id_Serv`),
  KEY `fk_SucursalServicio_Servicio1_idx` (`Servicio_id_Serv`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `sucursalservicio`
--

INSERT INTO `sucursalservicio` (`Sucursal_id_Suc`, `Servicio_id_Serv`) VALUES
(1, 1),
(2, 1),
(3, 1),
(4, 1),
(5, 1),
(6, 1),
(1, 2),
(2, 2),
(3, 2),
(4, 2),
(5, 2),
(6, 2),
(1, 3),
(2, 3),
(3, 3),
(4, 3),
(5, 3),
(6, 3),
(1, 4),
(2, 4),
(3, 4),
(4, 4),
(5, 4),
(6, 4),
(1, 5),
(2, 5),
(3, 5),
(4, 5),
(5, 5),
(6, 5),
(1, 6),
(2, 6),
(3, 6),
(4, 6),
(5, 6),
(6, 6),
(6, 7),
(1, 9),
(2, 9),
(3, 9),
(4, 9),
(5, 9),
(6, 9);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `telefono`
--

CREATE TABLE IF NOT EXISTS `telefono` (
  `id_Tel` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `numero_Tel` char(10) COLLATE utf8_spanish_ci NOT NULL,
  `tipo_tel` varchar(45) COLLATE utf8_spanish_ci NOT NULL DEFAULT '0' COMMENT '0: Fijo Casa\\n1: Fijo Trabajo\\n2: Movistar1\\n3: Claro\\n4: Nextel\\n5: RPM\\n6: RPC\\n7: Radio-Nextel\\n',
  `emergencia_Tel` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '0: No\\n1: Si',
  `nombreEmergencia_Tel` varchar(35) COLLATE utf8_spanish_ci DEFAULT NULL,
  `parentesco_Tel` varchar(15) COLLATE utf8_spanish_ci DEFAULT NULL,
  `Socio_id_Soc` smallint(5) unsigned NOT NULL,
  PRIMARY KEY (`id_Tel`),
  KEY `fk_Telefono_Socio1_idx` (`Socio_id_Soc`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci AUTO_INCREMENT=174 ;

--
-- Volcado de datos para la tabla `telefono`
--

INSERT INTO `telefono` (`id_Tel`, `numero_Tel`, `tipo_tel`, `emergencia_Tel`, `nombreEmergencia_Tel`, `parentesco_Tel`, `Socio_id_Soc`) VALUES
(1, '228099', '0', 0, '', '', 1),
(2, '958903956', '2', 0, '', '', 2),
(3, '979354449', '2', 0, '', '', 3),
(4, '979799531', '2', 1, 'Cecilia Julca Silva', 'Enamorada', 3),
(5, '948532340', '2', 0, '', '', 4),
(6, '950454220', '2', 1, 'maria luisa', 'mama', 4),
(7, '984791094', '2', 0, '', '', 5),
(8, '978080125', '2', 1, 'rubi del sol tello arroyo', 'amiga', 5),
(9, '990595612', '2', 0, '', '', 6),
(10, '215775', '0', 0, '', '', 7),
(11, '978980202', '2', 0, '', '', 7),
(12, '215326', '0', 0, '', '', 8),
(13, '978959815', '2', 0, '', '', 8),
(14, '979341176', '2', 0, '', '', 9),
(15, '215326', '0', 1, 'miryan gonzales villarreal', 'hermana', 9),
(16, '502044', '0', 0, '', '', 10),
(17, '949049348', '2', 0, '', '', 10),
(18, '969015169', '2', 0, '', '', 11),
(19, '', '0', 0, '', '', 12),
(20, '952017705', '2', 0, '', '', 12),
(21, '327830', '1', 0, '', '', 13),
(22, '994467409', '2', 0, '', '', 13),
(23, '994467336', '2', 1, 'maria oviedo ordoñez', 'madre', 13),
(24, '964639195', '2', 0, '', '', 14),
(25, '', '0', 0, '', '', 15),
(26, '942444149', '2', 0, '', '', 15),
(27, '211437', '2', 1, 'wilber castro', 'papa', 15),
(28, '435003', '0', 0, '', '', 16),
(29, '978745140', '2', 0, '', '', 16),
(30, '979783038', '2', 1, 'victor burga medina', 'padre', 16),
(31, '978425557', '2', 0, '', '', 17),
(32, '988989441', '2', 1, 'olga', 'mama', 17),
(33, '959590103', '2', 0, '', '', 18),
(34, '976941495', '2', 1, 'amalia vargas', 'mama', 18),
(35, '952619241', '2', 0, '', '', 19),
(36, '507502', '0', 0, '', '', 20),
(37, '981823019', '2', 0, '', '', 20),
(38, '265095', '0', 0, '', '', 21),
(39, '975237608', '2', 0, '', '', 21),
(40, '274433', '0', 0, '', '', 22),
(41, '985258535', '2', 0, '', '', 22),
(42, '979948376', '2', 1, 'rosa', 'mama', 22),
(43, '957641793', '2', 0, '', '', 23),
(44, '979226950', '2', 1, 'amanda varias', 'mama', 24),
(45, '224592', '0', 0, '', '', 25),
(46, '979608560', '2', 0, '', '', 25),
(47, '979183587', '2', 0, '', '', 26),
(48, '481210', '0', 1, 'soledad', 'prima', 26),
(49, '995413456', '2', 0, '', '', 27),
(50, '971242519', '2', 0, '', '', 28),
(51, '971226180', '2', 1, 'teofilo', 'padre', 28),
(52, '947898724', '2', 0, '', '', 29),
(53, '975748568', '2', 1, 'cesar cruzado', 'padre', 29),
(54, '961580255', '2', 0, '', '', 30),
(55, '976941334', '2', 1, 'genebroddo cruz', 'padre', 30),
(56, '224240', '0', 0, '', '', 31),
(57, '', '0', 0, '', '', 32),
(58, '943052221', '2', 0, '', '', 32),
(59, '229281', '0', 1, 'nieves galvez quispe', 'tia', 32),
(60, '969895598', '2', 0, '', '', 33),
(61, '220104', '0', 0, '', '', 34),
(62, '979997412', '2', 0, '', '', 35),
(63, '969421191', '2', 1, 'oswaldo seminario', 'padre', 35),
(64, '206037', '0', 0, '', '', 36),
(65, '978900042', '2', 0, '', '', 36),
(66, '979865703', '2', 1, 'ladis salazar', 'madre', 36),
(67, '979641608', '2', 0, '', '', 37),
(68, '226967', '0', 1, 'nancy guerrero', 'hermana', 37),
(69, '978935054', '2', 0, '', '', 38),
(70, '492956', '0', 0, '', '', 39),
(71, '492956', '0', 0, '', '', 39),
(72, '956840256', '2', 0, '', '', 39),
(73, '956545330', '2', 1, 'rodolfo seminario', 'padre', 39),
(74, '451369', '0', 0, '', '', 40),
(75, '994866858', '2', 0, '', '', 40),
(76, '942603485', '2', 1, 'marina perez', 'mama', 40),
(77, '965945880', '2', 0, '', '', 41),
(78, '233660', '0', 0, '', '', 42),
(79, '979660536', '2', 0, '', '', 42),
(80, '200172', '0', 0, '', '', 43),
(81, '941994089', '2', 0, '', '', 43),
(82, '957924887', '2', 1, 'carmen colchado', 'mama', 43),
(83, '975021950', '2', 0, '', '', 44),
(84, '615090', '0', 0, '', '', 45),
(85, '978135918', '2', 0, '', '', 45),
(86, '414286', '0', 0, '', '', 46),
(87, '229152', '0', 0, '', '', 47),
(88, '979202802', '2', 1, 'meche koo', 'esposa', 47),
(89, '266760', '0', 0, '', '', 48),
(90, '951520237', '2', 0, '', '', 48),
(91, '', '0', 0, '', '', 49),
(92, '971241495', '2', 0, '', '', 49),
(93, '971242519', '2', 1, 'janinne rojas rojas', 'hermana', 49),
(94, '', '0', 0, '', '', 50),
(95, '945689343', '2', 0, '', '', 50),
(96, '942121377', '2', 1, 'susana barturen', 'madre', 50),
(97, '237824', '0', 0, '', '', 51),
(98, '979770297', '2', 0, '', '', 51),
(99, '253477', '0', 0, '', '', 52),
(100, '975679382', '2', 0, '', '', 52),
(101, '995107539', '2', 1, 'maria arroyo chero', 'madre', 52),
(102, '979554052', '2', 0, '', '', 53),
(103, '995732068', '2', 0, '', '', 55),
(104, '949080310', '2', 0, '', '', 56),
(105, '258412', '0', 1, 'manzu galvez alcantara ', 'hermana', 56),
(106, '208353', '0', 0, '', '', 57),
(107, '978141716', '2', 0, '', '', 57),
(108, '981690124', '2', 1, 'margarita cubas', 'madre', 57),
(109, '*211584', '5', 0, '', '', 58),
(110, '969895598', '5', 1, 'cristian', 'esposo', 58),
(111, '991976284', '2', 0, '', '', 59),
(112, '493116', '0', 0, '', '', 59),
(113, '315250', '0', 0, '', '', 60),
(114, '979802015', '2', 0, '', '', 61),
(115, '272045', '0', 0, '', '', 62),
(116, '961603404', '2', 0, '', '', 62),
(117, '9799928279', '2', 0, '', '', 63),
(118, '978883689', '2', 1, 'MARIA CLARA', 'madre', 63),
(119, '416126', '0', 0, '', '', 64),
(120, '978434558', '2', 0, '', '', 64),
(121, '984532031', '5', 0, '', '', 64),
(122, '984530506', '5', 1, 'MAICO CLUPE', 'AMIGO', 64),
(123, '206568', '0', 0, '', '', 65),
(124, '', '0', 0, '', '', 65),
(125, '984118808', '2', 1, 'christians salazar', 'novio', 65),
(126, '272611', '0', 0, '', '', 66),
(127, '992340002', '2', 0, '', '', 66),
(128, '*159979', '2', 0, '', '', 66),
(129, '962386411', '2', 0, '', '', 67),
(130, '294971', '0', 1, 'CLAUDIA RUIZ', 'madre', 67),
(131, '257969', '0', 0, '', '', 68),
(132, '975691259', '2', 0, '', '', 68),
(133, '979426625', '2', 0, '', '', 69),
(134, '949696098', '2', 1, 'REBECA ALZA MORENO', 'AMIGA', 69),
(135, '254152', '0', 0, '', '', 70),
(136, '978049437', '2', 0, '', '', 70),
(137, '205037', '0', 1, 'lidia', 'madre', 71),
(138, '978018303', '2', 0, '', '', 71),
(139, '319674', '0', 0, '', '', 72),
(140, '968747400', '2', 0, '', '', 72),
(141, '979750000', '2', 1, 'ANA MARIA', 'MADRE', 72),
(142, '987573959', '2', 0, '', '', 73),
(143, '979576191', '2', 1, 'GUILLERMO APOLAYA', 'GUILLERMO', 73),
(144, '458699', '0', 1, 'MANUEL MONCHON', 'PADRE', 75),
(145, '979107224', '3', 1, 'MANUEL MONCHON', 'PADRE', 75),
(146, '', '0', 0, '', '', 75),
(147, '979107224', '3', 0, '', '', 75),
(148, '995274031', '2', 0, '', '', 76),
(149, '208729', '0', 0, '', '', 77),
(150, '956436331', '2', 0, '', '', 78),
(151, '978156505', '2', 0, '', '', 79),
(152, '961638411', '2', 1, 'SANDRA', 'ESPOSA', 79),
(153, '275066', '0', 0, '', '', 80),
(154, '275060', '0', 0, '', '', 81),
(155, '989299968', '2', 0, '', '', 81),
(156, '979777406', '2', 1, 'JOSE VELASQUEZ', 'PAPA', 81),
(157, '966827761', '2', 0, '', '', 82),
(158, '227174', '0', 0, '', '', 82),
(159, '956915630', '3', 1, 'MIGUEL ANGEL CUBAS CHAVARRY', 'HERMANO', 82),
(160, '208730', '0', 0, '', '', 83),
(161, '979651744', '2', 0, '', '', 83),
(162, '202869', '0', 1, 'JOSE BERNABE', 'ABUELO', 83),
(163, '202869', '0', 1, 'JOSE BERNABE TORRES', 'PAPA', 84),
(164, '325488', '0', 0, '', '', 85),
(165, '976088484', '2', 0, '', '', 85),
(166, '506678', '0', 0, '', '', 86),
(167, '963540071', '2', 0, '', '', 86),
(168, '95681282', '2', 1, 'ISABEL', 'MAMA', 86),
(169, '954461822', '2', 0, '', '', 87),
(170, '976311509', '2', 1, 'BILLY MONGEZA', 'NOVIO', 87),
(171, '228099', '0', 0, '', '', 88),
(172, '228099', '0', 0, '', '', 1),
(173, '227860', '1', 0, '', '', 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipocondicion`
--

CREATE TABLE IF NOT EXISTS `tipocondicion` (
  `id_TCon` tinyint(3) unsigned NOT NULL,
  `nombre_TCon` varchar(30) COLLATE utf8_spanish_ci NOT NULL,
  PRIMARY KEY (`id_TCon`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci COMMENT='son los grupos de condiciones ( condicion fisica - perimetro';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuariopersonal`
--

CREATE TABLE IF NOT EXISTS `usuariopersonal` (
  `id_UPer` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `alias_UPer` varchar(20) COLLATE utf8_spanish_ci NOT NULL,
  `clave_UPer` char(60) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `estado_UPer` tinyint(1) NOT NULL DEFAULT '1' COMMENT '0: Inactivo\\n1: Activo',
  `Personal_id_Per` smallint(5) unsigned NOT NULL,
  PRIMARY KEY (`id_UPer`),
  KEY `fk_UsuarioPersonal_Personal1_idx` (`Personal_id_Per`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci AUTO_INCREMENT=4 ;

--
-- Volcado de datos para la tabla `usuariopersonal`
--

INSERT INTO `usuariopersonal` (`id_UPer`, `alias_UPer`, `clave_UPer`, `estado_UPer`, `Personal_id_Per`) VALUES
(1, 'eurrutia', '$2y$14$0w5ILcAvvjB7spJIbBNnkecoDhRSK4lvoxfd3tPnxORCbzRuPLMTO', 1, 1),
(3, 'rrentería', '$2y$14$6sVb5hyO.YuyQKO8UR3oWuApgsdIMSg3mQ.dhNLeL8m9yzt7c9Lvy', 1, 4);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuariosocio`
--

CREATE TABLE IF NOT EXISTS `usuariosocio` (
  `id_USoc` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `alias_user` char(15) COLLATE utf8_spanish_ci NOT NULL,
  `clave_user` char(60) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `estado_user` tinyint(1) NOT NULL COMMENT '0: Inactivo\\n1: Activo',
  `Socio_id_Soc` smallint(5) unsigned NOT NULL,
  PRIMARY KEY (`id_USoc`),
  KEY `fk_UsuarioSocio_Socio1_idx` (`Socio_id_Soc`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `zona`
--

CREATE TABLE IF NOT EXISTS `zona` (
  `id_Zona` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `nombre_zona` varchar(45) COLLATE utf8_spanish_ci DEFAULT NULL,
  PRIMARY KEY (`id_Zona`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci AUTO_INCREMENT=1 ;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `asistencia`
--
ALTER TABLE `asistencia`
  ADD CONSTRAINT `fk_Asistencia_HorarioServicio1` FOREIGN KEY (`HorarioServicio_id_HSer`) REFERENCES `horarioservicio` (`id_HSer`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Asistencia_Inscripcion1` FOREIGN KEY (`Inscripcion_id_Ins`) REFERENCES `inscripcion` (`id_Ins`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Asistencia_Personal1` FOREIGN KEY (`Personal_id_Per`) REFERENCES `personal` (`id_Per`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Asistencia_Socio1` FOREIGN KEY (`Socio_id_Soc`) REFERENCES `socio` (`id_Soc`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Asistencia_Sucursal1` FOREIGN KEY (`Sucursal_id_Suc`) REFERENCES `sucursal` (`id_Suc`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `caja`
--
ALTER TABLE `caja`
  ADD CONSTRAINT `fk_Caja_Personal1` FOREIGN KEY (`Personal_id_Per`) REFERENCES `personal` (`id_Per`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Caja_Sucursal1` FOREIGN KEY (`Sucursal_id_Suc`) REFERENCES `sucursal` (`id_Suc`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `cita`
--
ALTER TABLE `cita`
  ADD CONSTRAINT `fk_Cita_Inscripcion1` FOREIGN KEY (`Inscripcion_id_Ins`) REFERENCES `inscripcion` (`id_Ins`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Cita_Personal1` FOREIGN KEY (`Personal_id_Per`) REFERENCES `personal` (`id_Per`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Cita_PersonalAtendio` FOREIGN KEY (`Personal_Atendio`) REFERENCES `personal` (`id_Per`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `comprobante`
--
ALTER TABLE `comprobante`
  ADD CONSTRAINT `fk_Comprobante_Caja1` FOREIGN KEY (`Caja_id_Caja`) REFERENCES `caja` (`id_Caja`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Comprobante_Cuenta1` FOREIGN KEY (`Cuenta_id_Cuenta`) REFERENCES `cuenta` (`id_Cuenta`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Comprobante_Socio1` FOREIGN KEY (`Socio_id_Soc`) REFERENCES `socio` (`id_Soc`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `condicion`
--
ALTER TABLE `condicion`
  ADD CONSTRAINT `fk_Condicion_TipoCondicion1` FOREIGN KEY (`TipoCondicion_id_TCon`) REFERENCES `tipocondicion` (`id_TCon`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `contrato`
--
ALTER TABLE `contrato`
  ADD CONSTRAINT `fk_Contrato_Personal1` FOREIGN KEY (`Personal_id_Per`) REFERENCES `personal` (`id_Per`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `cuota`
--
ALTER TABLE `cuota`
  ADD CONSTRAINT `fk_Cuota_Inscripcion1` FOREIGN KEY (`Inscripcion_id_Ins`) REFERENCES `inscripcion` (`id_Ins`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Cuota_Personal1` FOREIGN KEY (`Personal_id_Per`) REFERENCES `personal` (`id_Per`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Cuota_Socio1` FOREIGN KEY (`Socio_id_Soc`) REFERENCES `socio` (`id_Soc`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `detallecomprobante`
--
ALTER TABLE `detallecomprobante`
  ADD CONSTRAINT `fk_DetalleComprobante_Cuota1` FOREIGN KEY (`Cuota_id_Cuo`) REFERENCES `cuota` (`id_Cuo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_DetalleComprobante_Servicio1` FOREIGN KEY (`Servicio_id_Serv`) REFERENCES `servicio` (`id_Serv`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `detalledieta`
--
ALTER TABLE `detalledieta`
  ADD CONSTRAINT `fk_DetalleDieta_Dieta1` FOREIGN KEY (`Dieta_id_Diet`) REFERENCES `dieta` (`id_Diet`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `detalleejercicio`
--
ALTER TABLE `detalleejercicio`
  ADD CONSTRAINT `fk_DetalleEjercicio_Ejercicio1` FOREIGN KEY (`Ejercicio_id_Ejer`) REFERENCES `ejercicio` (`id_Ejer`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_DetalleEjercicio_Programa1` FOREIGN KEY (`Programa_id_Prog`) REFERENCES `programa` (`id_Prog`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `detalleestiramiento`
--
ALTER TABLE `detalleestiramiento`
  ADD CONSTRAINT `fk_detalleEstiramiento_Ejercicio1` FOREIGN KEY (`Ejercicio_id_Ejer`) REFERENCES `ejercicio` (`id_Ejer`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_detalleEstiramiento_Programa1` FOREIGN KEY (`Programa_id_Prog`) REFERENCES `programa` (`id_Prog`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `detalleevaluacion`
--
ALTER TABLE `detalleevaluacion`
  ADD CONSTRAINT `fk_DetalleEvaluacion_Condicion1` FOREIGN KEY (`Condicion_id_Con`) REFERENCES `condicion` (`id_Con`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_DetalleEvaluacion_Evaluacion1` FOREIGN KEY (`Evaluacion_id_Eva`) REFERENCES `evaluacion` (`id_Eva`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `detallefactor`
--
ALTER TABLE `detallefactor`
  ADD CONSTRAINT `fk_DetalleFactor_Factor1` FOREIGN KEY (`Factor_id_Fac`) REFERENCES `factor` (`id_Fac`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_DetalleFactor_Socio1` FOREIGN KEY (`Socio_id_Soc`) REFERENCES `socio` (`id_Soc`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `detallehorarioservicio`
--
ALTER TABLE `detallehorarioservicio`
  ADD CONSTRAINT `fk_DetalleHorarioServicio_HorarioServicio1` FOREIGN KEY (`HorarioServicio_id_HSer`) REFERENCES `horarioservicio` (`id_HSer`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `detallemeta`
--
ALTER TABLE `detallemeta`
  ADD CONSTRAINT `fk_DetalleMeta_Entrenamiento1` FOREIGN KEY (`Entrenamiento_id_Ent`) REFERENCES `entrenamiento` (`id_Ent`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_DetalleMeta_pregunta1` FOREIGN KEY (`pregunta_id_pre`) REFERENCES `pregunta` (`id_pre`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `detalleobservacion`
--
ALTER TABLE `detalleobservacion`
  ADD CONSTRAINT `fk_DetalleObservacion_opcion1` FOREIGN KEY (`opcion_id_op`) REFERENCES `opcion` (`id_op`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_DetalleObservacion_pregunta1` FOREIGN KEY (`pregunta_id_pre`) REFERENCES `pregunta` (`id_pre`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_DetalleObservacion_Socio1` FOREIGN KEY (`Socio_id_Soc`) REFERENCES `socio` (`id_Soc`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `detallepromocion`
--
ALTER TABLE `detallepromocion`
  ADD CONSTRAINT `fk_DetallePromocion_Servicio1` FOREIGN KEY (`Servicio_id_Serv`) REFERENCES `servicio` (`id_Serv`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `detalleservicio`
--
ALTER TABLE `detalleservicio`
  ADD CONSTRAINT `fk_DetalleServicio_Servicio1` FOREIGN KEY (`Plan_id_Serv`) REFERENCES `servicio` (`id_Serv`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_DetalleServicio_Servicio2` FOREIGN KEY (`Servicio_id_Serv1`) REFERENCES `servicio` (`id_Serv`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `detallezona`
--
ALTER TABLE `detallezona`
  ADD CONSTRAINT `fk_DetalleZona_Programa1` FOREIGN KEY (`Programa_id_Prog`) REFERENCES `programa` (`id_Prog`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_DetalleZona_Zona1` FOREIGN KEY (`Zona_id_Zona`) REFERENCES `zona` (`id_Zona`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `dieta`
--
ALTER TABLE `dieta`
  ADD CONSTRAINT `fk_Dieta_Cita1` FOREIGN KEY (`Cita_id_Cita`) REFERENCES `cita` (`id_Cita`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `distrito`
--
ALTER TABLE `distrito`
  ADD CONSTRAINT `fk_Distrito_Ciudad1` FOREIGN KEY (`Ciudad_id_Ciu`) REFERENCES `ciudad` (`id_Ciu`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `ejercicio`
--
ALTER TABLE `ejercicio`
  ADD CONSTRAINT `fk_Ejercicio_Zona1` FOREIGN KEY (`Zona_id_Zona`) REFERENCES `zona` (`id_Zona`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `entrenamiento`
--
ALTER TABLE `entrenamiento`
  ADD CONSTRAINT `fk_Entrenamiento_Inscripcion1` FOREIGN KEY (`Inscripcion_id_Ins`) REFERENCES `inscripcion` (`id_Ins`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Entrenamiento_Personal1` FOREIGN KEY (`Personal_id_Per`) REFERENCES `personal` (`id_Per`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `evaluacion`
--
ALTER TABLE `evaluacion`
  ADD CONSTRAINT `fk_Evaluacion_Cita1` FOREIGN KEY (`Cita_id_Cita`) REFERENCES `cita` (`id_Cita`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Evaluacion_Ficha1` FOREIGN KEY (`Ficha_id_Fic`) REFERENCES `ficha` (`id_Fic`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `ficha`
--
ALTER TABLE `ficha`
  ADD CONSTRAINT `fk_Ficha_Socio1` FOREIGN KEY (`Socio_id_Soc`) REFERENCES `socio` (`id_Soc`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `freezing`
--
ALTER TABLE `freezing`
  ADD CONSTRAINT `fk_Freezing_Inscripcion1` FOREIGN KEY (`Inscripcion_id_Ins`) REFERENCES `inscripcion` (`id_Ins`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Freezing_Personal1` FOREIGN KEY (`Personal_id_Per`) REFERENCES `personal` (`id_Per`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Freezing_Socio1` FOREIGN KEY (`Socio_id_Soc`) REFERENCES `socio` (`id_Soc`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `horariopersonal`
--
ALTER TABLE `horariopersonal`
  ADD CONSTRAINT `fk_HorarioPersonal_Contrato1` FOREIGN KEY (`Contrato_id_Cont`) REFERENCES `contrato` (`id_Cont`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `inscripcion`
--
ALTER TABLE `inscripcion`
  ADD CONSTRAINT `fk_Inscripcion_Inscripcion1` FOREIGN KEY (`Inscripcion_id_Ins`) REFERENCES `inscripcion` (`id_Ins`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Inscripcion_Personal1` FOREIGN KEY (`Personal_id_Per`) REFERENCES `personal` (`id_Per`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Inscripcion_Servicio1` FOREIGN KEY (`Servicio_id_Serv`) REFERENCES `servicio` (`id_Serv`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Inscripcion_Socio1` FOREIGN KEY (`Socio_id_Soc`) REFERENCES `socio` (`id_Soc`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Inscripcion_Sucursal1` FOREIGN KEY (`Sucursal_id_Suc`) REFERENCES `sucursal` (`id_Suc`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `opcion`
--
ALTER TABLE `opcion`
  ADD CONSTRAINT `fk_opcion_pregunta1` FOREIGN KEY (`pregunta_id_pre`) REFERENCES `pregunta` (`id_pre`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `personal`
--
ALTER TABLE `personal`
  ADD CONSTRAINT `fk_Personal_Sucursal1` FOREIGN KEY (`Sucursal_id_Suc`) REFERENCES `sucursal` (`id_Suc`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `programa`
--
ALTER TABLE `programa`
  ADD CONSTRAINT `fk_Programa_Entrenamiento1` FOREIGN KEY (`Entrenamiento_id_Ent`) REFERENCES `entrenamiento` (`id_Ent`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `respuesta`
--
ALTER TABLE `respuesta`
  ADD CONSTRAINT `fk_Respuesta_opcion1` FOREIGN KEY (`opcion_id_op`) REFERENCES `opcion` (`id_op`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Respuesta_pregunta1` FOREIGN KEY (`pregunta_id_pre`) REFERENCES `pregunta` (`id_pre`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Respuesta_Socio1` FOREIGN KEY (`Socio_id_Soc`) REFERENCES `socio` (`id_Soc`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `sala`
--
ALTER TABLE `sala`
  ADD CONSTRAINT `fk_Sala_Sucursal1` FOREIGN KEY (`Sucursal_id_Suc`) REFERENCES `sucursal` (`id_Suc`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `servicio`
--
ALTER TABLE `servicio`
  ADD CONSTRAINT `fk_Servicio_empresa1` FOREIGN KEY (`empresa_id_emp`) REFERENCES `empresa` (`id_emp`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Servicio_Personal1` FOREIGN KEY (`Personal_id_Per`) REFERENCES `personal` (`id_Per`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Servicio_Servicio1` FOREIGN KEY (`Servicio_id_Serv`) REFERENCES `servicio` (`id_Serv`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `serviciosala`
--
ALTER TABLE `serviciosala`
  ADD CONSTRAINT `fk_ServicioSala_Sala1` FOREIGN KEY (`Sala_id_Sala`) REFERENCES `sala` (`id_Sala`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_ServicioSala_Servicio1` FOREIGN KEY (`Servicio_id_Serv`) REFERENCES `servicio` (`id_Serv`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `socio`
--
ALTER TABLE `socio`
  ADD CONSTRAINT `fk_Socio_Distrito1` FOREIGN KEY (`Distrito_id_Dis`) REFERENCES `distrito` (`id_Dis`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Socio_empresa1` FOREIGN KEY (`empresa_id_emp`) REFERENCES `empresa` (`id_emp`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Socio_Personal1` FOREIGN KEY (`Personal_id_Per`) REFERENCES `personal` (`id_Per`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Socio_Socio1` FOREIGN KEY (`Socio_Referido`) REFERENCES `socio` (`id_Soc`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `sucursalservicio`
--
ALTER TABLE `sucursalservicio`
  ADD CONSTRAINT `fk_SucursalServicio_Servicio1` FOREIGN KEY (`Servicio_id_Serv`) REFERENCES `servicio` (`id_Serv`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_SucursalServicio_Sucursal1` FOREIGN KEY (`Sucursal_id_Suc`) REFERENCES `sucursal` (`id_Suc`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `telefono`
--
ALTER TABLE `telefono`
  ADD CONSTRAINT `fk_Telefono_Socio1` FOREIGN KEY (`Socio_id_Soc`) REFERENCES `socio` (`id_Soc`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `usuariopersonal`
--
ALTER TABLE `usuariopersonal`
  ADD CONSTRAINT `fk_UsuarioPersonal_Personal1` FOREIGN KEY (`Personal_id_Per`) REFERENCES `personal` (`id_Per`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `usuariosocio`
--
ALTER TABLE `usuariosocio`
  ADD CONSTRAINT `fk_UsuarioSocio_Socio1` FOREIGN KEY (`Socio_id_Soc`) REFERENCES `socio` (`id_Soc`) ON DELETE NO ACTION ON UPDATE NO ACTION;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
