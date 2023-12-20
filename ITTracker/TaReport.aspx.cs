using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.Services;
namespace ITTracker
{
    public partial class TaReport : System.Web.UI.Page
    {
        string usr, bid;
        protected void Page_Load(object sender, EventArgs e)
        {

            usr = Session["username"].ToString();
            bid = Session["branch_id"].ToString();
           
            this.hdUserId.Value = usr;
            this.hdBranchId.Value = bid;
            

        }

        [WebMethod(EnableSession = true)]
        public static string user_chk(string flag,string user)
        {
            DataSet ds;
            string result = "";
            ITService.ITServiceClient obj1 = new ITService.ITServiceClient();
            ds = obj1.TrackerSelect(flag, user, "", "", "");
            try
            {

                if (ds.Tables[0].Rows.Count > 0)
                {

                    result = ds.Tables[0].Rows[0][0].ToString();
                }

            }
            catch (Exception e)
            {

            }
            return result;
        }

        [WebMethod(EnableSession = true)]
        public static string Encrypt(string clearText)

        {
            //string EncryptionKey = "MAKV2SPBNI99212";
            string EncryptionKey = "J1MAORUPPHANAMN";
            byte[] clearBytes = Encoding.Unicode.GetBytes(clearText);
            using (Aes encryptor = Aes.Create())
            {
                Rfc2898DeriveBytes pdb = new Rfc2898DeriveBytes(EncryptionKey, new byte[] { 0x49, 0x76, 0x61, 0x6e, 0x20, 0x4d, 0x65, 0x64, 0x76, 0x65, 0x64, 0x65, 0x76 });
                encryptor.Key = pdb.GetBytes(32);
                encryptor.IV = pdb.GetBytes(16);
                using (MemoryStream ms = new MemoryStream())
                {
                    using (CryptoStream cs = new CryptoStream(ms, encryptor.CreateEncryptor(), CryptoStreamMode.Write))
                    {
                        cs.Write(clearBytes, 0, clearBytes.Length);
                        cs.Close();
                    }
                    clearText = Convert.ToBase64String(ms.ToArray());
                }
            }
            return clearText;
        }
    }
}