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
    public partial class fmDangNhap : Form
    {
        public fmDangNhap()
        {
            InitializeComponent();
            KiemTra();
        }
        void KiemTra()
        {
            if(TaiKhoanDAO.Instance.KiemTra())
            {
                txbTenDangNhap.Text = "admin";
                txbMatKhau.Text = "000";
            }
        }
        private void btnDangNhap_Click(object sender, EventArgs e)
        {
            string tenDangNhap = txbTenDangNhap.Text;
            string matKhau = txbMatKhau.Text;
            if (DangNhap(tenDangNhap, matKhau))
            {
                TaiKhoan tk = TaiKhoanDAO.Instance.XuatTaiKhoanBangTenTaiKhoan(tenDangNhap);
                fmQuanLyBan f = new fmQuanLyBan(tk);
                this.Hide();
                f.ShowDialog();
                this.Show();
            }
            else
            {
                MessageBox.Show("Sai tên tài khoản hoặc mật khẩu!","Lỗi",MessageBoxButtons.OK,MessageBoxIcon.Error);
            }
        }
        bool DangNhap(string tenDangNhap, string matKhau)
        {
            return TaiKhoanDAO.Instance.DangNhap(tenDangNhap, matKhau);
        }
        private void BtnThoat_Click(object sender, EventArgs e)
        {
            Application.Exit();
        }

        private void fmDangNhap_FormClosing(object sender, FormClosingEventArgs e)
        {
            if (MessageBox.Show("Bạn muốn thoát?", "Thông báo", MessageBoxButtons.OKCancel) != System.Windows.Forms.DialogResult.OK)
            {
                e.Cancel = true;
            }
        }

    }
}
