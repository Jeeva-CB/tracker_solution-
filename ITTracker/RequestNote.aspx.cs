using System;
using System.Collections.Generic;
using System.Data;
using System.Drawing.Imaging;
using System.IO;
using System.Text;
using System.Web;
using System.Web.Services;
namespace ITTacker
{
    public partial class RequestNote : System.Web.UI.Page
    {
        public void Page_Init(object o, EventArgs e)
        {

            Response.Cache.SetCacheability(HttpCacheability.NoCache);

            Response.Cache.SetExpires(DateTime.UtcNow.AddHours(-1));

            Response.Cache.SetNoStore();
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            string usr, bid, fimid,sessn;
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
        public class getDropDownData
        {
            public string id { get; set; }
            public string name { get; set; }
        }



        [WebMethod(EnableSession = true)]
        public static List<getDropDownData> getFillData(string pageVal, string pageval1)
        {
            DataSet ds;
            List<getDropDownData> getData = new List<getDropDownData>();
            PWA_Service.PWA_ServiceClient obj1 = new PWA_Service.PWA_ServiceClient();
            ds = obj1.PwaSelectData("PWAAPP", pageVal, pageval1, "","");
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
        public static string RequestNoteConfirm(string pageVal, string pageval1, string pageval2, string pageval3)
        {
            DataSet ds,ds1,ds2;
            string str = "";

            PWA_Service.PWA_ServiceClient obj1 = new PWA_Service.PWA_ServiceClient();
            ds = obj1.PwaSelectData("PWAAPP", pageVal, pageval1, pageval2, pageval3);
            try
            {
                if (ds.Tables[0].Rows.Count > 0)
                {
                    str = ds.Tables[0].Rows[0][0].ToString();
                    try
                    {
                        if (!str.Contains("µ"))
                        {
                            string noteid = str;
                            DataTable dt1, dt2, dt3;
                            dt1 = obj1.PwaSelectData("PWAAPP", "GetEmailNoteRequest", noteid, "", "").Tables[0];

                            dt2 = obj1.PwaSelectData("PWAAPP", "GetEmailReviewNext", noteid, "", "").Tables[0];
                            string NextReviewrsId = dt2.Rows[0][0].ToString();
                            string NextReviewrsName = dt2.Rows[0][1].ToString();

                            dt3 = obj1.PwaSelectData("PWAAPP", "GetApprovedRDLCheader", noteid, "", "").Tables[0];
                            string tblHead = ExportDatatableToHtmlHeading(dt3);

                            if (dt1.Rows.Count > 0)
                            {
                                string reqmailid = dt1.Rows[0][0].ToString() + "@manappuram.com";
                                string reqname = dt1.Rows[0][1].ToString();
                                string reqdate = dt1.Rows[0][2].ToString();
                                string imageUrlLog = GetImageUrl("files/img/manappuram_logo.png");
                                string imageContentLog = "<img src='" + imageUrlLog + "' alt='Alternate Text' />";
                                string imageUrlPaperless = GetImageUrl("files/img/paperlessBanner1.png");
                                string imageContentPaperless = "<img src='" + imageUrlPaperless + "' alt='Alternate Text' />";

                                string bdy = "<p style='font-family: Calibri,Arial,Helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0);'>Dear " + reqname + ",<br/><br/>Paperless Note has been created by <b>" + reqname + "</b> on <b>" + reqdate + "</b> and assigned to <b> " + NextReviewrsName + "</b> <br/><br/> <u><b>Note Details</b></u><br/><br/> " + tblHead + " <br/><br/> Thanks & Regards,<br/>Paperless Portal<br/><span style = 'font-size:11.0pt; font-family:&quot;Calibri&quot;,sans-serif; color:gray' lang='EN-IN'>Please do not reply to this email ID as this is an automatically generated email and reply to this ID is not being monitored</span></p>" + imageContentLog + "   " + imageContentPaperless + "<p><span style = 'color:rgb(105,105,105); font-size:7pt; font-family:arial,sans-serif; line-height:normal; background-color:rgba(0,0,0,0)' >Please be aware that this email/attachment contains MAFIL confidential/sensitive data. You are requested to follow MAFIL Information Security and data sharing policies in case the data is shared further. Feel free to contact AGM Information Security when youare in doubt.</span></p>";
                                string subj = "Paperless Note -: " + noteid + " - New Note Created";
                                string dtls = "1µ" + reqmailid + "µµµ" + subj + "µ" + noteid + "µPaperless";

                                ds1 = obj1.PwaSelectData("PWAAPP", "InsertEmail", dtls, "", bdy);

                                



                                string[] NextReviewrs = NextReviewrsId.Split(',');
                                if (NextReviewrs.Length > 0)
                                {
                                    foreach (string i in NextReviewrs)
                                    {

                                        string[] reviwnames = i.Split('±');
                                        string revwmailid = reviwnames[0].ToString() + "@manappuram.com";
                                        string revwname = reviwnames[1].ToString();

                                        string bdy1 = "<p style='font-family: Calibri,Arial,Helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0);'>Dear " + revwname + ",<br/><br/> A note has been assigned for your review on <b>" + reqdate + "</b><br/>Kindly process the same at the earliest. <br/> <br/><br/><u><b>Note Details</b></u><br/><br/> " + tblHead + " <br/><br/> Thanks & Regards,<br/>Paperless Portal<br/><span style = 'font-size:11.0pt; font-family:&quot;Calibri&quot;,sans-serif; color:gray' lang='EN-IN'>Please do not reply to this email ID as this is an automatically generated email and reply to this ID is not being monitored</span></p>" + imageContentLog + "   " + imageContentPaperless + "<p><span style = 'color:rgb(105,105,105); font-size:7pt; font-family:arial,sans-serif; line-height:normal; background-color:rgba(0,0,0,0)' >Please be aware that this email/attachment contains MAFIL confidential/sensitive data. You are requested to follow MAFIL Information Security and data sharing policies in case the data is shared further. Feel free to contact AGM Information Security when youare in doubt.</span></p>";
                                        string subj1 = "Paperless Note -: " + noteid + " - New Note Created";
                                        string dtls1 = "1µ" + revwmailid + "µµµ" + subj + "µ" + noteid + "µPaperless";

                                        ds2 = obj1.PwaSelectData("PWAAPP", "InsertEmail", dtls1, "", bdy1);


                                       
                                    }
                                }
                            }

                           

                        }
                    }
                    catch (Exception ef)
                    {
                        //return ef.Message;
                        string msg= ef.Message;
                    }                  
                }
            }
            catch (Exception e)
            {
                return e.Message;
            }
            return str;
        }

        [WebMethod(EnableSession = true)]
        public static string GetNewNoteID(string pageVal)
        {

            DataSet ds;
            DataTable dt = new DataTable();           

            PWA_Service.PWA_ServiceClient obj1 = new PWA_Service.PWA_ServiceClient();
            ds = obj1.PwaSelectData("PWAAPP", pageVal, "", "", "");
            dt = ds.Tables[0];
            if (dt.Rows.Count > 0)
            {
                return dt.Rows[0][0].ToString();
            }
            else

            { return "NA"; }
                
        }

        [WebMethod(EnableSession = true)]
        public static string UploadingFile(string ImageData, string InputData)
        {
            String InputDataDecrypted = ClientsideEncryption.AESEncrytDecry.DecryptStringAES(InputData);
            //List<string> extentions = new List<string>();
            //extentions.Add("913020010321699");

            List<string> extentions = new List<string>();

            extentions.InsertRange(extentions.Count, new string[] {"pdf","jpg", "gif", "jpeg", "bmp", "tif", "tiff", "png", "xps", "doc", "docx", "fax", "wmp", "ico", "txt", "rtf", "xls", "xlsx", "ppt", "pptx"});

            string InputDataExt = InputDataDecrypted.Split('µ')[2];

           if (extentions.Contains(InputDataExt))
            {
                string result = "";
                string InputString = ImageData.Split(',')[1];
                Byte[] imgByte = Convert.FromBase64String(InputString);
                PWA_Service.PWA_ServiceClient obj1 = new PWA_Service.PWA_ServiceClient();

                result = obj1.PwaDocumentUpload("1", InputDataDecrypted, imgByte);
                return result;
            }
            else
            {
                return "666";
            }

        }

        [WebMethod(EnableSession = true)]
        public static string GetImageUrl(string imagePath)
        {
            //System.Drawing.Image image = System.Drawing.Image.FromFile(Server.MapPath(imagePath));
            System.Drawing.Image image = System.Drawing.Image.FromFile(System.Web.HttpContext.Current.Server.MapPath(imagePath));
            MemoryStream memoryStream = new MemoryStream();
            image.Save(memoryStream, ImageFormat.Png);
            Byte[] bytes = new Byte[memoryStream.Length];
            memoryStream.Position = 0;
            memoryStream.Read(bytes, 0, (int)bytes.Length);
            string base64String = Convert.ToBase64String(bytes, 0, bytes.Length);
            string imageUrl = "data:image/png;base64," + base64String;
            return imageUrl;
        }
        [WebMethod(EnableSession = true)]
        public static string ExportDatatableToHtmlHeading(DataTable dt)
        {
            StringBuilder strHTMLBuilder = new StringBuilder();
            strHTMLBuilder.Append("<table style='font-size: 10pt; border: 1px solid #ccc;width: 100%;'>");
            //strHTMLBuilder.Append("<thead><tr style='background-color: #f2f2f2;background-color: #3498db;color: white;font-size: 12pt;font-weight: bold; '><th>Reviewer Name</th><th>Designation </th><th>Department</th><th>Status</th><th >Updated Date</th><th>Remarks</th></tr></thead>");
            strHTMLBuilder.Append("<thead>");
            strHTMLBuilder.Append("<tr style='background-color: #fdd935;color: black;font-size: 12pt;font-weight: bold; border: 1px solid #ccc;' >");
            foreach (DataColumn myColumn in dt.Columns)
            {
                strHTMLBuilder.Append("<th style='border: 1px solid #ccc; padding: 10px; '>");
                strHTMLBuilder.Append(myColumn.ColumnName);
                strHTMLBuilder.Append("</th>");
            }
            strHTMLBuilder.Append("</tr>");
            strHTMLBuilder.Append("</thead>");

            foreach (DataRow myRow in dt.Rows)
            {
                strHTMLBuilder.Append("<tr style='border: 1px solid #ccc; '>");
                foreach (DataColumn myColumn in dt.Columns)
                {
                    strHTMLBuilder.Append("<td style='border: 1px solid #ccc; padding: 10px; '>");
                    strHTMLBuilder.Append(myRow[myColumn.ColumnName].ToString());
                    strHTMLBuilder.Append("</td>");
                }
                strHTMLBuilder.Append("</tr>");
            }

            //Close tags.  
            strHTMLBuilder.Append("</tbody>");
            strHTMLBuilder.Append("</table>");
            string Htmltext = strHTMLBuilder.ToString();

            return Htmltext;

        }
    }
}