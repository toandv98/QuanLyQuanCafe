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
    public partial class fmThongTin : Form
    {
        private TaiKhoan dangNhapTaiKhoan;

        public TaiKhoan DangNhapTaiKhoan
        {
            get { return dangNhapTaiKhoan; }
            set { dangNhapTaiKhoan = value; DatKieuTaiKhoan(dangNhapTaiKhoan); }
        }
        public fmThongTin(TaiKhoan acc)
        {
            InitializeComponent();

            DangNhapTaiKhoan = acc;
        }

        void DatKieuTaiKhoan(TaiKhoan acc)
        {
            txbTenDangNhap.Text = DangNhapTaiKhoan.TenDangNhap;
            txbTenHienThi.Text = DangNhapTaiKhoan.TenHienThi;
        }

        void CapNhatThongTinTaiKhoan()
        {
            string tenHienthi = txbTenHienThi.Text;
            string matKhau = txbMatKhau.Text;
            string matKhauMoi = txbMatKhauMoi.Text;
            string nhapLaiMatKhau = txbXacNhan.Text;
            string tenDangnhap = txbTenDangNhap.Text;

            if (!matKhauMoi.Equals(nhapLaiMatKhau))
            {
                MessageBox.Show("Vui lòng nhập lại mật khẩu đúng với mật khẩu mới!", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
            else
            {
                if (TaiKhoanDAO.Instance.SuaTaiKhoan(tenDangnhap, tenHienthi, matKhau, matKhauMoi))
                {
                    MessageBox.Show("Cập nhật thành công", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Information);
                    if (capNhatTaiKhoan != null)
                        capNhatTaiKhoan(this, new AccountEvent(TaiKhoanDAO.Instance.XuatTaiKhoanBangTenTaiKhoan(tenDangnhap)));
                }
                else
                {
                    MessageBox.Show("Vui lòng điền đúng mật khấu");
                }
            }
        }

        private event EventHandler<AccountEvent> capNhatTaiKhoan;
        public event EventHandler<AccountEvent> UpdateAccount
        {
            add { capNhatTaiKhoan += value; }
            remove { capNhatTaiKhoan -= value; }
        }

        private void btnCapNhat_Click(object sender, EventArgs e)
        {
            CapNhatThongTinTaiKhoan();
        }

        private void btnThoat_Click(object sender, EventArgs e)
        {
            this.Close();
        }
    }

    public class AccountEvent : EventArgs
    {
        private TaiKhoan acc;

        public TaiKhoan Acc
        {
            get { return acc; }
            set { acc = value; }
        }

        public AccountEvent(TaiKhoan acc)
        {
            this.Acc = acc;
        }
    }
}

