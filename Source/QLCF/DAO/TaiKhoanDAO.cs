using QLCF.DTO;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;

namespace QLCF.DAO
{

    public class TaiKhoanDAO
    {
        private static TaiKhoanDAO instance;

        public static TaiKhoanDAO Instance
        {
            get { if (instance == null) instance = new TaiKhoanDAO(); return instance; }
            private set { instance = value; }
        }

        private TaiKhoanDAO() { }

        public bool DangNhap(string tenTaiKhoan, string matKhau)
        {
            string hasPass = MaHoa(matKhau);

            string query = "proc_DangNhap @tendangnhap , @matKhau";

            DataTable result = DataProvider.Instance.ExecuteQuery(query, new object[] { tenTaiKhoan, hasPass });

            return result.Rows.Count > 0;
        }
        public bool KiemTra()
        {
            DataTable data = DataProvider.Instance.ExecuteQuery("SELECT * FROM dbo.TaiKhoan");
            if (data.Rows.Count < 1)
            {
                int result = DataProvider.Instance.ExecuteNonQuery("INSERT INTO dbo.TaiKhoan(TenDangNhap, TenHienThi, MatKhau, LoaiTaiKhoan) VALUES(N'admin', N'Admin', N'1982408718410113214846658453255177250147212', 1)");
                DataTable data1 = DataProvider.Instance.ExecuteQuery("SELECT * FROM dbo.NhanVien WHERE TenDangNhap = N'admin'");
                if (data1.Rows.Count < 1)
                {
                    int result1 = DataProvider.Instance.ExecuteNonQuery("INSERT INTO dbo.NhanVien(TenDangNhap, HoTen, DiaChi, GioiTinh, NgaySinh, QueQuan, SoDienThoai, TrangThai) VALUES(N'admin', N'ADMIN', N'--', N'Khác', GETDATE(), N'--', N'--', 0)");
                }
                return true;
            }
            return false;
        }
        public string MaHoa(string str)
        {
            byte[] temp = ASCIIEncoding.ASCII.GetBytes(str);
            byte[] hasData = new MD5CryptoServiceProvider().ComputeHash(temp);

            string hasPass = "";

            foreach (byte item in hasData)
            {
                hasPass += item;
            }
            return hasPass;
        }
        public bool SuaTaiKhoan(string tenDangNhap, string tenHienThi, string matKhau, string matKhauMoi)
        {
            string mk = MaHoa(matKhau);
            string nmk = MaHoa(matKhauMoi);

            int result = DataProvider.Instance.ExecuteNonQuery("exec proc_CapNhatTaiKhoan @tendangnhap , @tenhienthi , @matkhau , @matkhaumoi", new object[] { tenDangNhap, tenHienThi, mk, nmk });

            return result > 0;
        }
        public DataTable TimTaiKhoanBangTen(string tenHienThi)
        {
            string query = string.Format("SELECT TenDangNhap, TenHienThi, LoaiTaiKhoan  FROM dbo.TaiKhoan WHERE dbo.f_ChuyenDoi(TenHienThi) LIKE N'%' + dbo.f_ChuyenDoi(N'{0}') + '%'", tenHienThi);
            DataTable data = DataProvider.Instance.ExecuteQuery(query);
            
            return data;
        }
        public DataTable XuatListTaiKhoan()
        {
            return DataProvider.Instance.ExecuteQuery("SELECT TenDangNhap, TenHienThi, LoaiTaiKhoan FROM dbo.TaiKhoan");
        }

        public TaiKhoan XuatTaiKhoanBangTenTaiKhoan(string tenDangNhap)
        {
            DataTable data = DataProvider.Instance.ExecuteQuery("Select * from TaiKhoan where TenDangNhap = '" + tenDangNhap + "'");

            foreach (DataRow item in data.Rows)
            {
                return new TaiKhoan(item);
            }

            return null;
        }

        public bool ChenTaiKhoan(string ten, string tenHienThi, int loaiTaiKhoan)
        {
            string query = string.Format("EXEC dbo.proc_ThemTaiKhoan @TenDangNhap=N'{0}', @TenHienThi=N'{1}', @LoaiTaiKhoan={2};", ten, tenHienThi, loaiTaiKhoan);
            int result = DataProvider.Instance.ExecuteNonQuery(query);

            return result > 0;
        }

        public bool SuaTaiKhoan(string tenDangNhap, string tenHienThi, int loaiTaiKhoan)
        {
            string query = string.Format("UPDATE dbo.TaiKhoan SET TenHienThi = N'{1}', LoaiTaiKhoan = {2} WHERE TenDangNhap = N'{0}'", tenDangNhap, tenHienThi, loaiTaiKhoan);
            int result = DataProvider.Instance.ExecuteNonQuery(query);

            return result > 0;
        }

        public bool XoaTaiKhoan(string tenDangNhap)
        {
            NhanVienDAO.Instance.XoaNhanVienBangTenDangNhap(tenDangNhap);
            string query = string.Format("Delete TaiKhoan where TenDangNhap = N'{0}'", tenDangNhap);
            int result = DataProvider.Instance.ExecuteNonQuery(query);

            return result > 0;
        }

        public bool ResetMatKhau(string name)
        {
            string query = string.Format("update TaiKhoan set matkhau = N'1982408718410113214846658453255177250147212' where TenDangNhap = N'{0}'", name);
            int result = DataProvider.Instance.ExecuteNonQuery(query);

            return result > 0;
        }
    }
}
