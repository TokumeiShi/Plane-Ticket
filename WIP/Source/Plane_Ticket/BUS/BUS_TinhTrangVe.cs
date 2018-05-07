﻿using DAL;
using DTO;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BUS
{
    public class BUS_TinhTrangVe
    {
        DAL_TinhTrangVe dal = new DAL_TinhTrangVe();

        public DataTable Get()
        {
            return dal.Get();
        }
        public bool Add(DTO_TinhTrangVe dto)
        {
            return dal.Add(dto);
        }
        public bool Update(DTO_TinhTrangVe dto)
        {
            return dal.Update(dto);
        }

        public bool Delete(DTO_TinhTrangVe dto)
        {
            return dal.Delete(dto);
        }

        public DataTable GetOfMaChuyenBay(string maChuyenBay)
        {
            return dal.GetOfMaChuyenBay(maChuyenBay);
        }
    }
}
