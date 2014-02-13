DELIMITER $$

DROP PROCEDURE IF EXISTS `bdfinal`.`pa_actualizaPersonal`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE  `bdfinal`.`pa_actualizaPersonal`(
  IN id SMALLINT,IN dni CHAR(8),IN nom VARCHAR(45),IN pat VARCHAR(45),IN mat VARCHAR(45),IN fecha DATE,
  IN sexo TINYINT(1),IN dir VARCHAR(75),IN tcasa VARCHAR(10),IN tmov VARCHAR(10),IN mail VARCHAR(50),
  IN suc TINYINT,IN cargo TINYINT, IN estado TINYINT(1),OUT msje VARCHAR(80))
BEGIN
  DECLARE m VARCHAR(80);
  UPDATE personal SET
    dni_per=dni,nombres_per=nom,apellidoPaterno_per=pat,apellidoMaterno_per=mat,fechaNacimiento_Per=fecha,
    sexo_Per=sexo,direccion_per=dir,telefonoCasa_per=tcasa,telefonoMovil_per=tmov,email_per=mail,
    cargo_Per=cargo,sucursal_id_suc=suc,estado_per=estado
  WHERE id_per=id;
  SET m='Datos del Personal Actualizado.';
  SELECT m INTO msje;
END $$

DELIMITER ;

DELIMITER $$

DROP PROCEDURE IF EXISTS `bdfinal`.`pa_actualizaPersonalUsuario`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE  `bdfinal`.`pa_actualizaPersonalUsuario`(
  IN id SMALLINT,IN dni CHAR(8),IN nom VARCHAR(45),IN pat VARCHAR(45),IN mat VARCHAR(45),IN fecha DATE,
  IN sexo TINYINT(1),IN dir VARCHAR(75),IN tcasa VARCHAR(10),IN tmov VARCHAR(10),IN mail VARCHAR(50),
  IN suc TINYINT,IN cargo TINYINT, IN estado TINYINT(1),IN estadoUper TINYINT(1),OUT msje VARCHAR(80))
BEGIN
  DECLARE m VARCHAR(80);
  START TRANSACTION;
    UPDATE personal SET
      dni_per=dni,nombres_per=nom,apellidoPaterno_per=pat,apellidoMaterno_per=mat,fechaNacimiento_Per=fecha,
      sexo_Per=sexo,direccion_per=dir,telefonoCasa_per=tcasa,telefonoMovil_per=tmov,email_per=mail,
      cargo_Per=cargo,sucursal_id_suc=suc,estado_per=estado
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

DROP PROCEDURE IF EXISTS `bdfinal`.`pa_actualizaSucursal`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE  `bdfinal`.`pa_actualizaSucursal`(IN nombre VARCHAR(40),IN direccion VARCHAR(45),IN linea TINYINT,IN telefono CHAR(9),IN estado TINYINT(1),IN id TINYINT,OUT msje VARCHAR(80))
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

DROP PROCEDURE IF EXISTS `bdfinal`.`pa_buscaPersonal`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE  `bdfinal`.`pa_buscaPersonal`(IN dni CHAR(8))
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
      personal.estado_Per,personal.fechaNacimiento_Per,personal.id_Per,personal.nombres_Per,personal.sucursal_id_suc,
      personal.cargo_Per,personal.sexo_Per,personal.telefonoCasa_Per,personal.telefonoMovil_Per,usuariopersonal.id_UPer,
      usuariopersonal.alias_UPer,usuariopersonal.estado_UPer
      FROM personal INNER JOIN usuariopersonal
      ON personal.id_per=usuariopersonal.personal_id_per
      WHERE personal.dni_per=dni
      LIMIT 1;
  END CASE;
END $$

DELIMITER ;

DELIMITER $$

DROP PROCEDURE IF EXISTS `bdfinal`.`pa_buscarsocio`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE  `bdfinal`.`pa_buscarsocio`(in nro char(11))
begin
select id_Soc,nombres_Soc from socio where documento_soc=nro;
end $$

