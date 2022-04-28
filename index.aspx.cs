using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SignalRRealTimeSQL
{
    public partial class index : System.Web.UI.Page
    {
        public static int ExecuteSqlNonQuery(String sqlStr)
        {
            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["DataBase"].ConnectionString);
            conn.Open();
            SqlCommand cmd = new SqlCommand(sqlStr, conn);
            cmd.CommandType = CommandType.Text;
            cmd.CommandTimeout = 600; // thời gian thực thi trong 10 phút
            if (conn.State == ConnectionState.Closed) conn.Open();
            try
            {
                cmd.ExecuteNonQuery();
                conn.Close();
                return 0;
            }
            catch (SqlException e)
            {
                conn.Close();
                return e.State;
            }
        }
            protected void Page_Load(object sender, EventArgs e)
        {

        }

        [WebMethod]
        public static IEnumerable<BangGiaTrucTuyen> GetData()
        {

            using (var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["DataBase"].ConnectionString))
            {
                if (connection.State == ConnectionState.Closed)
                    connection.Open();
                using (SqlCommand command = new SqlCommand(@"SELECT [ID] , [MACP] ,[GIAMUA3] ,[LUONGMUA3] ,[GIAMUA2] ,[LUONGMUA2] ,[GIAMUA1] ,[LUONGMUA1] ,[GIABAN3] ,[LUONGBAN3] ,[GIABAN2] ,[LUONGBAN2] ,[GIABAN1] ,[LUONGBAN1] ,[GIAKHOP] ,[LUONGKHOP] ,[TONGSO] FROM [dbo].[BANGGIATRUCTUYEN]", connection))
                {
                    // Make sure the command object does not already have
                    // a notification object associated with it.
                    command.Notification = null;
                    SqlDependency.Stop(ConfigurationManager.ConnectionStrings["DataBase"].ConnectionString);
                    SqlDependency.Start(ConfigurationManager.ConnectionStrings["DataBase"].ConnectionString);
                    SqlDependency dependency = new SqlDependency(command);
                    dependency.OnChange += new OnChangeEventHandler(dependency_OnChange);

                    if (connection.State == ConnectionState.Closed)
                        connection.Open();

                    using (var reader = command.ExecuteReader())
                            return reader.Cast<IDataRecord>()
                            .Select(x => new BangGiaTrucTuyen()
                            {
                                ID = x.GetInt32(0),
                                MACP = x.GetString(1),
                                GIAMUA3 = x.GetDouble(2),
                                LUONGMUA3 = x.GetInt32(3),
                                GIAMUA2 = x.GetDouble(4),
                                LUONGMUA2 = x.GetInt32(5),
                                GIAMUA1 = x.GetDouble(6),
                                LUONGMUA1 = x.GetInt32(7),
                                GIABAN3 = x.GetDouble(8),
                                LUONGBAN3 = x.GetInt32(9),
                                GIABAN2 = x.GetDouble(10),
                                LUONGBAN2 = x.GetInt32(11),
                                GIABAN1 = x.GetDouble(12),
                                LUONGBAN1 = x.GetInt32(13),
                                GIAKHOP = x.GetDouble(14),
                                LUONGKHOP = x.GetInt32(15),
                                TONGSO = x.GetInt32(16)
                            }).ToList();



                }
            }
        }
        private static void dependency_OnChange(object sender, SqlNotificationEventArgs e)
        {
            MyHub.Show();
        }

        protected void btnDatLenh_Click(object sender, EventArgs e)
        {
            if (!Regex.IsMatch(txtMaCP.Text.Trim(), "[A-Za-z0-9]{1,7}"))
            {
                PageUtility.MessageBox(this, "Mã cổ phiếu không được để trống!");
                txtMaCP.Focus();
                return;
            }

            if (!Regex.IsMatch(txtSoLuong.Text.Trim(), "^\\d+$"))
            {
                PageUtility.MessageBox(this, "Số lượng không hợp lệ!");
                txtSoLuong.Focus();
                return;
            }

            else if (!Regex.IsMatch(txtGiaDat.Text.Trim(), "^\\d+$"))
            {
                PageUtility.MessageBox(this, "giá đặt không hợp lệ!");
                txtGiaDat.Focus();
                return;
            }

            //
            //
            String MaCP = txtMaCP.Text;
            int SoLuong = Int32.Parse(txtSoLuong.Text.Trim());
            float GiaDat = float.Parse(txtGiaDat.Text.Trim());
            String LoaiGD = cbbLoaiGD.SelectedValue.ToString();
            String sql = " INSERT INTO LENHDAT VALUES( " + "'" + MaCP + "' ,  GETDATE(),'" + LoaiGD + "', 'LO'," + SoLuong + "," + GiaDat + ", N'Chờ khớp')";
            Console.WriteLine(sql);
            if (ExecuteSqlNonQuery(sql) == 0)
            {
                PageUtility.MessageBox(this, "Đăt lệnh thành công!");
                txtMaCP.Text = "";
                txtSoLuong.Text = "";
                txtGiaDat.Text = "";
                return;
            }
            else
            {
                PageUtility.MessageBox(this, "Đặt lệnh thất bại!");
                return;
            }
        }
    }
}