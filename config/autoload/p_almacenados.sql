CREATE PROCEDURE pa_insertaSucursal (IN display VARCHAR(45),IN ubicacion VARCHAR(45),IN telefono VARCHAR(45))
BEGIN
	DECLARE cod TINYINT;
	SELECT (COALESCE( MAX( id_suc ) , 0 ) +1) INTO cod FROM sucursal;
	INSERT INTO sucursal (id_suc,display_suc,ubicacion_suc,telefono_suc) VALUES (cod,display,ubicacion,telefono);
END$$

CALL pa_insertaSucursal ('Villarreal','Av. Libertad # 855 Urb. Federico Villarreal','270226');
CALL pa_insertaSucursal ('Torres Paz','Calle Torres Paz # 175','231854');

CREATE PROCEDURE pa_listaSucursal()
BEGIN
	SELECT id_suc,display_suc cod FROM sucursal;
END$$

CALL pa_listaSucursal;

CREATE PROCEDURE pa_insertaPersonal
(IN dni CHAR(8),IN nom VARCHAR(45),IN pat VARCHAR(45),IN mat VARCHAR(45),IN dir VARCHAR(75),
	IN tcasa VARCHAR(10),IN tmov VARCHAR(10),IN mail VARCHAR(50),IN estado CHAR(1),IN suc TINYINT,OUT msje VARCHAR(80))
BEGIN
	DECLARE cod TINYINT;
	DECLARE d CHAR(8);
	DECLARE m VARCHAR(80);
	SELECT COALESCE( MAX( dni_per ) , 0 ) INTO d FROM personal WHERE dni_per=dni;

	IF d=0 THEN
		SELECT (COALESCE( MAX( id_per ) , 0 ) +1) INTO cod FROM personal;
		INSERT INTO personal (id_per,dni_per,nombre_per,apellidoPat_per,apellidoMat_per,telCasa_per,telMovil_per,email_per,estado_per,sucursal)
				VALUES (cod,dni,nom,pat,mat,tcasa,tmov,mail,estado,suc);
	ELSE
		SET m='La persona ya fue Registrada..!! (DNI Registrado)';
		SELECT m INTO msje;
	END IF;
END$$

CALL pa_insertaPersonal ('45733856','Erik','Urrutia','Santamaria','Juan Vizcardo # 178 - PJ Muro','074273545','958903956','e_urrutia@outlook.com','A',1,@msje);