using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace QLCF.DTO
{
    public class ChiTietHoaDon
    {
        public ChiTietHoaDon(int id, int idHoaDon, int idMon, int soLuong)
        {
            this.ID = id;
            this.IDHoaDon = idHoaDon;
            this.IDMon = idMon;
            this.SoLuong = soLuong;
        }

        public ChiTietHoaDon(DataRow row)
        {
            this.ID = (int)row["id"];
            this.IDHoaDon = (int)row["idhoadon"];
            this.IDMon = (int)row["idmon"];
            this.SoLuong = (int)row["soluong"];
        }

        private int soluong;

        public int SoLuong
        {
            get { return soluong; }
            set { soluong = value; }
        }

        private int idmon;

        public int IDMon
        {
            get { return idmon; }
            set { idmon = value; }
        }

        private int idhoadon;

        public int IDHoaDon
        {
            get { return idhoadon; }
            set { idhoadon = value; }
        }

        private int iD;

        public int ID
        {
            get { return iD; }
            set { iD = value; }
        }
    }
}
