﻿CREATE DATABASE PLANE_TICKET
GO

USE PLANE_TICKET
GO

SET DATEFORMAT DMY
GO

CREATE TABLE SANBAY
(
	MASANBAY VARCHAR(10) PRIMARY KEY,
	TENSANBAY NVARCHAR(100) NOT NULL,
	TENTHANHPHO NVARCHAR(50) NOT NULL
)
GO

CREATE TABLE MAYBAY
(
	MAMAYBAY VARCHAR(10) PRIMARY KEY,
	TENMAYBAY NVARCHAR(100) NOT NULL,
	SOLUONGGHE INT NOT NULL
)
GO

CREATE TABLE TUYENBAY
(
	MATUYENBAY VARCHAR(10) PRIMARY KEY,
	MASANBAYDI VARCHAR(10) NOT NULL,
	MASANBAYDEN VARCHAR(10) NOT NULL,
	CONSTRAINT UQ_TUYENBAY UNIQUE(MASANBAYDI,MASANBAYDEN)
)
GO

CREATE TABLE CHUYENBAY
(
	MACHUYENBAY VARCHAR(10) PRIMARY KEY,
	MATUYENBAY VARCHAR(10) NOT NULL,
	MAMAYBAY VARCHAR(10) NOT NULL,
	THOIGIANKHOIHANH DATETIME NOT NULL,
	THOIGIANBAY FLOAT NOT NULL
	CONSTRAINT FK_CHUYENBAY_TUYENBAY FOREIGN KEY(MATUYENBAY) REFERENCES TUYENBAY(MATUYENBAY),
	CONSTRAINT FK_CHUYENBAY_MAYBAY FOREIGN KEY(MAMAYBAY) REFERENCES MAYBAY(MAMAYBAY)
)
GO

CREATE TABLE CTCHUYENBAY
(
	MACHUYENBAY VARCHAR(10),
	MASANBAYTG VARCHAR(10),
	THOIGIANDUNG FLOAT NOT NULL,
	GHICHU NVARCHAR(100)
	CONSTRAINT PK_CTCHUYENBAY PRIMARY KEY(MACHUYENBAY, MASANBAYTG),
	CONSTRAINT FK_CTCHUYENBAY_CHUYENBAY FOREIGN KEY(MACHUYENBAY) REFERENCES CHUYENBAY(MACHUYENBAY),
)

CREATE TABLE HANGVE
(
	MAHANGVE VARCHAR(10) PRIMARY KEY,
	TENHANGVE NVARCHAR(20) NOT NULL UNIQUE
)
GO



CREATE TABLE DONGIA
(
	MATUYENBAY VARCHAR(10),
	MAHANGVE VARCHAR(10),
	DONGIA DECIMAL NOT NULL
	CONSTRAINT PK_DONGIA PRIMARY KEY(MATUYENBAY, MAHANGVE)
	CONSTRAINT FK_DONGIA_TUYENBAY FOREIGN KEY(MATUYENBAY) REFERENCES TUYENBAY(MATUYENBAY),
	CONSTRAINT FK_DONGIA_HANGVE FOREIGN KEY(MAHANGVE) REFERENCES HANGVE(MAHANGVE)
)

CREATE TABLE TINHTRANGVE
(
	MACHUYENBAY VARCHAR(10),
	MAHANGVE VARCHAR(10),
	TONGSOGHE INT NOT NULL,
	SOGHETRONG INT NOT NULL,
	CONSTRAINT PK_TINHTRANGVE PRIMARY KEY(MACHUYENBAY, MAHANGVE),
	CONSTRAINT FK_TINHTRANGVE_CHUYENBAY FOREIGN KEY(MACHUYENBAY) REFERENCES CHUYENBAY(MACHUYENBAY),
	CONSTRAINT FK_TINHTRANGVE_HANGVE FOREIGN KEY(MAHANGVE) REFERENCES HANGVE(MAHANGVE)
)

CREATE TABLE KHACHHANG
(
	MAKHACHHANG VARCHAR(10) PRIMARY KEY,
	TENKHACHHANG NVARCHAR(100) NOT NULL,
	CMND NVARCHAR(20) NOT NULL UNIQUE,
	SDT NVARCHAR(15)
)
GO

