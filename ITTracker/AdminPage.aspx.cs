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
using System.Web.Script.Serialization;

namespace ITTacker
{
    public partial class AdminPage : System.Web.UI.Page
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

                DataSet ds;
                string str = "0";
                PWA_Service.PWA_ServiceClient obj1 = new PWA_Service.PWA_ServiceClient();
                ds = obj1.PwaSelectData("PWAAPP", "GetAccessAdminForm", usr, "", "");
                if (ds.Tables[0].Rows.Count > 0)
                {
                    str = ds.Tables[0].Rows[0][0].ToString();
                }

                //try
                //{
                //    if (ds.Tables[0].Rows.Count > 0)
                //    {
                //        str = ds.Tables[0].Rows[0][0].ToString();
                //    }
                //}
                //catch (Exception e)
                //{
                //    str = "0";
                //}

                if (str == "0")
                {
                    Response.Redirect("AccessDenied.aspx");
                }
            }
           
        }
        [WebMethod(EnableSession = true)]
        public static string getTable(string pageVal)
        {
            string str = "";

            DataSet ds = new DataSet();
            PWA_Service.PWA_ServiceClient obj1 = new PWA_Service.PWA_ServiceClient();
            ds = obj1.PwaSelectData("PWAAPP", pageVal, "", "", "");
            if (ds.Tables.Count > 0)
            {
                if (ds.Tables[0].Rows.Count > 0)
                {
                    foreach (DataRow dr in ds.Tables[0].Rows)
                    {
                        str = str + dr[0] + "^" + dr[1] + "Θ";
                    }

                }

            }
            return str;
        }

        [WebMethod(EnableSession = true)]
        public static string AddDocType(string pageval1,string pageVal)
        {
            string str = "";
            DataSet ds = new DataSet();
            PWA_Service.PWA_ServiceClient obj1 = new PWA_Service.PWA_ServiceClient();
           ds=  obj1.PwaSelectData("PWAAPP", pageVal,pageval1, "", "");
            if(ds.Tables[0].Rows.Count > 0)
            {
                str = ds.Tables[0].Rows[0][0].ToString();
            }
            return str;
        }

        //[WebMethod(EnableSession = true)]
        //public static string getApprTable(string pageVal)
        //{
        //    string str = "";

        //    DataSet ds = new DataSet();
        //    PWA_Service.PWA_ServiceClient obj1 = new PWA_Service.PWA_ServiceClient();
        //    ds = obj1.PwaSelectData("PWAAPP", pageVal, "", "", "");
        //    if (ds.Tables.Count > 0)
        //    {
        //        if (ds.Tables[0].Rows.Count > 0)
        //        {
        //            foreach (DataRow dr in ds.Tables[0].Rows)
        //            {
        //                str = str + dr[0] + "^" + dr[1] + "^" + dr[2] + "^" + dr[3] + "Θ";
        //            }

        //        }

        //    }
        //    return str;
        //}

        [WebMethod(EnableSession = true)]
        public static string getTableData(string pageVal, string pageval1, string pageval2)
        {
            DataSet ds;
            string str = "";

            PWA_Service.PWA_ServiceClient obj1 = new PWA_Service.PWA_ServiceClient();
            ds = obj1.PwaSelectData("PWAAPP", pageVal, pageval1, pageval2, "");
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

        [WebMethod(EnableSession = true)]
        public static string RemoveApprover(string pageval1, string pageVal)
        {
            string str = "";
            DataSet ds = new DataSet();
            PWA_Service.PWA_ServiceClient obj1 = new PWA_Service.PWA_ServiceClient();
            ds = obj1.PwaSelectData("PWAAPP", pageVal, pageval1, "", "");
            if (ds.Tables[0].Rows.Count > 0)
            {
                str = ds.Tables[0].Rows[0][0].ToString();
            }
            return str;
        }


        [WebMethod(EnableSession = true)]
        public static string AddNewApprover(string pageval1, string pageVal)
        {
            string str = "";
            DataSet ds = new DataSet();
            PWA_Service.PWA_ServiceClient obj1 = new PWA_Service.PWA_ServiceClient();
            ds = obj1.PwaSelectData("PWAAPP", pageval1, pageVal, "", "");
            if (ds.Tables[0].Rows.Count > 0)
            {
                str = ds.Tables[0].Rows[0][0].ToString();
            }
            return str;
        }
    }
}