CREATE DATABASE QLCF;
GO

USE QLCF;
GO

CREATE TABLE NhanVien 
(
	ID INT IDENTITY PRIMARY KEY,
	TenDangNhap NVARCHAR(100) NOT NULL UNIQUE,
	HoTen NVARCHAR(100) NOT NULL,
	DiaChi NVARCHAR(100) NOT NULL,
	GioiTinh NVARCHAR(10) NOT NULL,
	NgaySinh DATE NOT NULL,
	QueQuan NVARCHAR(100) NOT NULL,
	SoDienThoai NVARCHAR(20) NOT NULL,
	TrangThai INT DEFAULT 0 NOT NULL
);
GO
   
CREATE TABLE TaiKhoan
(
    TenDangNhap NVARCHAR(100) NOT NULL PRIMARY KEY,
    TenHienThi NVARCHAR(100)
        DEFAULT N'Tên hiển thị' NOT NULL,
    MatKhau NVARCHAR(1000)
        DEFAULT 0 NOT NULL,
    LoaiTaiKhoan INT
        DEFAULT 0 NOT NULL
);
GO

CREATE TABLE Ban
(
    ID INT IDENTITY PRIMARY KEY,
    TenBan NVARCHAR(100)
        DEFAULT N'Bàn chưa có tên' NOT NULL,
    TrangThai NVARCHAR(100)
        DEFAULT N'Trống' NOT NULL
);
GO

CREATE TABLE DanhMuc
(
    ID INT IDENTITY PRIMARY KEY,
    TenDanhMuc NVARCHAR(100)
        DEFAULT N'Chưa đặt tên' NOT NULL
);
GO

CREATE TABLE Mon
(
    ID INT IDENTITY PRIMARY KEY,
    TenMon NVARCHAR(100)
        DEFAULT N'Chưa đặt tên' NOT NULL,
    IDDanhMuc INT NOT NULL,
    Gia FLOAT
        DEFAULT 0 NOT NULL,
    FOREIGN KEY (IDDanhMuc) REFERENCES dbo.DanhMuc (ID) ON DELETE CASCADE
);
GO

CREATE TABLE HoaDon
(
    ID INT IDENTITY PRIMARY KEY,
    NgayVao DATE
        DEFAULT GETDATE() NOT NULL,
    NgayRa DATE,
    IDBan INT NOT NULL,
	IDNhanVien INT NOT NULL,
    TrangThai INT
        DEFAULT 0 NOT NULL,
    GiamGia INT
        DEFAULT 0 NOT NULL,
    TongTien FLOAT
        DEFAULT 0 NOT NULL,
    FOREIGN KEY (IDBan) REFERENCES dbo.Ban (ID),
	FOREIGN KEY (IDNhanVien) REFERENCES dbo.NhanVien (ID)
);
GO

CREATE TABLE ChiTietHD
(
    ID INT IDENTITY PRIMARY KEY,
    IDHoaDon INT NOT NULL,
    IDMon INT NOT NULL,
    SoLuong INT
        DEFAULT 0 NOT NULL,
    FOREIGN KEY (IDHoaDon) REFERENCES dbo.HoaDon (ID) ON DELETE CASCADE,
    FOREIGN KEY (IDMon) REFERENCES dbo.Mon (ID) ON DELETE CASCADE
);
GO

CREATE PROC proc_DangNhap @TenDangNhap NVARCHAR(100), @MatKhau NVARCHAR(100)
AS BEGIN
    SELECT *
    FROM dbo.TaiKhoan
    WHERE TenDangNhap=@TenDangNhap AND MatKhau=@MatKhau;
END;
GO

CREATE PROC proc_ChenChiTietHD @IDHoaDon INT, @IDMon INT, @SoLuong INT
AS BEGIN
    DECLARE @IDChiTietHD INT;
    DECLARE @SoMon INT=1;
    SELECT @IDChiTietHD=ID, @SoMon=SoLuong
    FROM dbo.ChiTietHD
    WHERE IDHoaDon=@IDHoaDon AND IDMon=@IDMon;
    IF(@IDChiTietHD>0)
	BEGIN
        DECLARE @SoLuongMoi INT=@SoMon+@SoLuong;
        IF(@SoLuongMoi>0)
		UPDATE dbo.ChiTietHD SET SoLuong=@SoMon+@SoLuong WHERE IDMon=@IDMon;
        ELSE 
		DELETE dbo.ChiTietHD WHERE IDHoaDon=@IDHoaDon AND IDMon=@IDMon;
    END;
    ELSE IF(@SoLuong>0)
	BEGIN
             INSERT dbo.ChiTietHD(IDHoaDon, IDMon, SoLuong)
             VALUES(@IDHoaDon, -- IDHoaDon - int
             @IDMon, -- IDMon - int
             @SoLuong -- SoLuong - int
                 );
    END;
