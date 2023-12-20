using GHelper.Report;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ITTracker
{
    public partial class RDReportShow : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            string usr;
            if (string.IsNullOrEmpty(Session["username"] as string))
            {
                Response.Redirect("SessionExpired.aspx");
            }
            else
            {
                usr = Session["username"].ToString();
                this.Hduser.Value = usr;

            }
            DataSet ds = new DataSet();
           
            string mnuId = Decrypt(HttpUtility.UrlDecode(Request.QueryString["mnuId"]));
     
            menuid.Value = mnuId;

            ITService.ITServiceClient obj1 = new ITService.ITServiceClient();
            ds = obj1.TrackerSelect("RANDWORKREPORT", mnuId, "", "", "");

            this.menuid.Value = mnuId;
            // GetDataFromDB(mnuId);

            if (ds.Tables.Count > 0)
            {

                if (ds.Tables[0].Rows.Count > 0)
                {
                    if (ds.Tables[0].Rows.Count > 500)
                    {
                        // Excel_export(ds.Tables[0]);
                        DataTableToHTMLTable(ds.Tables[0]);
                    }
                    else
                    {
                        DataTableToHTMLTable(ds.Tables[0]);
                    }
                }
                else
                {
                    this.Reportcount.Value = "";

                    MyTable.InnerHtml = "No data to view";
                    MyTable.Style.Add("color", "red");
                    MyTable.Style.Add("font-size", "15px");
                    MyTable.Style.Add("padding-top", "1em");
                    btn_Excel.Style.Add("display", "none");



                }
            }


            // lblTitle.Text = mnuName;
        }



        private string Decrypt(string cipherText)
        {
            string EncryptionKey = "J1MAORUPPHANAMN";
            cipherText = cipherText.Replace(" ", "+");
            byte[] cipherBytes = Convert.FromBase64String(cipherText);
            using (Aes encryptor = Aes.Create())
            {
                Rfc2898DeriveBytes pdb = new Rfc2898DeriveBytes(EncryptionKey, new byte[] { 0x49, 0x76, 0x61, 0x6e, 0x20, 0x4d, 0x65, 0x64, 0x76, 0x65, 0x64, 0x65, 0x76 });
                encryptor.Key = pdb.GetBytes(32);
                encryptor.IV = pdb.GetBytes(16);
                using (MemoryStream ms = new MemoryStream())
                {
                    using (CryptoStream cs = new CryptoStream(ms, encryptor.CreateDecryptor(), CryptoStreamMode.Write))
                    {
                        cs.Write(cipherBytes, 0, cipherBytes.Length);
                        cs.Close();
                    }
                    cipherText = Encoding.Unicode.GetString(ms.ToArray());
                }
            }
            return cipherText;
        }
        public string DataTableToHTMLTable(DataTable inTable)
        {
            System.Text.StringBuilder dString = new System.Text.StringBuilder();
            dString.Append("<table id='example' class='display' cellpadding='0' cellspacing='0' border='0'>");
            dString.Append(GetHeader(inTable));
            dString.Append(GetBody(inTable));
            dString.Append("</table>");
            MyTable.InnerHtml = dString.ToString();
            return "";
        }

        private string GetHeader(DataTable dTable)
        {
            System.Text.StringBuilder dString = new System.Text.StringBuilder();
            dString.Append("<thead><tr>");
            foreach (DataColumn dColumn in dTable.Columns)
            {
                dString.AppendFormat("<th>{0}</th>", dColumn.ColumnName);
            }
            dString.Append("</tr></thead>");
            return dString.ToString();
        }

        private string GetBody(DataTable dTable)
        {
            System.Text.StringBuilder dString = new System.Text.StringBuilder();
            dString.Append("<tbody>");
            foreach (DataRow dRow in dTable.Rows)
            {
                dString.Append("<tr class='odd_gradeX'>");
                for (int dCount = 0; dCount < dTable.Columns.Count; dCount++)
                {
                    dString.AppendFormat("<td style=text-align:left>{0}</td>", dRow[dCount]);
                }
                dString.Append("</tr>");
            }
            dString.Append("</tbody>");
            return dString.ToString();
        }

        private string GetFooter(DataTable dTable)
        {
            System.Text.StringBuilder dString = new System.Text.StringBuilder();
            dString.Append("<tfoot><tr>");
            foreach (DataColumn dColumn in dTable.Columns)
            {
                dString.AppendFormat("<th>{0}</th>", dColumn.ColumnName);
            }
            dString.Append("</tr></tfoot>");
            return dString.ToString();
        }

        protected void btn_Excel_Click(object sender, EventArgs e)
        {
            System.IO.StringWriter stringWrite = new System.IO.StringWriter();
            HtmlTextWriter htmlWrite = new HtmlTextWriter(stringWrite);
            Response.Clear();
            Response.Charset = "";
            Response.ContentEncoding = System.Text.Encoding.UTF8;
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.ContentType = "application/vnd.ms-excel";
            Response.AddHeader("content-disposition", "attachment;filename=DailyTrackReport.xls");
            Panel1.RenderControl(htmlWrite);
            Response.Write(stringWrite.ToString());
            Response.End();

        }

        public void Excel_export(DataTable dt)
        {
            //System.IO.StringWriter stringWrite = new System.IO.StringWriter();
            //HtmlTextWriter htmlWrite = new HtmlTextWriter(stringWrite);
            //Response.Clear();
            //Response.Charset = "";
            //Response.ContentEncoding = System.Text.Encoding.UTF8;
            //Response.Cache.SetCacheability(HttpCacheability.NoCache);
            //Response.ContentType = "application/vnd.ms-excel";
            //Response.AddHeader("content-disposition", "attachment;filename=MarketExpenseReport.xls");
            //Panel1.RenderControl(htmlWrite);
            //Response.Write(stringWrite.ToString());
            //Response.End();
            ExcelExport Gobj = new ExcelExport();
            string fnm = Gobj.ExportToExcelfile(dt, this.Server.MapPath(this.Request.ApplicationPath));
            Response.ContentType = "application/vnd.ms-excel";

            Response.AppendHeader("Content-Disposition", "attachment; filename=Report.xls");

            Response.TransmitFile(fnm);

            Response.End();

        }





        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static string getData(string menuId)
        {


            string data = GetJson(menuId);
            return data;
        }
        public static string GetJson(string menuId)
        {//
         // List<ReportData> datatlist = new List<ReportData>();

            // ReportData data1 = new ReportData();
            DataTable dt = new DataTable();
            DataSet ds = new DataSet();

            ITService.ITServiceClient obj1 = new ITService.ITServiceClient();

            ds = obj1.TrackerSelect("DAILYREPORTVIEW", "DAILYRPT", menuId, "", "");
            dt = ds.Tables[0];
            //da.Fill(dt);
            System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
            List<System.Collections.Generic.Dictionary<string, object>> rows = new List<Dictionary<string, object>>();
            Dictionary<string, object> row;

            //foreach (DataRow dr in ds.Tables[0].Rows)
            //{
            //    row = new Dictionary<string, object>();
            //    foreach (DataColumn col in ds.Tables[0].Columns)
            //    {
            //        row.Add(col.ColumnName, dr[col]);
            //    }
            //    rows.Add(row);
            //}

            foreach (DataRow dr in dt.Rows)
            {
                row = new Dictionary<string, object>();
                foreach (DataColumn col in dt.Columns)
                {
                    row.Add(col.ColumnName, dr[col]);
                }
                rows.Add(row);
            }
            string JSONresult;
            JSONresult = Newtonsoft.Json.JsonConvert.SerializeObject(dt);
            var jsonData = new
            {
                colModel = dt.Columns.Cast<DataColumn>().Select(x =>
                  new
                  {
                      name = x.ColumnName,
                      index = x.ColumnName
                  }
                ),
            };
            // return jsonData;
            return serializer.Serialize(rows);
        }



        [WebMethod(EnableSession = true)]
        public static System.Collections.Generic.List<System.Collections.Generic.Dictionary<string, object>> GetDataFromDB(string mnuId)
        {
            DataTable dt = new DataTable();
         

            DataSet ds = new DataSet();
            ITService.ITServiceClient obj1 = new ITService.ITServiceClient();
            ds = obj1.TrackerSelect("DAILYREPORTVIEW", "DAILYRPT", mnuId, "", "");
            dt = ds.Tables[0];
           
            System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
            List<System.Collections.Generic.Dictionary<string, object>> rows = new List<Dictionary<string, object>>();
            Dictionary<string, object> row;

           

            foreach (DataRow dr in dt.Rows)
            {
                row = new Dictionary<string, object>();
                foreach (DataColumn col in dt.Columns)
                {
                    row.Add(col.ColumnName, dr[col]);
                }
                rows.Add(row);
            }
         
            return rows;
      

        }


    }
}