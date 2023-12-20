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
    public partial class ContentViewer : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [WebMethod(EnableSession = true)]
        public static string getRequestNote(string pageVal, string pageval1, string pageval2)
        {
            DataSet ds;
            string str = "";

            PWA_Service.PWA_ServiceClient obj1 = new PWA_Service.PWA_ServiceClient();
            ds = obj1.PwaSelectData("PWAAPP", pageVal, pageval1, pageval2, "");
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

        [WebMethod(EnableSession = true)]
        public static string getRequestNote1(string pageVal, string pageval1, string pageval2)
        {
            PWA_Service.PWA_ServiceClient obj1 = new PWA_Service.PWA_ServiceClient();
            string str = "";
            try
            {
                str = obj1.PwaSelectClob("PWAAPP", pageVal, pageval1, pageval2, "");
                return str;
            }
            catch (Exception e)
            {
                return e.Message;
            }
            //return obj1.PwaSelectClob("PWAAPP", pageVal, pageval1, pageval2, "");
        }
    }
}