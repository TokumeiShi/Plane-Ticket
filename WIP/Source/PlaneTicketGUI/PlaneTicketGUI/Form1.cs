﻿using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace PlaneTicketGUI
{
    public partial class PlaneTicketGUI : Form
    {
        public PlaneTicketGUI()
        {
            InitializeComponent();
        }

        private void button3_Click(object sender, EventArgs e)
        {
            Form frm1 = new SignInGUI();
            frm1.Show();
            this.Hide();
        }
    }
}
