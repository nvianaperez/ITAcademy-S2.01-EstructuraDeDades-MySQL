-- MySQL Workbench Synchronization
-- Generated: 2023-05-19 10:58
-- Model: New Model
-- Version: 1.0
-- Project: Name of the project
-- Author: Ideapad Gaming

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

ALTER SCHEMA `youtube`  DEFAULT CHARACTER SET utf8  DEFAULT COLLATE utf8_general_ci ;

ALTER TABLE `youtube`.`channel` 
DROP FOREIGN KEY `channel_user_fk1`;

ALTER TABLE `youtube`.`video` 
DROP FOREIGN KEY `video_channel_fk1`,
DROP FOREIGN KEY `video_user_fk1`;

ALTER TABLE `youtube`.`playlist` 
DROP FOREIGN KEY `playlist_user_fk1`;

ALTER TABLE `youtube`.`userFeedback_Video` 
DROP FOREIGN KEY `userFeedback_Video_user_fk1`,
DROP FOREIGN KEY `userFeedback_Video_video_fk1`;

ALTER TABLE `youtube`.`comments` 
DROP FOREIGN KEY `comments_user_fk1`;

ALTER TABLE `youtube`.`subscription` 
DROP FOREIGN KEY `channel_has_user_channel_fk`,
DROP FOREIGN KEY `channel_has_user_user_fk1`;

ALTER TABLE `youtube`.`video_has_tag` 
DROP FOREIGN KEY `video_has_tag_tag_fk1`;

ALTER TABLE `youtube`.`userFeedback_Comment` 
DROP FOREIGN KEY `userFeedback_Comment_comments_fk1`;

ALTER TABLE `youtube`.`playlist_has_video` 
DROP FOREIGN KEY `playlist_has_video_playlist_fk1`,
DROP FOREIGN KEY `playlist_has_video_video_fk1`;

ALTER TABLE `youtube`.`channel` 
CHARACTER SET = utf8 , COLLATE = utf8_general_ci ;

ALTER TABLE `youtube`.`user` 
CHARACTER SET = utf8 , COLLATE = utf8_general_ci ,
CHANGE COLUMN `user_gender` `user_gender` ENUM("M", "F", "I") NULL DEFAULT NULL COMMENT 'Possible values:\nM : masculine\nF : female\nI : does not want to answer' ;

ALTER TABLE `youtube`.`video` 
CHARACTER SET = utf8 , COLLATE = utf8_general_ci ,
CHANGE COLUMN `video_length` `video_length` TIME NOT NULL DEFAULT 0 ,
CHANGE COLUMN `video_visibility` `video_visibility` ENUM("Public", "Private", "Hidden") NOT NULL DEFAULT 'Private' ;

ALTER TABLE `youtube`.`tag` 
CHARACTER SET = utf8 , COLLATE = utf8_general_ci ;

ALTER TABLE `youtube`.`playlist` 
CHARACTER SET = utf8 , COLLATE = utf8_general_ci ,
CHANGE COLUMN `playlist_visibility` `playlist_visibility` ENUM("Public", "Private") NOT NULL DEFAULT 'Private' ;

ALTER TABLE `youtube`.`userFeedback_Video` 
CHARACTER SET = utf8 , COLLATE = utf8_general_ci ,
CHANGE COLUMN `userFeedback_feedbackVideo` `userFeedback_feedbackVideo` ENUM("Like", "Dislike") NOT NULL ;

ALTER TABLE `youtube`.`comments` 
CHARACTER SET = utf8 , COLLATE = utf8_general_ci ;

ALTER TABLE `youtube`.`subscription` 
CHARACTER SET = utf8 , COLLATE = utf8_general_ci ;

ALTER TABLE `youtube`.`video_has_tag` 
CHARACTER SET = utf8 , COLLATE = utf8_general_ci ;

