using QLCF.DAO;
using QLCF.DTO;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace QLCF
{
    public partial class fmQuanLy : Form
    {
        BindingSource listMon = new BindingSource();
        BindingSource listDanhMuc = new BindingSource();
        BindingSource listBan = new BindingSource();
        BindingSource listTaiKhoan = new BindingSource();
        BindingSource listNhanVien = new BindingSource();
        BindingSource listMonTheoDanhMuc = new BindingSource();

        public TaiKhoan dangNhapTaiKhoan;
        public fmQuanLy()
        {
            InitializeComponent();
            LoadData();
        }

        #region methods

        List<Mon> TimMonBangTen(string ten)
        {
            List<Mon> listMon = MonDAO.Instance.TimMonBangTen(ten);

            return listMon;
        }
        List<Danhmuc> TimDanhMucBangTen(string ten)
        {
            List<Danhmuc> listDanhMuc = DanhMucDAO.Instance.TimDanhMucTen(ten);

            return listDanhMuc;
        }
        List<NhanVien> TimNhanVienBangTen(string ten)
        {
            List<NhanVien> listNhanVien = NhanVienDAO.Instance.TimNhanVienBangTen(ten);

            return listNhanVien;
        }
        void LoadData()
        {
            dtgMon.DataSource = listMon;
            dtgMonTheoDanhMuc.DataSource = listMonTheoDanhMuc;
            dtgTaiKhoan.DataSource = listTaiKhoan;
            dtgDanhMuc.DataSource = listDanhMuc;
            dtgBan.DataSource = listBan;
            dtgNhanVien.DataSource = listNhanVien;
            LoadThoiGiamHD();
            LoadListHoaDonTheoNgay(dtpTuNgay.Value, dtpDenNgay.Value);
            LoadListMon();
            LoadListDanhMuc();
            LoadListBan();
            LoadTaiKhoan();
            LoadListNhanVien();
            LoadDanhMucVaoCombobox(cbDanhMuc);
            LoadGioiTinhVaoCombobox(cbGioiTinh);
            AddMonBinding();
            AddBanBinding();
            AddDanhMucBinding();
            AddTaiKhoanBinding();
            AddNhanVienBinding();
        }

        void AddTaiKhoanBinding()
        {
            txbTenDangNhap.DataBindings.Add(new Binding("Text", dtgTaiKhoan.DataSource, "TenDangNhap", true, DataSourceUpdateMode.Never));
            txbTenHienThi.DataBindings.Add(new Binding("Text", dtgTaiKhoan.DataSource, "TenHienThi", true, DataSourceUpdateMode.Never));
            nmLoaiTaiKhoan.DataBindings.Add(new Binding("Value", dtgTaiKhoan.DataSource, "LoaiTaiKhoan", true, DataSourceUpdateMode.Never));
        }
        void LoadTaiKhoan()
        {
            listTaiKhoan.DataSource = TaiKhoanDAO.Instance.XuatListTaiKhoan();
        }
        void LoadThoiGiamHD()
        {
            DateTime homnay = DateTime.Now;
            dtpTuNgay.Value = new DateTime(homnay.Year, homnay.Month, 1);
            dtpDenNgay.Value = dtpTuNgay.Value.AddMonths(1).AddDays(-1);
        }
        void LoadListHoaDonTheoNgay(DateTime vao, DateTime ra)
        {
            dtgDoanhThu.DataSource = HoaDonDAO.Instance.XuatListHoaDonTheoNgay(vao, ra);
        }
        void LoadTienNVThuTheoNgay(DateTime vao, DateTime ra)
        {
            dtgDoanhThu.DataSource = HoaDonDAO.Instance.XuatTienNVThuTheoNgay(vao, ra);
        }
        void LoadListBanChay(DateTime vao, DateTime ra)
        {
            dtgDoanhThu.DataSource = MonDAO.Instance.XuatListBanChay(vao,ra);
        }
        void AddMonBinding()
        {
            txbTenMon.DataBindings.Add(new Binding("Text", dtgMon.DataSource, "Ten", true, DataSourceUpdateMode.Never));
            txbIDMon.DataBindings.Add(new Binding("Text", dtgMon.DataSource, "ID", true, DataSourceUpdateMode.Never));
            nmGiaMon.DataBindings.Add(new Binding("Value", dtgMon.DataSource, "Gia", true, DataSourceUpdateMode.Never));
        }
        void AddNhanVienBinding()
        {
            txbHoTen.DataBindings.Add(new Binding("Text", dtgNhanVien.DataSource, "HoTen", true, DataSourceUpdateMode.Never));
            txbIDNhanVien.DataBindings.Add(new Binding("Text", dtgNhanVien.DataSource, "ID", true, DataSourceUpdateMode.Never));
            txbQueQuan.DataBindings.Add(new Binding("Text", dtgNhanVien.DataSource, "QueQuan", true, DataSourceUpdateMode.Never));
            txbDiaChi.DataBindings.Add(new Binding("Text", dtgNhanVien.DataSource, "DiaChi", true, DataSourceUpdateMode.Never));
            txbSoDienThoai.DataBindings.Add(new Binding("Text", dtgNhanVien.DataSource, "SoDienThoai", true, DataSourceUpdateMode.Never));
            txbTenDangNhapNV.DataBindings.Add(new Binding("Text", dtgNhanVien.DataSource, "TenDangNhap", true, DataSourceUpdateMode.Never));
            dtpNgaySinh.DataBindings.Add(new Binding("Value", dtgNhanVien.DataSource, "NgaySinh", true, DataSourceUpdateMode.Never));
            cbGioiTinh.DataBindings.Add(new Binding("Text", dtgNhanVien.DataSource, "GioiTinh", true, DataSourceUpdateMode.Never));
        }
        void AddBanBinding()
        {
            txbIDBan.DataBindings.Add(new Binding("Text", dtgBan.DataSource, "ID", true, DataSourceUpdateMode.Never));
            txbTenBan.DataBindings.Add(new Binding("Text", dtgBan.DataSource, "Ten", true, DataSourceUpdateMode.Never));
            txbTrangThai.DataBindings.Add(new Binding("Text", dtgBan.DataSource, "TrangThai", true, DataSourceUpdateMode.Never));
        }
        void AddDanhMucBinding()
        {
            txbIDDanhMuc.DataBindings.Add(new Binding("Text", dtgDanhMuc.DataSource, "ID", true, DataSourceUpdateMode.Never));
            txbTenDanhMuc.DataBindings.Add(new Binding("Text", dtgDanhMuc.DataSource, "Ten", true, DataSourceUpdateMode.Never));
        }
        void LoadDanhMucVaoCombobox(ComboBox cb)
        {
            cb.DataSource = DanhMucDAO.Instance.XuatListDanhMuc();
            cb.DisplayMember = "Ten";
        }
        void LoadGioiTinhVaoCombobox(ComboBox cb)
        {
            cbGioiTinh.Items.Add("Nam");
            cbGioiTinh.Items.Add("Nữ");
            cbGioiTinh.Items.Add("Khác");
        }
        void LoadListBan()
        {
            listBan.DataSource = BanDAO.Instance.LoadListBan();
        }
        void LoadListMon()
        {
            listMon.DataSource = MonDAO.Instance.XuatListMon();
        }
        void LoadListMonTheoDanhMuc(int id)
        {
            listMonTheoDanhMuc.DataSource = MonDAO.Instance.XuatMonBangIDDanhMuc(id);
        }
        void LoadListNhanVien()
        {
            listNhanVien.DataSource = NhanVienDAO.Instance.XuatListNhanVien();
        }
        void LoadListDanhMuc()
        {
            listDanhMuc.DataSource = DanhMucDAO.Instance.XuatListDanhMuc();
        }
        void ThemTaiKhoan(string userName, string displayName, int type)
        {
            if (TaiKhoanDAO.Instance.ChenTaiKhoan(userName, displayName, type))
            {
                MessageBox.Show("Thêm tài khoản thành công", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
            else
            {
                MessageBox.Show("Thêm tài khoản thất bại", "Lỗi", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }

            LoadTaiKhoan();
        }

        void SuaTaiKhoan(string tenTaiKhoan, string tenHienThi, int loaiTaiKhoan)
        {
            if (dangNhapTaiKhoan.TenDangNhap.Equals(tenTaiKhoan))
            {
                MessageBox.Show("Tài khoản đang được sử dụng", "Cảnh báo", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }
            if (TaiKhoanDAO.Instance.SuaTaiKhoan(tenTaiKhoan, tenHienThi, loaiTaiKhoan))
            {
                MessageBox.Show("Cập nhật tài khoản thành công", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
            else
            {
                MessageBox.Show("Cập nhật tài khoản thất bại", "Lỗi", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }

            LoadTaiKhoan();
        }

        void XoaTaiKhoan(string tenTaiKhoan)
        {
            if (dangNhapTaiKhoan.TenDangNhap.Equals(tenTaiKhoan))
            {
                MessageBox.Show("Tài khoản đang được sử dụng", "Cảnh báo", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }
            if (TaiKhoanDAO.Instance.XoaTaiKhoan(tenTaiKhoan))
            {
                MessageBox.Show("Xóa tài khoản thành công", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
            else
            {
                MessageBox.Show("Xóa tài khoản thất bại", "Lỗi", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }

            LoadTaiKhoan();
            LoadListNhanVien();
        }

        void ResetMatKhau(string tenTaiKhoan)
        {
            if (TaiKhoanDAO.Instance.ResetMatKhau(tenTaiKhoan))
            {
                MessageBox.Show("Đặt lại mật khẩu thành công", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
            else
            {
                MessageBox.Show("Đặt lại mật khẩu thất bại", "Lỗi", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        #endregion

        private void btnThongKe_Click(object sender, EventArgs e)
        {
            if (rbTheoNhanVien.Checked)
            {
                LoadTienNVThuTheoNgay(dtpTuNgay.Value, dtpDenNgay.Value);
            }
            if (rbTheoMon.Checked)
            {
                LoadListBanChay(dtpTuNgay.Value, dtpDenNgay.Value);
            }
            if(rbTatCa.Checked)
            {
                LoadListHoaDonTheoNgay(dtpTuNgay.Value, dtpDenNgay.Value);
            }
        }

        private void btnTimKien_Click(object sender, EventArgs e)
        {
            listMon.DataSource = TimMonBangTen(txbTimMon.Text);
        }

        private void btnThemMon_Click(object sender, EventArgs e)
        {
            string ten = txbTenMon.Text;
            int idDanhMuc = (cbDanhMuc.SelectedItem as Danhmuc).ID;
            float gia = (float)nmGiaMon.Value;

            if (MonDAO.Instance.ChenMon(ten, idDanhMuc, gia))
            {
                MessageBox.Show("Thêm món thành công", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Information);
                LoadListMon();
                if (chenMon != null)
                    chenMon(this, new EventArgs());
            }
            else
            {
                MessageBox.Show("Có lỗi khi thêm thức ăn", "Lỗi", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void btnSuaMon_Click(object sender, EventArgs e)
        {
            string ten = txbTenMon.Text;
            int idDanhMuc = (cbDanhMuc.SelectedItem as Danhmuc).ID;
            float gia = (float)nmGiaMon.Value;
            int id = Convert.ToInt32(txbIDMon.Text);

            if (MonDAO.Instance.CapNhatMon(id, ten, idDanhMuc, gia))
            {
                MessageBox.Show("Sửa món thành công", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Information);
                LoadListMon();
                if (capNhatMon != null)
                    capNhatMon(this, new EventArgs());
            }
            else
            {
                MessageBox.Show("Có lỗi khi sửa thức ăn", "Lỗi", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void btnXoaMon_Click(object sender, EventArgs e)
        {
            int id = Convert.ToInt32(txbIDMon.Text);

            if (MonDAO.Instance.XoaMon(id))
            {
                MessageBox.Show("Xóa món thành công", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Information);
                LoadListMon();
                if (xoaMon != null)
                    xoaMon(this, new EventArgs());
            }
            else
            {
                MessageBox.Show("Có lỗi khi xóa thức ăn", "Lỗi", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void btnXemMon_Click(object sender, EventArgs e)
        {
            LoadListMon();
            LoadDanhMucVaoCombobox(cbDanhMuc);
        }

        private void txbIDMon_TextChanged(object sender, EventArgs e)
        {
            try
            {
                if (dtgMon.SelectedCells.Count > 0)
                {
                    int id = (int)dtgMon.SelectedCells[0].OwningRow.Cells["IDDanhMuc"].Value;

                    Danhmuc danhmuc = DanhMucDAO.Instance.XuatDanhMucBangID(id);

                    cbDanhMuc.SelectedItem = danhmuc;

                    int index = -1;
                    int i = 0;
                    foreach (Danhmuc item in cbDanhMuc.Items)
                    {
                        if (item.ID == danhmuc.ID)
                        {
                            index = i;
                            break;
                        }
                        i++;
                    }

                    cbDanhMuc.SelectedIndex = index;
                }
            }
            catch { }
        }

        private void btnSuaTaiKhoan_Click(object sender, EventArgs e)
        {
            string tenDangNhap = txbTenDangNhap.Text;
            string tenHienThi = txbTenHienThi.Text;
            int loaiTaiKhoan = (int)nmLoaiTaiKhoan.Value;

            SuaTaiKhoan(tenDangNhap, tenHienThi, loaiTaiKhoan);
        }

        private void btnXoaTaiKhoan_Click(object sender, EventArgs e)
        {
            string tenTaiKhoan = txbTenDangNhap.Text;

            XoaTaiKhoan(tenTaiKhoan);
        }

        private void btnXemTaiKhoan_Click(object sender, EventArgs e)
        {
            LoadTaiKhoan();
        }

        private void btnResetMatKhau_Click(object sender, EventArgs e)
        {
            string tenDangnhap = txbTenDangNhap.Text;

            ResetMatKhau(tenDangnhap);
        }

        private void btnThemDanhMuc_Click(object sender, EventArgs e)
        {
            string ten = txbTenDanhMuc.Text;

            if (DanhMucDAO.Instance.ChenDanhMuc(ten))
            {
                MessageBox.Show("Thêm danh mục thành công", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Information);
                LoadListDanhMuc();
                if (chenDanhMuc != null)
                    chenDanhMuc(this, new EventArgs());
            }
            else
            {
                MessageBox.Show("Có lỗi khi thêm danh mục", "Lỗi", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void btnSuaDanhMuc_Click(object sender, EventArgs e)
        {
            string ten = txbTenDanhMuc.Text;
            int id = Int32.Parse(txbIDDanhMuc.Text);

            if (DanhMucDAO.Instance.SuaDanhMuc(ten, id))
            {
                MessageBox.Show("Sửa danh mục thành công", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Information);
                LoadListDanhMuc();
                if (capNhatDanhMuc != null)
                    capNhatDanhMuc(this, new EventArgs());
            }
            else
            {
                MessageBox.Show("Có lỗi khi sửa danh mục", "Lỗi", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void btnXoaDanhMuc_Click(object sender, EventArgs e)
        {
            int id = Convert.ToInt32(txbIDDanhMuc.Text);

            if (DanhMucDAO.Instance.XoaDanhMuc(id))
            {
                MessageBox.Show("Xóa danh mục thành công", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Information);
                LoadListDanhMuc();
                LoadListMon();
                if (xoaMon != null)
                    xoaMon(this, new EventArgs());
            }
            else
            {
                MessageBox.Show("Có lỗi khi xóa danh mục", "Lỗi", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void btnXemBan_Click(object sender, EventArgs e)
        {
            LoadListBan();
        }

        private void btnXemDanhMuc_Click(object sender, EventArgs e)
        {
            LoadListDanhMuc();
        }

        private void btnThemBan_Click(object sender, EventArgs e)
        {
            string ten = txbTenBan.Text;

            if (BanDAO.Instance.ThemBan(ten))
            {
                MessageBox.Show("Thêm bàn thành công", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Information);
                LoadListBan();
                if (themBan != null)
                    themBan(this, new EventArgs());
            }
            else
            {
                MessageBox.Show("Có lỗi khi thêm bàn", "Lỗi", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void btnSuaBan_Click(object sender, EventArgs e)
        {
            string ten = txbTenBan.Text;
            int id = Int32.Parse(txbIDBan.Text);

            if (BanDAO.Instance.SuaBan(ten, id))
            {
                MessageBox.Show("Sửa bàn thành công", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Information);
                LoadListBan();
                if (suaBan != null)
                    suaBan(this, new EventArgs());
            }
            else
            {
                MessageBox.Show("Có lỗi khi sửa bàn", "Lỗi", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void btnXoaBan_Click(object sender, EventArgs e)
        {
            int id = Convert.ToInt32(txbIDBan.Text);

            if (BanDAO.Instance.XoaBan(id))
            {
                MessageBox.Show("Xóa bàn thành công", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Information);
                LoadListBan();
                if (xoaBan != null)
                    xoaBan(this, new EventArgs());
            }
            else
            {
                MessageBox.Show("Có lỗi khi xóa bàn", "Lỗi", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void btnTimDanhMuc_Click(object sender, EventArgs e)
        {
            listDanhMuc.DataSource = TimDanhMucBangTen(txbTimDanhMuc.Text);
        }

        private void nmLoaiTaiKhoan_ValueChanged(object sender, EventArgs e)
        {
            string str = nmLoaiTaiKhoan.Value.ToString();
            if (str == "1")
                lblTypeTaiKhoan.Text = "Quản lý";
            else
                lblTypeTaiKhoan.Text = "Nhân viên";
        }

        private void fmQuanLy_FormClosed(object sender, FormClosedEventArgs e)
        {
            this.DialogResult = DialogResult.OK;
        }

        private void button1_Click(object sender, EventArgs e)
        {
            LoadListNhanVien();
        }

        private void btnThemNhanVien_Click(object sender, EventArgs e)
        {
            string tenDangNhap = txbTenDangNhapNV.Text;
            string hoTen = txbHoTen.Text;
            string diaChi = txbDiaChi.Text;
            string gioiTinh = cbGioiTinh.Text;
            string ngaySinh = dtpNgaySinh.Value.ToString("MM-dd-yyyy");
            string queQuan = txbQueQuan.Text;
            string soDienThoai = txbSoDienThoai.Text;

            if (NhanVienDAO.Instance.ThemNhanVien(tenDangNhap, hoTen, diaChi, gioiTinh, ngaySinh, queQuan, soDienThoai))
            {
                MessageBox.Show("Thêm nhân viên thành công", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Information);
                LoadListNhanVien();
                LoadTaiKhoan();
                if (themNhanVien != null)
                    themNhanVien(this, new EventArgs());
            }
            else
            {
                MessageBox.Show("Có lỗi khi thêm nhân viên", "Lỗi", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void btnSuaNhanVien_Click(object sender, EventArgs e)
        {
            int id = Int32.Parse(txbIDNhanVien.Text);
            string hoTen = txbHoTen.Text;
            string diaChi = txbDiaChi.Text;
            string gioiTinh = cbGioiTinh.Text;
            string ngaySinh = dtpNgaySinh.Value.ToString("MM-dd-yyyy");
            string queQuan = txbQueQuan.Text;
            string soDienThoai = txbSoDienThoai.Text;

            if (NhanVienDAO.Instance.SuaNhanVien(id, hoTen, diaChi, gioiTinh, ngaySinh, queQuan, soDienThoai)) 
            {
                MessageBox.Show("Sửa nhân viên thành công", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Information);
                LoadListNhanVien();
                LoadTaiKhoan();
                if (suaNhanVien != null)
                    suaNhanVien(this, new EventArgs());
            }
            else
            {
                MessageBox.Show("Có lỗi khi sửa nhân viên", "Lỗi", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void btnXoaNhanVien_Click(object sender, EventArgs e)
        {
            int id = Convert.ToInt32(txbIDNhanVien.Text);

            if (NhanVienDAO.Instance.XoaNhanVien(id))
            {
                MessageBox.Show("Xóa nhân viên thành công", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Information);
                LoadListNhanVien();
                LoadTaiKhoan();
                if (xoaNhanVien != null)
                    xoaNhanVien(this, new EventArgs());
            }
            else
            {
                MessageBox.Show("Có lỗi khi xóa nhân viên", "Lỗi", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void btnTimNhanVien_Click(object sender, EventArgs e)
        {
            listNhanVien.DataSource = TimNhanVienBangTen(txbTimNhanVien.Text);
        }

        private void btnTimTaiKhoan_Click(object sender, EventArgs e)
        {
            listTaiKhoan.DataSource = TaiKhoanDAO.Instance.TimTaiKhoanBangTen(txbTimTaiKhoan.Text);
        }

        private void txbIDDanhMuc_TextChanged(object sender, EventArgs e)
        {
            LoadListMonTheoDanhMuc(Int32.Parse(txbIDDanhMuc.Text));
        }
        private void txbTenDanhMuc_TextChanged(object sender, EventArgs e)
        {
            lblMonTheoDanhMuc.Text = "Món trong danh mục " + txbTenDanhMuc.Text + ":";
        }

        private event EventHandler chenMon;
        public event EventHandler ChenMon
        {
            add { chenMon += value; }
            remove { chenMon -= value; }
        }
        private event EventHandler chenDanhMuc;
        public event EventHandler ChenDanhMuc
        {
            add { chenDanhMuc += value; }
            remove { chenDanhMuc -= value; }
        }
        private event EventHandler themBan;
        public event EventHandler ThemBan
        {
            add { themBan += value; }
            remove { themBan -= value; }
        }
        private event EventHandler themNhanVien;
        public event EventHandler ThemNhanVien
        {
            add { themNhanVien += value; }
            remove { themNhanVien -= value; }
        }
        private event EventHandler suaBan;
        public event EventHandler SuaBan
        {
            add { suaBan += value; }
            remove { suaBan -= value; }
        }
        private event EventHandler suaNhanVien;
        public event EventHandler SuaNhanVien
        {
            add { suaNhanVien += value; }
            remove { suaNhanVien -= value; }
        }
        private event EventHandler xoaBan;
        public event EventHandler XoaBan
        {
            add { xoaBan += value; }
            remove { xoaBan -= value; }
        }
        private event EventHandler xoaNhanVien;
        public event EventHandler XoaNhanVien
        {
            add { xoaNhanVien += value; }
            remove { xoaNhanVien -= value; }
        }
        private event EventHandler xoaMon;
        public event EventHandler XoaMon
        {
            add { xoaMon += value; }
            remove { xoaMon -= value; }
        }
        private event EventHandler capNhatMon;
        public event EventHandler CapNhatMon
        {
            add { capNhatMon += value; }
            remove { capNhatMon -= value; }
        }
        private event EventHandler capNhatDanhMuc;
        public event EventHandler CapNhatDanhMuc
        {
            add { capNhatDanhMuc += value; }
            remove { capNhatDanhMuc -= value; }
        }

    }
}
