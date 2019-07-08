using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace QLCF.DTO
{
    public class HoaDon
    {
        public HoaDon(int id, DateTime? ngayVao, DateTime? ngayRa, int trangThai, int giamGia = 0)
        {
            this.ID = id;
            this.NgayVao = ngayVao;
            this.NgayRa = ngayRa;
            this.TrangThai = trangThai;
            this.GiamGia = giamGia;
        }

        public HoaDon(DataRow row)
        {
            this.ID = (int)row["id"];
            this.NgayVao = (DateTime?)row["ngayvao"];

            var ngayRaTemp = row["ngayra"];
            if (ngayRaTemp.ToString() != "")
                this.NgayRa = (DateTime?)ngayRaTemp;

            this.TrangThai = (int)row["trangthai"];

            if (row["giamgia"].ToString() != "")
                this.GiamGia = (int)row["giamgia"];
        }

        private int giamgia;

        public int GiamGia
        {
            get { return giamgia; }
            set { giamgia = value; }
        }

        private int trangthai;

        public int TrangThai
        {
            get { return trangthai; }
            set { trangthai = value; }
        }

        private DateTime? ngayra;

        public DateTime? NgayRa
        {
            get { return ngayra; }
            set { ngayra = value; }
        }

        private DateTime? ngayvao;

        public DateTime? NgayVao
        {
            get { return ngayvao; }
            set { ngayvao = value; }
        }

        private int iD;

        public int ID
        {
            get { return iD; }
            set { iD = value; }
        }
    }
}
