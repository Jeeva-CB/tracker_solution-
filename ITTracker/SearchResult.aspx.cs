using GHelper.Report;
using System;
using System.Data;
using System.IO;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.UI;

namespace ITTracker
{
    public partial class SearchResult : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            DataSet ds = new DataSet();
            string mnuId = Request.QueryString.Get("mnuId");
            //string mnuId = Decrypt(HttpUtility.UrlDecode(Request.QueryString["mnuId"]));
            //string mnuId = this.hdSearchKey.Value;

            // string poid = Decrypt(HttpUtility.UrlDecode(Request.QueryString["poid"]));
            //string mnuName = Request.QueryString.Get("mnuName");
            //string mnuName = Request.QueryString["mnuName"];
            //PurchaseService.PurchaseClient obj = new PurchaseService.PurchaseClient();
            //ds = obj.PurchaseFillData("PURCHASEREPORT", "REPORTVIEW", mnuId, "");
            //ITService.ITServiceClient obj1 = new ITService.ITServiceClient();
            //ds = obj1.TrackerSelect("REPORTVIEW", "STATUSRPT", mnuId, "", "");
            ITTracker.ITService.ITServiceClient obj1 = new ITTracker.ITService.ITServiceClient();
            string s = Convert.ToString(HttpContext.Current.Session["username"]);
            ds = obj1.TrackerSelect("GetSearchReport", mnuId, Convert.ToString(HttpContext.Current.Session["username"]), "", "");

            if (ds.Tables.Count > 0)
            {
                if (ds.Tables[0].Rows.Count > 0)
                {
                    DataTableToHTMLTable(ds.Tables[0]);
                    //Excel_export(ds.Tables[0]);
                    //if (ds.Tables[0].Rows.Count > 500)
                    //{
                    //    Excel_export(ds.Tables[0]);
                    //}
                    //else
                    //{
                    //    DataTableToHTMLTable(ds.Tables[0]);
                    //}
                }
            }
           

            // lblTitle.Text = mnuName;
        }
        private string Decrypt(string cipherText)
        {
            string EncryptionKey = "MAKV2SPBNI99212";
            //string EncryptionKey = "J1MAORUPPHANAMN";
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
            dString.Append("<table id='example' class='display' cellpadding='0' cellspacing='0' border='0' onmousedown='gr();'>");
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
            ////
            string style = @"<style> TABLE { border: 1px solid black; } TD { border: 1px solid black; } </style> ";
            Response.Write(style);
            //////  application/vnd.openxmlformats-officedocument.spreadsheetml.sheet
             Response.ContentType = "application/vnd.ms-excel";
            Response.AddHeader("content-disposition", "attachment;filename=CRFStatusReport.xls");
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
            Response.Flush();

            Response.End();

        }


    }
}
