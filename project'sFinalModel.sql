-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema onlinetesting
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema onlinetesting
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `onlinetesting` DEFAULT CHARACTER SET utf8 ;
USE `onlinetesting` ;

-- -----------------------------------------------------
-- Table `onlinetesting`.`test`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `onlinetesting`.`test` (
  `testID` INT(11) NOT NULL,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`testID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `onlinetesting`.`question`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `onlinetesting`.`question` (
  `qid` INT(11) NOT NULL AUTO_INCREMENT,
  `text` VARCHAR(45) NULL DEFAULT NULL,
  `test_testID` INT(11) NOT NULL,
  PRIMARY KEY (`qid`, `test_testID`),
  INDEX `fk_question_test1_idx` (`test_testID` ASC),
  CONSTRAINT `fk_question_test1`
    FOREIGN KEY (`test_testID`)
    REFERENCES `onlinetesting`.`test` (`testID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `onlinetesting`.`answer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `onlinetesting`.`answer` (
  `aid` INT(11) NOT NULL AUTO_INCREMENT,
  `text` VARCHAR(100) NOT NULL,
  `correct` BINARY(1) NOT NULL,
  `question_qid` INT(11) NOT NULL,
  PRIMARY KEY (`aid`, `question_qid`),
  INDEX `fk_answer_question_idx` (`question_qid` ASC),
  CONSTRAINT `fk_answer_question`
    FOREIGN KEY (`question_qid`)
    REFERENCES `onlinetesting`.`question` (`qid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 12
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `onlinetesting`.`hr`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `onlinetesting`.`hr` (
  `uname` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`uname`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `onlinetesting`.`position`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `onlinetesting`.`position` (
  `pid` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  `dep` VARCHAR(45) NULL DEFAULT NULL,
  `hr_uname` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`pid`),
  INDEX `fk_position_hr1_idx` (`hr_uname` ASC),
  CONSTRAINT `fk_position_hr1`
    FOREIGN KEY (`hr_uname`)
    REFERENCES `onlinetesting`.`hr` (`uname`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `onlinetesting`.`candidate`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `onlinetesting`.`candidate` (
  `uname` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `phone` VARCHAR(45) NULL DEFAULT NULL,
  `position_pid` INT(11) NULL DEFAULT NULL,
  `new` TINYINT(1) NULL DEFAULT '1',
  `lastTest` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`uname`),
  INDEX `fk_candidate_position1_idx` (`position_pid` ASC),
  CONSTRAINT `fk_candidate_position1`
    FOREIGN KEY (`position_pid`)
    REFERENCES `onlinetesting`.`position` (`pid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `onlinetesting`.`candidatesolution`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `onlinetesting`.`candidatesolution` (
  `candidate_uname` VARCHAR(45) NOT NULL,
  `answer_aid` INT(11) NOT NULL,
  `question_qid` INT(11) NOT NULL,
  `test_testID` INT(11) NOT NULL,
  PRIMARY KEY (`candidate_uname`, `answer_aid`, `question_qid`, `test_testID`),
  INDEX `fk_candidatesolution_answer1_idx` (`answer_aid` ASC),
  INDEX `fk_candidatesolution_question1_idx` (`question_qid` ASC),
  INDEX `fk_candidatesolution_test1_idx` (`test_testID` ASC),
  CONSTRAINT `fk_candidatesolution_answer1`
    FOREIGN KEY (`answer_aid`)
    REFERENCES `onlinetesting`.`answer` (`aid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_candidatesolution_candidate1`
    FOREIGN KEY (`candidate_uname`)
    REFERENCES `onlinetesting`.`candidate` (`uname`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_candidatesolution_question1`
    FOREIGN KEY (`question_qid`)
    REFERENCES `onlinetesting`.`question` (`qid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_candidatesolution_test1`
    FOREIGN KEY (`test_testID`)
    REFERENCES `onlinetesting`.`test` (`testID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `onlinetesting`.`candidatetest`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `onlinetesting`.`candidatetest` (
  `candidate_uname` VARCHAR(45) NOT NULL,
  `test_testID` INT(11) NOT NULL,
  `sequence` INT(11) NULL DEFAULT NULL,
  `deadline` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`candidate_uname`, `test_testID`),
  INDEX `fk_candidate_has_test_test1_idx` (`test_testID` ASC),
  INDEX `fk_candidate_has_test_candidate1_idx` (`candidate_uname` ASC),
  CONSTRAINT `fk_candidate_has_test_candidate1`
    FOREIGN KEY (`candidate_uname`)
    REFERENCES `onlinetesting`.`candidate` (`uname`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_candidate_has_test_test1`
    FOREIGN KEY (`test_testID`)
    REFERENCES `onlinetesting`.`test` (`testID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
