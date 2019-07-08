using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace QLCF.DTO
{
    public class TaiKhoan
    {
        public TaiKhoan(string tenDangNhap, string tenHienThi, int loaiTaiKhoan, string matKhau = null)
        {
            this.TenDangNhap = tenDangNhap;
            this.TenHienThi = tenHienThi;
            this.LoaiTaiKhoan = loaiTaiKhoan;
            this.MatKhau = matKhau;
        }

        public TaiKhoan(DataRow row)
        {
            this.TenDangNhap = row["TenDangNhap"].ToString();
            this.TenHienThi = row["TenHienThi"].ToString();
            this.LoaiTaiKhoan = (int)row["LoaiTaiKhoan"];
            this.MatKhau = row["MatKhau"].ToString();
        }

        private int loaitaikhoan;

        public int LoaiTaiKhoan
        {
            get { return loaitaikhoan; }
            set { loaitaikhoan = value; }
        }

        private string matkhau;

        public string MatKhau
        {
            get { return matkhau; }
            set { matkhau = value; }
        }

        private string tenhienthi;

        public string TenHienThi
        {
            get { return tenhienthi; }
            set { tenhienthi = value; }
        }

        private string tendangnhap;

        public string TenDangNhap
        {
            get { return tendangnhap; }
            set { tendangnhap = value; }
        }
    }
}
