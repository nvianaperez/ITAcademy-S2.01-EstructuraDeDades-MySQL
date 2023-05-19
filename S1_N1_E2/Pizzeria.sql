-- MySQL Script generated by MySQL Workbench
-- Thu May 18 11:29:13 2023
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `mydb` ;

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`district`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`district` (
  `district_id` INT NOT NULL AUTO_INCREMENT,
  `district_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`district_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`city`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`city` (
  `city_id` INT NOT NULL AUTO_INCREMENT,
  `city_name` VARCHAR(45) NOT NULL,
  `district_district_id` INT NOT NULL,
  PRIMARY KEY (`city_id`, `district_district_id`),
  INDEX `city_district_fk_idx` (`district_district_id` ASC) VISIBLE,
  CONSTRAINT `city_district_fk`
    FOREIGN KEY (`district_district_id`)
    REFERENCES `mydb`.`district` (`district_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`client`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`client` (
  `client_id` INT NOT NULL AUTO_INCREMENT,
  `client_name` VARCHAR(45) NOT NULL,
  `client_lastName` VARCHAR(45) NOT NULL,
  `client_address` VARCHAR(45) NOT NULL,
  `client_zipCode` VARCHAR(5) NOT NULL,
  `client_phone` VARCHAR(12) NOT NULL,
  `city_city_id` INT NOT NULL,
  `city_district_district_id` INT NOT NULL,
  PRIMARY KEY (`client_id`, `city_city_id`, `city_district_district_id`),
  INDEX `client_city_fk1_idx` (`city_city_id` ASC, `city_district_district_id` ASC) VISIBLE,
  CONSTRAINT `client_city_fk1`
    FOREIGN KEY (`city_city_id` , `city_district_district_id`)
    REFERENCES `mydb`.`city` (`city_id` , `district_district_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`category_Pizza`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`category_Pizza` (
  `category_Pizza_id` INT NOT NULL,
  `category_Pizza_name` VARCHAR(10) NOT NULL COMMENT 'Possible values, only for product_type P (pizza):\nV :  vegan\nPromo : promotional',
  PRIMARY KEY (`category_Pizza_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`product` (
  `product_id` INT NOT NULL AUTO_INCREMENT,
  `product_name` VARCHAR(45) NOT NULL,
  `product_type` ENUM("P", "H", "D") NOT NULL COMMENT 'Poosible values:\nP : pizza\nH : hamburguer\nD : drink',
  `product_description` VARCHAR(45) NULL COMMENT 'Values Enum:\nP : pizza\nH : hambuerguer\nD : drink',
  `product_photo` TINYBLOB NULL,
  `product_price` FLOAT NOT NULL,
  `category_Pizza_category_Pizza_id` INT NOT NULL,
  PRIMARY KEY (`product_id`, `category_Pizza_category_Pizza_id`),
  INDEX `product_category_Pizza_fk1_idx` (`category_Pizza_category_Pizza_id` ASC) VISIBLE,
  CONSTRAINT `product_category_Pizza_fk1`
    FOREIGN KEY (`category_Pizza_category_Pizza_id`)
    REFERENCES `mydb`.`category_Pizza` (`category_Pizza_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`shop`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`shop` (
  `shop_id` INT NOT NULL AUTO_INCREMENT,
  `shop_address` VARCHAR(45) NOT NULL,
  `shop_zipCode` VARCHAR(5) NOT NULL,
  `city_city_id` INT NOT NULL,
  `city_district_district_id` INT NOT NULL,
  PRIMARY KEY (`shop_id`, `city_city_id`, `city_district_district_id`),
  INDEX `shop_city_fk1_idx` (`city_city_id` ASC, `city_district_district_id` ASC) VISIBLE,
  CONSTRAINT `shop_city_fk1`
    FOREIGN KEY (`city_city_id` , `city_district_district_id`)
    REFERENCES `mydb`.`city` (`city_id` , `district_district_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`employee` (
  `employee_id` INT NOT NULL AUTO_INCREMENT,
  `employee_name` VARCHAR(45) NOT NULL,
  `employee_lastName` VARCHAR(45) NOT NULL,
  `employee_CIF` VARCHAR(12) NOT NULL,
  `employee_phone` VARCHAR(12) NOT NULL,
  `employee_type` ENUM("Cooker", "Deliver") NOT NULL,
  `shop_shop_id` INT NOT NULL,
  `shop_city_city_id` INT NOT NULL,
  `shop_city_district_district_id` INT NOT NULL,
  PRIMARY KEY (`employee_id`, `shop_shop_id`, `shop_city_city_id`, `shop_city_district_district_id`),
  INDEX `employee_shop_fk1_idx` (`shop_shop_id` ASC, `shop_city_city_id` ASC, `shop_city_district_district_id` ASC) VISIBLE,
  CONSTRAINT `employee_shop_fk1`
    FOREIGN KEY (`shop_shop_id` , `shop_city_city_id` , `shop_city_district_district_id`)
    REFERENCES `mydb`.`shop` (`shop_id` , `city_city_id` , `city_district_district_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`order` (
  `order_id` INT NOT NULL AUTO_INCREMENT,
  `order_timeStamp` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(),
  `order_type` ENUM("TakeAway", "DeliverHome") NOT NULL,
  `order_quantityPizza` INT NOT NULL,
  `order_quantityHambuguer` INT NOT NULL,
  `order_quantityDrink` INT NOT NULL,
  `order_totalPrice` FLOAT NOT NULL,
  `client_client_id` INT NOT NULL,
  `client_city_city_id` INT NOT NULL,
  `client_city_district_district_id` INT NOT NULL,
  PRIMARY KEY (`order_id`, `client_client_id`, `client_city_city_id`, `client_city_district_district_id`),
  INDEX `order_client_fk1_idx` (`client_client_id` ASC, `client_city_city_id` ASC, `client_city_district_district_id` ASC) VISIBLE,
  CONSTRAINT `order_client_fk1`
    FOREIGN KEY (`client_client_id` , `client_city_city_id` , `client_city_district_district_id`)
    REFERENCES `mydb`.`client` (`client_id` , `city_city_id` , `city_district_district_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`order_has_product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`order_has_product` (
  `order_order_id` INT NOT NULL,
  `order_client_client_id` INT NOT NULL,
  `order_client_city_city_id` INT NOT NULL,
  `order_client_city_district_district_id` INT NOT NULL,
  `product_product_id` INT NOT NULL,
  `product_category_Pizza_category_Pizza_id` INT NOT NULL,
  PRIMARY KEY (`order_order_id`, `order_client_client_id`, `order_client_city_city_id`, `order_client_city_district_district_id`, `product_product_id`, `product_category_Pizza_category_Pizza_id`),
  INDEX `order_has_product_product_fk1_idx` (`product_product_id` ASC, `product_category_Pizza_category_Pizza_id` ASC) VISIBLE,
  INDEX `order_has_product_order_fk1_idx` (`order_order_id` ASC, `order_client_client_id` ASC, `order_client_city_city_id` ASC, `order_client_city_district_district_id` ASC) VISIBLE,
  CONSTRAINT `order_has_product_order_fk1`
    FOREIGN KEY (`order_order_id` , `order_client_client_id` , `order_client_city_city_id` , `order_client_city_district_district_id`)
    REFERENCES `mydb`.`order` (`order_id` , `client_client_id` , `client_city_city_id` , `client_city_district_district_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `order_has_product_product_fk1`
    FOREIGN KEY (`product_product_id` , `product_category_Pizza_category_Pizza_id`)
    REFERENCES `mydb`.`product` (`product_id` , `category_Pizza_category_Pizza_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;