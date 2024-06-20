-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema tickets
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema tickets
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `tickets` DEFAULT CHARACTER SET utf8 ;
USE `tickets` ;

-- -----------------------------------------------------
-- Table `tickets`.`usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tickets`.`usuarios` (
  `idusuarios` INT NOT NULL AUTO_INCREMENT,
  `nombres` VARCHAR(45) NOT NULL,
  `apellidos` VARCHAR(45) NOT NULL,
  `correo` VARCHAR(45) NOT NULL,
  `claveus` VARCHAR(45) NOT NULL,
  `cargo` VARCHAR(155) NOT NULL,
  `estado` TINYINT NOT NULL,
  `creado` DATETIME NOT NULL DEFAULT current_timestamp(),
  `modificado` DATETIME NOT NULL,
  PRIMARY KEY (`idusuarios`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tickets`.`roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tickets`.`roles` (
  `idroles` INT NOT NULL AUTO_INCREMENT,
  `nombre_rol` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idroles`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tickets`.`grupos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tickets`.`grupos` (
  `idgrupos` INT NOT NULL AUTO_INCREMENT,
  `nombre_grupo` VARCHAR(45) NOT NULL,
  `creado` DATETIME NOT NULL,
  `modificado` DATETIME NOT NULL,
  PRIMARY KEY (`idgrupos`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tickets`.`perfil`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tickets`.`perfil` (
  `idperfil` INT NOT NULL AUTO_INCREMENT,
  `nombre_perfil` VARCHAR(45) NOT NULL COMMENT 'El nombre del perfil hace referencia a las actividades macro del usuario\nTecnico\nOperario\nAuxiliar\nProfesional\nDirector',
  `creado` DATETIME NOT NULL,
  `modificado` DATETIME NOT NULL,
  `idroles` INT NOT NULL,
  `idusuarios` INT NOT NULL,
  `idgrupos` INT NOT NULL,
  PRIMARY KEY (`idperfil`, `idroles`, `idusuarios`, `idgrupos`),
  INDEX `fk_perfil_roles_idx` (`idroles` ASC) VISIBLE,
  INDEX `fk_perfil_usuarios1_idx` (`idusuarios` ASC) VISIBLE,
  INDEX `fk_perfil_grupos1_idx` (`idgrupos` ASC) VISIBLE,
  CONSTRAINT `fk_perfil_roles`
    FOREIGN KEY (`idroles`)
    REFERENCES `tickets`.`roles` (`idroles`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_perfil_usuarios1`
    FOREIGN KEY (`idusuarios`)
    REFERENCES `tickets`.`usuarios` (`idusuarios`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_perfil_grupos1`
    FOREIGN KEY (`idgrupos`)
    REFERENCES `tickets`.`grupos` (`idgrupos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tickets`.`tipo_solicitud`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tickets`.`tipo_solicitud` (
  `idtipo_solicitud` INT NOT NULL AUTO_INCREMENT,
  `nombre_tipo` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idtipo_solicitud`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tickets`.`estado_solicitud`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tickets`.`estado_solicitud` (
  `idestado_solicitud` INT NOT NULL AUTO_INCREMENT,
  `nombre_estado` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idestado_solicitud`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tickets`.`solicitud`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tickets`.`solicitud` (
  `idsolicitud` INT NOT NULL AUTO_INCREMENT,
  `asunto` VARCHAR(45) NOT NULL,
  `descripcion` MEDIUMTEXT NOT NULL,
  `adjunto` VARCHAR(45) NOT NULL,
  `creado` DATETIME NOT NULL,
  `modificado` DATETIME NOT NULL,
  `idtipo_solicitud` INT NOT NULL,
  `idestado_solicitud` INT NOT NULL,
  `solicitante` INT NOT NULL,
  PRIMARY KEY (`idsolicitud`, `idtipo_solicitud`, `idestado_solicitud`, `solicitante`),
  INDEX `fk_solicitud_tipo_solicitud1_idx` (`idtipo_solicitud` ASC) VISIBLE,
  INDEX `fk_solicitud_estado_solicitud1_idx` (`idestado_solicitud` ASC) VISIBLE,
  INDEX `fk_solicitud_usuarios1_idx` (`solicitante` ASC) VISIBLE,
  CONSTRAINT `fk_solicitud_tipo_solicitud1`
    FOREIGN KEY (`idtipo_solicitud`)
    REFERENCES `tickets`.`tipo_solicitud` (`idtipo_solicitud`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_solicitud_estado_solicitud1`
    FOREIGN KEY (`idestado_solicitud`)
    REFERENCES `tickets`.`estado_solicitud` (`idestado_solicitud`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_solicitud_usuarios1`
    FOREIGN KEY (`solicitante`)
    REFERENCES `tickets`.`usuarios` (`idusuarios`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tickets`.`detalle_solicitud`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tickets`.`detalle_solicitud` (
  `iddetalle_solicitud` INT NOT NULL AUTO_INCREMENT,
  `observacion` MEDIUMTEXT NOT NULL,
  `creado` DATETIME NOT NULL,
  `modificado` DATETIME NOT NULL,
  `idsolicitud` INT NOT NULL,
  `responsable` INT NOT NULL,
  PRIMARY KEY (`iddetalle_solicitud`, `idsolicitud`, `responsable`),
  INDEX `fk_detalle_solicitud_solicitud1_idx` (`idsolicitud` ASC) VISIBLE,
  INDEX `fk_detalle_solicitud_usuarios1_idx` (`responsable` ASC) VISIBLE,
  CONSTRAINT `fk_detalle_solicitud_solicitud1`
    FOREIGN KEY (`idsolicitud`)
    REFERENCES `tickets`.`solicitud` (`idsolicitud`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_detalle_solicitud_usuarios1`
    FOREIGN KEY (`responsable`)
    REFERENCES `tickets`.`usuarios` (`idusuarios`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