CREATE TABLE NHANVIEN
(
	MANHANVIEN VARCHAR(10) PRIMARY KEY,
	TENNHANVIEN NVARCHAR(100) NOT NULL
)
GO

CREATE TABLE DOANHTHUNAM
(
	NAM VARCHAR(5) PRIMARY KEY,
	DOANHTHU DECIMAL NOT NULL
)
GO

CREATE TABLE DOANHTHUTHANG
(
	THANG VARCHAR(3),
	NAM VARCHAR(5),
	SOCHUYENBAY INT NOT NULL,
	DOANHTHU DECIMAL NOT NULL
	CONSTRAINT PK_DOANHTHUTHANG PRIMARY KEY(THANG,NAM),
	CONSTRAINT FK_DOANHTHUTHANG_DOANHTHUNAM FOREIGN KEY(NAM) REFERENCES DOANHTHUNAM(NAM)
)
GO

CREATE TABLE CTDOANHTHUTHANG
(
	THANG VARCHAR(3),
	NAM VARCHAR(5),
	MACHUYENBAY VARCHAR(10),
	SOVEBANDUOC INT NOT NULL,
	DOANHTHU DECIMAL NOT NULL
	CONSTRAINT PK_CTDOANHTHUTHANG PRIMARY KEY(THANG, NAM, MACHUYENBAY),
	CONSTRAINT FK_CTDOANHTHUTHANG_DOANHTHUTHANG FOREIGN KEY(THANG, NAM) REFERENCES DOANHTHUTHANG(THANG, NAM),
	CONSTRAINT FK_CTDOANHTHUTHANG_CHUYENBAY FOREIGN KEY(MACHUYENBAY) REFERENCES CHUYENBAY(MACHUYENBAY)
)
GO

CREATE TABLE THAMSO
(
	THOIGIANBAYTOITHIEU FLOAT,
	SOSANBAYTGTOIDA INT,
	THOIGIANDUNGTOITHIEU FLOAT,
	THOIGIANDUNGTOIDA FLOAT,
	TGCHAMNHATDATVE INT,
	TGCHAMNHATHUYDATVE INT
)
GO

CREATE TABLE VECHUYENBAY
(
	MAVE VARCHAR(10) PRIMARY KEY,
	MAKHACHHANG VARCHAR(10),
	MACHUYENBAY VARCHAR(10),
	MAHANGVE VARCHAR(10) NOT NULL,
	GIATIEN DECIMAL NOT NULL,
	NGAYHUY DATE,
	MANHANVIEN VARCHAR(10),
	NGAYGIOGD DATETIME,
	LOAIVE NVARCHAR(20)
	CONSTRAINT FK_VECHUYENBAY_KHACHHANG FOREIGN KEY(MAKHACHHANG) REFERENCES KHACHHANG(MAKHACHHANG),
	CONSTRAINT FK_VECHUYENBAY_CHUYENBAY FOREIGN KEY(MACHUYENBAY) REFERENCES CHUYENBAY(MACHUYENBAY),
	CONSTRAINT FK_VECHUYENBAY_HANGVE FOREIGN KEY(MAHANGVE) REFERENCES HANGVE(MAHANGVE),
	CONSTRAINT FK_VECHUYENBAY_NHANVIEN FOREIGN KEY(MANHANVIEN) REFERENCES NHANVIEN(MANHANVIEN)
)
GO 

CREATE TABLE ACCOUNT
(
	USERNAME VARCHAR(20) PRIMARY KEY,
	PASSWORD VARCHAR(10) NOT NULL,
	MANHANVIEN VARCHAR(10) NOT NULL,
	TYPE INT NOT NULL
	CONSTRAINT FK_ACCOUNT_NHANVIEN FOREIGN KEY(MANHANVIEN) REFERENCES NHANVIEN(MANHANVIEN)
)
GO
--------------------------------------------TRIGGER---------------------------------------------------

CREATE TRIGGER INSERT_DOANHTHUNAM_WHEN_INSERT_CHUYENBAY
ON CHUYENBAY
FOR INSERT
AS
BEGIN
	DECLARE @NAM VARCHAR(5)= (SELECT YEAR(THOIGIANKHOIHANH) FROM INSERTED)
	DECLARE @COUNT INT = (SELECT COUNT(*) FROM DOANHTHUNAM WHERE NAM=@NAM)
	IF(@COUNT=0)
	BEGIN
		INSERT INTO DOANHTHUNAM(NAM, DOANHTHU) VALUES(@NAM, 0)
	END
