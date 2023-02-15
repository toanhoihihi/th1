CREATE DATABASE sales ON PRIMARY
 (
 NAME = 'thsql1_data',
FILENAME ='T:\toan\thsql1-1_data.mdf',
SIZE = 10MB,
MAXSIZE = 20MB,
FILEGROWTH = 20%
 )
 LOG ON
 (
 NAME = 'thsql1_log',
 FILENAME = 'T:\toan\thsql1-1_log.ldf',
 SIZE = 10MB,
 MAXSIZE = 20MB,
 FILEGROWTH = 20%
 )
USE sales
--1.
EXEC sp_addtype 'mota','NVARCHAR(40)';
EXEC sp_addtype 'idkh','CHAR(10)','NOT NULL';
EXEC sp_addtype 'dt', 'CHAR(12)';

--2.bang
CREATE TABLE sanpham
(
	masp char(6) not null ,
	tensp varchar(20),
	ngaynhap date,
	dvt char(10),
	soluongton Int,
	dongianhap money,
	primary key(masp),
  )


  CREATE TABLE hoadon
(
	mahd char(10) not null,
	ngaylap  date not null,
	ngaygiao date not null,
	makh idkh,
	diengiai mota
  )
   create table khachhang 
   (
   makh idkh,
   tenkh nvarchar(30) ,
   diachi nvarchar(40) ,
   dienthoai dt,
   )

   create table chihd
   (
		mahd char(10) not null,
		masp char(6) not null,
		soluong int
   )

-- 3.  sửa cột DienGiai thành nvarchar(100) trong table hoadon
ALTER TABLE hoadon
ALTER COLUMN diengiai NVARCHAR(100)
-- 4. Thêm vào bảng SanPham cột TyLeHoaHong float
ALTER TABLE sanpham
ADD tylehoahong float
-- 5. xóa cột ngay nhap trong bảng sanpham
ALTER TABLE sanpham
DROP COLUMN ngaynhap

--6 

ALTER TABLE hoadon
ADD
CONSTRAINT pk_hd primary key(mahd)

ALTER TABLE khachhang
ADD
CONSTRAINT pk_khanghang primary key(makh)

ALTER TABLE hoadon
ADD
CONSTRAINT fk_khachhang_hoadon FOREIGN KEY(makh) REFERENCES khachhang(makh)

ALTER TABLE chihd
ADD
CONSTRAINT fk_hoadon_chihd FOREIGN KEY(mahd) REFERENCES hoadon(mahd),
CONSTRAINT fk_sanpham_chihd FOREIGN KEY(masp) REFERENCES sanpham(masp)


--7
ALTER TABLE hoadon
ADD CONSTRAINT check_ngaygiao CHECK (ngaygiao >= ngaylap);
------MaHD gồm 6 ký tự, 2 ký tự đầu là chữ, các ký tự còn lại là số-----
ALTER TABLE hoadon
ADD CONSTRAINT check_mahd CHECK(mahd like '[A-Z][A-Z][0-9][0-9][0-9][0-9]');
------Giá trị mặc định ban đầu cho cột NgayLap luôn luôn là ngày hiện hành-----
ALTER TABLE hoadon
ADD CONSTRAINT df_ngaylap DEFAULT GETDATE() FOR ngaylap;

--Cau 8:
------SoLuongTon chỉ nhập từ 0 đến 500----
ALTER TABLE sanpham
ADD CONSTRAINT check_soluongton CHECK (soluongton BETWEEN 0 AND 500)
------DonGiaNhap lớn hơn 0------
ALTER TABLE SanPham
ADD CONSTRAINT check_dongianhap CHECK (dongianhap > 0)
------Giá trị mặc định cho NgayNhap là ngày hiện hành-----
ALTER TABLE sanpham
ADD CONSTRAINT df_ngaynhap DEFAULT GETDATE() FOR ngaynhap;
------DVT chỉ nhập vào các giá trị ‘KG’, ‘Thùng’, ‘Hộp’, ‘Cái’----
ALTER TABLE sanpham
ADD CONSTRAINT df_DVT CHECK (DVT = N'KG' or DVT = N'Thùng' or DVT = N'Hộp' or DVT = N'Cái')


--9 
INSERT INTO sanpham
    (masp, tensp, ngaynhap, dvt, soluongton, dongianhap)
VALUES
    ('SP01', 'Bánh gạo', '2023/10/12', 'Cái', 18, 20000),
	 ('SP02', 'Bánh mì', '2023/04/12', 'Thùng', 30, 2),
	  ('SP03', 'Kẹo vinamilk', '2023/01/11', 'Hộp', 10, 55000),
	  ('SP04', 'Mứt dừa', '2023/01/03', 'Kg', 13, 12000);

INSERT INTO Khachhang
    (makh, tenkh, diachi, dienthoai)
VALUES
    ('KH01', 'Nguyễn khánh an', 'Tây Ninh', '090934345'),
	 ('KH02', 'Võ Nguyễn Đức Toàn', 'Tân Bình', '0946234123'),
	  ('KH03', 'Võ hoàng Minh tuấn', 'Châu Đốc', '0121682212'),
	   ('KH04', 'Châu Nhựt Quang', 'tp.HCM', '09163543'),
	    ('KH05', 'Lý công hoàng anh', 'Tiền Giang', '0829719271'),
		 ('KH06', 'Nguyễn minh thuận', 'Tây NInh', '0126542671');
Insert into hoadon
values  ('HD01', '2023/02/15','2023/12/30','KH01','1'),
		('HD02', '2023/03/15','2023/03/30','KH02','2'),
		('HD03', '2023/04/15','2023/04/30','KH03','3'),
		('HD04', '2023/05/15','2023/05/30','KH04','4');

INSERT INTO chihd
    (mahd, masp,soluong)
VALUES
    ('HD01', 'SP01', 1),
	 ('HD02', 'SP02', 2),
	('HD03', 'SP02', 3),
	('HD04', 'SP04', 4);


