using System;
using System.Collections.Generic;
using System.Data;
using System.Drawing.Imaging;
using System.IO;
using System.Text;
using System.Web;
using System.Web.Services;

namespace ITTracker
{
    public partial class CRFtracker : System.Web.UI.Page
    { 
        public void Page_Init(object o, EventArgs e)
    {

        Response.Cache.SetCacheability(HttpCacheability.NoCache);

        Response.Cache.SetExpires(DateTime.UtcNow.AddHours(-1));

        Response.Cache.SetNoStore();
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        string usr, bid, fimid, ipaddres, sessn;
        if (string.IsNullOrEmpty(Session["username"] as string))
        {
            Response.Redirect("SessionExpired.aspx");
        }
        else
        {
            usr = Session["username"].ToString();
            bid = Session["branch_id"].ToString();
            fimid = Session["firm_id"].ToString();
            ipaddres = Session["system_ip"].ToString();
            sessn = Session["sessionkey"].ToString();
            this.hdUserId.Value = usr;
            this.hdBranchId.Value = bid;
            this.hdFirmId.Value = fimid;
            this.hdnSystemIP.Value = ipaddres;
            this.hdSesssion.Value = sessn;

        }
    }

        [WebMethod(EnableSession = true)]
        public static string getTableData(string pageVal, string pageval1, string pageval2)
        {
            DataSet ds;
            string str = "";
            ITTracker.ITService.ITServiceClient obj1 = new ITTracker.ITService.ITServiceClient();
            ds = obj1.TrackerSelect(pageVal, pageval1, pageval2, "", "");
            
            if (ds.Tables.Count > 0)
            {
                if (ds.Tables[0].Rows.Count > 0)
                {
                    foreach (DataRow dr in ds.Tables[0].Rows)
                    {
                        string row1 = "";
                        foreach (DataColumn dc in ds.Tables[0].Columns)
                        {
                            
                            row1 = row1 + dr[dc] + "µ";
                        }
                        str = str + row1 + "Θ";
                    }

                }

            }
            return str;
        }




        [WebMethod(EnableSession = true)]
        public static string Confirm(string pageVal, string pageval1, string pageval2)
        {
            DataSet ds;
            string str = "";
            ITTracker.ITService.ITServiceClient obj1 = new ITTracker.ITService.ITServiceClient();
            ds = obj1.TrackerSelect(pageVal, pageval1, pageval2, "", "");
            
            try
            {
                if (ds.Tables[0].Rows.Count > 0)
                {
                    str = ds.Tables[0].Rows[0][0].ToString();
                }
            }
            catch (Exception e)
            {
                return e.Message;
            }
            return str;
        }



    }
}