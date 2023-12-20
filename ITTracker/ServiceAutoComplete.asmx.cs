using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.Script.Services;
using System.Data;
using System.IO;


namespace ITTracker
{
    /// <summary>
    /// Summary description for ServiceAutoCompletes
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
     [System.Web.Script.Services.ScriptService]
    public class ServiceAutoComplete : System.Web.Services.WebService
    {

        [WebMethod]
        public string HelloWorld()
        {
            return "Hello World";
        }

       // [WebMethod]
       // [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
       // public string[] GetSearchData(string SearchKey,string QueryFlag,string QueryID)
       //{
       //     //PurchaseService.PurchaseClient obj;
       //     Civiltrack_Service.CivilElectricalClient obj;
       //     List<string> SearchArray = new List<string>();
       //     obj = new Civiltrack_Service.CivilElectricalClient();
       //     DataSet ds = new DataSet();
       //     ds = obj.CiviltrackFillData(QueryFlag, QueryID, SearchKey, "");
       //     try
       //     {
       //         if (ds.Tables.Count > 0)
       //         {
       //             if (ds.Tables[0].Rows.Count > 0)
       //             {
       //                 foreach (DataRow dr in ds.Tables[0].Rows)
       //                 {
       //                     SearchArray.Add(string.Format("{0}ʒ{1}", dr[0], dr[1]));
       //                 }
       //             }
       //         }

       //     }
       //     catch (Exception ex)
       //     {
       //     }
       //     return SearchArray.ToArray();
       // }


        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static string[] GetSearchingData(string SearchKey, string QueryFlag, string QueryID)
        {
            ITTracker.ITService.ITServiceClient obj = new ITTracker.ITService.ITServiceClient();
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
