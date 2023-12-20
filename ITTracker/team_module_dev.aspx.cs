using System.Collections.Generic;
using System.Linq;
using System.Web.Services;
using System.Web.Configuration;
using System;
using System.Data;

namespace ITTracker
{
    public partial class team_module_dev : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string usr;
            usr = Session["username"].ToString();

            this.hdUserId.Value = usr;
        }
        public class getDropDownData
        {
            public string id { get; set; }
            public string name { get; set; }


        }

        [WebMethod(EnableSession = true)]
        public static List<getDropDownData> getData(string pageVal, string pageval1, string pageval2)
        {
            DataSet ds;
            List<getDropDownData> getData = new List<getDropDownData>();
            ITService.ITServiceClient obj1 = new ITService.ITServiceClient();
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
        public static string Confirm(string pageVal, string pageval1, string pageval2)
        {
            DataSet ds;
            string str = "";
            int i = 0;
            ITService.ITServiceClient obj1 = new ITService.ITServiceClient();
            ds = obj1.TrackerSelect(pageVal, pageval1, pageval2, "", "");
            if (ds.Tables[0].Rows.Count > 0)
            {
                foreach (DataRow dr in ds.Tables[0].Rows)
                {
                    str = ds.Tables[0].Rows[i][0].ToString();
                }
            }
            return str;

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
    }
}