END;
GO

CREATE TRIGGER tr_CapNhatChiTietHD
ON dbo.ChiTietHD
FOR INSERT, UPDATE
AS
BEGIN
    DECLARE @IDHoaDon INT;
    SELECT @IDHoaDon=IDHoaDon FROM Inserted;
    DECLARE @IDBan INT;
    SELECT @IDBan=IDBan FROM dbo.HoaDon WHERE ID=@IDHoaDon AND TrangThai=0;
    DECLARE @SoLuong INT;
    SELECT @SoLuong=COUNT(*)FROM dbo.ChiTietHD WHERE IDHoaDon=@IDHoaDon;
    IF(@SoLuong>0)
	UPDATE dbo.Ban SET TrangThai=N'Có Người' WHERE ID=@IDBan;
    ELSE 
	UPDATE dbo.Ban SET TrangThai=N'Trống' WHERE ID=@IDBan;
END;
GO

CREATE TRIGGER tr_CapNhatHoaDon
ON dbo.HoaDon
FOR UPDATE
AS
BEGIN
    DECLARE @IDHoaDon INT;
    DECLARE @IDBan INT;
    SELECT @IDHoaDon=ID FROM Inserted;
    SELECT @IDBan=IDBan FROM dbo.HoaDon WHERE ID=@IDHoaDon;
    DECLARE @SoLuong INT=0;
    SELECT @SoLuong=COUNT(*)FROM dbo.HoaDon WHERE IDBan=@IDBan AND TrangThai=0;
    IF(@SoLuong=0)
	UPDATE dbo.Ban SET TrangThai=N'Trống' WHERE ID=@IDBan;
END;
GO

CREATE TRIGGER tr_XoaChiTietHD
ON dbo.ChiTietHD
FOR DELETE
AS
BEGIN
    DECLARE @IDHoaDon INT;
    SELECT @IDHoaDon=IDHoaDon FROM Deleted;
    DECLARE @IDBan INT;
    SELECT @IDBan=IDBan FROM dbo.HoaDon WHERE ID=@IDHoaDon;
    DECLARE @SoLuong INT=0;
    SELECT @SoLuong=COUNT(*)
    FROM dbo.ChiTietHD ct
         INNER JOIN dbo.HoaDon hd ON hd.ID=ct.IDHoaDon
    WHERE hd.ID=@IDHoaDon AND hd.TrangThai=0;
    IF(@SoLuong=0)
	UPDATE dbo.Ban SET TrangThai=N'Trống' WHERE ID=@IDBan;
END;
GO

CREATE PROC proc_ChuyenBan @IDBan1 INT,@IDBan2 INT
AS
BEGIN
    DECLARE @IDHoaDon1 INT;
    DECLARE @IDHoaDon2 INT;
	DECLARE @TrangThai1 NVARCHAR(100);
	DECLARE @TrangThai2 NVARCHAR(100);
    SELECT @IDHoaDon1=ID FROM dbo.HoaDon WHERE IDBan=@IDBan1 AND TrangThai=0;
	SELECT @IDHoaDon2=ID FROM dbo.HoaDon WHERE IDBan=@IDBan2 AND TrangThai=0;
	SELECT @TrangThai1=TrangThai FROM dbo.Ban WHERE ID=@IDBan1;
	SELECT @TrangThai2=TrangThai FROM dbo.Ban WHERE ID=@IDBan2;
	UPDATE dbo.Ban SET TrangThai=@TrangThai1 WHERE ID=@IDBan2;
	UPDATE dbo.Ban SET TrangThai=@TrangThai2 WHERE ID=@IDBan1;
	UPDATE dbo.HoaDon SET IDBan = @IDBan1 WHERE ID=@IDHoaDon2;
	UPDATE dbo.HoaDon SET IDBan=@IDBan2 WHERE ID =@IDHoaDon1;
END
GO

CREATE PROC proc_CapNhatTaiKhoan @tenDangNhap NVARCHAR(100), @tenHienThi NVARCHAR(100), @matKhau NVARCHAR(100), @matKhauMoi NVARCHAR(100)
AS BEGIN
    DECLARE @kiemTraMatKhau INT=0;
    SELECT @kiemTraMatKhau=COUNT(*)
    FROM dbo.TaiKhoan
    WHERE TenDangNhap=@tenDangNhap AND MatKhau=@matKhau;
    IF(@kiemTraMatKhau=1)
	BEGIN
        IF(@matKhauMoi=NULL OR @matKhauMoi='')
		BEGIN
            UPDATE dbo.TaiKhoan
            SET TenHienThi=@tenHienThi
            WHERE TenDangNhap=@tenDangNhap;
        END;
        ELSE
            UPDATE dbo.TaiKhoan
            SET TenHienThi=@tenHienThi, MatKhau=@matKhauMoi
            WHERE TenDangNhap=@tenDangNhap;
    END;
