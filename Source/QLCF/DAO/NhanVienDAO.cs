using QLCF.DTO;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace QLCF.DAO
{
    public class NhanVienDAO
    {
        private static NhanVienDAO instance;

        public static NhanVienDAO Instance
        {
            get { if (instance == null) instance = new NhanVienDAO(); return NhanVienDAO.instance; }
            private set { NhanVienDAO.instance = value; }
        }

        private NhanVienDAO() { }

        public List<NhanVien> XuatListNhanVien()
        {
            List<NhanVien> list = new List<NhanVien>();

            string query = "SELECT * FROM dbo.NhanVien WHERE TrangThai = 0";

            DataTable data = DataProvider.Instance.ExecuteQuery(query);

            foreach (DataRow item in data.Rows)
            {
                NhanVien nhanVien = new NhanVien(item);
                list.Add(nhanVien);
            }

            return list;
        }

        public List<NhanVien> TimNhanVienBangTen(string hoten)
        {

            List<NhanVien> list = new List<NhanVien>();

            string query = string.Format("SELECT * FROM dbo.NhanVien WHERE TrangThai=0 AND dbo.f_ChuyenDoi(HoTen) LIKE N'%' + dbo.f_ChuyenDoi(N'{0}') + '%'", hoten);

            DataTable data = DataProvider.Instance.ExecuteQuery(query);

            foreach (DataRow item in data.Rows)
            {
                NhanVien nv = new NhanVien(item);
                list.Add(nv);
            }

            return list;
        }

        public bool ThemNhanVien(string tenDangNhap, string hoTen, string diaChi, string gioiTinh, string ngaySinh, string queQuan, string soDienThoai)
        {
            bool ck = TaiKhoanDAO.Instance.ChenTaiKhoan(tenDangNhap, hoTen, 0);
            if (ck)
            {
                string query = string.Format("INSERT INTO dbo.NhanVien(TenDangNhap, HoTen, DiaChi, GioiTinh, NgaySinh, QueQuan, SoDienThoai) VALUES(N'{0}', N'{1}', N'{2}', N'{3}', '{4}', N'{5}', N'{6}');", tenDangNhap, hoTen, diaChi, gioiTinh, ngaySinh, queQuan, soDienThoai);
                int result = DataProvider.Instance.ExecuteNonQuery(query);
                if (!(result > 0))
                    TaiKhoanDAO.Instance.XoaTaiKhoan(tenDangNhap);
                return result > 0;
            }
            else
            {
                return ck;
            }
        }

        public bool SuaNhanVien(int id, string hoTen, string diaChi, string gioiTinh, string ngaySinh, string queQuan, string soDienThoai)
        {
            string query = string.Format("UPDATE dbo.NhanVien SET HoTen = N'{0}', DiaChi = N'{1}', GioiTinh = N'{2}', NgaySinh = '{3}', QueQuan = N'{4}', SoDienThoai = '{5}' WHERE id = {6}", hoTen, diaChi, gioiTinh, ngaySinh, queQuan, soDienThoai, id);
            int result = DataProvider.Instance.ExecuteNonQuery(query);

            return result > 0;
        }
        public void XoaNhanVienBangTenDangNhap(string ten)
        {
            string query = "UPDATE dbo.NhanVien SET TrangThai = 1 WHERE TenDangNhap = '" + ten + "'";

            DataTable data = DataProvider.Instance.ExecuteQuery(query);
            
        }
        public int LayIDNhanVienBangTenDangNhap(string ten)
        {
            string query = "SELECT ID FROM dbo.NhanVien WHERE TenDangNhap= '" + ten + "'";
            DataTable data = DataProvider.Instance.ExecuteQuery(query);
            DataRow id = data.Rows[0];
            return (int)id["ID"];
        }
        public string LayTenDangNhapBangIDNhanVien(int idNhanVien)
        {
            string query = "SELECT TenDangNhap FROM dbo.NhanVien WHERE ID= " + idNhanVien;
            DataTable data = DataProvider.Instance.ExecuteQuery(query);
            DataRow tenDangNhap = data.Rows[0];
            return tenDangNhap["TenDangNhap"].ToString();
        }
        public bool XoaNhanVien(int idNhanVien)
        {
            TaiKhoanDAO.Instance.XoaTaiKhoan(LayTenDangNhapBangIDNhanVien(idNhanVien));
            string query = string.Format("UPDATE dbo.NhanVien SET TrangThai = 1 WHERE id = {0}", idNhanVien);
            int result = DataProvider.Instance.ExecuteNonQuery(query);

            return result > 0;
        }

    }
}
