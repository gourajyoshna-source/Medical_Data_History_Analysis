CREATE DATABASE IF NOT EXISTS project_movie_database;
USE project_movie_database;
CREATE TABLE `admissions` (
  `patient_id` int(11) NOT NULL,
  `admission_date` date NOT NULL,
  `discharge_date` date DEFAULT NULL,
  `diagnosis` varchar(50) DEFAULT NULL,
  `attending_doctor_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`patient_id`,`admission_date`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `doctors` (
  `doctor_id` int(11) NOT NULL,
  `first_name` varchar(130) DEFAULT NULL,
  `last_name` varchar(130) DEFAULT NULL,
  `specialty` varchar(125) DEFAULT NULL,
  PRIMARY KEY (`doctor_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `patients` (
  `patient_id` int(11) NOT NULL,
  `first_name` varchar(150) DEFAULT NULL,
  `last_name` varchar(150) DEFAULT NULL,
  `gender` char(1) DEFAULT NULL,
  `birth_date` date DEFAULT NULL,
  `city` varchar(150) DEFAULT NULL,
  `province_id` char(2) DEFAULT NULL,
  `allergies` varchar(150) DEFAULT NULL,
  `height` decimal(3,0) DEFAULT NULL,
  `weight` decimal(4,0) DEFAULT NULL,
  PRIMARY KEY (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `province_names` (
  `province_id` char(2) NOT NULL,
  `province_name` varchar(30) NOT NULL,
  PRIMARY KEY (`province_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;