using GHelper.Report;
using System;
using System.Data;
using System.IO;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Collections.Generic;


namespace ITTacker
{
    public partial class NoteSearchReport : System.Web.UI.Page
    {
        public void Page_Init(object o, EventArgs e)
        {

            Response.Cache.SetCacheability(HttpCacheability.NoCache);

            Response.Cache.SetExpires(DateTime.UtcNow.AddHours(-1));

            Response.Cache.SetNoStore();
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            string usr, bid, fimid;
            if (string.IsNullOrEmpty(Session["username"] as string))
            {
                Response.Redirect("SessionExpired.aspx");
            }
            else
            {
                usr = Session["username"].ToString();
                bid = Session["branch_id"].ToString();
                fimid = Session["firm_id"].ToString();
                this.hdUserId.Value = usr;
                this.hdBranchId.Value = bid;
                this.hdFirmId.Value = fimid;
                //hdPag.Value = Request.QueryString["pag"];
            }
        }

        //public string function reportGen()
        //{
        //    string str = "";
        //    ITService.ITServiceClient obj1 = new ITService.ITServiceClient();
        //    ds = obj1.TrackerSelect("REPORTVIEW", "STATUSRPT", mnuId, "", "");

        //    if (ds.Tables.Count > 0)
        //    {
        //        if (ds.Tables[0].Rows.Count > 0)
        //        {
        //            DataTableToHTMLTable(ds.Tables[0]);
        //            //Excel_export(ds.Tables[0]);
        //            //if (ds.Tables[0].Rows.Count > 500)
        //            //{
        //            //    Excel_export(ds.Tables[0]);
        //            //}
        //            //else
        //            //{
        //            //    DataTableToHTMLTable(ds.Tables[0]);
        //            //}
        //        }
        //    }
        //    return strToString();
        //}

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
            ////
            string style = @"<style> TABLE { border: 1px solid black; } TD { border: 1px solid black; } </style> ";
            Response.Write(style);
            //////
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
        public class getDropDownData
        {
            public string id { get; set; }
            public string name { get; set; }
        }

        [WebMethod(EnableSession = true)]
        public static List<getDropDownData> getFillData(string pageVal, string pageval1, string pageval2)
        {
            DataSet ds;
            List<getDropDownData> getData = new List<getDropDownData>();
            ITTracker.ITService.ITServiceClient obj1 = new ITTracker.ITService.ITServiceClient();
            ds = obj1.TrackerSelect(pageVal, pageval1, pageval2, "", "");
            try
            {
                if (ds.Tables[0].Rows.Count > 0)
                {
                    foreach (DataRow dr in ds.Tables[0].Rows)
                    {
                        getData.Add(new getDropDownData()
                        {
                            id = dr[0].ToString(),
                            name = dr[1].ToString()
                        });
                    }
                }
            }
            catch (Exception e)
            {

            }
            return getData;
        }
        [WebMethod(EnableSession = true)]
        public static string GetReportDtls(string pageVal, string pageval1, string pageval2)
        {
            string result = "";

            DataSet ds = new DataSet();

            ITTracker.ITService.ITServiceClient obj1 = new ITTracker.ITService.ITServiceClient();
            ds = obj1.TrackerSelect(pageVal, pageval1, pageval2, "", "");

            try
            {
                if (ds.Tables[0].Rows.Count > 0)
                {
                    foreach (DataRow dr in ds.Tables[0].Rows)
                    {
                        //result = result + dr[0].ToString() + 'Θ';
                        string row1 = "";
                        foreach (DataColumn dc in ds.Tables[0].Columns)
                        {
                            //str1 = dr[dc].ToString();
                            //1µ2µ3µ4µ8µ
                            row1 = row1 + dr[dc] + "µ";
                        }
                        result = result + row1 + "Θ";
                    }
                    return result;
                }
                else
                {
                    return "";
                }
            }
            catch (Exception e)
            {
                // return e.Message;
            }
            return result;
        }

        [WebMethod(EnableSession = true)]
        public static string GetSearchReportDtls(string pageVal, string pageval1, string pageval2)
        {
            string result = "";

            DataSet ds = new DataSet();
            //PWA_Service.PWA_ServiceClient obj1 = new PWA_Service.PWA_ServiceClient();
            //ds = obj1.PwaSelectData("PWAAPP", pageVal, pageval1, pageval2, "");
            //ITTracker.ITService.ITServiceClient obj1 = new ITTracker.ITService.ITServiceClient();
            ITTracker.ITService.ITServiceClient obj1 = new ITTracker.ITService.ITServiceClient();
            ds = obj1.TrackerSelect(pageVal, pageVal, pageval1, pageval2, "");

            try
            {
              if (ds.Tables[0].Rows.Count > 0)
              {
                foreach (DataRow dr in ds.Tables[0].Rows)
                {
                    //result = result + dr[0].ToString() + 'Θ';
                    string row1 = "";
                    foreach (DataColumn dc in ds.Tables[0].Columns)
                    {
                        //str1 = dr[dc].ToString();
                        //1µ2µ3µ4µ8µ
                        row1 = row1 + dr[dc] + "µ";
                    }
                    result = result + row1 + "Θ";
                }
                return result;
              }
              else
              {
                return "";
              }
            }
            catch (Exception e)
            {
                // return e.Message;
            }
            return result;
        }
    }
}