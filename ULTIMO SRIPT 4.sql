SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';


-- -----------------------------------------------------
-- Table `empresa`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `empresa` (
  `id_emp` INT NOT NULL ,
  `nombre_emp` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`id_emp`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `profesion`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `profesion` (
  `id_prof` INT NOT NULL ,
  `nombre_prof` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`id_prof`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sucursal`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `sucursal` (
  `id_suc` TINYINT NOT NULL ,
  `display_suc` VARCHAR(45) NOT NULL ,
  `ubicacion_suc` VARCHAR(100) NOT NULL ,
  `telefono_suc` VARCHAR(45) NULL ,
  PRIMARY KEY (`id_suc`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `personal`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `personal` (
  `id_per` INT NOT NULL ,
  `dni_per` CHAR(8) NOT NULL ,
  `nombre_per` VARCHAR(45) NOT NULL ,
  `apellidoPat_per` VARCHAR(45) NOT NULL ,
  `apellidoMat_per` VARCHAR(45) NOT NULL ,
  `direccion_per` VARCHAR(75) NOT NULL ,
  `telCasa_per` VARCHAR(10) NOT NULL ,
  `telMovil_per` VARCHAR(10) NOT NULL ,
  `email_per` VARCHAR(50) NULL ,
  `estado_per` CHAR(1) NOT NULL ,
  `sucursal` TINYINT NOT NULL ,
  PRIMARY KEY (`id_per`) ,
  INDEX `fk_Personal_sucursal1_idx` (`sucursal` ASC) ,
  CONSTRAINT `fk_Personal_sucursal1`
    FOREIGN KEY (`sucursal` )
    REFERENCES `sucursal` (`id_suc` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `usuarioPer`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `usuarioPer` (
  `id_uPer` CHAR(5) NOT NULL ,
  `clave_uPer` VARCHAR(32) NOT NULL ,
  `estado_uPer` CHAR(1) NOT NULL DEFAULT 'A' COMMENT 'A:Activo\\nI:Inactivo' ,
  `personal_id_per` INT NOT NULL ,
  PRIMARY KEY (`id_uPer`) ,
  INDEX `fk_usuarioPer_personal1_idx` (`personal_id_per` ASC) ,
  CONSTRAINT `fk_usuarioPer_personal1`
    FOREIGN KEY (`personal_id_per` )
    REFERENCES `personal` (`id_per` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `socio`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `socio` (
  `id_soc` BIGINT NOT NULL ,
  `documento_soc` VARCHAR(11) NOT NULL ,
  `nombre_soc` VARCHAR(45) NOT NULL ,
  `apellidoPat_soc` VARCHAR(45) NOT NULL ,
  `apellidoMat_soc` VARCHAR(45) NOT NULL ,
  `direccion_soc` VARCHAR(45) NULL DEFAULT NULL ,
  `clave_soc` VARCHAR(32) NULL COMMENT 'Clave necesaria para ver sus pagos, rutinas ,avances, desde el protal para usuarios.' ,
  `sexo_soc` CHAR(1) NOT NULL COMMENT 'M: Masculino\\nF: Femenino' ,
  `telCasa_soc` VARCHAR(10) NULL DEFAULT NULL ,
  `telMovil_soc` VARCHAR(10) NULL DEFAULT NULL ,
  `fechaNac_soc` DATE NULL COMMENT 'Fecha de Nacimiento' ,
  `telEmer_soc` VARCHAR(10) NULL COMMENT 'Telefono de Emergencia' ,
  `nombreEmer_soc` VARCHAR(45) NULL COMMENT '\\\'Nombre de Contacto en Caso de Emergencia\\\'' ,
  `estCivil_soc` CHAR(1) NULL COMMENT 'S: Soltero\\nC: Casado\\nV: Viudo\\nD: Divorciado' ,
  `email_soc` VARCHAR(50) NULL DEFAULT NULL ,
  `nacionalidad_soc` CHAR(1) NULL COMMENT 'P: Peruano\\nE: Extranjero' ,
  `fechaReg_soc` DATETIME NULL COMMENT 'Fecha de Registro' ,
  `fechaVisita_soc` DATETIME NULL DEFAULT NULL COMMENT 'Fecha de Visita' ,
  `fechaInv_soc` DATE NULL DEFAULT NULL COMMENT 'Fecha de Invitacion ya sea por Referido, Fecha o Promocion' ,
  `estado_soc` CHAR(1) NULL DEFAULT 'S' COMMENT 'S:SOCIO\\nI: INVITADO\\nV: VISITA\\nR: RECUPERACION\\n' ,
  `empresa` INT NULL DEFAULT NULL COMMENT 'Empresa a la que pertenece' ,
  `profesion_id_prof` INT NULL DEFAULT NULL ,
  `referido` BIGINT NULL DEFAULT NULL COMMENT 'Referido por algun socio' ,
  `usuarioPer` CHAR(5) NULL ,
  PRIMARY KEY (`id_soc`) ,
  INDEX `fk_socio_empresa_idx` (`empresa` ASC) ,
  INDEX `fk_socio_profesion1_idx` (`profesion_id_prof` ASC) ,
  INDEX `fk_socio_socio1_idx` (`referido` ASC) ,
  INDEX `fk_socio_usuarioPer1_idx` (`usuarioPer` ASC) ,
  CONSTRAINT `fk_socio_empresa`
    FOREIGN KEY (`empresa` )
    REFERENCES `empresa` (`id_emp` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_socio_profesion1`
    FOREIGN KEY (`profesion_id_prof` )
    REFERENCES `profesion` (`id_prof` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_socio_socio1`
    FOREIGN KEY (`referido` )
    REFERENCES `socio` (`id_soc` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_socio_usuarioPer1`
    FOREIGN KEY (`usuarioPer` )
    REFERENCES `usuarioPer` (`id_uPer` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `promocion`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `promocion` (
  `id_promo` INT NOT NULL ,
  `nombre_promo` VARCHAR(65) NOT NULL ,
  `descripcion_promo` VARCHAR(200) NULL ,
  `tipo_promo` CHAR(1) NOT NULL COMMENT 'D: Dias\\nP: Precio\\nE: Empresa\\nX: Porcentual' ,
  `fechaIni_promo` DATETIME NOT NULL COMMENT 'Fecha de inicio de promocion.' ,
  `fechaFin_promo` DATETIME NOT NULL COMMENT 'Fecha y hora en que concluira la promocion y no debera ser listada' ,
  `monto_promo` DECIMAL(3,2) NULL COMMENT 'monto de dscto a plan' ,
  `dias_promo` INT NULL COMMENT 'dias adicionales a plan' ,
  `dscto_promo` FLOAT NULL COMMENT 'Porcentaje de dscto a plan' ,
  `empMin_promo` TINYINT NULL COMMENT 'minimo de persona para dscto de empresas' ,
  `empMax_promo` TINYINT NULL COMMENT 'maximo de persona para dscto de empresas' ,
  `usuarioPer` CHAR(5) NOT NULL ,
  PRIMARY KEY (`id_promo`) ,
  INDEX `fk_promocion_usuarioPer1_idx` (`usuarioPer` ASC) ,
  CONSTRAINT `fk_promocion_usuarioPer1`
    FOREIGN KEY (`usuarioPer` )
    REFERENCES `usuarioPer` (`id_uPer` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `plan`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `plan` (
  `id_plan` INT NOT NULL ,
  `nombre_plan` VARCHAR(45) NOT NULL COMMENT 'Nombre a Mostrar al Listar el Plan' ,
  `descripcion_plan` VARCHAR(200) NULL DEFAULT NULL ,
  `montoBase_plan` DECIMAL(3,2) NOT NULL COMMENT 'Precio Base del Plan' ,
  `montoIni_plan` DECIMAL(3,2) NULL DEFAULT NULL COMMENT 'Si se permite el pago Fragmentado' ,
  `duracion_plan` INT NOT NULL COMMENT 'Definir duracion de membresia de Plan (Días, Semanas, Meses)' ,
  `tipoDur_plan` CHAR(1) NOT NULL COMMENT 'M: Meses\\nS: Semanas\\nD: Dias' ,
  `freezing_plan` INT NOT NULL DEFAULT 0 COMMENT 'Tiempo de Reserva de Membresía (Días)\\n' ,
  `gracia_plan` INT NULL DEFAULT 0 COMMENT 'Dias de Gracia para el pago' ,
  `penalizacion_plan` DECIMAL(3,2) NOT NULL COMMENT 'Monto de Penalizacion' ,
  `horaIni_plan` TIME NOT NULL COMMENT 'Hora de Inicio' ,
  `horaFin_plan` TIME NOT NULL COMMENT 'hora de finalizacion' ,
  `dias_plan` VARCHAR(7) NOT NULL DEFAULT 'LMWJVSD' COMMENT 'L:   Lunes\\nM:  Martes\\nW: Miercoles\\nJ:   Jueves\\nV:   Viernes\\nS:   Sabado\\nD:  Domingo' ,
  `cupon_plan` INT NOT NULL DEFAULT 0 COMMENT 'Dias disponibles para invitacion a otra persona' ,
  `fechaReg_plan` DATETIME NOT NULL ,
  `plan_base` INT NULL ,
  `usuarioPer` CHAR(5) NOT NULL ,
  `promocion` INT NULL ,
  PRIMARY KEY (`id_plan`) ,
  INDEX `fk_plan_plan1_idx` (`plan_base` ASC) ,
  INDEX `fk_plan_usuarioPer1_idx` (`usuarioPer` ASC) ,
  INDEX `fk_plan_promocion1_idx` (`promocion` ASC) ,
  CONSTRAINT `fk_plan_plan1`
    FOREIGN KEY (`plan_base` )
    REFERENCES `plan` (`id_plan` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_plan_usuarioPer1`
    FOREIGN KEY (`usuarioPer` )
    REFERENCES `usuarioPer` (`id_uPer` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_plan_promocion1`
    FOREIGN KEY (`promocion` )
    REFERENCES `promocion` (`id_promo` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'tabla cliente';


-- -----------------------------------------------------
-- Table `sala`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `sala` (
  `id_sala` INT NOT NULL ,
  `nombre_sala` VARCHAR(45) NOT NULL ,
  `descripcion_sala` VARCHAR(200) NOT NULL ,
  PRIMARY KEY (`id_sala`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `planSucursal`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `planSucursal` (
  `plan_id_plan` INT NOT NULL ,
  `sucursal_id_suc` TINYINT NOT NULL ,
  PRIMARY KEY (`plan_id_plan`, `sucursal_id_suc`) ,
  INDEX `fk_planSucursal_sucursal1_idx` (`sucursal_id_suc` ASC) ,
  CONSTRAINT `fk_planSucursal_plan1`
    FOREIGN KEY (`plan_id_plan` )
    REFERENCES `plan` (`id_plan` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_planSucursal_sucursal1`
    FOREIGN KEY (`sucursal_id_suc` )
    REFERENCES `sucursal` (`id_suc` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HorarioPLan`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `HorarioPLan` (
  `id_horaPlan` INT NOT NULL ,
  `promocion_id_promo` INT NULL ,
  `estado_horaPlan` BIT NULL ,
  `personal_id_per` INT NOT NULL ,
  `planSucursal_plan_id_plan` INT NOT NULL ,
  `planSucursal_sucursal_id_suc` TINYINT NOT NULL ,
  PRIMARY KEY (`id_horaPlan`) ,
  INDEX `fk_HorarioPLan_promocion1_idx` (`promocion_id_promo` ASC) ,
  INDEX `fk_HorarioPLan_personal1_idx` (`personal_id_per` ASC) ,
  INDEX `fk_HorarioPLan_planSucursal1_idx` (`planSucursal_plan_id_plan` ASC, `planSucursal_sucursal_id_suc` ASC) ,
  CONSTRAINT `fk_HorarioPLan_promocion1`
    FOREIGN KEY (`promocion_id_promo` )
    REFERENCES `promocion` (`id_promo` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_HorarioPLan_personal1`
    FOREIGN KEY (`personal_id_per` )
    REFERENCES `personal` (`id_per` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_HorarioPLan_planSucursal1`
    FOREIGN KEY (`planSucursal_plan_id_plan` , `planSucursal_sucursal_id_suc` )
    REFERENCES `planSucursal` (`plan_id_plan` , `sucursal_id_suc` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `detalleHoraPlan`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `detalleHoraPlan` (
  `id_dhp` INT NOT NULL ,
  `HorarioPLan` INT NOT NULL ,
  `dia_dhp` CHAR(1) NOT NULL ,
  `horaIni_dhp` TIME NOT NULL ,
  `horaFin_dhp` TIME NOT NULL ,
  `sala_id_sala` INT NULL ,
  PRIMARY KEY (`id_dhp`) ,
  INDEX `fk_detalleHoraPlan_sala1_idx` (`sala_id_sala` ASC) ,
  INDEX `fk_detalleHoraPlan_HorarioPLan1_idx` (`HorarioPLan` ASC) ,
  CONSTRAINT `fk_detalleHoraPlan_sala1`
    FOREIGN KEY (`sala_id_sala` )
    REFERENCES `sala` (`id_sala` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_detalleHoraPlan_HorarioPLan1`
    FOREIGN KEY (`HorarioPLan` )
    REFERENCES `HorarioPLan` (`id_horaPlan` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `servicio`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `servicio` (
  `id_serv` INT NOT NULL ,
  `nombre_serv` VARCHAR(45) NOT NULL ,
  `descripcion_serv` VARCHAR(45) NULL ,
  PRIMARY KEY (`id_serv`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `detalleServPlan`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `detalleServPlan` (
  `servicio_id_serv` INT NOT NULL ,
  `plan_id_plan` INT NOT NULL ,
  PRIMARY KEY (`servicio_id_serv`, `plan_id_plan`) ,
  INDEX `fk_detalleServPlan_plan1_idx` (`plan_id_plan` ASC) ,
  CONSTRAINT `fk_detalleServPlan_servicio1`
    FOREIGN KEY (`servicio_id_serv` )
    REFERENCES `servicio` (`id_serv` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_detalleServPlan_plan1`
    FOREIGN KEY (`plan_id_plan` )
    REFERENCES `plan` (`id_plan` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pregunta`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `pregunta` (
  `id_preg` INT NOT NULL ,
  `descripcion_preg` VARCHAR(150) NOT NULL ,
  `tipo_preg` CHAR(1) NOT NULL COMMENT 'P:  Pregunta\\nO: Observacion\\nM: Meta' ,
  `tipoObs_preg` VARCHAR(45) NULL ,
  PRIMARY KEY (`id_preg`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rpta`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `rpta` (
  `pregunta_id_preg` INT NOT NULL ,
  `socio_id_soc` BIGINT NOT NULL ,
  `texto_rpta` VARCHAR(250) NULL ,
  PRIMARY KEY (`pregunta_id_preg`, `socio_id_soc`) ,
  INDEX `fk_rpta_socio1_idx` (`socio_id_soc` ASC) ,
  CONSTRAINT `fk_rpta_pregunta1`
    FOREIGN KEY (`pregunta_id_preg` )
    REFERENCES `pregunta` (`id_preg` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_rpta_socio1`
    FOREIGN KEY (`socio_id_soc` )
    REFERENCES `socio` (`id_soc` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `detalleObs`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `detalleObs` (
  `pregunta_id_preg` INT NOT NULL ,
  `socio_id_soc` BIGINT NOT NULL ,
  `texto_dobs` VARCHAR(250) NULL ,
  PRIMARY KEY (`pregunta_id_preg`, `socio_id_soc`) ,
  INDEX `fk_detalleObs_socio1_idx` (`socio_id_soc` ASC) ,
  CONSTRAINT `fk_detalleObs_pregunta1`
    FOREIGN KEY (`pregunta_id_preg` )
    REFERENCES `pregunta` (`id_preg` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_detalleObs_socio1`
    FOREIGN KEY (`socio_id_soc` )
    REFERENCES `socio` (`id_soc` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `inscripcion`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `inscripcion` (
  `id_ins` BIGINT NOT NULL ,
  `plan` INT NOT NULL ,
  `socio` BIGINT NOT NULL ,
  `fechaIni_ins` DATE NOT NULL ,
  `fechaFin_ins` DATE NOT NULL ,
  `estado_ins` CHAR(1) NOT NULL DEFAULT 'A' COMMENT 'A: Activo\\nI : Inactivo\\nR: Reservado' ,
  `fechaReserva_ins` VARCHAR(45) NULL ,
  `promocion` INT NULL ,
  `referido_ins` BIGINT NULL ,
  `usuarioPer` CHAR(5) NOT NULL ,
  `tipo_ins` CHAR(1) NULL DEFAULT 'R' COMMENT 'R: REGULAR\\nI: INVITADO\\n' ,
  `inscripcioncol` VARCHAR(45) NULL ,
  PRIMARY KEY (`id_ins`) ,
  INDEX `fk_inscripcion_plan1_idx` (`plan` ASC) ,
  INDEX `fk_inscripcion_promocion1_idx` (`promocion` ASC) ,
  INDEX `fk_inscripcion_socio1_idx` (`socio` ASC) ,
  INDEX `fk_inscripcion_inscripcion1_idx` (`referido_ins` ASC) ,
  INDEX `fk_inscripcion_usuarioPer1_idx` (`usuarioPer` ASC) ,
  CONSTRAINT `fk_inscripcion_plan1`
    FOREIGN KEY (`plan` )
    REFERENCES `plan` (`id_plan` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_inscripcion_promocion1`
    FOREIGN KEY (`promocion` )
    REFERENCES `promocion` (`id_promo` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_inscripcion_socio1`
    FOREIGN KEY (`socio` )
    REFERENCES `socio` (`id_soc` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_inscripcion_inscripcion1`
    FOREIGN KEY (`referido_ins` )
    REFERENCES `inscripcion` (`id_ins` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_inscripcion_usuarioPer1`
    FOREIGN KEY (`usuarioPer` )
    REFERENCES `usuarioPer` (`id_uPer` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `entrenamiento`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `entrenamiento` (
  `id_ent` BIGINT NOT NULL ,
  `fechaReg_ent` DATE NOT NULL ,
  `descripcion_ent` VARCHAR(250) NULL ,
  `estado_ent` BIT NOT NULL DEFAULT 1 COMMENT '0: Inactivo\\n1: Activo' ,
  `inscripcion_id_ins` BIGINT NOT NULL ,
  PRIMARY KEY (`id_ent`) ,
  INDEX `fk_entrenamiento_inscripcion1_idx` (`inscripcion_id_ins` ASC) ,
  CONSTRAINT `fk_entrenamiento_inscripcion1`
    FOREIGN KEY (`inscripcion_id_ins` )
    REFERENCES `inscripcion` (`id_ins` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `detalleMeta`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `detalleMeta` (
  `pregunta` INT NOT NULL ,
  `entrenamiento` BIGINT NOT NULL ,
  PRIMARY KEY (`pregunta`, `entrenamiento`) ,
  INDEX `fk_detalleMeta_entrenamiento1_idx` (`entrenamiento` ASC) ,
  CONSTRAINT `fk_detalleMeta_pregunta1`
    FOREIGN KEY (`pregunta` )
    REFERENCES `pregunta` (`id_preg` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_detalleMeta_entrenamiento1`
    FOREIGN KEY (`entrenamiento` )
    REFERENCES `entrenamiento` (`id_ent` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `freezing`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `freezing` (
  `id_free` INT NOT NULL ,
  `socio` BIGINT NOT NULL ,
  `inscripcion` BIGINT NOT NULL ,
  `fecha_free` DATE NOT NULL ,
  `dias_free` TINYINT NOT NULL ,
  `usuarioPer` CHAR(5) NOT NULL ,
  PRIMARY KEY (`id_free`) ,
  INDEX `fk_freezing_socio1_idx` (`socio` ASC) ,
  INDEX `fk_freezing_inscripcion1_idx` (`inscripcion` ASC) ,
  INDEX `fk_freezing_usuarioPer1_idx` (`usuarioPer` ASC) ,
  CONSTRAINT `fk_freezing_socio1`
    FOREIGN KEY (`socio` )
    REFERENCES `socio` (`id_soc` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_freezing_inscripcion1`
    FOREIGN KEY (`inscripcion` )
    REFERENCES `inscripcion` (`id_ins` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_freezing_usuarioPer1`
    FOREIGN KEY (`usuarioPer` )
    REFERENCES `usuarioPer` (`id_uPer` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `zona`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `zona` (
  `id_zona` TINYINT NOT NULL ,
  `nombre_zona` VARCHAR(70) NOT NULL ,
  PRIMARY KEY (`id_zona`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `programa`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `programa` (
  `id_prog` BIGINT NOT NULL ,
  `fechaIni_prog` DATE NOT NULL ,
  `vigencia_prog` INT NOT NULL COMMENT 'periodo de duracion de rutina' ,
  `descripcion_prog` VARCHAR(250) NOT NULL ,
  `estado_prog` BIT NOT NULL DEFAULT 1 ,
  `entrenamiento` BIGINT NOT NULL ,
  `zona` TINYINT NOT NULL ,
  PRIMARY KEY (`id_prog`) ,
  INDEX `fk_programa_entrenamiento1_idx` (`entrenamiento` ASC) ,
  INDEX `fk_programa_zona1_idx` (`zona` ASC) ,
  CONSTRAINT `fk_programa_entrenamiento1`
    FOREIGN KEY (`entrenamiento` )
    REFERENCES `entrenamiento` (`id_ent` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_programa_zona1`
    FOREIGN KEY (`zona` )
    REFERENCES `zona` (`id_zona` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `maquina`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `maquina` (
  `id_maq` INT NOT NULL ,
  `nombre_maq` VARCHAR(5) NOT NULL ,
  `descripcion_maq` VARCHAR(150) NULL DEFAULT NULL ,
  `sala_id_sala` INT NULL ,
  PRIMARY KEY (`id_maq`) ,
  INDEX `fk_maquina_sala1_idx` (`sala_id_sala` ASC) ,
  CONSTRAINT `fk_maquina_sala1`
    FOREIGN KEY (`sala_id_sala` )
    REFERENCES `sala` (`id_sala` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ejercicio`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `ejercicio` (
  `id_ejer` INT NOT NULL ,
  `nombre_ejer` VARCHAR(70) NOT NULL COMMENT 'Nombre a mostrar en ficha de ejecricios' ,
  `descripcion_ejer` VARCHAR(250) NOT NULL ,
  `tipo_ejer` CHAR(1) NOT NULL COMMENT 'C: Calentamiento\\nE: Ejercicio\\nS: Estiramiento' ,
  `zona` TINYINT NOT NULL ,
  `maquina` INT NULL ,
  PRIMARY KEY (`id_ejer`) ,
  INDEX `fk_ejercicio_zona1_idx` (`zona` ASC) ,
  INDEX `fk_ejercicio_maquina1_idx` (`maquina` ASC) ,
  CONSTRAINT `fk_ejercicio_zona1`
    FOREIGN KEY (`zona` )
    REFERENCES `zona` (`id_zona` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ejercicio_maquina1`
    FOREIGN KEY (`maquina` )
    REFERENCES `maquina` (`id_maq` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `asistencia`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `asistencia` (
  `id_asis` BIGINT NOT NULL ,
  `fechaIng_asis` DATETIME NOT NULL ,
  `fechaReg_asis` DATETIME NULL ,
  `socio` BIGINT NOT NULL ,
  `inscripcion` BIGINT NOT NULL ,
  `usuarioPer` CHAR(5) NOT NULL ,
  `sucursal_id_suc` TINYINT NOT NULL ,
  PRIMARY KEY (`id_asis`) ,
  INDEX `fk_asistencia_socio1_idx` (`socio` ASC) ,
  INDEX `fk_asistencia_inscripcion1_idx` (`inscripcion` ASC) ,
  INDEX `fk_asistencia_usuarioPer1_idx` (`usuarioPer` ASC) ,
  INDEX `fk_asistencia_sucursal1_idx` (`sucursal_id_suc` ASC) ,
  CONSTRAINT `fk_asistencia_socio1`
    FOREIGN KEY (`socio` )
    REFERENCES `socio` (`id_soc` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_asistencia_inscripcion1`
    FOREIGN KEY (`inscripcion` )
    REFERENCES `inscripcion` (`id_ins` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_asistencia_usuarioPer1`
    FOREIGN KEY (`usuarioPer` )
    REFERENCES `usuarioPer` (`id_uPer` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_asistencia_sucursal1`
    FOREIGN KEY (`sucursal_id_suc` )
    REFERENCES `sucursal` (`id_suc` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cuenta`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `cuenta` (
  `id_cta` INT NOT NULL ,
  `display_cta` VARCHAR(100) NOT NULL ,
  `tipo_cta` CHAR(1) NOT NULL COMMENT 'V:Visa\\nM:MasterCard\\nD:DinnersClub\\n' ,
  `moneda_cta` VARCHAR(45) NOT NULL ,
  `banco_cta` VARCHAR(60) NOT NULL ,
  `estado_cta` BIT NOT NULL ,
  PRIMARY KEY (`id_cta`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pago`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `pago` (
  `id_pago` BIGINT NOT NULL ,
  `monto_pago` VARCHAR(45) NOT NULL ,
  `fechaReg_pago` DATETIME NOT NULL ,
  `moneda_pago` CHAR(1) NOT NULL COMMENT 'S: Soles\\nD: Dolares' ,
  `forma_pago` CHAR(1) NOT NULL COMMENT 'E: Efectivo\\nC: Credito\\nH: Cheque' ,
  `concepto_pago` VARCHAR(70) NULL DEFAULT NULL ,
  `banco_pago` VARCHAR(45) NULL DEFAULT NULL ,
  `operacion_pago` VARCHAR(45) NULL DEFAULT NULL ,
  `tarjeta_pago` VARCHAR(45) NULL DEFAULT NULL ,
  `fechaPago_pago` VARCHAR(45) NULL DEFAULT NULL ,
  `socio` BIGINT NOT NULL ,
  `usuarioPer` CHAR(5) NOT NULL ,
  `cuenta_id_cta` INT NULL ,
  `sucursal_id_suc` TINYINT NOT NULL ,
  `inscripcion_id_ins` BIGINT NULL ,
  PRIMARY KEY (`id_pago`) ,
  INDEX `fk_pago_socio1_idx` (`socio` ASC) ,
  INDEX `fk_pago_usuarioPer1_idx` (`usuarioPer` ASC) ,
  INDEX `fk_pago_cuenta1_idx` (`cuenta_id_cta` ASC) ,
  INDEX `fk_pago_sucursal1_idx` (`sucursal_id_suc` ASC) ,
  INDEX `fk_pago_inscripcion1_idx` (`inscripcion_id_ins` ASC) ,
  CONSTRAINT `fk_pago_socio1`
    FOREIGN KEY (`socio` )
    REFERENCES `socio` (`id_soc` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pago_usuarioPer1`
    FOREIGN KEY (`usuarioPer` )
    REFERENCES `usuarioPer` (`id_uPer` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pago_cuenta1`
    FOREIGN KEY (`cuenta_id_cta` )
    REFERENCES `cuenta` (`id_cta` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pago_sucursal1`
    FOREIGN KEY (`sucursal_id_suc` )
    REFERENCES `sucursal` (`id_suc` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pago_inscripcion1`
    FOREIGN KEY (`inscripcion_id_ins` )
    REFERENCES `inscripcion` (`id_ins` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `detalleEst`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `detalleEst` (
  `id_dest` BIGINT NOT NULL ,
  `programa` BIGINT NOT NULL ,
  `ejercicio` INT NOT NULL ,
  `observacion_dest` VARCHAR(45) NULL ,
  PRIMARY KEY (`id_dest`) ,
  INDEX `fk_detalleEst_programa1_idx` (`programa` ASC) ,
  INDEX `fk_detalleEst_ejercicio1_idx` (`ejercicio` ASC) ,
  CONSTRAINT `fk_detalleEst_programa1`
    FOREIGN KEY (`programa` )
    REFERENCES `programa` (`id_prog` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_detalleEst_ejercicio1`
    FOREIGN KEY (`ejercicio` )
    REFERENCES `ejercicio` (`id_ejer` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `detallePrograma`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `detallePrograma` (
  `id_dprog` BIGINT NOT NULL ,
  `series_dprog` TINYINT NOT NULL COMMENT 'nro de veces que se deben hacer las repeticiones' ,
  `repeticiones_dprog` TINYINT NOT NULL COMMENT 'cantidad de veces que se hace un ejercicio' ,
  `ejercicio` INT NOT NULL ,
  `programa` BIGINT NOT NULL ,
  PRIMARY KEY (`id_dprog`) ,
  INDEX `fk_detallePrograma_ejercicio1_idx` (`ejercicio` ASC) ,
  INDEX `fk_detallePrograma_programa1_idx` (`programa` ASC) ,
  CONSTRAINT `fk_detallePrograma_ejercicio1`
    FOREIGN KEY (`ejercicio` )
    REFERENCES `ejercicio` (`id_ejer` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_detallePrograma_programa1`
    FOREIGN KEY (`programa` )
    REFERENCES `programa` (`id_prog` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
