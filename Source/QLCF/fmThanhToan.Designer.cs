namespace QLCF
{
    partial class fmThanhToan
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(fmThanhToan));
            this.panel1 = new System.Windows.Forms.Panel();
            this.panel4 = new System.Windows.Forms.Panel();
            this.txbThanhTien = new System.Windows.Forms.TextBox();
            this.label1 = new System.Windows.Forms.Label();
            this.btnThoat = new System.Windows.Forms.Button();
            this.panel3 = new System.Windows.Forms.Panel();
            this.txbGiamGia = new System.Windows.Forms.TextBox();
            this.lblGG = new System.Windows.Forms.Label();
            this.panel2 = new System.Windows.Forms.Panel();
            this.txbTongTien = new System.Windows.Forms.TextBox();
            this.lbltt = new System.Windows.Forms.Label();
            this.lblTenBan = new System.Windows.Forms.Label();
            this.btnThanhToan = new System.Windows.Forms.Button();
            this.pictureBox1 = new System.Windows.Forms.PictureBox();
            this.panel1.SuspendLayout();
            this.panel4.SuspendLayout();
            this.panel3.SuspendLayout();
            this.panel2.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).BeginInit();
            this.SuspendLayout();
            // 
            // panel1
            // 
            this.panel1.Controls.Add(this.panel4);
            this.panel1.Controls.Add(this.btnThoat);
            this.panel1.Controls.Add(this.btnThanhToan);
            this.panel1.Controls.Add(this.panel3);
            this.panel1.Controls.Add(this.panel2);
            this.panel1.Location = new System.Drawing.Point(26, 78);
            this.panel1.Name = "panel1";
            this.panel1.Size = new System.Drawing.Size(319, 203);
            this.panel1.TabIndex = 1;
            // 
            // panel4
            // 
            this.panel4.Controls.Add(this.txbThanhTien);
            this.panel4.Controls.Add(this.label1);
            this.panel4.Location = new System.Drawing.Point(3, 102);
            this.panel4.Name = "panel4";
            this.panel4.Size = new System.Drawing.Size(310, 39);
            this.panel4.TabIndex = 4;
            // 
            // txbThanhTien
            // 
            this.txbThanhTien.Font = new System.Drawing.Font("Arial", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txbThanhTien.Location = new System.Drawing.Point(104, 8);
            this.txbThanhTien.Name = "txbThanhTien";
            this.txbThanhTien.ReadOnly = true;
            this.txbThanhTien.Size = new System.Drawing.Size(203, 26);
            this.txbThanhTien.TabIndex = 1;
            this.txbThanhTien.TextAlign = System.Windows.Forms.HorizontalAlignment.Right;
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Arial", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label1.Location = new System.Drawing.Point(3, 11);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(96, 19);
            this.label1.TabIndex = 0;
            this.label1.Text = "Thành tiền:";
            // 
            // btnThoat
            // 
            this.btnThoat.Cursor = System.Windows.Forms.Cursors.Hand;
            this.btnThoat.DialogResult = System.Windows.Forms.DialogResult.Cancel;
            this.btnThoat.Font = new System.Drawing.Font("Arial", 11.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnThoat.Location = new System.Drawing.Point(213, 147);
            this.btnThoat.Name = "btnThoat";
            this.btnThoat.Size = new System.Drawing.Size(97, 45);
            this.btnThoat.TabIndex = 3;
            this.btnThoat.Text = "Thoát";
            this.btnThoat.UseVisualStyleBackColor = true;
            this.btnThoat.Click += new System.EventHandler(this.btnThoat_Click);
            // 
            // panel3
            // 
            this.panel3.Controls.Add(this.txbGiamGia);
            this.panel3.Controls.Add(this.lblGG);
            this.panel3.Location = new System.Drawing.Point(3, 57);
            this.panel3.Name = "panel3";
            this.panel3.Size = new System.Drawing.Size(310, 39);
            this.panel3.TabIndex = 1;
            // 
            // txbGiamGia
            // 
            this.txbGiamGia.Font = new System.Drawing.Font("Arial", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txbGiamGia.Location = new System.Drawing.Point(104, 8);
            this.txbGiamGia.Name = "txbGiamGia";
            this.txbGiamGia.ReadOnly = true;
            this.txbGiamGia.Size = new System.Drawing.Size(203, 26);
            this.txbGiamGia.TabIndex = 1;
            this.txbGiamGia.TextAlign = System.Windows.Forms.HorizontalAlignment.Right;
            // 
            // lblGG
            // 
            this.lblGG.AutoSize = true;
            this.lblGG.Font = new System.Drawing.Font("Arial", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblGG.Location = new System.Drawing.Point(3, 11);
            this.lblGG.Name = "lblGG";
            this.lblGG.Size = new System.Drawing.Size(81, 19);
            this.lblGG.TabIndex = 0;
            this.lblGG.Text = "Giảm giá:";
            // 
            // panel2
            // 
            this.panel2.Controls.Add(this.txbTongTien);
            this.panel2.Controls.Add(this.lbltt);
            this.panel2.Location = new System.Drawing.Point(3, 12);
            this.panel2.Name = "panel2";
            this.panel2.Size = new System.Drawing.Size(310, 39);
            this.panel2.TabIndex = 0;
            // 
            // txbTongTien
            // 
            this.txbTongTien.Font = new System.Drawing.Font("Arial", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txbTongTien.Location = new System.Drawing.Point(104, 8);
            this.txbTongTien.Name = "txbTongTien";
            this.txbTongTien.ReadOnly = true;
            this.txbTongTien.Size = new System.Drawing.Size(203, 26);
            this.txbTongTien.TabIndex = 1;
            this.txbTongTien.TextAlign = System.Windows.Forms.HorizontalAlignment.Right;
            // 
            // lbltt
            // 
            this.lbltt.AutoSize = true;
            this.lbltt.Font = new System.Drawing.Font("Arial", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lbltt.Location = new System.Drawing.Point(3, 11);
            this.lbltt.Name = "lbltt";
            this.lbltt.Size = new System.Drawing.Size(87, 19);
            this.lbltt.TabIndex = 0;
            this.lbltt.Text = "Tổng tiền:";
            // 
            // lblTenBan
            // 
            this.lblTenBan.AutoSize = true;
            this.lblTenBan.Font = new System.Drawing.Font("Arial", 18F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblTenBan.Location = new System.Drawing.Point(134, 33);
            this.lblTenBan.Name = "lblTenBan";
            this.lblTenBan.Size = new System.Drawing.Size(0, 29);
            this.lblTenBan.TabIndex = 2;
            // 
            // btnThanhToan
            // 
            this.btnThanhToan.Cursor = System.Windows.Forms.Cursors.Hand;
            this.btnThanhToan.Font = new System.Drawing.Font("Arial", 11.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnThanhToan.ForeColor = System.Drawing.SystemColors.ActiveCaptionText;
            this.btnThanhToan.Image = global::QLCF.Properties.Resources.ncc;
            this.btnThanhToan.ImageAlign = System.Drawing.ContentAlignment.MiddleLeft;
            this.btnThanhToan.Location = new System.Drawing.Point(107, 147);
            this.btnThanhToan.Name = "btnThanhToan";
            this.btnThanhToan.Size = new System.Drawing.Size(98, 45);
            this.btnThanhToan.TabIndex = 2;
            this.btnThanhToan.Text = "Thanh\r\ntoán ";
            this.btnThanhToan.TextAlign = System.Drawing.ContentAlignment.MiddleRight;
            this.btnThanhToan.UseVisualStyleBackColor = true;
            this.btnThanhToan.Click += new System.EventHandler(this.btnThanhToan_Click);
            // 
            // pictureBox1
            // 
            this.pictureBox1.Image = global::QLCF.Properties.Resources.ktea;
            this.pictureBox1.Location = new System.Drawing.Point(55, 9);
            this.pictureBox1.Name = "pictureBox1";
            this.pictureBox1.Size = new System.Drawing.Size(73, 63);
            this.pictureBox1.SizeMode = System.Windows.Forms.PictureBoxSizeMode.StretchImage;
            this.pictureBox1.TabIndex = 0;
            this.pictureBox1.TabStop = false;
            // 
            // fmThanhToan
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(185)))), ((int)(((byte)(226)))), ((int)(((byte)(238)))));
            this.ClientSize = new System.Drawing.Size(360, 293);
            this.Controls.Add(this.pictureBox1);
            this.Controls.Add(this.lblTenBan);
            this.Controls.Add(this.panel1);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.SizableToolWindow;
            this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
            this.Name = "fmThanhToan";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Thanh toán";
            this.panel1.ResumeLayout(false);
            this.panel4.ResumeLayout(false);
            this.panel4.PerformLayout();
            this.panel3.ResumeLayout(false);
            this.panel3.PerformLayout();
            this.panel2.ResumeLayout(false);
            this.panel2.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Panel panel1;
        private System.Windows.Forms.Button btnThoat;
        private System.Windows.Forms.Button btnThanhToan;
        private System.Windows.Forms.Panel panel3;
        private System.Windows.Forms.TextBox txbGiamGia;
        private System.Windows.Forms.Label lblGG;
        private System.Windows.Forms.Panel panel2;
        private System.Windows.Forms.TextBox txbTongTien;
        private System.Windows.Forms.Label lbltt;
        private System.Windows.Forms.Panel panel4;
        private System.Windows.Forms.TextBox txbThanhTien;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label lblTenBan;
        private System.Windows.Forms.PictureBox pictureBox1;
    }
}