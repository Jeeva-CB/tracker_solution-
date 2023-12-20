using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ITTracker
{
    public partial class ChangeDocUpload : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string usr, bid, fimid, sessn;
            if (string.IsNullOrEmpty(Session["username"] as string))
            {
                Response.Redirect("SessionExpired.aspx");
            }
            else
            {
                usr = Session["username"].ToString();
                bid = Session["branch_id"].ToString();
                fimid = Session["firm_id"].ToString();
                sessn = Session["sessionkey"].ToString();
                this.hdUserId.Value = usr;
                this.hdBranchId.Value = bid;
                this.hdFirmId.Value = fimid;
                this.hdSesssion.Value = sessn;


            }
        }

        [WebMethod(EnableSession = true)]
        public string deleteDownloadFileAll(string input)
        {
            try
            {
                string fname = input + "*.*";
                string rootFolderPath = Server.MapPath("~/Images/");
                string filesToDelete = @"" + fname;   // Only delete DOC files containing "DeleteMe" in their filenames
                string[] fileList = System.IO.Directory.GetFiles(rootFolderPath, filesToDelete);
                foreach (string file in fileList)
                {
                    ChangeDocUpload d = new ChangeDocUpload();
                    d.FileDelete(file);
                    //System.Diagnostics.Debug.WriteLine(file + "will be deleted");
                    //  System.IO.File.Delete(file);
                }
                return "File Deleted Successfully";
            }
            catch
            {
                return "Error in Deletion";
            }

        }

        public void FileDelete(string fname)
        {
            //System.IO.File.Delete(Server.MapPath("~/Images/" + fname));
            System.IO.File.Delete(fname);
        }
        public void DownloadFile(string fn, byte[] s)
        {
            string FileName = fn;
            System.Web.HttpResponse Response = System.Web.HttpContext.Current.Response;
            using (Stream file = File.OpenWrite(Server.MapPath("~/Images/" + fn)))
            {
                file.Write(s, 0, s.Length);
            }
        }

        [WebMethod(EnableSession = true)]
        public static string getFileData(string pageVal, string pageval1, string pageval2)
        {
            try
            {
                ChangeDocUpload f = new ChangeDocUpload();
                f.deleteDownloadFileAll(pageval2);
                DataSet ds;
                string str = "";
                byte[] fileByt;
                ITTracker.ITService.ITServiceClient obj1 = new ITTracker.ITService.ITServiceClient();
                ds = obj1.TrackerSelect(pageVal, pageval1, pageval2, "", "");
                if (ds.Tables.Count > 0)
                {
                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        foreach (DataRow dr in ds.Tables[0].Rows)
                        {
                            string row1 = "";
                            string DocFileName = "";
                            foreach (DataColumn dc in ds.Tables[0].Columns)
                            {

                                if (dc.ColumnName == "FILE_NAME")
                                {
                                    DocFileName = dr[dc].ToString();
                                    row1 = row1 + dr[dc] + "µ";

                                }

                                else if (dc.ColumnName == "FILE_DATA" || dc.ColumnName == "TEST_CASE" || dc.ColumnName == "OTHER_DOC" || dc.ColumnName == "RELEASE_DOC" || dc.ColumnName == "TESTING_DOC" || dc.ColumnName == "CHANGE_DOC")

                                {
                                    fileByt = (byte[])(dr[dc]);
                                    ChangeDocUpload d = new ChangeDocUpload();
                                    d.DownloadFile(pageval2 + DocFileName, fileByt);
                                    row1 = row1 + DocFileName + "µ";
                                }
                                else
                                {
                                    row1 = row1 + dr[dc] + "µ";
                                }

                            }
                            str = str + row1 + "Θ";
                        }

                    }

                }
                return str;
            }
            catch (Exception ex)
            {
                return ex.Message;
            }
        }
        [WebMethod(EnableSession = true)]
        public static string DeleteFileInDB(string pageVal, string pageval1, string pageval2, string pageval3)
        {
            string result = "";
            DataSet ds;
            ITTracker.ITService.ITServiceClient obj1 = new ITTracker.ITService.ITServiceClient();
            
            try
            {
                ds = obj1.TrackerSelect(pageVal, pageval1, pageval2, pageval3, "");
                if (ds != null)
                {
                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        foreach (DataRow dr in ds.Tables[0].Rows)
                        {
                            result = result + dr[0].ToString();
                        }

                        return result;
                    }
                    else
                    {
                        return "";
                    }
                }
                else
                {
                    return "";
                }
            }
            catch(Exception e)
            {
                throw e;
            }
            return result;
        }
        [WebMethod(EnableSession = true)]
        public static string UploadingFile(string ImageData, string InputData)
        {
            String InputDataDecrypted = ClientsideEncryption.AESEncrytDecry.DecryptStringAES(InputData);


            List<string> extentions = new List<string>();

            extentions.InsertRange(extentions.Count, new string[] { "pdf", "jpg", "gif", "jpeg", "bmp", "tif", "tiff", "png", "xps", "doc", "docx", "fax", "wmp", "ico", "txt", "rtf", "xls", "xlsx", "ppt", "pptx", "odt", "ods" });

            string InputDataExt = InputDataDecrypted.Split('µ')[2];

            if (extentions.Contains(InputDataExt))
            {
                string result = "";
                string InputString = ImageData.Split(',')[1];
                Byte[] imgByte = Convert.FromBase64String(InputString);
                ITService.ITServiceClient obj1 = new ITService.ITServiceClient();

                result = obj1.TrackerDocumentUpload("11", InputDataDecrypted, imgByte);
                return result;
            }
            else
            {
                return "666";
            }

        }
    }
}