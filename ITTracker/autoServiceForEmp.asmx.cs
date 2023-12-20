using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.Script.Services;
using Newtonsoft.Json.Linq;
using System.Net.NetworkInformation;

namespace ITTracker
{
    /// <summary>
    /// Summary description for autoServiceForEmp
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    // [System.Web.Script.Services.ScriptService]
    [System.Web.Script.Services.ScriptService]
    public class autoServiceForEmp : System.Web.Services.WebService
    {
        ITService.ITServiceClient obj = new ITService.ITServiceClient();
        //[WebMethod]
        //public string HelloWorld()
        //{
        //    return "Hello World";
        //}

        [WebMethod(EnableSession = true)]
        public string[] GetSearchingData(string SearchKey, string QueryFlag, string QueryID)
        {
            obj = new ITService.ITServiceClient();
            List<string> SearchArray = new List<string>();

            DataSet ds = new DataSet();
            ds = obj.TrackerSelect(QueryFlag, QueryID, SearchKey, "");
            try
            {
                if (ds.Tables.Count > 0)
                {
                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        foreach (DataRow dr in ds.Tables[0].Rows)
                        {
                            SearchArray.Add(string.Format("{0}ʒ{1}", dr[0], dr[1]));
                        }
                    }
                }

            }
            catch (Exception ex)
            {
            }
            return SearchArray.ToArray();
        }
    }
}
