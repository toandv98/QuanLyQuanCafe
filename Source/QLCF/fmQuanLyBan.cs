using QLCF.DAO;
using QLCF.DTO;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace QLCF
{
    public partial class fmQuanLyBan : Form
    {
        private TaiKhoan dangNhapTaiKhoan;

        public TaiKhoan DangNhapTaiKhoan
        {
            get { return dangNhapTaiKhoan; }
            set { dangNhapTaiKhoan = value; DatKieuTaiKhoan(dangNhapTaiKhoan.LoaiTaiKhoan); }
        }

        public fmQuanLyBan(TaiKhoan acc)
        {
            InitializeComponent();

            this.DangNhapTaiKhoan = acc;

            LoadBan();
            LoadDanhMuc();
            LoadCBBan(cbDoiBan);
        }

        #region Method
        void DatKieuTaiKhoan(int loaiTaiKhoan)
        {
            quảnLýToolStripMenuItem.Enabled = loaiTaiKhoan == 1;
            thôngTinToolStripMenuItem.Text += " (" + DangNhapTaiKhoan.TenHienThi + ")";
        }
        void LoadDanhMuc()
        {
            List<Danhmuc> listDanhMuc = DanhMucDAO.Instance.XuatListDanhMuc();
            cbDanhMuc.DataSource = listDanhMuc;
            cbDanhMuc.DisplayMember = "Ten";
        }

        void LoadListMonBangIDDanhMuc(int id)
        {
            List<Mon> listFood = MonDAO.Instance.XuatMonBangIDDanhMuc(id);
            cbMon.DataSource = listFood;
            cbMon.DisplayMember = "Ten";
        }
        void LoadCBBan(ComboBox cb)
        {
            cb.DataSource = BanDAO.Instance.LoadListBan();
            cb.DisplayMember = "Ten";
        }

        void LoadBan()
        {
            flpXepBan.Controls.Clear();

            List<Ban> ListBan = BanDAO.Instance.LoadListBan();

            foreach (Ban item in ListBan)
            {
                Button btn = new Button() { Width = BanDAO.Rong, Height = BanDAO.Cao };
                btn.Text = Environment.NewLine + Environment.NewLine + item.Ten;
                btn.Click += Btn_Click;
                btn.Tag = item;
                switch (item.TrangThai)
                {
                    case "Trống":
                        btn.BackColor = Color.Azure;
                        break;
                    default:
                        btn.Image = Properties.Resources.ktea;
                        btn.BackColor = Color.Azure;
                        break;
                }

                flpXepBan.Controls.Add(btn);
            }
        }
        void HienThiHoaDon(int id)
        {
            lsvHoaDon.Items.Clear();
            List<QLCF.DTO.Menu> listChiTietHD = MenuDAO.Instance.XuatListMenuBangIDBan(id);
            float tongTien = 0;
            foreach (QLCF.DTO.Menu item in listChiTietHD)
            {
                ListViewItem lsvItem = new ListViewItem(item.TenMon.ToString());
                lsvItem.SubItems.Add(item.SoLuong.ToString());
                lsvItem.SubItems.Add(item.Gia.ToString());
                lsvItem.SubItems.Add(item.TongTien.ToString());
                tongTien += item.TongTien;
                lsvHoaDon.Items.Add(lsvItem);
            }
            CultureInfo culture = new CultureInfo("vi-VN");
            tT = tongTien;
            txbTongTien.Text = tongTien.ToString("c", culture);
        }

        private double tT;
        #endregion

        #region Events
        private void Btn_Click(object sender, EventArgs e)
        {
            int IDBan = ((sender as Button).Tag as Ban).ID;
            lsvHoaDon.Tag = (sender as Button).Tag;
            HienThiHoaDon(IDBan);
        }
        private void thôngTinToolStripMenuItem_Click(object sender, EventArgs e)
        {
            fmThongTin f = new fmThongTin(DangNhapTaiKhoan);
            f.UpdateAccount += f_CapNhatTaiKhoan;
            f.ShowDialog();
        }
        void f_CapNhatTaiKhoan(object sender, AccountEvent e)
        {
            thôngTinToolStripMenuItem.Text = "Thông tin tài khoản (" + e.Acc.TenHienThi + ")";
        }
        private void quảnLýToolStripMenuItem_Click(object sender, EventArgs e)
        {
            fmQuanLy f = new fmQuanLy();
            f.dangNhapTaiKhoan = DangNhapTaiKhoan;
            f.ChenMon += f_ChenMon;
            f.XoaMon += f_XoaMon;
            f.CapNhatMon += f_CapNhatMon;
            if (f.ShowDialog() == DialogResult.OK)
            {
                LoadBan();
                LoadDanhMuc();
            }
        }
        void f_CapNhatMon(object sender, EventArgs e)
        {
            LoadListMonBangIDDanhMuc((cbDanhMuc.SelectedItem as Danhmuc).ID);
            if (lsvHoaDon.Tag != null)
                HienThiHoaDon((lsvHoaDon.Tag as Ban).ID);
        }

        void f_XoaMon(object sender, EventArgs e)
        {
            LoadListMonBangIDDanhMuc((cbDanhMuc.SelectedItem as Danhmuc).ID);
            if (lsvHoaDon.Tag != null)
                HienThiHoaDon((lsvHoaDon.Tag as Ban).ID);
            LoadBan();
        }

        void f_ChenMon(object sender, EventArgs e)
        {
            LoadListMonBangIDDanhMuc((cbDanhMuc.SelectedItem as Danhmuc).ID);
            if (lsvHoaDon.Tag != null)
                HienThiHoaDon((lsvHoaDon.Tag as Ban).ID);
        }
        private void đăngXuấtToolStripMenuItem_Click(object sender, EventArgs e)
        {
            this.Close();
        }
        #endregion

        private void cbDanhMuc_SelectedIndexChanged(object sender, EventArgs e)
        {
            int id = 0;

            ComboBox cb = sender as ComboBox;

            if (cb.SelectedItem == null)
                return;

            Danhmuc selected = cb.SelectedItem as Danhmuc;
            id = selected.ID;

            LoadListMonBangIDDanhMuc(id);
        }

        private void btnThemMon_Click(object sender, EventArgs e)
        {
            Ban ban = lsvHoaDon.Tag as Ban;
            if (ban == null)
            {
                MessageBox.Show("Hãy chọn bàn", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Information);
                return;
            }

            int idHoaDon = HoaDonDAO.Instance.GetHDChuaThanhToanBangIDBan(ban.ID);
            int idMon = (cbMon.SelectedItem as Mon).ID;
            int soLuong = (int)nmSoMon.Value;
            int idNhanVien = NhanVienDAO.Instance.LayIDNhanVienBangTenDangNhap(DangNhapTaiKhoan.TenDangNhap);

            if (idHoaDon == -1)
            {
                HoaDonDAO.Instance.chenHoaDon(ban.ID,idNhanVien);
                ChiTietHDDAO.Instance.ChenChiTietHD(HoaDonDAO.Instance.GetMaxIDHoaDon(), idMon, soLuong);
            }
            else
            {
                ChiTietHDDAO.Instance.ChenChiTietHD(idHoaDon, idMon, soLuong);
            }

            HienThiHoaDon(ban.ID);

            LoadBan();
        }

        private void btnThanhToan_Click(object sender, EventArgs e)
        {
            Ban ban = lsvHoaDon.Tag as Ban;

            int idHoaDon = HoaDonDAO.Instance.GetHDChuaThanhToanBangIDBan(ban.ID);
            int giamGia = (int)nmGiamGia.Value;

            double tongTien = tT;
            double truGiamGia = tongTien - (tongTien / 100) * giamGia;
            string ten = ban.Ten;
            
            if (idHoaDon != -1)
            {
                fmThanhToan f = new fmThanhToan();
                f.LoadThanhToan(ten, tongTien, giamGia, truGiamGia);

                if (f.ShowDialog() == DialogResult.OK)
                {
                    HoaDonDAO.Instance.DaRa(idHoaDon, giamGia, (float)truGiamGia);
                    HienThiHoaDon(ban.ID);
                    LoadBan();
                }
            }
        }

        private void btnDoiBan_Click(object sender, EventArgs e)
        {
            int id1 = (lsvHoaDon.Tag as Ban).ID;

            int id2 = (cbDoiBan.SelectedItem as Ban).ID;
            if (MessageBox.Show(string.Format("Bạn có thật sự muốn chuyển bàn {0} qua bàn {1}", (lsvHoaDon.Tag as Ban).Ten, (cbDoiBan.SelectedItem as Ban).Ten), "Thông báo", MessageBoxButtons.OKCancel) == System.Windows.Forms.DialogResult.OK)
            {
                BanDAO.Instance.ChuyenBan(id1, id2);

                LoadBan();
            }
        }
    }
}
