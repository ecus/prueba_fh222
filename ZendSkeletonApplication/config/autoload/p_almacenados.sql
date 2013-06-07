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