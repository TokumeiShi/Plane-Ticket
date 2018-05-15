﻿using BUS;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Plane_Ticket
{
    public partial class frmTraCuuChuyenBay : Form
    {
        #region Properties
        BUS_ChuyenBay busChuyenBay;
        #endregion

        #region Initialize
        public frmTraCuuChuyenBay()
        {
            InitializeComponent();
            busChuyenBay = new BUS_ChuyenBay();
            KhoiTaoGiaoDien();
        }

        #endregion

        #region Methods
        private void TaoLai()
        {
        }
        private void btnTimKiem_Click(object sender, EventArgs e)
        {
            if (cboSanBayDi.Text != "" && cboSanBayDen.Text != "" && dtpNgayKHTu.Text != "" && dtpNgayKHDen.Text != "")
            {
                try
                {
                    string maSanBayDi = cboSanBayDi.SelectedValue.ToString();
                    string maSanBayDen = cboSanBayDen.SelectedValue.ToString();
                    DateTime ngayKHTu = dtpNgayKHTu.Value;
                    DateTime ngayKHDen = dtpNgayKHDen.Value;
                    TaoBangDSChuyenBayTheoYeuCau(maSanBayDi, maSanBayDen, ngayKHTu, ngayKHDen);
                }
                catch(Exception a)
                {

                }
                finally
                {
                    TaoLai();
                }
               
                
            }
            else
            {
                MessageBox.Show("Vui lòng nhập đầy đủ thông tin!", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Information);

            }

        }
        private void KhoiTaoGiaoDien()
        {
            BUS_SanBay busSanBay = new BUS_SanBay();
            busSanBay = new BUS_SanBay();
            DataTable dtSanBayDi = new DataTable();
            dtSanBayDi = busSanBay.Get();
            cboSanBayDi.DataSource = dtSanBayDi;
            cboSanBayDi.DisplayMember = "TENSANBAY";
            cboSanBayDi.ValueMember = "MASANBAY";


            DataTable dtSanBayDen = new DataTable();
            dtSanBayDen = busSanBay.Get();
            cboSanBayDen.DataSource = dtSanBayDen;
            cboSanBayDen.DisplayMember = "TENSANBAY";
            cboSanBayDen.ValueMember = "MASANBAY";
        }
        private void TaoBangDSChuyenBayTheoYeuCau(string maSanBayDen, string maSanBayDi, DateTime thoiGianKHTu, DateTime thoiGianKHDen)
        {
            DataTable dtChuyenBay = busChuyenBay.Search(maSanBayDen,maSanBayDi, thoiGianKHTu, thoiGianKHDen);
            dtgvChuyenBay.DataSource = dtChuyenBay;
            dtgvChuyenBay.Sort(dtgvChuyenBay.Columns[0], ListSortDirection.Descending);
            dtgvChuyenBay.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.Fill;
            dtgvChuyenBay.AutoSizeRowsMode = DataGridViewAutoSizeRowsMode.None;
        }
        #endregion


    }
}
