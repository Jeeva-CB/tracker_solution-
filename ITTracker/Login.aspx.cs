using System;
using System.Data;
using System.Web;
using System.Web.Services;


namespace ITTacker
{
    public partial class Login : System.Web.UI.Page
    {
        

        protected void Page_Load(object sender, EventArgs e)
        {
            
        }
        //string Message = "hai";
        //protected void ShowMessage(string Message)
        //{
        //    ScriptManager.RegisterStartupScript(this, this.GetType(), System.Guid.NewGuid().ToString(), "ShowMessage('" + Message + "');", true);
        //}

       

        [WebMethod]
        public static string loginauth(string username, string password)
        {
          

            ITTracker.HRM_Service.ServiceClient ob = new ITTracker.HRM_Service.ServiceClient();            
            DataTable dt = new DataTable();
            string indata = username + '~' + password;
            string ID = "", s, result = "";

            ITTracker.Purchase.PurchaseClient obj;
            obj = new ITTracker.Purchase.PurchaseClient();
            DataSet ds = new DataSet();
            ds = obj.PurchaseFillData("PURCOMMON", "GETROLE", username, "");
            result = ds.Tables[0].Rows[0][0].ToString();
            //return result;

            //if (result == "10")
            //{


                //string res = obj.testmethod("1", indata);
                s = ob.getdata_login("3", indata);


                if (s != null)
                {
                    string[] res = s.Split('~');
                    int r1 = Convert.ToInt32(res[0]);
                    if (r1 == 1)
                    {
                        string[] ss = res[1].Split('µ');
                        // HttpContext.Current.Session["branch_id"] = Convert.ToInt32(res[1]);
                        HttpContext.Current.Session["branch_id"] = Convert.ToInt32(ss[0]);
                        HttpContext.Current.Session["department_id"] = Convert.ToInt32(ss[1]);
                        HttpContext.Current.Session["post_id"] = Convert.ToInt32(ss[2]);
                        HttpContext.Current.Session["firm_id"] = Convert.ToInt32(ss[3]);
                        HttpContext.Current.Session["username"] = username;
                        return "Valid";
                    }
                    else
                    {
                        return "Invalid";

                    }

                }
                return "Valid";
           // }
            //else
            //{
            //    return "Invalid";

            //}
        
           
           
        }
    }
}