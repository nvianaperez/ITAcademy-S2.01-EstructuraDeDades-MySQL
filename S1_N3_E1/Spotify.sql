-- MySQL Workbench Synchronization
-- Generated: 2023-05-19 14:16
-- Model: New Model
-- Version: 1.0
-- Project: Name of the project
-- Author: Ideapad Gaming

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

CREATE SCHEMA IF NOT EXISTS `spotify` DEFAULT CHARACTER SET utf8 ;

CREATE TABLE IF NOT EXISTS `spotify`.`user` (
  `user_id` INT(11) NOT NULL AUTO_INCREMENT,
  `user_name` VARCHAR(45) NOT NULL DEFAULT 'guest',
  `user_email` VARCHAR(45) NOT NULL,
  `user_password` VARCHAR(45) NOT NULL,
  `user_dateOfBirth` DATE NULL DEFAULT NULL,
  `user_gender` ENUM("Male", "Female", "Not Answer") NULL DEFAULT 'Not Answer',
  `user_state` VARCHAR(45) NULL DEFAULT NULL,
  `user_zipCode` VARCHAR(5) NULL DEFAULT NULL,
  `user_category` ENUM("Free", "Premium") NOT NULL DEFAULT 'Free',
  PRIMARY KEY (`user_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `spotify`.`subscription` (
  `subscription_id` INT(11) NOT NULL AUTO_INCREMENT,
  `subscription_timeStamp` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(),
  `subscription_serviceRenewalDate` DATETIME NOT NULL,
  `subscription_methodPayment` ENUM("CreditCard", "Paypal") NOT NULL,
  `user_user_id` INT(11) NOT NULL,
  `paypal_paypal_id` INT(11) NOT NULL,
  `creditCard_creditCard_numberCreditCard_id` VARCHAR(16) NOT NULL,
  PRIMARY KEY (`subscription_id`, `user_user_id`),
  INDEX `subscription_user_fk_idx` (`user_user_id` ASC) VISIBLE,
  INDEX `subscription_paypal_fk1_idx` (`paypal_paypal_id` ASC) VISIBLE,
  INDEX `subscription_creditCard_fk1_idx` (`creditCard_creditCard_numberCreditCard_id` ASC) VISIBLE,
  CONSTRAINT `subscription_user_fk`
    FOREIGN KEY (`user_user_id`)
    REFERENCES `spotify`.`user` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `subscription_paypal_fk1`
    FOREIGN KEY (`paypal_paypal_id`)
    REFERENCES `spotify`.`paypal` (`paypal_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `subscription_creditCard_fk1`
    FOREIGN KEY (`creditCard_creditCard_numberCreditCard_id`)
    REFERENCES `spotify`.`creditCard` (`creditCard_numberCreditCard_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `spotify`.`creditCard` (
  `creditCard_numberCreditCard_id` VARCHAR(16) NOT NULL,
  `creditCard_expirationDate` DATE NOT NULL,
  `creditCard_securityCode` INT(11) NOT NULL,
  PRIMARY KEY (`creditCard_numberCreditCard_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `spotify`.`paypal` (
  `paypal_id` INT(11) NOT NULL AUTO_INCREMENT,
  `paypal_userName` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`paypal_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `spotify`.`payment` (
  `payment_orderNumber_id` INT(11) NOT NULL,
  `payment_timeStamp` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(),
  `payment_totalAmount` DOUBLE NOT NULL DEFAULT 0.0,
  `subscription_subscription_id` INT(11) NOT NULL,
  `subscription_user_user_id` INT(11) NOT NULL,
  PRIMARY KEY (`payment_orderNumber_id`, `subscription_subscription_id`, `subscription_user_user_id`),
  INDEX `payment_subscription_fk1_idx` (`subscription_subscription_id` ASC, `subscription_user_user_id` ASC) VISIBLE,
  CONSTRAINT `payment_subscription_fk1`
    FOREIGN KEY (`subscription_subscription_id` , `subscription_user_user_id`)
    REFERENCES `spotify`.`subscription` (`subscription_id` , `user_user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `spotify`.`activePlaylist` (
  `activePlaylist_id` INT(11) NOT NULL AUTO_INCREMENT,
  `activePlaylist_title` VARCHAR(45) NOT NULL,
  `activePlaylist_timeStamp` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(),
  `activePlaylist_numberOfSongs` INT(11) NULL DEFAULT NULL,
  `activePlaylist_isShared` ENUM("Yes", "No") NOT NULL DEFAULT 'No',
  `activePlaylist_dateOfShared` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`activePlaylist_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `spotify`.`deletedPlaylist` (
  `deletedPlaylist_id` INT(11) NOT NULL AUTO_INCREMENT,
  `deletedPlaylist_timeStamp` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(),
  `user_user_id` INT(11) NOT NULL,
  `activePlaylist_activePlaylist_id` INT(11) NOT NULL,
  PRIMARY KEY (`deletedPlaylist_id`, `user_user_id`, `activePlaylist_activePlaylist_id`),
  INDEX `deletedPlaylist_user_fk1_idx` (`user_user_id` ASC) VISIBLE,
  INDEX `deletedPlaylist_activePlaylist_fk1_idx` (`activePlaylist_activePlaylist_id` ASC) VISIBLE,
  CONSTRAINT `deletedPlaylist_user_fk1`
    FOREIGN KEY (`user_user_id`)
    REFERENCES `spotify`.`user` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `deletedPlaylist_activePlaylist_fk1`
    FOREIGN KEY (`activePlaylist_activePlaylist_id`)
    REFERENCES `spotify`.`activePlaylist` (`activePlaylist_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `spotify`.`user_has_activePlaylist` (
  `user_user_id` INT(11) NOT NULL,
  `activePlaylist_activePlaylist_id` INT(11) NOT NULL,
  PRIMARY KEY (`user_user_id`, `activePlaylist_activePlaylist_id`),
  INDEX `user_has_activePlaylist_activePlaylist_fk1_idx` (`activePlaylist_activePlaylist_id` ASC) VISIBLE,
  INDEX `user_has_activePlaylist_user_fk1_idx` (`user_user_id` ASC) VISIBLE,
  CONSTRAINT `user_has_activePlaylist_user_fk1`
    FOREIGN KEY (`user_user_id`)
    REFERENCES `spotify`.`user` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `user_has_activePlaylist_activePlaylist_fk1`
    FOREIGN KEY (`activePlaylist_activePlaylist_id`)
    REFERENCES `spotify`.`activePlaylist` (`activePlaylist_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `spotify`.`song` (
  `song_id` INT(11) NOT NULL AUTO_INCREMENT,
  `song_title` VARCHAR(45) NOT NULL,
  `song_length` TIME NOT NULL,
  `song_numberReproductions` INT(11) NOT NULL DEFAULT 0,
  `album_album_id` INT(11) NOT NULL,
  PRIMARY KEY (`song_id`, `album_album_id`),
  INDEX `song_album_fk1_idx` (`album_album_id` ASC) VISIBLE,
  CONSTRAINT `song_album_fk1`
    FOREIGN KEY (`album_album_id`)
    REFERENCES `spotify`.`album` (`album_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `spotify`.`album` (
  `album_id` INT(11) NOT NULL AUTO_INCREMENT,
  `album_title` VARCHAR(45) NOT NULL,
  `album_publishDate` YEAR NOT NULL,
  `album_thumbnail` BLOB NOT NULL,
  `artist_artist_id` INT(11) NOT NULL,
  PRIMARY KEY (`album_id`, `artist_artist_id`),
  INDEX `album_artist_fk1_idx` (`artist_artist_id` ASC) VISIBLE,
  CONSTRAINT `album_artist_fk1`
    FOREIGN KEY (`artist_artist_id`)
    REFERENCES `spotify`.`artist` (`artist_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `spotify`.`artist` (
  `artist_id` INT(11) NOT NULL AUTO_INCREMENT,
  `artist_name` VARCHAR(45) NOT NULL,
  `artist_thumbnail` BLOB NOT NULL,
  `musicGenre_musicGenre_id` INT(11) NOT NULL,
  PRIMARY KEY (`artist_id`),
  INDEX `artist_musicGenre_fk1_idx` (`musicGenre_musicGenre_id` ASC) VISIBLE,
  CONSTRAINT `artist_musicGenre_fk1`
    FOREIGN KEY (`musicGenre_musicGenre_id`)
    REFERENCES `spotify`.`musicGenre` (`musicGenre_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `spotify`.`musicGenre` (
  `musicGenre_id` INT(11) NOT NULL AUTO_INCREMENT,
  `musicGenre_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`musicGenre_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `spotify`.`activePlaylist_has_song` (
  `activePlaylist_activePlaylist_id` INT(11) NOT NULL,
  `song_song_id` INT(11) NOT NULL,
  PRIMARY KEY (`activePlaylist_activePlaylist_id`, `song_song_id`),
  INDEX `activePlaylist_has_song_song_fk1_idx` (`song_song_id` ASC) VISIBLE,
  INDEX `activePlaylist_has_song_activePlaylist_fk1_idx` (`activePlaylist_activePlaylist_id` ASC) VISIBLE,
  CONSTRAINT `activePlaylist_has_song_activePlaylist_fk1`
    FOREIGN KEY (`activePlaylist_activePlaylist_id`)
    REFERENCES `spotify`.`activePlaylist` (`activePlaylist_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `activePlaylist_has_song_song_fk1`
    FOREIGN KEY (`song_song_id`)
    REFERENCES `spotify`.`song` (`song_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `spotify`.`favouriteSong` (
  `favouriteSong_id` INT(11) NOT NULL AUTO_INCREMENT,
  `user_user_id` INT(11) NOT NULL,
  `song_song_id` INT(11) NOT NULL,
  `song_album_album_id` INT(11) NOT NULL,
  PRIMARY KEY (`favouriteSong_id`, `user_user_id`, `song_song_id`, `song_album_album_id`),
  INDEX `favouriteSong_user_fk1_idx` (`user_user_id` ASC) VISIBLE,
  INDEX `favouriteSong_song_fk1_idx` (`song_song_id` ASC, `song_album_album_id` ASC) VISIBLE,
  CONSTRAINT `favouriteSong_user_fk1`
    FOREIGN KEY (`user_user_id`)
    REFERENCES `spotify`.`user` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `favouriteSong_song_fk1`
    FOREIGN KEY (`song_song_id` , `song_album_album_id`)
    REFERENCES `spotify`.`song` (`song_id` , `album_album_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `spotify`.`favouriteArtist` (
  `favouriteArtist_id` INT(11) NOT NULL AUTO_INCREMENT,
  `user_user_id` INT(11) NOT NULL,
  `artist_artist_id` INT(11) NOT NULL,
  PRIMARY KEY (`favouriteArtist_id`, `user_user_id`, `artist_artist_id`),
  INDEX `favouriteArtist_user_fk1_idx` (`user_user_id` ASC) VISIBLE,
  INDEX `favouriteArtist_artist_fk1_idx` (`artist_artist_id` ASC) VISIBLE,
  CONSTRAINT `favouriteArtist_user_fk1`
    FOREIGN KEY (`user_user_id`)
    REFERENCES `spotify`.`user` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `favouriteArtist_artist_fk1`
    FOREIGN KEY (`artist_artist_id`)
    REFERENCES `spotify`.`artist` (`artist_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `spotify`.`favouriteAlbum` (
  `favouriteAlbum_id` INT(11) NOT NULL AUTO_INCREMENT,
  `user_user_id` INT(11) NOT NULL,
  `album_album_id` INT(11) NOT NULL,
  `album_artist_artist_id` INT(11) NOT NULL,
  PRIMARY KEY (`favouriteAlbum_id`, `user_user_id`, `album_album_id`, `album_artist_artist_id`),
  INDEX `favouriteAlbum_user_fk1_idx` (`user_user_id` ASC) VISIBLE,
  INDEX `favouriteAlbum_album_fk1_idx` (`album_album_id` ASC, `album_artist_artist_id` ASC) VISIBLE,
  CONSTRAINT `favouriteAlbum_user_fk1`
    FOREIGN KEY (`user_user_id`)
    REFERENCES `spotify`.`user` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `favouriteAlbum_album_fk1`
    FOREIGN KEY (`album_album_id` , `album_artist_artist_id`)
    REFERENCES `spotify`.`album` (`album_id` , `artist_artist_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
