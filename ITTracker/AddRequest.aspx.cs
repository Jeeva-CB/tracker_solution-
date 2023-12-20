using System;
using System;
using System.Collections.Generic;
using System.Data;
using System.Drawing.Imaging;
using System.IO;
using System.Text;
using System.Web;
using System.Web.Services;
using System.Net.Mail;
using System.Linq;

namespace ITTracker
{
    public partial class AddRequest : System.Web.UI.Page
    {
        public void Page_Init(object o, EventArgs e)
        {

            Response.Cache.SetCacheability(HttpCacheability.NoCache);

            Response.Cache.SetExpires(DateTime.UtcNow.AddHours(-1));

            Response.Cache.SetNoStore();
        }
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
            
            ITService.ITServiceClient obj1 = new ITService.ITServiceClient();
            ds = obj1.TrackerSelect(pageVal, pageval1, "", "","");
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
                throw e;
            }
            return getData;
        }

        
        

        [WebMethod(EnableSession = true)]
        public static string UploadingFile(string ImageData, string InputData)
        {
            String InputDataDecrypted = ClientsideEncryption.AESEncrytDecry.DecryptStringAES(InputData);
            //List<string> extentions = new List<string>();
            //extentions.Add("913020010321699");

            List<string> extentions = new List<string>();

            extentions.InsertRange(extentions.Count, new string[] { "pdf", "jpg", "gif", "jpeg", "bmp", "tif", "tiff", "png", "xps", "doc", "docx", "fax", "wmp", "ico", "txt", "rtf", "xls", "xlsx", "ppt", "pptx","odc", "odt" });

            string InputDataExt = InputDataDecrypted.Split('µ')[2];
            try
            {
                if (extentions.Contains(InputDataExt))
                {
                    string result = "";
                    string InputString = ImageData.Split(',')[1];
                    Byte[] imgByte = Convert.FromBase64String(InputString);
                    ITService.ITServiceClient obj1 = new ITService.ITServiceClient();

                    result = obj1.TrackerDocumentUpload("1", InputDataDecrypted, imgByte);
                    return result;
                }
                else
                {
                    return "666";
                }
            } 
            catch(Exception ex)
            {
                throw ex;
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
            strHTMLBuilder.Append("<tr style='background-color: #d98fe3;color: black;font-size: 12pt;font-weight: bold; border: 1px solid #ccc;' >");
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
        // For creating new CRFID ///
        [WebMethod(EnableSession = true)]
        public static string GetNewNoteID(string pageVal)
        {

            DataSet ds;
            DataTable dt = new DataTable();
            try
            {
          
                ITService.ITServiceClient obj1 = new ITService.ITServiceClient();
                ds = obj1.TrackerSelect(pageVal, "", "", "", "");
                dt = ds.Tables[0];
                if (dt.Rows.Count > 0)
                {
                    return dt.Rows[0][0].ToString();
                }
                else

                { return "NA"; }
            }
            catch(Exception ex)
            {
                throw ex;
            }

        }


        [WebMethod(EnableSession = true)]
        public static string SendMail(string toMail, List<string> cc, string body, string subject)
        {
            string exp = "";
            try
            {
                SmtpClient server = new SmtpClient("smtp.office365.com");
                server.Port = 587;
                server.EnableSsl = true;
                server.UseDefaultCredentials = false;
                server.Credentials = new System.Net.NetworkCredential("itportal@manappuram.com", "PLMokn@789", "smtp.office365.com");
                server.Timeout = 10000;
                server.TargetName = "STARTTLS/smtp.office365.com";
                server.DeliveryMethod = SmtpDeliveryMethod.Network;
                MailMessage mail = new MailMessage();
                mail.To.Add(new MailAddress(toMail)); 
                mail.From = new MailAddress("itportal@manappuram.com");
                mail.Subject = subject;
                mail.IsBodyHtml = true;
                mail.Body = body;
                if (cc.Count > 0)
                    foreach (string c in cc) mail.CC.Add(new MailAddress(c));

                System.Net.ServicePointManager.SecurityProtocol = System.Net.SecurityProtocolType.Tls | System.Net.SecurityProtocolType.Tls11 | System.Net.SecurityProtocolType.Tls12;
                System.Net.ServicePointManager.SecurityProtocol = System.Net.SecurityProtocolType.Tls | System.Net.SecurityProtocolType.Tls11 | System.Net.SecurityProtocolType.Tls12;
                mail.IsBodyHtml = true;
                   //server.Send(mail);
            }
            catch (Exception e)
            {
                exp = "NA";
                return exp;
                throw e;
            }
            return exp;

        }




        [WebMethod(EnableSession = true)]
        public static string RequestNoteConfirm(string pageVal, string pageval1, string pageval2, string pageval3)
        {
            DataSet ds, ds1, ds2,ds3;
            string str = "", exp = "";
            List<string> ccList = new List<string>();
            ITService.ITServiceClient obj1 = new ITService.ITServiceClient();
            ds = obj1.TrackerSelect(pageVal, pageVal, pageval1, pageval2, pageval3);
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
                            DataTable dt1, dt2, dt3,dHeads;
                            dt1 = obj1.TrackerSelect("GetEmailNoteRequest", noteid, "", "","").Tables[0];

                            dt2 = obj1.TrackerSelect("GetEmailReviewNext", noteid, "", "","").Tables[0];
                            string NextReviewrsId = dt2.Rows[0][0].ToString();
                            string NextReviewrsName = dt2.Rows[0][1].ToString();

                            dt3 = obj1.TrackerSelect("GetApprovedRDLCheader", noteid, "", "","").Tables[0];
                            string tblHead = ExportDatatableToHtmlHeading(dt3);
                            pageval2 = pageval2.Replace(',', '±');
                            dHeads = obj1.TrackerSelect("GetModuleHead", pageval2, noteid, "", "").Tables[0];

                            if (dt1.Rows.Count > 0)
                            {
                                string reqmailid = dt1.Rows[0][0].ToString() + "@manappuram.com";
                                string reqname = dt1.Rows[0][1].ToString();
                                string reqdate = dt1.Rows[0][2].ToString();
                                string imageUrlLog = GetImageUrl("files/img/manappuram_logo.png");
                                string imageContentLog = "<img src='" + imageUrlLog + "' alt='Alternate Text' />";
                                string imageUrlPaperless = GetImageUrl("files/img/paperlessBanner.png");
                                string imageContentPaperless = "<img src='" + imageUrlPaperless + "' alt='Alternate Text' />";
                                string bdy = "<p style='font-family: Calibri,Arial,Helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0);'>Dear " + reqname + ",<br/><br/>CRF has been Created by <b>" + reqname + "</b> on <b>" + reqdate + "</b> and assigned to <b> " + NextReviewrsName + " </b>for approval.. <br/><br/> <u><b>CRF Details</b></u><br/><br/> " + tblHead + " <br/><br/> Thanks & Regards,<br/>IT  Portal<br/><span style = 'font-size:11.0pt; font-family:&quot;Calibri&quot;,sans-serif; color:gray' lang='EN-IN'>Please do not reply to this email ID as this is an automatically generated email and reply to this ID is not being monitored</span></p>" + imageContentLog + "   " + imageContentPaperless + "<p><span style = 'color:rgb(105,105,105); font-size:7pt; font-family:arial,sans-serif; line-height:normal; background-color:rgba(0,0,0,0)' >Please be aware that this email/attachment contains MAFIL confidential/sensitive data. You are requested to follow MAFIL Information Security and data sharing policies in case the data is shared further. Feel free to contact AGM Information Security when youare in doubt.</span></p>";
                                string subj = "CRF -: " + noteid + " - New CRF Created";
                                ccList.Add("sunithakb@manappuram.com");
                                ccList.Add("itc@manappuram.com");
                                ccList.Add("cto@manappuram.com");
                                ccList.Add("15225@manappuram.com");
                                ccList.Add("md-tech@manappuram.com");
                                ccList.Add("mgresec2@manappuram.com");
                                string dtls = "10µ" + reqmailid + "µsunithakb@manappuram.com;itc@manappuram.com;cto@manappuram.com;15225@manappuram.com;md-tech@manappuram.com;mgresec2@manappuram.comµµ" + subj + "µ" + noteid + "µAMS";
                                //SendMail(reqmailid, ccList, bdy, subj);
                                //ds1 = obj1.TrackerSelect("InsertEmail", "InsertEmail", dtls, "", bdy);
                                string revwname = NextReviewrsName.ToString();
                                string bdy1 = "<p style='font-family: Calibri,Arial,Helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0);'>Dear " + revwname + ",<br/><br/> A CRF has been assigned for your review on <b>" + reqdate + "</b><br/>Kindly process the same at the earliest. <br/> <br/><br/><u><b>CRF Details</b></u><br/><br/> " + tblHead + " <br/><br/> Thanks & Regards,<br/>IT Portal<br/><span style = 'font-size:11.0pt; font-family:&quot;Calibri&quot;,sans-serif; color:gray' lang='EN-IN'>Please do not reply to this email ID as this is an automatically generated email and reply to this ID is not being monitored</span></p>" + imageContentLog + "   " + imageContentPaperless + "<p><span style = 'color:rgb(105,105,105); font-size:7pt; font-family:arial,sans-serif; line-height:normal; background-color:rgba(0,0,0,0)' >Please be aware that this email/attachment contains MAFIL confidential/sensitive data. You are requested to follow MAFIL Information Security and data sharing policies in case the data is shared further. Feel free to contact AGM Information Security when youare in doubt.</span></p>";
                                string subj1 = "CRF -: " + noteid + " - New CRF Created";
                                string dtls1 = "10µ" + NextReviewrsId + "@manappuram.com" + "µsunithakb@manappuram.com;itc@manappuram.com;cto@manappuram.com;15225@manappuram.com;md-tech@manappuram.com;mgresec2@manappuram.comµµ" + subj + "µ" + noteid + "µAMS";
                                //ds2 = obj1.TrackerSelect("InsertEmail", "InsertEmail", dtls1, "", bdy1);
                                //SendMail(NextReviewrsId, ccList, bdy1, subj1);
                                string hddata= dHeads.Rows[0][0].ToString();
                                string[] to_Email_Dup = hddata.Split('¶');
                                string[] to_Email = to_Email_Dup.Distinct().ToArray();
                                   for (int i = 0; i < to_Email.Length-1; i++)
                                    {
                                    try
                                    {
                                        string[] to_ = to_Email[i].Split('^');
                                        string bdy2 = "<p style='font-family: Calibri,Arial,Helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0);'>Dear " + to_[1] + ",<br/><br/> A CRF has been assigned for your review on <b>" + reqdate + "</b><br/>Kindly add your feedback if any... <br/> <br/><br/><u><b>CRF Details</b></u><br/><br/> " + tblHead + " <br/><br/> Thanks & Regards,<br/>IT Portal<br/><span style = 'font-size:11.0pt; font-family:&quot;Calibri&quot;,sans-serif; color:gray' lang='EN-IN'>Please do not reply to this email ID as this is an automatically generated email and reply to this ID is not being monitored</span></p>" + imageContentLog + "   " + imageContentPaperless + "<p><span style = 'color:rgb(105,105,105); font-size:7pt; font-family:arial,sans-serif; line-height:normal; background-color:rgba(0,0,0,0)' >Please be aware that this email/attachment contains MAFIL confidential/sensitive data. You are requested to follow MAFIL Information Security and data sharing policies in case the data is shared further. Feel free to contact AGM Information Security when youare in doubt.</span></p>";
                                        string dtls2 = "10µ" + to_[0] + "@manappuram.com" + "µsunithakb@manappuram.com;itc@manappuram.com;cto@manappuram.com;15225@manappuram.com;md-tech@manappuram.com;mgresec2@manappuram.comµµ" + subj + "µ" + noteid + "µAMS";
                                        //SendMail(to_[0] + "@manappuram.com", ccList, bdy1, subj1);
                                        //ds3 = obj1.TrackerSelect("InsertEmail", "InsertEmail", dtls2, "", bdy2);
                                    }
                                    catch (Exception exe)
                                    {
                                        throw exe;
                                    }
                                        
                                    }                              
                           
                            }
                            


                        }
                    }
                    catch (Exception ef)
                    {
                        //return ef.Message;
                        string msg = ef.Message;
                    }
                }
            }
            catch (Exception e)
            {
                return e.Message;
            }
            return str;
        }
    }
}