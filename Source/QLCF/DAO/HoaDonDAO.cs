using QLCF.DTO;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace QLCF.DAO
{
    public class HoaDonDAO
    {
        private static HoaDonDAO instance;

        public static HoaDonDAO Instance
        {
            get { if (instance == null) instance = new HoaDonDAO(); return HoaDonDAO.instance; }
            private set { HoaDonDAO.instance = value; }
        }
        
        private HoaDonDAO() { }

        public int GetHDChuaThanhToanBangIDBan(int id)
        {
            DataTable data = DataProvider.Instance.ExecuteQuery("SELECT * FROM dbo.HoaDon WHERE idban = " + id + " AND trangthai = 0");

            if (data.Rows.Count > 0)
            {
                HoaDon hoadon = new HoaDon(data.Rows[0]);
                return hoadon.ID;
            }

            return -1;
        }

        public void DaRa(int id, int giamgia, float tongTien)
        {
            string query = "UPDATE dbo.HoaDon SET ngayRA = GETDATE(), trangthai = 1, " + "giamgia = " + giamgia + ", tongTien = " + tongTien + " WHERE id = " + id;
            DataProvider.Instance.ExecuteNonQuery(query);
        }
        public void chenHoaDon(int idBan,int idNhanVien)
        {
            DataProvider.Instance.ExecuteNonQuery("INSERT INTO dbo.HoaDon(NgayVao, NgayRa, IDBan, IDNhanVien, TrangThai, GiamGia) VALUES(GETDATE(), NULL, " + idBan + "," + idNhanVien + ", 0, 0) ");
        }

        public DataTable XuatListHoaDonTheoNgay(DateTime tu, DateTime den)
        {
            return DataProvider.Instance.ExecuteQuery("exec proc_ThongKeHoaDon @tuNgay , @denNgay", new object[] { tu, den });
        }
        public DataTable XuatTienNVThuTheoNgay(DateTime tu, DateTime den)
        {
            return DataProvider.Instance.ExecuteQuery("EXEC dbo.proc_ThongKeTheoNhanVien @tuNgay , @denNgay", new object[] { tu, den });
        }
        public int GetMaxIDHoaDon()
        {
            try
            {
                return (int)DataProvider.Instance.ExecuteScalar("SELECT MAX(id) FROM dbo.HoaDon");
            }
            catch
            {
                return 1;
            }
        }
    }
}
