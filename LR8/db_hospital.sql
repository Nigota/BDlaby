/*
Описание:
* Больничные палаты: номер, количество коек, отделение, занятые койки,
дата последнего обновления, гендер (мужская или женская)
* Врачи: идентификатор, ФИО, отделение
* Пациенты: идентификатор, ФИО, пол, номер полиса, дата поступления,
номер палаты, дата поступления, лечащий врач, диагноз, дата выписки.
*/

DROP DATABASE IF EXISTS Hospital;
CREATE DATABASE IF NOT EXISTS Hospital;

USE Hospital;

CREATE TABLE Room (
  roomID int PRIMARY KEY,
  number int,
  bedCnt int,
  department varchar(100),
  bedOccupiedCnt int,
  lastDate timestamp,
  gender boolean
);

CREATE TABLE Doctor (
  doctorID int PRIMARY KEY,
  fullName varchar(100),
  department varchar(100)
);

-- 0 - мужчина, 1 - женщина
CREATE TABLE Patient (
  patientID int PRIMARY KEY,
  fullName varchar(100),
  gender boolean,
  policy varchar(100),
  startTime timestamp,
  roomID int REFERENCES Room(roomID),
  doctorID int REFERENCES Doctor(doctorID),
  diagnosis varchar(100),
  endTime timestamp
);
