using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;

namespace ITTracker
{
    /// <summary>
    /// Summary description for AutoCompleteService
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    // [System.Web.Script.Services.ScriptService]
    public class AutoCompleteService : System.Web.Services.WebService
    {

        [WebMethod]
        public string HelloWorld()
        {
            return "Hello World";
        }


        [WebMethod(EnableSession = true)]
        public  string[] GetSearchingData_Employees(string SearchKey, string QueryFlag, string QueryID, string dep)
        {
            ITService.ITServiceClient obj = new ITService.ITServiceClient();
            List<string> SearchArray = new List<string>();
            DataSet ds = new DataSet();
            //ds = obj.GetDetails("proc_horisk", QueryFlag, QueryID, SearchKey, dep, "");
            ds = obj.TrackerSelect(QueryFlag, "", SearchKey, "", "");
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
