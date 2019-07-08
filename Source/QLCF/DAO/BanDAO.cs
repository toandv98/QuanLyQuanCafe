using QLCF.DTO;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace QLCF.DAO
{
    public class BanDAO
    {
        private static BanDAO instance;

        public static BanDAO Instance
        {
            get { if (instance == null) instance = new BanDAO(); return BanDAO.instance; }
            private set { BanDAO.instance = value; }
        }

        public static int Rong = 100;
        public static int Cao = 100;

        private BanDAO() { }

        public void ChuyenBan(int id1, int id2)
        {
            DataProvider.Instance.ExecuteQuery("proc_ChuyenBan @idBan1 , @idBan2", new object[] { id1, id2 });
        }

        public List<Ban> LoadListBan()
        {
            List<Ban> ListBan = new List<Ban>();

            DataTable data = DataProvider.Instance.ExecuteQuery("SELECT * FROM dbo.Ban WHERE TrangThai != N'Xoá'");

            foreach (DataRow item in data.Rows)
            {
                Ban ban = new Ban(item);
                ListBan.Add(ban);
            }

            return ListBan;
        }
        public bool ThemBan(string ten)
        {
            string query = string.Format("INSERT INTO dbo.Ban(TenBan) VALUES(N'{0}')", ten);
            int result = DataProvider.Instance.ExecuteNonQuery(query);
            return result > 0;
        }
        public bool SuaBan(string ten, int id)
        {
            string query = string.Format("UPDATE dbo.Ban SET TenBan = N'{0}' WHERE id = {1}", ten, id);
            int result = DataProvider.Instance.ExecuteNonQuery(query);
            return result > 0;
        }

        public bool XoaBan(int id)
        {
            string query = string.Format("UPDATE dbo.Ban SET TrangThai = N'Xoá' WHERE ID = {0}", id);
            int result = DataProvider.Instance.ExecuteNonQuery(query);
            return result > 0;
        }
    }
}