END
GO

CREATE TRIGGER INSERT_DOANHTHUNAM_WHEN_UPDATE_CHUYENBAY
ON CHUYENBAY
FOR UPDATE
AS
BEGIN
	DECLARE @NAM VARCHAR(5)= (SELECT YEAR(THOIGIANKHOIHANH) FROM INSERTED)
	DECLARE @COUNT INT = (SELECT COUNT(*) FROM DOANHTHUNAM WHERE NAM=@NAM)
	IF(@COUNT=0)
	BEGIN
		INSERT INTO DOANHTHUNAM(NAM, DOANHTHU) VALUES(@NAM, 0)
	END
END
GO

CREATE TRIGGER INSERT_DOANHTHUTHANG_WHEN_INSERT_CHUYENBAY
ON CHUYENBAY
FOR INSERT
AS
BEGIN
	DECLARE @NAM VARCHAR(5)= (SELECT YEAR(THOIGIANKHOIHANH) FROM INSERTED)
	DECLARE @THANG VARCHAR(5)= (SELECT MONTH(THOIGIANKHOIHANH) FROM INSERTED)
	DECLARE @COUNT INT = (SELECT COUNT(*) FROM DOANHTHUTHANG WHERE NAM=@NAM AND THANG=@THANG)
	IF(@COUNT=0)
	BEGIN
		INSERT INTO DOANHTHUTHANG(THANG, NAM, SOCHUYENBAY, DOANHTHU) VALUES(@THANG, @NAM, 0, 0)
	END
END
GO

CREATE TRIGGER INSERT_DOANHTHUTHANG_WHEN_UPDATE_CHUYENBAY
ON CHUYENBAY
FOR UPDATE
AS
BEGIN
	DECLARE @NAM VARCHAR(5)= (SELECT YEAR(THOIGIANKHOIHANH) FROM INSERTED)
	DECLARE @THANG VARCHAR(5)= (SELECT MONTH(THOIGIANKHOIHANH) FROM INSERTED)
	DECLARE @COUNT INT = (SELECT COUNT(*) FROM DOANHTHUTHANG WHERE NAM=@NAM AND THANG=@THANG)
	IF(@COUNT=0)
	BEGIN
		INSERT INTO DOANHTHUTHANG(THANG, NAM, SOCHUYENBAY, DOANHTHU) VALUES(@THANG, @NAM, 0, 0)
	END
END
GO

CREATE TRIGGER INSERT_CTDOANHTHUTHANG_WHEN_INSERT_CHUYENBAY
ON CHUYENBAY
FOR INSERT
AS
BEGIN
	DECLARE @NAM VARCHAR(5)= (SELECT YEAR(THOIGIANKHOIHANH) FROM INSERTED)
	DECLARE @THANG VARCHAR(5)= (SELECT MONTH(THOIGIANKHOIHANH) FROM INSERTED)
	DECLARE @MACHUYENBAY VARCHAR(10)= (SELECT MACHUYENBAY FROM INSERTED)
	DECLARE @COUNT INT = (SELECT COUNT(*) FROM CTDOANHTHUTHANG WHERE NAM=@NAM AND THANG=@THANG AND MACHUYENBAY=@MACHUYENBAY)
	IF(@COUNT=0)
	BEGIN
		INSERT INTO CTDOANHTHUTHANG(THANG, NAM, MACHUYENBAY, SOVEBANDUOC, DOANHTHU) VALUES(@THANG, @NAM, @MACHUYENBAY, 0, 0)
	END
END
GO

