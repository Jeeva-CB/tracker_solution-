using System;
using System.Collections.Generic;
using System.Data;
using System.Drawing.Imaging;
using System.IO;
using System.Net.Mail;
using System.Text;
using System.Web;
using System.Web.Services;
using static ITTacker.StatusReport;

namespace ITTracker
{
    public partial class RequestTypeUpdation : System.Web.UI.Page
    {
        Helper.Oracle.OracleHelper oh = new Helper.Oracle.OracleHelper();

        private string userid;

        public void Page_Init(object o, EventArgs e)
        {

            Response.Cache.SetCacheability(HttpCacheability.NoCache);

            Response.Cache.SetExpires(DateTime.UtcNow.AddHours(-1));

            Response.Cache.SetNoStore();
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            
            string usr, bid, fimid, ipaddres, sessn, depid;
            

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
                
               
                
                //this.hdFirmId.Value = fimid;
                //this.hdSesssion.Value = sessn;
                DataTable dtUsrDtls = new DataTable();
                dtUsrDtls = oh.ExecuteDataSet("SELECT A.BRANCH_ID,B.BRANCH_NAME,A.EMP_NAME,A.ACCESS_ID,A.FIRM_ID,a.DEPARTMENT_ID FROM BRANCH_MASTER B,EMP_MASTER A WHERE A.BRANCH_ID=B.BRANCH_ID AND A.STATUS_ID=1 AND A.EMP_CODE=" + usr + "").Tables[0];
                depid = dtUsrDtls.Rows[0][5].ToString();
                this.hddepid.Value = depid;
            }
        }

        [WebMethod(EnableSession = true)]
        public static string Formacess(string pageVal, string pageval1)
        {
            DataTable dt = new DataTable();
            string rslt = "";
            ITTracker.ITService.ITServiceClient obj = new ITTracker.ITService.ITServiceClient();
            dt = obj.TrackerSelect(pageVal, pageval1, "", "", "").Tables[0];
            try
            {
                if (dt.Rows.Count > 0)
                {
                    rslt = dt.Rows[0][0].ToString();
                }
                return rslt;
            }
            catch (Exception e)
            {
                return e.Message;
            }
            
        }

        [WebMethod(EnableSession = true)]
        public static string Headverification(string pageVal, string pageval1)
        {
            DataTable dt = new DataTable();
            string rslt = "";
            ITTracker.ITService.ITServiceClient obj = new ITTracker.ITService.ITServiceClient();
            dt = obj.TrackerSelect(pageVal, pageval1, "", "", "").Tables[0];
            try
            {
                if (dt.Rows.Count > 0)
                {
                    rslt = dt.Rows[0][0].ToString();
                }
                return rslt;
            }
            catch (Exception e)
            {
                return e.Message;
            }

        }

        [WebMethod(EnableSession = true)]
        public static List<getDropDownData> getFillData(string pageVal, string pageval1)
        {
            DataSet ds;
            List<getDropDownData> getData = new List<getDropDownData>();
            ITService.ITServiceClient obj1 = new ITService.ITServiceClient();
            ds = obj1.TrackerSelect(pageVal, pageval1, "", "", "");
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
        public static string getRequestNote(string pageVal, string pageval1, string pageval2)
        {
            DataSet ds;
            string str = "";
            ITService.ITServiceClient obj1 = new ITService.ITServiceClient();
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

        [WebMethod(EnableSession = true)]
        public static string ModHdFeedback(string pageVal, string pageval1)
        {

            DataSet ds;
            string result = "";
            DataTable dt = new DataTable();
            ITService.ITServiceClient obj1 = new ITService.ITServiceClient();
            try
            {
                ds = obj1.TrackerSelect(pageVal, pageval1, "", "", "");
                if (ds != null)
                {
                    dt = ds.Tables[0];
                    if (dt.Rows.Count > 0)
                    {
                        result = dt.Rows[0][0].ToString();
                    }
                    else result = "NA";
                }

                else result = "NA";
            }
            catch (Exception e)
            {

            }
            return result;

        }
        [WebMethod(EnableSession = true)]
        public static string Headcorrection(string pageVal, string pageval1)
        {
            DataSet ds;
            string str = "";
            ITService.ITServiceClient obj1 = new ITService.ITServiceClient();
            ds = obj1.TrackerSelect(pageVal, pageval1, "", "", "");

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