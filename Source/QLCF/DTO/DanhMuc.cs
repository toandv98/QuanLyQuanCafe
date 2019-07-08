using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace QLCF.DTO
{
    public class Danhmuc
    {
        public Danhmuc(int id, string ten)
        {
            this.ID = id;
            this.Ten = ten;
        }

        public Danhmuc(DataRow row)
        {
            this.ID = (int)row["id"];
            this.Ten = row["tendanhmuc"].ToString();
        }

        private string ten;

        public string Ten
        {
            get { return ten; }
            set { ten = value; }
        }

        private int iD;

        public int ID
        {
            get { return iD; }
            set { iD = value; }
        }
    }
}
