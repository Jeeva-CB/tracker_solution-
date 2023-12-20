using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using System.Data;
using System.Data.OleDb;
using System.IO;
using System.Configuration;
using System.Collections;
using System.Net.Mail;

namespace ITTacker
{
    public partial class FileDownloader : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [WebMethod(EnableSession = true)]
        public static string getTableData(string pageVal, string pageval1, string pageval2)
        {
            FileDownloader f = new FileDownloader();
            f.deleteDownloadFileAll("1967580");
            DataSet ds;
            string str = "";
            byte[] fileByt;
            PWA_Service.PWA_ServiceClient obj1 = new PWA_Service.PWA_ServiceClient();
            ds = obj1.PwaSelectData("PWAAPP", pageVal, pageval1, pageval2, "");
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
                            //str1 = dr[dc].ToString();
                            //1µ2µ3µ4µ8µ
                            if (dc.ColumnName == "FILE_NAME")
                            {
                                DocFileName = dr[dc].ToString();
                                row1 = row1 + dr[dc] + "µ";

                            }
                            else if (dc.ColumnName=="FILE_DATA")
                            {
                                fileByt = (byte[])(dr[dc]);                                
                                FileDownloader d = new FileDownloader();
                                d.DownloadFile("1967580" + DocFileName, fileByt);
                                //return DocFileName;
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
                    FileDownloader d = new FileDownloader();
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

        [WebMethod(EnableSession = true)]
        public string deleteDownloadFile(string input)
        {
            string fname = input;
            FileDownloader d = new FileDownloader();
            d.FileDelete(fname);
            return "File Deleted Successfully";
        }
        public void FileDelete(string fname)
        {
            //System.IO.File.Delete(Server.MapPath("~/Images/" + fname));
            System.IO.File.Delete(fname);
        }
    }
}