DELIMITER ;

DELIMITER $$

DROP PROCEDURE IF EXISTS `bdfinal`.`pa_ClienteInscripcion`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE  `bdfinal`.`pa_ClienteInscripcion`(in dni varchar(11))
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

DROP PROCEDURE IF EXISTS `bdfinal`.`pa_consolidadoPlan`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE  `bdfinal`.`pa_consolidadoPlan`(IN id SMALLINT)
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

END $$

DELIMITER ;

DELIMITER $$

DROP PROCEDURE IF EXISTS `bdfinal`.`pa_desactivarSucursal`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE  `bdfinal`.`pa_desactivarSucursal`(IN id TINYINT,OUT msje VARCHAR(80))
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

DROP PROCEDURE IF EXISTS `bdfinal`.`pa_insertaPersonal`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE  `bdfinal`.`pa_insertaPersonal`(
  IN dni CHAR(8),IN nom VARCHAR(45),IN pat VARCHAR(45),IN mat VARCHAR(45),IN fecha DATE, IN sexo TINYINT(1),IN dir VARCHAR(75),
  IN tcasa VARCHAR(10),IN tmov VARCHAR(10),IN mail VARCHAR(50), IN suc TINYINT,IN cargo TINYINT,
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
      ( dni_per,nombres_per,apellidoPaterno_per,apellidoMaterno_per,fechaNacimiento_Per,
        sexo_Per,direccion_per,telefonoCasa_per,telefonoMovil_per,email_per,sucursal_id_suc,cargo_Per)
      VALUES (
        dni,nom,pat,mat,fecha,
        sexo,dir,tcasa,tmov,mail,suc,cargo);
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

DROP PROCEDURE IF EXISTS `bdfinal`.`pa_insertaPersonalUsuario`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE  `bdfinal`.`pa_insertaPersonalUsuario`(
  IN dni CHAR(8),IN nom VARCHAR(45),IN pat VARCHAR(45),IN mat VARCHAR(45),IN fecha DATE, IN sexo TINYINT(1),IN dir VARCHAR(75),
  IN tcasa VARCHAR(10),IN tmov VARCHAR(10),IN mail VARCHAR(50),IN suc TINYINT,IN cargo TINYINT,IN alias VARCHAR(20),IN clave CHAR(60),
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
        ( dni_per,nombres_per,apellidoPaterno_per,apellidoMaterno_per,fechaNacimiento_Per,
          sexo_Per,direccion_per,telefonoCasa_per,telefonoMovil_per,email_per,sucursal_id_suc,cargo_Per)
        VALUES (
          dni,nom,pat,mat,fecha,
          sexo,dir,tcasa,tmov,mail,suc,cargo);
        SELECT MAX(LAST_INSERT_ID(id_per)) INTO codigo FROM personal;
        INSERT INTO UsuarioPersonal
        ( alias_UPer,clave_UPer,Personal_id_Per ) VALUES
        ( alias,clave,codigo  );
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

DROP PROCEDURE IF EXISTS `bdfinal`.`pa_insertaPlan`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE  `bdfinal`.`pa_insertaPlan`(
  IN nombre VARCHAR(45), IN mBase DECIMAL(6,2), IN tipo TINYINT(1), IN cupon TINYINT(4),
	IN freezing TINYINT(4), IN mInicial DECIMAL(6,2), IN fecha DATETIME,IN promo TINYINT(1),
	IN tipoDuracion TINYINT,IN duracion TINYINT, IN cuotas TINYINT, IN pagoMax TINYINT,
  IN personalReg SMALLINT, IN planBase SMALLINT,IN xmlServ TEXT, IN xmlSuc TEXT,OUT msje VARCHAR(80))
BEGIN
  DECLARE m VARCHAR(80);
--  para servicio
	DECLARE serv SMALLINT;

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
    CASE
      WHEN planBase = 0 THEN
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
		  WHEN planBase > 0 THEN
        UPDATE servicio SET estado_Serv = 0 WHERE id_serv=planBase;
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

    SET msje:='Plan Registrado con exito.';
    COMMIT;

END $$

DELIMITER ;

DELIMITER $$

DROP PROCEDURE IF EXISTS `bdfinal`.`pa_insertaPromoBase`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE  `bdfinal`.`pa_insertaPromoBase`(
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

DROP PROCEDURE IF EXISTS `bdfinal`.`pa_insertaServicio`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE  `bdfinal`.`pa_insertaServicio`(IN nombre VARCHAR(45), IN tipo TINYINT(1), IN fecha DATETIME,
	IN personalReg SMALLINT, IN xmlSuc TEXT, OUT msje VARCHAR(80))
BEGIN
  DECLARE m VARCHAR(80);
--  para servicio
	DECLARE serv SMALLINT;

--  para sucursal Servicio
	DECLARE s int DEFAULT 1;
	DECLARE dSuc TINYINT;
	DECLARE smax int DEFAULT 0;

	START TRANSACTION;
		-- id_Serv
		INSERT INTO servicio
		( nombre_Serv, tipo_Serv, fechaRegistro_Serv, Personal_id_Per)
		VALUES
		( nombre, tipo, fecha, personalReg);

		SELECT MAX(LAST_INSERT_ID(id_Serv)) INTO serv FROM servicio;

	    -- Detalle de Sucursal Servicio
		SET smax:=ExtractValue(xmlSuc, 'count(lista/sucursal)');
		WHILE s   <=smax DO
			SET dSuc:=ExtractValue(xmlSuc, 'lista/sucursal[$s]');
			SELECT dSuc,serv;
				INSERT INTO sucursalservicio
					(Sucursal_id_Suc, Servicio_id_Serv)
				VALUES (dSuc,serv);
			SET s =s+1;
		END WHILE;

		-- Fin Sucursal Servicio --

		SET m ='Servicio Regitrado con exito.';
		SELECT m INTO msje;
	COMMIT;

END $$

DELIMITER ;

DELIMITER $$

DROP PROCEDURE IF EXISTS `bdfinal`.`pa_insertaSocio`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE  `bdfinal`.`pa_insertaSocio`(IN dni CHAR(11),in tipodoc tinyint, IN pat VARCHAR(45), IN mat VARCHAR(45),
  IN nom VARCHAR(45),in sexo tinyint(1),in fechanac date,in mail varchar(50),in ecivil tinyint, in distrito tinyint(3),
  IN dir varchar(50),in fevisita date,in feregis date,
  IN feinvitacion date,in estado tinyint,in referido smallint,in empresa tinyint,in personal smallint,
  IN sucursal TINYINT(4),IN xml TEXT,OUT msje VARCHAR(80) )
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
      fechaVisita_Soc,fechaRegistro_Soc,fechaInvitacion_Soc,estado_Soc,Socio_Referido,
      empresa_id_emp,Personal_id_Per,Sucursal_id_Suc)
      VALUES (dni,tipodoc,pat,mat,nom,sexo,fechanac,mail,ecivil,dir,distrito,fevisita,feregis,feinvitacion,
      estado,referido,empresa,personal,sucursal);

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

DROP PROCEDURE IF EXISTS `bdfinal`.`pa_insertaSocioUsuario`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE  `bdfinal`.`pa_insertaSocioUsuario`(
	IN dni CHAR(11),in tipodoc tinyint,IN pat VARCHAR(45),IN mat VARCHAR(45),IN nom VARCHAR(45),in sexo tinyint(1),
 	 in fechanac date,in mail varchar(50),
  	in ecivil tinyint,in fevisita date,in feregis date,in feinvitacion date,in estado tinyint,
 	 in referido smallint,in empresa tinyint,in personal smallint,in alias char(15),
    IN sucursal TINYINT(4),in xml text,OUT msje VARCHAR(80))
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
					fechaVisita_Soc,fechaRegistro_Soc,fechaInvitacion_Soc,estado_Soc,Socio_Referido,
          empresa_id_emp,Personal_id_Per,Sucursal_id_Suc)
				VALUES (dni,tipodoc,pat,mat,nom,sexo,fechanac,mail,ecivil,fevisita,feregis,feinvitacion,
					estado,referido,empresa,personal,sucursal);

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

DROP PROCEDURE IF EXISTS `bdfinal`.`pa_insertaSocioUsuarios`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE  `bdfinal`.`pa_insertaSocioUsuarios`(
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

DROP PROCEDURE IF EXISTS `bdfinal`.`pa_insertaSucursal`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE  `bdfinal`.`pa_insertaSucursal`(IN nombre VARCHAR(40),IN direccion VARCHAR(45),IN linea TINYINT,IN telefono CHAR(9),OUT msje VARCHAR(80))
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

DROP PROCEDURE IF EXISTS `bdfinal`.`pa_leeSucursal`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE  `bdfinal`.`pa_leeSucursal`(IN id TINYINT)
BEGIN
	SELECT id_suc,nombre_suc,direccion_suc,linea_suc,telefono_suc,estado_suc FROM sucursal WHERE id_suc=id LIMIT 1;
END $$

DELIMITER ;

DELIMITER $$

DROP PROCEDURE IF EXISTS `bdfinal`.`pa_listaCiudad`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE  `bdfinal`.`pa_listaCiudad`()
BEGIN
  SELECT id_Ciu, nombre_Ciu FROM ciudad;
END $$

DELIMITER ;

DELIMITER $$

DROP PROCEDURE IF EXISTS `bdfinal`.`pa_listaDistrito`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE  `bdfinal`.`pa_listaDistrito`(IN id tinyint)
BEGIN
  SELECT id_Dis, nombre_Dis, Ciudad_id_Ciu FROM distrito WHERE Ciudad_id_Ciu = id;
END $$

DELIMITER ;

DELIMITER $$

DROP PROCEDURE IF EXISTS `bdfinal`.`pa_listaEmpresa`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE  `bdfinal`.`pa_listaEmpresa`()
BEGIN
  SELECT id_emp,nombre_emp FROM empresa;
END $$

DELIMITER ;

DELIMITER $$

DROP PROCEDURE IF EXISTS `bdfinal`.`pa_listaPersonal`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE  `bdfinal`.`pa_listaPersonal`()
BEGIN
  SELECT id_per, nombres_per,apellidoMaterno_Per,apellidoPaterno_Per FROM personal WHERE estado_per=1;
END $$

DELIMITER ;

DELIMITER $$

DROP PROCEDURE IF EXISTS `bdfinal`.`pa_listaPlan`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE  `bdfinal`.`pa_listaPlan`()
begin
    SELECT id_Serv,nombre_Serv FROM servicio WHERE tipo_Serv>=1;
end $$

DELIMITER ;

DELIMITER $$

DROP PROCEDURE IF EXISTS `bdfinal`.`pa_listaServicio`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE  `bdfinal`.`pa_listaServicio`()
begin
      SELECT id_Serv,nombre_Serv FROM servicio;
end $$

DELIMITER ;

DELIMITER $$

DROP PROCEDURE IF EXISTS `bdfinal`.`pa_listaServicioBase`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE  `bdfinal`.`pa_listaServicioBase`()
BEGIN
    SELECT id_Serv, nombre_Serv FROM servicio WHERE tipo_serv=0 AND estado_Serv=1;
END $$

DELIMITER ;

DELIMITER $$

DROP PROCEDURE IF EXISTS `bdfinal`.`pa_listaSocio`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE  `bdfinal`.`pa_listaSocio`()
BEGIN
select id_Soc,concat(apellidoPaterno_Soc, ' ' , apellidoMaterno_Soc, ', ',nombres_Soc) as cliente,documento_soc
from socio;
END $$

DELIMITER ;

DELIMITER $$

DROP PROCEDURE IF EXISTS `bdfinal`.`pa_ListaSociosActivos`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE  `bdfinal`.`pa_ListaSociosActivos`()
begin
select id_Soc,concat_ws(' ', apellidoPaterno_Soc, apellidoMaterno_Soc,nombres_Soc) as cliente,documento_soc
from socio soc
INNER JOIN inscripcion inc on soc.id_Soc = inc.Socio_id_Soc
where soc.estado_Soc=0 and inc.estado_Ins=1 and inc.tipo_Ins=0;
end $$

DELIMITER ;

DELIMITER $$

DROP PROCEDURE IF EXISTS `bdfinal`.`pa_ListaSociosReferir`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE  `bdfinal`.`pa_ListaSociosReferir`()
begin
select id_Soc,concat(apellidoPaterno_Soc, ' ', apellidoMaterno_Soc,', ', nombres_Soc) as cliente,documento_soc
from socio;
end $$

DELIMITER ;

DELIMITER $$

DROP PROCEDURE IF EXISTS `bdfinal`.`pa_listaSucursal`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE  `bdfinal`.`pa_listaSucursal`()
BEGIN
	SELECT id_suc,nombre_suc,direccion_suc,linea_suc,telefono_suc,estado_suc FROM sucursal;
END $$

DELIMITER ;

DELIMITER $$

DROP PROCEDURE IF EXISTS `bdfinal`.`pa_listaSucursalActivo`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE  `bdfinal`.`pa_listaSucursalActivo`()
BEGIN
	SELECT id_suc,nombre_suc,direccion_suc,linea_suc,telefono_suc,estado_suc FROM sucursal WHERE estado_suc=1;
END $$

DELIMITER ;

DELIMITER $$

DROP PROCEDURE IF EXISTS `bdfinal`.`pa_listaSucursalInactivo`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE  `bdfinal`.`pa_listaSucursalInactivo`()
BEGIN
	SELECT id_suc,nombre_suc,direccion_suc,linea_suc,telefono_suc,estado_suc FROM sucursal WHERE estado_suc=0;
END $$

DELIMITER ;

DELIMITER $$

DROP PROCEDURE IF EXISTS `bdfinal`.`pa_loginPersonal`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE  `bdfinal`.`pa_loginPersonal`(IN nombre VARCHAR(20))
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

DROP PROCEDURE IF EXISTS `bdfinal`.`pa_loginPersonalId`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE  `bdfinal`.`pa_loginPersonalId`(IN id INT)
BEGIN
    SELECT
		  personal.apellidoMaterno_Per,personal.apellidoPaterno_Per,personal.nombres_Per,
      personal.sexo_Per,personal.id_per,personal.Sucursal_id_Suc,personal.cargo_Per,
      (SELECT nombre_Suc FROM sucursal WHERE id_Suc=personal.Sucursal_id_Suc) as sucursalNombre,
      usuariopersonal.id_UPer,usuariopersonal.alias_UPer
    FROM personal INNER JOIN usuariopersonal
    ON personal.id_per=usuariopersonal.personal_id_per
    WHERE usuariopersonal.personal_id_per=id
	  LIMIT 1;
END $$

DELIMITER ;

DELIMITER $$

DROP PROCEDURE IF EXISTS `bdfinal`.`pa_verificaClavePersonal`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE  `bdfinal`.`pa_verificaClavePersonal`(IN id INT)
BEGIN
  SELECT clave_UPer FROM usuariopersonal WHERE Personal_id_Per=id;
END $$

DELIMITER ;

DELIMITER $$

DROP PROCEDURE IF EXISTS `bdfinal`.`pa_verPersonal`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE  `bdfinal`.`pa_verPersonal`(IN id INT)
BEGIN
  SELECT * FROM personal WHERE id_Per=id;
END $$

DELIMITER ;