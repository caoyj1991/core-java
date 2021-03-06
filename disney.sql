-- MySQL Script generated by MySQL Workbench
-- Thu Sep 14 22:08:47 2017
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema disney
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema disney
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `disney` DEFAULT CHARACTER SET utf8 ;
USE `disney` ;

-- -----------------------------------------------------
-- Table `disney`.`token`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `disney`.`token` (
  `userId` INT NOT NULL,
  `token` VARCHAR(45) NULL,
  `startDate` TIMESTAMP NOT NULL,
  `endDate` TIMESTAMP NULL,
  UNIQUE INDEX `token_UNIQUE` (`token` ASC),
  FOREIGN KEY (`userId`)
    REFERENCES `disney`.`user` (`userId`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `disney`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `disney`.`user` (
  `userId` INT NOT NULL AUTO_INCREMENT,
  `nickname` VARCHAR(45) NULL,
  `registerDate` TIMESTAMP NOT NULL,
  `level` INT NULL,
  PRIMARY KEY (`userId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `disney`.`missions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `disney`.`missions` (
  `missionId` INT NOT NULL AUTO_INCREMENT,
  `KEY` VARCHAR(50) NOT NULL,
  `status` INT NULL,
  `path` VARCHAR(45) NULL,
  `startDate` TIMESTAMP NOT NULL,
  `endDate` TIMESTAMP NULL,
  `userId` INT NOT NULL,
  PRIMARY KEY (`missionId`),
  INDEX `fk_missions_user1_idx` (`userId` ASC),
  CONSTRAINT `fk_missions_user1`
    FOREIGN KEY (`userId`)
    REFERENCES `disney`.`user` (`userId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `disney`.`phone`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `disney`.`phone` (
  `phoneNumber` VARCHAR(13) NOT NULL,
  `password` VARCHAR(100) NULL,
  `userId` INT NOT NULL,
  PRIMARY KEY (`phoneNumber`),
  UNIQUE INDEX `phoneNumber_UNIQUE` (`phoneNumber` ASC),
  INDEX `fk_phone_user1_idx` (`userId` ASC),
  UNIQUE INDEX `userId_UNIQUE` (`userId` ASC),
  CONSTRAINT `fk_phone_user1`
    FOREIGN KEY (`userId`)
    REFERENCES `disney`.`user` (`userId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `disney`.`task`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `disney`.`task` (
  `taskId` INT NOT NULL AUTO_INCREMENT,
  `type` VARCHAR(45) NULL,
  `description` VARCHAR(255) NULL,
  `status` INT NULL,
  `path` VARCHAR(50) NULL,
  `startDate` TIMESTAMP NOT NULL,
  `endDate` TIMESTAMP NULL,
  `missionId` INT NOT NULL,
  PRIMARY KEY (`taskId`),
  INDEX `fk_task_missions_idx` (`missionId` ASC),
  CONSTRAINT `fk_task_missions`
    FOREIGN KEY (`missionId`)
    REFERENCES `disney`.`missions` (`missionId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



CREATE TABLE IF NOT EXISTS `disney`.`config` (
  `data` VARCHAR(100) NOT NULL,
  `type` INT(1) NOT NULL)
  ENGINE = InnoDB;

#<!- these query will be change table structure.->
## replace token
INSERT INTO config VALUE("671606e1-c4c4-4d2a-b02f-ef3e422e341b", 0);
ALTER TABLE disney.missions ADD COLUMN email VARCHAR(255) AFTER status;
ALTER TABLE disney.task MODIFY path TEXT;
ALTER TABLE disney.task ADD COLUMN location TEXT AFTER path;
ALTER TABLE disney.user ADD COLUMN updateDate TIMESTAMP AFTER registerDate;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
