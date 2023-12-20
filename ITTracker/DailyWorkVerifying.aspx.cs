using System;
using System.Collections.Generic;
using System.Data;
using System.Drawing.Imaging;
using System.IO;
using System.Text;
using System.Web;
using System.Web.Services;
using System.Web.UI.WebControls;
namespace ITTracker
{
    public partial class DailyWorkVerifying : System.Web.UI.Page
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

               

                //hdPag.Value = Request.QueryString["pag"];
            }
        }
        protected void Hours_Load(DropDownList ddl)
        {
            int i;

            for (i = 0; i <= 12; i++)
            {
                ddl.Items.Add(i.ToString());
            }
        }


        /// <summary>
        /// Minutes
        /// </summary>
        protected void Minutes_Load(DropDownList ddl)
        {
            int i;

            for (i = 0; i <= 59; i++)
            {
                if (i > 9)
                {
                    ddl.Items.Add(i.ToString());
                }
                else if (i < 10)
                {
                    ddl.Items.Add("0" + i.ToString());
                }
            }
        }

        [WebMethod(EnableSession = true)]
        public static string getDatas(string pageVal, string pageval1)
        {
            DataSet ds;
            string str = "";
            int i = 0;
            ITService.ITServiceClient obj1 = new ITService.ITServiceClient();
            ds = obj1.TrackerSelect(pageVal, pageval1, "", "", "");
            try
            {
                if (ds.Tables[0].Rows.Count > 0)
                {
                    foreach (DataRow dr in ds.Tables[0].Rows)
                    {
                        str = ds.Tables[0].Rows[i][0].ToString();

                    }
                }

            }
            catch (Exception e)
            {

            }
            return str;

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
        public static List<getDropDownData> getDescOfWork(string pageVal, string pageval1)
        {
            DataSet ds;
            List<getDropDownData> getData = new List<getDropDownData>();
            ITService.ITServiceClient obj1 = new ITService.ITServiceClient();
            ds = obj1.TrackerSelect(pageVal, pageval1, "", "", "");
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
        public static string InsertData(string pageVal, string pageval1, string pageval2)
        {
            DataSet ds;
            string str = "";
            ITService.ITServiceClient obj1 = new ITService.ITServiceClient();
            ds = obj1.TrackerSelect(pageVal, pageval1, pageval2, "","");

            try
            {
                if (ds.Tables[0].Rows.Count > 0)
                {
                    str = ds.Tables[0].Rows[0][0].ToString();
                }
                //}
            }
            catch (Exception e)
            {

            }
            return str;

        }
        [WebMethod(EnableSession = true)]
        public static string selectdata(string pageVal, string pageval1)
        {
            DataSet ds;
            string str = "";
            int i = 0;
            ITService.ITServiceClient obj1 = new ITService.ITServiceClient();
            ds = obj1.TrackerSelect(pageVal, pageval1, pageval1, "", "");
            try
            {
                if (ds.Tables[0].Rows.Count > 0)
                {
                    foreach (DataRow dr in ds.Tables[0].Rows)
                    {
                        str = str + ds.Tables[0].Rows[i][0].ToString() + '~';
                        i++;
                    }


                }

            }
            catch (Exception e)
            {

            }
            return str;

        }

        public class getDropDownData
        {
            public string id { get; set; }
            public string name { get; set; }


        }
    }
}