END;
GO

CREATE PROC proc_ThemTaiKhoan @TenDangNhap NVARCHAR(100), @TenHienThi NVARCHAR(100), @LoaiTaiKhoan INT
AS BEGIN
    DECLARE @SoLuongTaiKhoan INT;
    SELECT @SoLuongTaiKhoan=COUNT(*)
    FROM dbo.TaiKhoan
    WHERE TenDangNhap=@TenDangNhap;
    IF(@SoLuongTaiKhoan<1)
        INSERT dbo.TaiKhoan(TenDangNhap, TenHienThi, LoaiTaiKhoan, MatKhau)
        VALUES(@TenDangNhap, @TenHienThi, @LoaiTaiKhoan, N'1982408718410113214846658453255177250147212');
END;
GO

CREATE FUNCTION f_ChuyenDoi(@strInput NVARCHAR(4000))
RETURNS NVARCHAR(4000)
AS BEGIN
    IF @strInput IS NULL RETURN @strInput;
    IF @strInput='' RETURN @strInput;
    DECLARE @RT NVARCHAR(4000);
    DECLARE @SIGN_CHARS NCHAR(136);
    DECLARE @UNSIGN_CHARS NCHAR(136);
    SET @SIGN_CHARS=N'ăâđêôơưàảãạáằẳẵặắầẩẫậấèẻẽẹéềểễệế ìỉĩịíòỏõọóồổỗộốờởỡợớùủũụúừửữựứỳỷỹỵý ĂÂĐÊÔƠƯÀẢÃẠÁẰẲẴẶẮẦẨẪẬẤÈẺẼẸÉỀỂỄỆẾÌỈĨỊÍ ÒỎÕỌÓỒỔỖỘỐỜỞỠỢỚÙỦŨỤÚỪỬỮỰỨỲỶỸỴÝ'+NCHAR(272)+NCHAR(208);
    SET @UNSIGN_CHARS=N'aadeoouaaaaaaaaaaaaaaaeeeeeeeeee iiiiiooooooooooooooouuuuuuuuuuyyyyy AADEOOUAAAAAAAAAAAAAAAEEEEEEEEEEIIIII OOOOOOOOOOOOOOOUUUUUUUUUUYYYYYDD';
    DECLARE @COUNTER INT;
    DECLARE @COUNTER1 INT;
    SET @COUNTER=1;
    WHILE(@COUNTER<=LEN(@strInput))BEGIN
        SET @COUNTER1=1;
        WHILE(@COUNTER1<=LEN(@SIGN_CHARS)+1)BEGIN
            IF UNICODE(SUBSTRING(@SIGN_CHARS, @COUNTER1, 1))=UNICODE(SUBSTRING(@strInput, @COUNTER, 1))BEGIN
                IF @COUNTER=1
                    SET @strInput=SUBSTRING(@UNSIGN_CHARS, @COUNTER1, 1)+SUBSTRING(@strInput, @COUNTER+1, LEN(@strInput)-1);
                ELSE
                    SET @strInput=SUBSTRING(@strInput, 1, @COUNTER-1)+SUBSTRING(@UNSIGN_CHARS, @COUNTER1, 1)+SUBSTRING(@strInput, @COUNTER+1, LEN(@strInput)-@COUNTER);
                BREAK;
            END;
            SET @COUNTER1=@COUNTER1+1;
        END;
        SET @COUNTER=@COUNTER+1;
    END;
    SET @strInput=REPLACE(@strInput, ' ', '-');
    RETURN @strInput;
END;
GO

CREATE PROC proc_ThongKeHoaDon @tuNgay DATE, @denNgay DATE
AS BEGIN
    SELECT b.TenBan AS [Tên bàn],nv.HoTen AS [Nhân viên], hd.NgayVao AS [Ngày vào], hd.NgayRa AS [Ngày ra], hd.TongTien AS [Tổng tiền], hd.GiamGia AS [Giảm giá]
    FROM dbo.HoaDon hd
         INNER JOIN dbo.Ban b ON b.ID=hd.IDBan INNER JOIN dbo.NhanVien nv ON nv.ID = hd.IDNhanVien
    WHERE hd.NgayVao>=@tuNgay AND hd.NgayRa<=@denNgay AND hd.TrangThai=1;