CREATE TRIGGER INSERT_CTDOANHTHUTHANG_WHEN_UPDATE_CHUYENBAY
ON CHUYENBAY
FOR UPDATE
AS
BEGIN
	DECLARE @NAM VARCHAR(5)= (SELECT YEAR(THOIGIANKHOIHANH) FROM INSERTED)
	DECLARE @THANG VARCHAR(5)= (SELECT MONTH(THOIGIANKHOIHANH) FROM INSERTED)
	DECLARE @MACHUYENBAY VARCHAR(10)= (SELECT MACHUYENBAY FROM INSERTED)
	DECLARE @COUNT INT = (SELECT COUNT(*) FROM CTDOANHTHUTHANG WHERE NAM=@NAM AND THANG=@THANG AND MACHUYENBAY=@MACHUYENBAY)
	IF(@COUNT=0)
	BEGIN
		INSERT INTO CTDOANHTHUTHANG(THANG, NAM, MACHUYENBAY, SOVEBANDUOC, DOANHTHU) VALUES(@THANG, @NAM, @MACHUYENBAY, 0, 0)
	END
END
GO

CREATE TRIGGER INSERT_CTDOANHTHUTHANG_WHEN_INSERT_VECHUYENBAY
ON VECHUYENBAY
FOR INSERT
AS
BEGIN
	DECLARE @MACHUYENBAY VARCHAR(10)=(SELECT MACHUYENBAY FROM INSERTED)
	DECLARE @GIATIEN DECIMAL =(SELECT GIATIEN FROM INSERTED)
	DECLARE @SOVEBANDUOC INT =(SELECT COUNT(MAVE) FROM VECHUYENBAY WHERE MACHUYENBAY=@MACHUYENBAY)
	UPDATE CTDOANHTHUTHANG SET DOANHTHU+=@GIATIEN, SOVEBANDUOC=@SOVEBANDUOC WHERE MACHUYENBAY=@MACHUYENBAY
END
GO

CREATE TRIGGER UPDATE_DOANHTHUTHANG_WHEN_UPDATE_CTDOANHTHUTHANG
ON CTDOANHTHUTHANG
FOR UPDATE
AS
BEGIN
	DECLARE @THANG VARCHAR(3)=(SELECT THANG FROM INSERTED)
	DECLARE @NAM VARCHAR(5)=(SELECT NAM FROM INSERTED)
	DECLARE @DOANHTHU DECIMAL =(SELECT SUM(DOANHTHU) FROM CTDOANHTHUTHANG WHERE NAM=@NAM AND THANG=@THANG)
	DECLARE @SOCHUYENBAY INT =(SELECT COUNT(MACHUYENBAY) FROM CHUYENBAY WHERE YEAR(THOIGIANKHOIHANH)=@NAM AND MONTH(THOIGIANKHOIHANH)=@THANG)
	UPDATE DOANHTHUTHANG SET DOANHTHU=@DOANHTHU, SOCHUYENBAY=@SOCHUYENBAY WHERE NAM=@NAM AND THANG=@THANG
END
GO

CREATE TRIGGER UPDATE_DOANHTHUNAM_WHEN_UPDATE_DOANHTHUTHANG
ON DOANHTHUTHANG
FOR UPDATE
AS
BEGIN
	DECLARE @NAM VARCHAR(5)=(SELECT NAM FROM INSERTED)
	DECLARE @DOANHTHU DECIMAL =(SELECT SUM(DOANHTHU) FROM DOANHTHUTHANG WHERE NAM=@NAM)
	UPDATE DOANHTHUNAM SET DOANHTHU=@DOANHTHU WHERE NAM=@NAM
END
GO

CREATE TRIGGER UPDATE_TINHTRANGVE_WHEN_INSERT_VECHUYENBAY
ON VECHUYENBAY
FOR INSERT
AS
BEGIN
	DECLARE @MACHUYENBAY VARCHAR(10)=(SELECT MACHUYENBAY FROM INSERTED)
	DECLARE @MAHANGVE VARCHAR(10)=(SELECT MAHANGVE FROM INSERTED)
	DECLARE @TONGSOGHE INT =(SELECT TONGSOGHE FROM TINHTRANGVE WHERE MACHUYENBAY=@MACHUYENBAY AND MAHANGVE=@MAHANGVE)
	DECLARE @SOGHEMUA INT =(SELECT COUNT(MAVE) FROM VECHUYENBAY WHERE MACHUYENBAY=@MACHUYENBAY AND MAHANGVE=@MAHANGVE)
	UPDATE TINHTRANGVE SET SOGHETRONG=@TONGSOGHE-@SOGHEMUA WHERE MACHUYENBAY=@MACHUYENBAY AND MAHANGVE=@MAHANGVE
END
GO
