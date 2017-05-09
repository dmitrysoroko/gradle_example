drop database if EXISTS jobs;
create database jobs;
use jobs;
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema diplom
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `diplom` ;

-- -----------------------------------------------------
-- Schema diplom
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `diplom` DEFAULT CHARACTER SET utf8 ;
USE `diplom` ;

-- -----------------------------------------------------
-- Table `diplom`.`role`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `diplom`.`role` ;

CREATE TABLE IF NOT EXISTS `diplom`.`role` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `diplom`.`country`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `diplom`.`country` ;

CREATE TABLE IF NOT EXISTS `diplom`.`country` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `diplom`.`city`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `diplom`.`city` ;

CREATE TABLE IF NOT EXISTS `diplom`.`city` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `country_id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_city_country1_idx` (`country_id` ASC),
  CONSTRAINT `fk_city_country1`
    FOREIGN KEY (`country_id`)
    REFERENCES `diplom`.`country` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `diplom`.`user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `diplom`.`user` ;

CREATE TABLE IF NOT EXISTS `diplom`.`user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `role_id` INT NOT NULL,
  `city_id` INT,
  `name` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_user_role_idx` (`role_id` ASC),
  INDEX `fk_user_city1_idx` (`city_id` ASC),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC),
  CONSTRAINT `fk_user_role`
    FOREIGN KEY (`role_id`)
    REFERENCES `diplom`.`role` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_city1`
    FOREIGN KEY (`city_id`)
    REFERENCES `diplom`.`city` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `diplom`.`employee`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `diplom`.`employee` ;

CREATE TABLE IF NOT EXISTS `diplom`.`employee` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `firstname` VARCHAR(45) NOT NULL,
  `middlename` VARCHAR(45) NOT NULL,
  `lastname` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_employee_user1_idx` (`user_id` ASC),
  UNIQUE INDEX `user_id_UNIQUE` (`user_id` ASC),
  CONSTRAINT `fk_employee_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `diplom`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `diplom`.`employer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `diplom`.`employer` ;

CREATE TABLE IF NOT EXISTS `diplom`.`employer` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_employer_user1_idx` (`user_id` ASC),
  UNIQUE INDEX `user_id_UNIQUE` (`user_id` ASC),
  CONSTRAINT `fk_employer_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `diplom`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `diplom`.`contact`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `diplom`.`contact` ;

CREATE TABLE IF NOT EXISTS `diplom`.`contact` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `phone` VARCHAR(45) NULL,
  `website` VARCHAR(45) NULL,
  `address` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_contact_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_contact_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `diplom`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `diplom`.`vacancy`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `diplom`.`vacancy` ;

CREATE TABLE IF NOT EXISTS `diplom`.`vacancy` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `employer_id` INT NOT NULL,
  `title` VARCHAR(45) NOT NULL,
  `description` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_vacancy_employer1_idx` (`employer_id` ASC),
  CONSTRAINT `fk_vacancy_employer1`
    FOREIGN KEY (`employer_id`)
    REFERENCES `diplom`.`employer` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `diplom`.`message_list`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `diplom`.`message_list` ;

CREATE TABLE IF NOT EXISTS `diplom`.`message_list` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `reciever_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_message_list_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_message_list_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `diplom`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `diplom`.`message`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `diplom`.`message` ;

CREATE TABLE IF NOT EXISTS `diplom`.`message` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `message_list_id` INT NOT NULL,
  `text` VARCHAR(45) NOT NULL,
  `date` DATE NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_message_message_list1_idx` (`message_list_id` ASC),
  CONSTRAINT `fk_message_message_list1`
    FOREIGN KEY (`message_list_id`)
    REFERENCES `diplom`.`message_list` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `diplom`.`schedule`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `diplom`.`schedule` ;

CREATE TABLE IF NOT EXISTS `diplom`.`schedule` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `type` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `diplom`.`resume`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `diplom`.`resume` ;

