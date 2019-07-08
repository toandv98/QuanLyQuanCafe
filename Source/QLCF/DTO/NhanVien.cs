using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace QLCF.DTO
{
    public class NhanVien
    {
        
        public NhanVien(int iD, string tenDangNhap, string hoTen, string diaChi, string gioiTinh, DateTime? ngaySinh, string queQuan, string soDienThoai)
        {
            ID = iD;
            TenDangNhap = tenDangNhap;
            HoTen = hoTen;
            DiaChi = diaChi;
            GioiTinh = gioiTinh;
            NgaySinh = ngaySinh;
            QueQuan = queQuan;
            SoDienThoai = soDienThoai;
        }
        public NhanVien(DataRow row)
        {
            ID = (int)row["ID"];
            TenDangNhap = row["TenDangNhap"].ToString();
            HoTen = row["HoTen"].ToString();
            DiaChi = row["DiaChi"].ToString();
            GioiTinh = row["GioiTinh"].ToString();
            var ngaySinh = row["NgaySinh"];
            if (ngaySinh.ToString() != "")
                this.NgaySinh = (DateTime?)ngaySinh;
            QueQuan = row["QueQuan"].ToString();
            SoDienThoai = row["SoDienThoai"].ToString();
        }

        public int ID { get => iD; set => iD = value; }
        public string TenDangNhap { get => tenDangNhap; set => tenDangNhap = value; }
        public string HoTen { get => hoTen; set => hoTen = value; }
        public string DiaChi { get => diaChi; set => diaChi = value; }
        public string GioiTinh { get => gioiTinh; set => gioiTinh = value; }
        public DateTime? NgaySinh { get => ngaySinh; set => ngaySinh = value; }
        public string QueQuan { get => queQuan; set => queQuan = value; }
        public string SoDienThoai { get => soDienThoai; set => soDienThoai = value; }

        private int iD;
        private string tenDangNhap;
        private string hoTen;
        private string diaChi;
        private string gioiTinh;
        private DateTime? ngaySinh;
        private string queQuan;
        private string soDienThoai;
    }
}
