using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using System.Data;
using System.Data.OleDb;
using System.IO;
using System.Configuration;
using System.Collections;
using System.Net.Mail;

namespace ITTacker
{
    public partial class ApprovePendingList : System.Web.UI.Page
    {
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
        [WebMethod(EnableSession = true)]
        public static string getTableData(string pageVal, string pageval1, string pageval2)
        {
            DataSet ds;
            string str = "";

            PWA_Service.PWA_ServiceClient obj1 = new PWA_Service.PWA_ServiceClient();
            ds = obj1.PwaSelectData("PWAAPP", pageVal, pageval1, "", "");
            if (ds.Tables.Count > 0)
            {
                if (ds.Tables[0].Rows.Count > 0)
                {
                    foreach (DataRow dr in ds.Tables[0].Rows)
                    {
                        string row1 = "";
                        foreach (DataColumn dc in ds.Tables[0].Columns)
                        {
                            //str1 = dr[dc].ToString();
                            //1µ2µ3µ4µ8µ
                            row1 = row1 + dr[dc] + "µ";
                        }
                        str = str + row1 + "Θ";
                    }

                }

            }
            return str;
        }
    }
}