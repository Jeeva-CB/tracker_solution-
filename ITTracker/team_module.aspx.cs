using System.Collections.Generic;
using System.Linq;
using System.Web.Services;
using System.Web.Configuration;
using System;
using System.Data;
namespace ITTracker
{
    public partial class team_module : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        public class getDropDownData
        {
            public string id { get; set; }
            public string name { get; set; }


        }

        [WebMethod(EnableSession = true)]
        public static List<getDropDownData> getData(string pageVal,string pageval1, string pageval2)
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
    }
}