ALTER TABLE `youtube`.`userFeedback_Comment` 
CHARACTER SET = utf8 , COLLATE = utf8_general_ci ,
CHANGE COLUMN `userFeedback_feedbackComment` `userFeedback_feedbackComment` ENUM("Like", "Dislike") NOT NULL ;

ALTER TABLE `youtube`.`playlist_has_video` 
CHARACTER SET = utf8 , COLLATE = utf8_general_ci ;

ALTER TABLE `youtube`.`channel` 
ADD CONSTRAINT `channel_user_fk1`
  FOREIGN KEY (`user_user_id`)
  REFERENCES `youtube`.`user` (`user_id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

ALTER TABLE `youtube`.`video` 
ADD CONSTRAINT `video_channel_fk1`
  FOREIGN KEY (`channel_channel_id`)
  REFERENCES `youtube`.`channel` (`channel_id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT `video_user_fk1`
  FOREIGN KEY (`user_user_id`)
  REFERENCES `youtube`.`user` (`user_id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

ALTER TABLE `youtube`.`playlist` 
ADD CONSTRAINT `playlist_user_fk1`
  FOREIGN KEY (`user_user_id`)
  REFERENCES `youtube`.`user` (`user_id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

ALTER TABLE `youtube`.`userFeedback_Video` 
ADD CONSTRAINT `userFeedback_Video_user_fk1`
  FOREIGN KEY (`user_user_id`)
  REFERENCES `youtube`.`user` (`user_id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT `userFeedback_Video_video_fk1`
  FOREIGN KEY (`video_video_id`)
  REFERENCES `youtube`.`video` (`video_id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

ALTER TABLE `youtube`.`comments` 
DROP FOREIGN KEY `comments_video_fk1`;

ALTER TABLE `youtube`.`comments` ADD CONSTRAINT `comments_video_fk1`
  FOREIGN KEY (`video_video_id`)
  REFERENCES `youtube`.`video` (`video_id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT `comments_user_fk1`
  FOREIGN KEY (`user_user_id`)
  REFERENCES `youtube`.`user` (`user_id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

ALTER TABLE `youtube`.`subscription` 
ADD CONSTRAINT `channel_has_user_channel_fk`
  FOREIGN KEY (`channel_channel_id`)
  REFERENCES `youtube`.`channel` (`channel_id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT `channel_has_user_user_fk1`
  FOREIGN KEY (`user_user_id`)
  REFERENCES `youtube`.`user` (`user_id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

ALTER TABLE `youtube`.`video_has_tag` 
DROP FOREIGN KEY `video_has_tag_video_fk1`;

ALTER TABLE `youtube`.`video_has_tag` ADD CONSTRAINT `video_has_tag_video_fk1`
  FOREIGN KEY (`video_video_id`)
  REFERENCES `youtube`.`video` (`video_id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT `video_has_tag_tag_fk1`
  FOREIGN KEY (`tag_tag_id`)
  REFERENCES `youtube`.`tag` (`tag_id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

ALTER TABLE `youtube`.`userFeedback_Comment` 
DROP FOREIGN KEY `userFeedback_Comment_user_fk1`;

ALTER TABLE `youtube`.`userFeedback_Comment` ADD CONSTRAINT `userFeedback_Comment_user_fk1`
  FOREIGN KEY (`user_user_id`)
  REFERENCES `youtube`.`user` (`user_id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT `userFeedback_Comment_comments_fk1`
  FOREIGN KEY (`comments_comments_id`)
  REFERENCES `youtube`.`comments` (`comments_id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

ALTER TABLE `youtube`.`playlist_has_video` 
ADD CONSTRAINT `playlist_has_video_playlist_fk1`
  FOREIGN KEY (`playlist_playlist_id`)
  REFERENCES `youtube`.`playlist` (`playlist_id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT `playlist_has_video_video_fk1`
  FOREIGN KEY (`video_video_id`)
  REFERENCES `youtube`.`video` (`video_id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
