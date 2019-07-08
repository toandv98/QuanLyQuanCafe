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
    public partial class fmThanhToan : Form
    {
        public fmThanhToan()
        {
            InitializeComponent();
        }
        public void LoadThanhToan(string ten, double tongTien, int giamGia, double truGiamGia)
        {
            CultureInfo culture = new CultureInfo("vi-VN");
            lblTenBan.Text = ten;
            txbTongTien.Text = tongTien.ToString("c", culture);
            txbGiamGia.Text = giamGia.ToString() + " %";
            txbThanhTien.Text = truGiamGia.ToString("c", culture);
        }
        private void btnThanhToan_Click(object sender, EventArgs e)
        {
            this.DialogResult = DialogResult.OK;
        }

        private void btnThoat_Click(object sender, EventArgs e)
        {
            this.Close();
        }
    }
}
