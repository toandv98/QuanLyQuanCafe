using QLCF.DTO;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace QLCF.DAO
{
    public class MonDAO
    {
        private static MonDAO instance;

        public static MonDAO Instance
        {
            get { if (instance == null) instance = new MonDAO(); return MonDAO.instance; }
            private set { MonDAO.instance = value; }
        }

        private MonDAO() { }

        public List<Mon> XuatMonBangIDDanhMuc(int id)
        {
            List<Mon> list = new List<Mon>();

            string query = "select * from Mon where IDDanhMuc = " + id;

            DataTable data = DataProvider.Instance.ExecuteQuery(query);

            foreach (DataRow item in data.Rows)
            {
                Mon mon = new Mon(item);
                list.Add(mon);
            }

            return list;
        }

        public List<Mon> XuatListMon()
        {
            List<Mon> list = new List<Mon>();

            string query = "select * from Mon";

            DataTable data = DataProvider.Instance.ExecuteQuery(query);

            foreach (DataRow item in data.Rows)
            {
                Mon mon = new Mon(item);
                list.Add(mon);
            }
            return list;
        }

        public List<Mon> TimMonBangTen(string ten)
        {

            List<Mon> list = new List<Mon>();

            string query = string.Format("SELECT * FROM dbo.Mon WHERE dbo.f_ChuyenDoi(tenmon) LIKE N'%' + dbo.f_ChuyenDoi(N'{0}') + '%'", ten);

            DataTable data = DataProvider.Instance.ExecuteQuery(query);

            foreach (DataRow item in data.Rows)
            {
                Mon mon = new Mon(item);
                list.Add(mon);
            }

            return list;
        }

        public bool ChenMon(string ten, int id, float gia)
        {
            string query = string.Format("INSERT dbo.Mon ( tenmon, IDDanhMuc, gia )VALUES  ( N'{0}', {1}, {2})", ten, id, gia);
            int result = DataProvider.Instance.ExecuteNonQuery(query);
            return result > 0;
        }

        public bool CapNhatMon(int idMon, string ten, int id, float gia)
        {
            string query = string.Format("UPDATE dbo.Mon SET tenmon = N'{0}', IDDanhMuc = {1}, gia = {2} WHERE id = {3}", ten, id, gia, idMon);
            int result = DataProvider.Instance.ExecuteNonQuery(query);
            return result > 0;
        }

        public bool XoaMon(int idMon)
        {
            string query = string.Format("Delete Mon where id = {0}", idMon);
            int result = DataProvider.Instance.ExecuteNonQuery(query);
            return result > 0;
        }
        public DataTable XuatListBanChay(DateTime tu, DateTime den)
        {
            return DataProvider.Instance.ExecuteQuery("EXEC dbo.proc_ThongKeTheoMon @tuNgay , @denNgay", new object[] { tu, den });
        }
    }
}
