DROP PROCEDURE pa_insertaSucursal$$
CREATE PROCEDURE pa_insertaSucursal (IN nombre VARCHAR(40),IN direccion VARCHAR(45),IN linea TINYINT,IN telefono CHAR(9),OUT msje VARCHAR(80))
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
END$$



--- EJECUTAR SUCURSAL ---
CALL pa_insertaSucursal ('Villarreal','Av. Libertad # 855 - Urb. Federico Villarreal',0,'270226',@msje);
SELECT @msje;
CALL pa_insertaSucursal ('Torres Paz','Calle Torres Paz # 175',0,'231854',@msje);
SELECT @msje;


------------LISTAR SUCURSAL

CREATE PROCEDURE pa_listaSucursal()
BEGIN
	SELECT id_suc,nombre_suc,direccion_suc,linea_suc,telefono_suc,estado_suc FROM sucursal;
END$$

CALL pa_listaSucursal;





------------registra personal
CREATE PROCEDURE pa_insertaPersonal
(IN dni CHAR(8),IN nom VARCHAR(45),IN pat VARCHAR(45),IN mat VARCHAR(45),IN dir VARCHAR(75),
	IN tcasa VARCHAR(10),IN tmov VARCHAR(10),IN mail VARCHAR(50),IN estado CHAR(1),IN suc TINYINT,OUT msje VARCHAR(80))
BEGIN
	DECLARE cod TINYINT;
	DECLARE d CHAR(8);
	DECLARE m VARCHAR(80);
	SELECT COALESCE( dni_per  , 0 ) INTO d FROM personal WHERE dni_per=dni;

	IF d=0 THEN
		SELECT (COALESCE( MAX( id_per ) , 0 ) +1) INTO cod FROM personal;
		INSERT INTO personal (id_per,dni_per,nombre_per,apellidoPat_per,apellidoMat_per,direccion_per,telCasa_per,telMovil_per,email_per,estado_per,sucursal)
				VALUES (cod,dni,nom,pat,mat,dir,tcasa,tmov,mail,estado,suc);
		SET m= CONCAT(nom, ' ', pat, ' se Registro en el sistema con ID: ', cod ,' ..!!');
		SELECT m INTO msje;
	ELSE
		SET m='La persona ya fue Registrada..!! (DNI Registrado)';
		SELECT m INTO msje;
	END IF;
END$$

CALL pa_insertaPersonal ('45733856','Erik','Urrutia','Santamaria','Juan Vizcardo # 178 - PJ Muro','074273545','958903956','e_urrutia@outlook.com','A',1,@msje);

