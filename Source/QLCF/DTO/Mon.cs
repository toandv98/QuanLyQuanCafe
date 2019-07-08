using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace QLCF.DTO
{
    public class Mon
    {
        public Mon(int id, string ten, int idDanhMuc, float gia)
        {
            this.ID = id;
            this.Ten = ten;
            this.IDDanhMuc = idDanhMuc;
            this.Gia = gia;
        }

        public Mon(DataRow row)
        {
            this.ID = (int)row["id"];
            this.Ten = row["tenmon"].ToString();
            this.IDDanhMuc = (int)row["iddanhmuc"];
            this.Gia = (float)Convert.ToDouble(row["gia"].ToString());
        }

        private float gia;

        public float Gia
        {
            get { return gia; }
            set { gia = value; }
        }

        private int iddanhmuc;

        public int IDDanhMuc
        {
            get { return iddanhmuc; }
            set { iddanhmuc = value; }
        }

        private string name;

        public string Ten
        {
            get { return name; }
            set { name = value; }
        }

        private int iD;

        public int ID
        {
            get { return iD; }
            set { iD = value; }
        }
    }
}