CREATE TABLE IF NOT EXISTS `diplom`.`resume` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `employee_id` INT NOT NULL,
  `schedule_id` INT NOT NULL,
  `title` VARCHAR(45) NOT NULL,
  `description` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_resume_employee1_idx` (`employee_id` ASC),
  INDEX `fk_resume_schedule1_idx` (`schedule_id` ASC),
  CONSTRAINT `fk_resume_employee1`
    FOREIGN KEY (`employee_id`)
    REFERENCES `diplom`.`employee` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_resume_schedule1`
    FOREIGN KEY (`schedule_id`)
    REFERENCES `diplom`.`schedule` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `diplom`.`language`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `diplom`.`language` ;

CREATE TABLE IF NOT EXISTS `diplom`.`language` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `diplom`.`language_has_resume`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `diplom`.`language_has_resume` ;

CREATE TABLE IF NOT EXISTS `diplom`.`language_has_resume` (
  `language_id` INT NOT NULL,
  `resume_id` INT NOT NULL,
  PRIMARY KEY (`language_id`, `resume_id`),
  INDEX `fk_language_has_resume_resume1_idx` (`resume_id` ASC),
  INDEX `fk_language_has_resume_language1_idx` (`language_id` ASC),
  CONSTRAINT `fk_language_has_resume_language1`
    FOREIGN KEY (`language_id`)
    REFERENCES `diplom`.`language` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_language_has_resume_resume1`
    FOREIGN KEY (`resume_id`)
    REFERENCES `diplom`.`resume` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `diplom`.`experience`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `diplom`.`experience` ;

CREATE TABLE IF NOT EXISTS `diplom`.`experience` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `employee_id` INT NOT NULL,
  `company` VARCHAR(45) NOT NULL,
  `position` VARCHAR(45) NOT NULL,
  `begin_date` DATE NOT NULL,
  `end_date` DATE NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_expirience_employee1_idx` (`employee_id` ASC),
  CONSTRAINT `fk_expirience_employee1`
    FOREIGN KEY (`employee_id`)
    REFERENCES `diplom`.`employee` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `diplom`.`skill`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `diplom`.`skill` ;

CREATE TABLE IF NOT EXISTS `diplom`.`skill` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `diplom`.`employee_has_skill`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `diplom`.`employee_has_skill` ;

CREATE TABLE IF NOT EXISTS `diplom`.`employee_has_skill` (
  `employee_id` INT NOT NULL,
  `skill_id` INT NOT NULL,
  PRIMARY KEY (`employee_id`, `skill_id`),
  INDEX `fk_employee_has_skill_skill1_idx` (`skill_id` ASC),
  INDEX `fk_employee_has_skill_employee1_idx` (`employee_id` ASC),
  CONSTRAINT `fk_employee_has_skill_employee1`
    FOREIGN KEY (`employee_id`)
    REFERENCES `diplom`.`employee` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_employee_has_skill_skill1`
    FOREIGN KEY (`skill_id`)
    REFERENCES `diplom`.`skill` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `diplom`.`institution`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `diplom`.`institution` ;

CREATE TABLE IF NOT EXISTS `diplom`.`institution` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `diplom`.`education`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `diplom`.`education` ;

CREATE TABLE IF NOT EXISTS `diplom`.`education` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `employee_id` INT NOT NULL,
  `institution_id` INT NOT NULL,
  `end_year` DATE NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_education_employee1_idx` (`employee_id` ASC),
  INDEX `fk_education_institution1_idx` (`institution_id` ASC),
  CONSTRAINT `fk_education_employee1`
    FOREIGN KEY (`employee_id`)
    REFERENCES `diplom`.`employee` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_education_institution1`
    FOREIGN KEY (`institution_id`)
    REFERENCES `diplom`.`institution` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `diplom`.`department`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `diplom`.`department` ;

CREATE TABLE IF NOT EXISTS `diplom`.`department` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `institution_id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_department_institution1_idx` (`institution_id` ASC),
  CONSTRAINT `fk_department_institution1`
    FOREIGN KEY (`institution_id`)
    REFERENCES `diplom`.`institution` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `diplom`.`specialization`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `diplom`.`specialization` ;

CREATE TABLE IF NOT EXISTS `diplom`.`specialization` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `department_id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_specialization_department1_idx` (`department_id` ASC),
  CONSTRAINT `fk_specialization_department1`
    FOREIGN KEY (`department_id`)
    REFERENCES `diplom`.`department` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
