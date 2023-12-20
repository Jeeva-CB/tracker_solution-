using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace ITTracker
{
    public partial class TestCaseUpdation : System.Web.UI.Page
    {
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
                //this.hdBranchId.Value = bid;
                //this.hdFirmId.Value = fimid;
                //this.hdnSystemIP.Value = ipaddres;
                this.hdSesssion.Value = sessn;
            }

        }

        [WebMethod(EnableSession = true)]
        public static string UploadingFiles(string ImageData, string InputData)
        {
            String InputDataDecrypted = ClientsideEncryption.AESEncrytDecry.DecryptStringAES(InputData);
            //List<string> extentions = new List<string>();
            //extentions.Add("913020010321699");

            List<string> extentions = new List<string>();

            extentions.InsertRange(extentions.Count, new string[] { "xls", "xlsx" });

            string InputDataExt = InputDataDecrypted.Split('µ')[1];
            try
            {
                if (extentions.Contains(InputDataExt))
                {
                    string result = "";
                    string InputString = ImageData.Split(',')[1];
                    Byte[] imgByte = Convert.FromBase64String(InputString);
                    ITService.ITServiceClient obj1 = new ITService.ITServiceClient();
                    result = obj1.TrackerDocumentUpload("54", InputDataDecrypted, imgByte);
                    return result;
                }
                else
                {
                    return "666";
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }


        }
       

        [WebMethod(EnableSession = true)]
        public static string getFillData(string pageVal, string pageval1, string pageval2)
        {
            DataTable dt = new DataTable();
            string rslt = "";
           

            ITService.ITServiceClient obj1 = new ITService.ITServiceClient();
            dt = obj1.TrackerSelect(pageVal, pageval1, pageval2, "", "").Tables[0];
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
    }
}