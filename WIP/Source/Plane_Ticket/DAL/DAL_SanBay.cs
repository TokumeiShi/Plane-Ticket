﻿using DTO;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL
{
    public class DAL_SanBay:DBConnect
    {
        public DataTable Get()
        {
            string sqlQuery = "SELECT* FROM SANBAY";
            SqlDataAdapter da = new SqlDataAdapter(sqlQuery, _con);
            DataTable dt = new DataTable();
            da.Fill(dt);
            return dt;
        }

        public bool Add(DTO_SanBay dto)
        {
            try
            {
                _con.Open();
                string sqlQuery = string.Format("INSERT INTO SANBAY(MASANBAY, TENSANBAY, TENTHANHPHO) VALUES('{0}', N'{1}', N'{2}')", dto.MaSanBay, dto.TenSanBay, dto.TenThanhPho);
                SqlCommand cmd = new SqlCommand(sqlQuery, _con);
                if (cmd.ExecuteNonQuery() > 0)
                    return true;
            }
            catch (Exception a)
            {

            }
            finally
            {
                _con.Close();
            }
            return false;
        }

        public bool Update(DTO_SanBay dto)
        {
            try
            {
                _con.Open();
                string sqlQuery = string.Format("UPDATE SANBAY SET TENSANBAY=N'{0}', MASANBAY='{1}', TENTHANHPHO=N'{2}')", dto.TenSanBay, dto.MaSanBay, dto.TenThanhPho);
                SqlCommand cmd = new SqlCommand(sqlQuery, _con);
                if (cmd.ExecuteNonQuery() > 0)
                {
                    return true;
                }
            }
            catch (Exception a)
            {

            }
            finally
            {
                _con.Close();
            }
            return false;
        }
        public bool Delete(DTO_SanBay dto)
        {
            try
            {
                _con.Open();
                string sqlQuery = string.Format("DELETE FROM SANBAY WHERE MASANBAY='{0}'", dto.MaSanBay);
                SqlCommand cmd = new SqlCommand(sqlQuery, _con);
                if (cmd.ExecuteNonQuery() > 0)
                {
                    return true;
                }
            }
            catch (Exception a)
            {

            }
            finally
            {
                _con.Close();
            }
            return false;
        }
    }
}
