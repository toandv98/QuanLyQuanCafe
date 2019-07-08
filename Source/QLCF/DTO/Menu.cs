using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace QLCF.DTO
{
    public class Menu
    {
        public Menu(string tenMon, int soLuong, float gia, float tongTien = 0)
        {
            this.TenMon = tenMon;
            this.SoLuong = soLuong;
            this.Gia = gia;
            this.TongTien = tongTien;
        }

        public Menu(DataRow row)
        {
            this.TenMon = row["tenmon"].ToString();
            this.SoLuong = (int)row["soLuong"];
            this.Gia = (float)Convert.ToDouble(row["gia"].ToString());
            this.TongTien = (float)Convert.ToDouble(row["tongTien"].ToString());
        }

        private float tongTien;

        public float TongTien
        {
            get { return tongTien; }
            set { tongTien = value; }
        }

        private float gia;

        public float Gia
        {
            get { return gia; }
            set { gia = value; }
        }

        private int soluong;

        public int SoLuong
        {
            get { return soluong; }
            set { soluong = value; }
        }

        private string tenMon;

        public string TenMon
        {
            get { return tenMon; }
            set { tenMon = value; }
        }
    }
}
