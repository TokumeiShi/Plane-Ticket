﻿CREATE DATABASE PLANE_TICKET
GO

USE PLANE_TICKET
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
)
GO

CREATE TABLE CHUYENBAY
(
	MACHUYENBAY VARCHAR(10) PRIMARY KEY,
	MATUYENBAY VARCHAR(10) NOT NULL,
	MAMAYBAY VARCHAR(10) NOT NULL,
	THOIGIANKHOIHANH DATETIME NOT NULL,
	THOIGIANBAY TIME NOT NULL
	CONSTRAINT FK_CHUYENBAY_TUYENBAY FOREIGN KEY(MATUYENBAY) REFERENCES TUYENBAY(MATUYENBAY),
	CONSTRAINT FK_CHUYENBAY_MAYBAY FOREIGN KEY(MAMAYBAY) REFERENCES MAYBAY(MAMAYBAY)
)
GO

CREATE TABLE CTCHUYENBAY
(
	MACHUYENBAY VARCHAR(10),
	MASANBAYTG VARCHAR(10),
	THOIGIANDUNG TIME NOT NULL,
	GHICHU NVARCHAR(100)
	CONSTRAINT PK_CTCHUYENBAY PRIMARY KEY(MACHUYENBAY, MASANBAYTG),
	CONSTRAINT FK_CTCHUYENBAY_CHUYENBAY FOREIGN KEY(MACHUYENBAY) REFERENCES CHUYENBAY(MACHUYENBAY),
)

CREATE TABLE HANGVE
(
	MAHANGVE VARCHAR(10) PRIMARY KEY,
	TENHANGVE NVARCHAR(20)
)
GO

CREATE TABLE VECHUYENBAY
(
	MACHUYENBAY VARCHAR(10),
	MAKHACHHANG VARCHAR(10),
	MAHANGVE VARCHAR(10) NOT NULL,
	GIATIEN MONEY NOT NULL,
	NGAYHUY DATE
	CONSTRAINT PK_VECHUYENBAY FOREIGN KEY(MACHUYENBAY, MAKHACHHANG)
	CONSTRAINT FK_VECHUYENBAY_CHUYENBAY FOREIGN KEY(MACHUYENBAY) REFERENCES CHUYENBAY(MACHUYENBAY),
	CONSTRAINT FK_VECHUYENBAY_HANGVE FOREIGN KEY(MAHANGVE) REFERENCES HANGVE(MAHANGVE)
)
GO

CREATE TABLE DONGIA
(
	MATUYENBAY VARCHAR(10),
	MAHANGVE VARCHAR(10),
	DONGIA MONEY NOT NULL
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
	CMND NVARCHAR(20) NOT NULL,
	SDT NVARCHAR(15) NOT NULL
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
	MADOANHTHUNAM VARCHAR(10) PRIMARY KEY,
	NAM VARCHAR(5) NOT NULL,
	DOANHTHU MONEY NOT NULL
)
GO

CREATE TABLE DOANHTHUTHANG
(
	MADOANHTHUTHANG VARCHAR(10) PRIMARY KEY,
	MADOANHTHUNAM VARCHAR(10) NOT NULL,
	THANG VARCHAR(3) NOT NULL,
	SOCHUYENBAY INT NOT NULL,
	DOANHTHU MONEY NOT NULL
	CONSTRAINT FK_DOANHTHUTHANG_DOANHTHUNAM FOREIGN KEY(MADOANHTHUNAM) REFERENCES DOANHTHUNAM(MADOANHTHUNAM),
)
GO

CREATE TABLE CTDOANHTHUTHANG
(
	MADOANHTHUTHANG VARCHAR(10),
	MACHUYENBAY VARCHAR(10),
	SOVEBANDUOC INT NOT NULL,
	DOANHTHU MONEY NOT NULL
	CONSTRAINT PK_CTDOANHTHUTHANG PRIMARY KEY(MADOANHTHUTHANG, MACHUYENBAY),
	CONSTRAINT FK_CTDOANHTHUTHANG_DOANHTHUTHANG FOREIGN KEY(MADOANHTHUTHANG) REFERENCES DOANHTHUTHANG(MADOANHTHUTHANG),
	CONSTRAINT FK_CTDOANHTHUTHANG_CHUYENBAY FOREIGN KEY(MACHUYENBAY) REFERENCES CHUYENBAY(MACHUYENBAY)
)
GO

CREATE TABLE THAMSO
(
	THOIGIANBAYTOITHIEU TIME,
	SOSANBAYTGTOIDA INT,
	THOIGIANDUNGTOITHIEU TIME,
	THOIGIANDUNGTOIDA TIME,
	TGCHAMNHATDATVE TIME,
	TGCHAMNHATHUYDATVE TIME
)