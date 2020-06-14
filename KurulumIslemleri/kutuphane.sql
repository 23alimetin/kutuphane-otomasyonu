/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 100113
Source Host           : localhost:3306
Source Database       : kutuphane

Target Server Type    : MYSQL
Target Server Version : 100113
File Encoding         : 65001

Date: 2016-07-18 11:33:52
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for kategoriler
-- ----------------------------
DROP TABLE IF EXISTS `kategoriler`;
CREATE TABLE `kategoriler` (
  `kategori_id` int(11) NOT NULL AUTO_INCREMENT,
  `kategori_adi` varchar(255) CHARACTER SET utf8 COLLATE utf8_turkish_ci DEFAULT NULL,
  `stand_no` varchar(50) DEFAULT NULL,
  `stand_adres` varchar(255) CHARACTER SET utf8 COLLATE utf8_turkish_ci DEFAULT NULL,
  PRIMARY KEY (`kategori_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of kategoriler
-- ----------------------------
INSERT INTO `kategoriler` VALUES ('1', 'Fantastik', '2', 'A kat?, B blok, D holü');
INSERT INTO `kategoriler` VALUES ('4', 'asdas', 'asdas', 'dddd');
INSERT INTO `kategoriler` VALUES ('5', '', '', '');

-- ----------------------------
-- Table structure for kitaplar
-- ----------------------------
DROP TABLE IF EXISTS `kitaplar`;
CREATE TABLE `kitaplar` (
  `kitap_id` int(11) NOT NULL AUTO_INCREMENT,
  `kategori_id` int(11) NOT NULL,
  `kitap_adi` varchar(255) CHARACTER SET utf8 COLLATE utf8_turkish_ci DEFAULT NULL,
  `yazari` varchar(255) CHARACTER SET utf8 COLLATE utf8_turkish_ci DEFAULT NULL,
  `dili` varchar(255) CHARACTER SET utf8 COLLATE utf8_turkish_ci DEFAULT NULL,
  `yayinevi` varchar(255) CHARACTER SET utf8 COLLATE utf8_turkish_ci DEFAULT NULL,
  `raf_no` int(11) DEFAULT NULL,
  `aciklama` varchar(255) CHARACTER SET utf8 COLLATE utf8_turkish_ci DEFAULT NULL,
  PRIMARY KEY (`kitap_id`,`kategori_id`),
  KEY `fk_kategori` (`kategori_id`) USING BTREE,
  CONSTRAINT `fk_kategori` FOREIGN KEY (`kategori_id`) REFERENCES `kategoriler` (`kategori_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of kitaplar
-- ----------------------------
INSERT INTO `kitaplar` VALUES ('1', '1', 'Harry Potter ve Azkaban Tutsa??', 'J. K. Rowling', 'Türkçe', 'YKY', '3', 'Sihirbaz  Harry Potter?n maceras? 3.kitapta devam ediyor.');
INSERT INTO `kitaplar` VALUES ('6', '1', 'Game of Thrones', 'George R. R. Martin', 'Türkçe', 'YKY', '9', '	Ejdarhalar Falan');

-- ----------------------------
-- Table structure for kullanicilar
-- ----------------------------
DROP TABLE IF EXISTS `kullanicilar`;
CREATE TABLE `kullanicilar` (
  `kullanici_id` int(11) NOT NULL,
  `kullanici_adi` varchar(255) DEFAULT NULL,
  `sifre` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`kullanici_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of kullanicilar
-- ----------------------------
INSERT INTO `kullanicilar` VALUES ('0', 'emir', '1', null);

-- ----------------------------
-- Procedure structure for fncKategoriAra
-- ----------------------------
DROP PROCEDURE IF EXISTS `fncKategoriAra`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `fncKategoriAra`(IN `ara` varchar(255))
BEGIN
	
	select * from kategoriler where kategori_adi like CONCAT('%',ara,'%');

END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for fncKategoriEkle
-- ----------------------------
DROP PROCEDURE IF EXISTS `fncKategoriEkle`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `fncKategoriEkle`(IN `adi` varchar(255),IN `stno` varchar(255),IN `adres` varchar(255))
BEGIN
	
	INSERT INTO kategoriler VALUES(null,adi,stno,adres);

END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for fncKitapAra
-- ----------------------------
DROP PROCEDURE IF EXISTS `fncKitapAra`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `fncKitapAra`(IN `ara` varchar(255))
BEGIN

	select * from kitaplar left join kategoriler on kitaplar.kategori_id=kategoriler.kategori_id where kitap_adi like CONCAT('%',ara,'%');

END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for fncKitapEkle
-- ----------------------------
DROP PROCEDURE IF EXISTS `fncKitapEkle`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `fncKitapEkle`(IN `adi` varchar(255),IN `yazar` varchar(255),IN `kateg` int(11),IN `dil` varchar(255),IN `yevi` varchar(255),IN `raf` int(11),IN `acik` varchar(255))
BEGIN
	INSERT into kitaplar values(NUll,kateg,adi,yazar,dil,yevi,raf,acik);
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for fncKitapSil
-- ----------------------------
DROP PROCEDURE IF EXISTS `fncKitapSil`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `fncKitapSil`(IN `kid` int(11))
BEGIN

	Delete from kitaplar where kitap_id = kid;

END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for fncUpdateKategori
-- ----------------------------
DROP PROCEDURE IF EXISTS `fncUpdateKategori`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `fncUpdateKategori`(IN `adi` varchar(255),IN `stno` varchar(255),IN `stadr` varchar(255),IN `kid` int(11))
BEGIN
	
	Update kategoriler set kategori_adi=adi,stand_no=stno,stand_adres=stadr where kategori_id=kid;

END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for fncUpdateKitap
-- ----------------------------
DROP PROCEDURE IF EXISTS `fncUpdateKitap`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `fncUpdateKitap`(IN `adi` varchar(255),IN `yazar` varchar(255),IN `kateg` int(11),IN `dil` varchar(255),IN `yevi` varchar(255),IN `raf` int(11),IN `acik` varchar(255),IN `kid` int(11))
BEGIN
	
	update kitaplar set kitap_adi=adi , yazari=yazar , kategori_id=kateg , dili = dil , yayinevi = yevi , raf_no=raf , aciklama=acik where kitap_id=kid;

END
;;
DELIMITER ;
