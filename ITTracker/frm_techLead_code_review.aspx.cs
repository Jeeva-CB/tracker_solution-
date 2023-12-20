using System;
using System.Collections.Generic;
using System.Data;
using System.Drawing.Imaging;
using System.IO;
using System.Net.Mail;
using System.Text;
using System.Web;
using System.Web.Services;

namespace ITTracker
{
    public partial class frm_techLead_code_review : System.Web.UI.Page
    {
        public static string editContent;
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
        public class getDropDownData
        {
            public string id { get; set; }
            public string name { get; set; }
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
        public static string fillTable(string pageVal, string pageval1)
        {
            DataSet ds;
            string str = "";
            ITService.ITServiceClient obj1 = new ITService.ITServiceClient();
            ds = obj1.TrackerSelect(pageVal, pageval1, "", "", "");
            if (ds.Tables[0].Rows.Count > 0)
            {
                foreach (DataRow dr in ds.Tables[0].Rows)
                {
                    str = str + dr[0].ToString() + "^" + dr[1].ToString() + "^" + dr[2].ToString() + "^" + dr[3].ToString() + "§";
                }

                return str;
            }
            else
            {
                return "";
            }
        }


        [WebMethod(EnableSession = true)]
        public static List<getDropDownData> getCrfFillData(string pageVal, string pageval1, string pageval2)
        {
            DataSet ds;
            List<getDropDownData> getData = new List<getDropDownData>();
            ITService.ITServiceClient obj1 = new ITService.ITServiceClient();

            //PWA_Service.PWA_ServiceClient obj1 = new PWA_Service.PWA_ServiceClient();
            //ds = obj1.PwaSelectData("PWAAPP", pageVal, pageval1, "", "");
            try
            {
                ds = obj1.TrackerSelect(pageVal, pageval1, pageval2, "", "");
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
        public static string fillReviewDes(string pageVal, string pageval1, string pageval2, string pageval3)
        {
            DataSet ds;
            string str = "";
            ITService.ITServiceClient obj1 = new ITService.ITServiceClient();
            ds = obj1.TrackerSelect(pageVal, pageval1, pageval2,pageval3, "");


            if (ds.Tables[0].Rows.Count > 0)
            {
                foreach (DataRow dr in ds.Tables[0].Rows)
                {
                    str = str + dr[0].ToString() + "^" + dr[1].ToString()  + "Θ";
                }

                return str;
            }
            else
            {
                return "";
            }
        }

        //[WebMethod(EnableSession = true)]
        //public static string TACompleteConfirm(string pageVal, string pageval1, string pageval2, string pageval3, string pageval4)
        //{
        //    DataSet ds, ds1, ds2, ds3;
        //    string str = "", newcontent = "", noteid;
        //    ITService.ITServiceClient obj1 = new ITService.ITServiceClient();
        //    ds = obj1.TrackerSelect(pageVal, pageVal, pageval1, pageval2, pageval4);
        //    str = ds.Tables[0].Rows[0][0].ToString();
        //}
        [WebMethod(EnableSession = true)]
        
        public static string TLCodeReviewConfirm(string pageVal, string pageval1, string pageval2, string pageval3)
        {
            DataSet ds, ds1, ds2, ds3;
            string str = "", newcontent = "", noteid;
            ITService.ITServiceClient obj1 = new ITService.ITServiceClient();
            ds = obj1.TrackerSelect(pageVal, pageval1, pageval2, pageval3, "");
          

            try
            {
                if (ds != null)
                {
                    str = ds.Tables[0].Rows[0][0].ToString();
                }
                else
                {
                    str = "0";
                }

            }
            catch (Exception e)
            {
                return e.Message;
            }
            return str;
        }




        [WebMethod(EnableSession = true)]

        public static string TLCodeReviewConfirm1(string pageVal, string pageval1, string pageval2, string pageval3)
        {
            DataSet ds, ds1, ds2, ds3;
            string str = "", newcontent = "", noteid;
            ITService.ITServiceClient obj1 = new ITService.ITServiceClient();
            ds = obj1.TrackerSelect(pageVal, pageval1, pageval2, pageval3, "");


            try
            {
                if (ds != null)
                {
                    str = ds.Tables[0].Rows[0][0].ToString();
                }
                else
                {
                    str = "0";
                }

            }
            catch (Exception e)
            {
                return e.Message;
            }
            return str;
        }
        [WebMethod(EnableSession = true)]

        public static string TLCodeReviewreturn(string pageVal, string pageval1, string pageval2, string pageval3)
        {
            DataSet ds, ds1, ds2, ds3;
            string str = "", newcontent = "", noteid;
            ITService.ITServiceClient obj1 = new ITService.ITServiceClient();
            ds = obj1.TrackerSelect(pageVal, pageval1, pageval2, pageval3, "");


            try
            {
                if (ds != null)
                {
                    str = ds.Tables[0].Rows[0][0].ToString();
                }
                else
                {
                    str = "0";
                }

            }
            catch (Exception e)
            {
                return e.Message;
            }
            return str;
        }



        [WebMethod(EnableSession = true)]
        public static List<getDropDownData> getFillData1(string pageVal, string pageval1, string pageval2)
        {
            DataSet ds;
            List<getDropDownData> getData = new List<getDropDownData>();
            ITService.ITServiceClient obj1 = new ITService.ITServiceClient();
            ds = obj1.TrackerSelect(pageVal, pageval1, pageval2, "", "");
            //PWA_Service.PWA_ServiceClient obj1 = new PWA_Service.PWA_ServiceClient();
            //ds = obj1.PwaSelectData("PWAAPP", pageVal, pageval1, "", "");
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
        public static string getRequestNote(string pageVal, string pageval1)
        {

            DataSet ds;
            DataTable dt = new DataTable();

            ITService.ITServiceClient obj1 = new ITService.ITServiceClient();
            ds = obj1.TrackerSelect(pageVal, pageval1, "", "", "");
            dt = ds.Tables[0];
            if (dt.Rows.Count > 0)
            {
                return dt.Rows[0][0].ToString();
            }
            else

            { return "NA"; }

        }


    }
}