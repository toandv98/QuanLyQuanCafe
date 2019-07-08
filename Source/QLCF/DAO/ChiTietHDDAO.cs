using QLCF.DTO;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace QLCF.DAO
{
    public class ChiTietHDDAO
    {
        private static ChiTietHDDAO instance;

        public static ChiTietHDDAO Instance
        {
            get { if (instance == null) instance = new ChiTietHDDAO(); return ChiTietHDDAO.instance; }
            private set { ChiTietHDDAO.instance = value; }
        }

        private ChiTietHDDAO() { }

        public List<ChiTietHoaDon> XuatListChiTietHD(int id)
        {
            List<ChiTietHoaDon> listChiTietHD = new List<ChiTietHoaDon>();

            DataTable data = DataProvider.Instance.ExecuteQuery("SELECT * FROM dbo.ChiTietHD WHERE IDHoaDon = " + id);

            foreach (DataRow item in data.Rows)
            {
                ChiTietHoaDon tt = new ChiTietHoaDon(item);
                listChiTietHD.Add(tt);
            }

            return listChiTietHD;
        }

        public void ChenChiTietHD(int idHoaDon, int idMon, int soLuong)
        {
            DataProvider.Instance.ExecuteNonQuery("proc_ChenChiTietHD @idHoaDon , @idMon , @soLuong", new object[] { idHoaDon, idMon, soLuong });
        }
    }
}
