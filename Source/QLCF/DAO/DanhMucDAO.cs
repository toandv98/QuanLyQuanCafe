using QLCF.DTO;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace QLCF.DAO
{
    public class DanhMucDAO
    {
        private static DanhMucDAO instance;

        public static DanhMucDAO Instance
        {
            get { if (instance == null) instance = new DanhMucDAO(); return DanhMucDAO.instance; }
            private set { DanhMucDAO.instance = value; }
        }

        private DanhMucDAO() { }

        public List<Danhmuc> XuatListDanhMuc()
        {
            List<Danhmuc> list = new List<Danhmuc>();

            string query = "select * from DanhMuc";

            DataTable data = DataProvider.Instance.ExecuteQuery(query);

            foreach (DataRow item in data.Rows)
            {
                Danhmuc danhmuc = new Danhmuc(item);
                list.Add(danhmuc);
            }

            return list;
        }

        public Danhmuc XuatDanhMucBangID(int id)
        {
            Danhmuc danhmuc = null;

            string query = "select * from DanhMuc where id = " + id;

            DataTable data = DataProvider.Instance.ExecuteQuery(query);

            foreach (DataRow item in data.Rows)
            {
                danhmuc = new Danhmuc(item);
                return danhmuc;
            }

            return danhmuc;
        }
        public bool ChenDanhMuc(string ten)
        {
            string query = string.Format("INSERT INTO dbo.DanhMuc (TenDanhMuc) VALUES(N'{0}')", ten);
            int result = DataProvider.Instance.ExecuteNonQuery(query);
            return result > 0;
        }
        public bool SuaDanhMuc(string ten,int id)
        {
            string query = string.Format("UPDATE dbo.DanhMuc SET TenDanhMuc = N'{0}' WHERE id = {1}", ten,id);
            int result = DataProvider.Instance.ExecuteNonQuery(query);

            return result > 0;
        }

        public bool XoaDanhMuc(int idDanhMuc)
        {
            string query = string.Format("DELETE dbo.DanhMuc WHERE ID= {0}",idDanhMuc);
            int result = DataProvider.Instance.ExecuteNonQuery(query);

            return result > 0;
        }
        public List<Danhmuc> TimDanhMucTen(string ten)
        {

            List<Danhmuc> list = new List<Danhmuc>();

            string query = string.Format("SELECT * FROM dbo.DanhMuc WHERE dbo.f_ChuyenDoi(tendanhmuc) LIKE N'%' + dbo.f_ChuyenDoi(N'{0}') + '%'", ten);

            DataTable data = DataProvider.Instance.ExecuteQuery(query);

            foreach (DataRow item in data.Rows)
            {
                Danhmuc danhmuc = new Danhmuc(item);
                list.Add(danhmuc);
            }

            return list;
        }
    }
}
