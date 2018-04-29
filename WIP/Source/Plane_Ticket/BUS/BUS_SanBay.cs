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
    public class BUS_SanBay
    {
        DAL_SanBay dal = new DAL_SanBay();

        public DataTable Get()
        {
            return dal.Get();
        }
        public bool Add(DTO_SanBay dto)
        {
            return dal.Add(dto);
        }
        public bool Update(DTO_SanBay dto)
        {
            return dal.Update(dto);
        }

        public bool Delete(DTO_SanBay dto)
        {
            return dal.Delete(dto);
        }
    }
}
