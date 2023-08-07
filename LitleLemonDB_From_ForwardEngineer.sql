-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema LittleLemonDB
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `LittleLemonDB` ;

-- -----------------------------------------------------
-- Schema LittleLemonDB
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `LittleLemonDB` DEFAULT CHARACTER SET utf8 ;
USE `LittleLemonDB` ;

-- -----------------------------------------------------
-- Table `LittleLemonDB`.`ContactDetails`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LittleLemonDB`.`ContactDetails` ;

CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`ContactDetails` (
  `ContactDetailsID` INT NOT NULL AUTO_INCREMENT,
  `FirstName` VARCHAR(45) NULL,
  `LastName` VARCHAR(45) NULL,
  `PhoneNumber` VARCHAR(45) NULL,
  `Address` VARCHAR(255) NULL,
  `Email` VARCHAR(100) NULL,
  `isStaff` TINYINT NULL DEFAULT 0 COMMENT '\n',
  UNIQUE INDEX `idContact Details_UNIQUE` (`ContactDetailsID` ASC) VISIBLE,
  PRIMARY KEY (`ContactDetailsID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Staff`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LittleLemonDB`.`Staff` ;

CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Staff` (
  `StaffID` INT NOT NULL AUTO_INCREMENT,
  `Role` VARCHAR(45) NOT NULL,
  `Salary` INT NOT NULL,
  `ContactDetails` INT NOT NULL,
  PRIMARY KEY (`StaffID`),
  UNIQUE INDEX `StaffID_UNIQUE` (`StaffID` ASC) VISIBLE,
  INDEX `fk_Staff_ContactDetails1_idx` (`ContactDetails` ASC) VISIBLE,
  CONSTRAINT `fk_Staff_ContactDetails1`
    FOREIGN KEY (`ContactDetails`)
    REFERENCES `LittleLemonDB`.`ContactDetails` (`ContactDetailsID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Customers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LittleLemonDB`.`Customers` ;

CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Customers` (
  `CustomerID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `ContactDetails` INT NOT NULL,
  PRIMARY KEY (`CustomerID`),
  INDEX `fk_Customers_ContactDetails1_idx` (`ContactDetails` ASC) VISIBLE,
  UNIQUE INDEX `CustomerID_UNIQUE` (`CustomerID` ASC) VISIBLE,
  CONSTRAINT `fk_Customers_ContactDetails1`
    FOREIGN KEY (`ContactDetails`)
    REFERENCES `LittleLemonDB`.`ContactDetails` (`ContactDetailsID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Bookings`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LittleLemonDB`.`Bookings` ;

CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Bookings` (
  `BookingID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `TableSlot` INT NULL,
  `Customers` INT UNSIGNED NULL,
  `Staff` INT NULL,
  `BookingDate` DATE NULL,
  PRIMARY KEY (`BookingID`),
  INDEX `fk_Bookings_Customers1_idx` (`Customers` ASC) VISIBLE,
  INDEX `fk_Bookings_Staff1_idx` (`Staff` ASC) VISIBLE,
  CONSTRAINT `fk_Bookings_Customers1`
    FOREIGN KEY (`Customers`)
    REFERENCES `LittleLemonDB`.`Customers` (`CustomerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Bookings_Staff1`
    FOREIGN KEY (`Staff`)
    REFERENCES `LittleLemonDB`.`Staff` (`StaffID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`OrderDeliveryStatus`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LittleLemonDB`.`OrderDeliveryStatus` ;

CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`OrderDeliveryStatus` (
  `OrderStatusID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `Status` VARCHAR(45) NULL,
  `Date` DATE NULL,
  PRIMARY KEY (`OrderStatusID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Orders`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LittleLemonDB`.`Orders` ;

CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Orders` (
  `OrderID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `Date` DATE NULL,
  `TotalPrice` DECIMAL(10,2) NULL,
  `Customer` INT UNSIGNED NOT NULL,
  `Booking` INT UNSIGNED NULL,
  `OrderDeliveryStatus` INT UNSIGNED NULL,
  PRIMARY KEY (`OrderID`),
  INDEX `fk_Orders_Customers1_idx` (`Customer` ASC) VISIBLE,
  INDEX `fk_Orders_Bookings1_idx` (`Booking` ASC) VISIBLE,
  INDEX `fk_Orders_OrderDeliveryStatus1_idx` (`OrderDeliveryStatus` ASC) VISIBLE,
  CONSTRAINT `fk_Orders_Customers1`
    FOREIGN KEY (`Customer`)
    REFERENCES `LittleLemonDB`.`Customers` (`CustomerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Orders_Bookings1`
    FOREIGN KEY (`Booking`)
    REFERENCES `LittleLemonDB`.`Bookings` (`BookingID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Orders_OrderDeliveryStatus1`
    FOREIGN KEY (`OrderDeliveryStatus`)
    REFERENCES `LittleLemonDB`.`OrderDeliveryStatus` (`OrderStatusID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Menu`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LittleLemonDB`.`Menu` ;

CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Menu` (
  `MenuItemID` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(45) NULL,
  `Category` VARCHAR(45) NULL,
  `Price` DECIMAL(10,2) NULL,
  PRIMARY KEY (`MenuItemID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`OrderItem`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LittleLemonDB`.`OrderItem` ;

CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`OrderItem` (
  `OrderItemID` INT NOT NULL AUTO_INCREMENT,
  `Quantity` INT NOT NULL,
  `MenuItem` INT NOT NULL,
  `OrderID` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`OrderItemID`),
  INDEX `fk_OrderItem_Menu1_idx` (`MenuItem` ASC) VISIBLE,
  INDEX `fk_OrderItem_Orders1_idx` (`OrderID` ASC) VISIBLE,
  CONSTRAINT `fk_OrderItem_Menu1`
    FOREIGN KEY (`MenuItem`)
    REFERENCES `LittleLemonDB`.`Menu` (`MenuItemID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_OrderItem_Orders1`
    FOREIGN KEY (`OrderID`)
    REFERENCES `LittleLemonDB`.`Orders` (`OrderID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