END;
GO

CREATE PROC proc_ThongKeTheoNhanVien @tuNgay DATE, @denNgay DATE
AS BEGIN
    SELECT nv.ID AS [ID Nhân viên], nv.HoTen AS [Họ tên nhân viên], COUNT(*) AS [Số lượng hoá đơn], SUM(hd.TongTien) AS [Tổng thu]
    FROM dbo.NhanVien nv
         INNER JOIN dbo.HoaDon hd ON hd.IDNhanVien=nv.ID
    WHERE hd.NgayVao>=@tuNgay AND hd.NgayRa<=@denNgay AND hd.TrangThai=1
    GROUP BY nv.ID, nv.HoTen;
END;
GO

CREATE PROC proc_ThongKeTheoMon @tuNgay DATE, @denNgay DATE
AS BEGIN
    SELECT m.TenMon AS [Tên món], d.TenDanhMuc AS [Tên danh mục], m.Gia AS [Giá], SUM(ct.SoLuong) AS [Số lượng bán ra], SUM(ct.SoLuong)* m.Gia AS [Tổng thu]
    FROM dbo.ChiTietHD ct
         INNER JOIN dbo.Mon m ON m.ID=ct.IDMon
         INNER JOIN dbo.DanhMuc d ON d.ID=m.IDDanhMuc
         INNER JOIN dbo.HoaDon hd ON hd.ID=ct.IDHoaDon
    WHERE hd.NgayVao>=@tuNgay AND hd.NgayRa<=@denNgay AND hd.TrangThai=1
    GROUP BY m.TenMon, d.TenDanhMuc, m.Gia;
END;
GO

CREATE PROC proc_Menu @IDBan INT
AS
SELECT m.TenMon, ct.SoLuong, m.Gia, m.Gia * ct.SoLuong AS tongTien
FROM dbo.ChiTietHD ct
     INNER JOIN dbo.HoaDon hd ON hd.ID=ct.IDHoaDon
     INNER JOIN dbo.Mon m ON m.ID=ct.IDMon
WHERE hd.TrangThai=0 AND hd.IDBan=@IDBan;
GO


CREATE PROC dangnhap
    @tentk NVARCHAR(30),
    @tenmk NVARCHAR(30),
    @tenuser NVARCHAR(30)
AS
BEGIN
    DECLARE @login NVARCHAR(MAX),
            @user NVARCHAR(MAX);
    SET @login = N'create login [' + @tentk + N'] with password =''' + @tenmk + N'''' + N', DEFAULT_DATABASE = [QLCF]';
    EXECUTE (@login);
    SET @user = N'USE QLCF exec sp_grantdbaccess ' + @tentk + N', ' + @tenuser;
    EXECUTE (@user);
END;
GO

CREATE PROC vt_csdl @tenuser NVARCHAR(30)
AS
BEGIN
    DECLARE @loaitaikhoan NVARCHAR(MAX),
            @vaitro NVARCHAR(MAX);
    SELECT @loaitaikhoan = LoaiTaiKhoan
    FROM TaiKhoan;
    IF (@loaitaikhoan = 1) EXEC sp_addrolemember 'Db_owner', @tenuser;
    IF (@loaitaikhoan = 0)
    BEGIN
        SET @vaitro
            = N'grant delete ,insert, select on HoaDon to ' + @tenuser
              + N'; 
			grant delete ,insert, select on ChiTietHD to ' + @tenuser + N';';
        EXECUTE (@vaitro);
    END;
END;
GO

CREATE PROC revoke_user @tenuser NVARCHAR(30)
AS
BEGIN
    DECLARE @thuhoi NVARCHAR(MAX);
    SET @thuhoi
        = N'revoke delete, insert,select on HoaDon to ' + @tenuser
          + N';
	revoke delete, insert, select on ChiTietHD to ' + @tenuser + N';';
    EXECUTE (@thuhoi);
END;
GO

/*Khai báo biến, chạy proc dangnhap với tên login là nhanvien1, mật khẩu là 123123
cấp quyền với tên mới là user1 cho cơ sở dữ liệu QLCF:
*/
EXECUTE dangnhap N'nhanvien1', N'123123', 'user1';

/*Khai báo biến, chạy proc vt_csdl với tên user là user1,
cấp quyền cho user1 với role là Db_owner nếu loại tài khoản = 1,
cấp quyền quyền thêm, xoá, select trên bảng HoaDon và ChiTietHD nếu loại tài khoản = 0:
*/
EXECUTE vt_csdl 'user1';

--Xoá thu hồi quyền nhân viên

EXECUTE revoke_user 'user1';