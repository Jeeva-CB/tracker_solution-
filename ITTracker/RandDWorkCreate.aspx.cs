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
    public partial class RandDWorkCreate : System.Web.UI.Page
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
        public static string AccessCheck(string pageVal,string pageval1)
        {

            DataSet ds;
            DataTable dt = new DataTable();
            try
            {
          
                ITService.ITServiceClient obj1 = new ITService.ITServiceClient();
                ds = obj1.TrackerSelect(pageVal, pageval1, "", "", "");
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
        public static string SendMail(List<string> ToMail, List<string> cc, string body, string subject)
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
               
                mail.From = new MailAddress("itportal@manappuram.com");
                mail.Subject = subject;
                mail.IsBodyHtml = true;
                mail.Body = body;
                if (ToMail.Count > 0)
                    foreach (string c in ToMail) mail.To.Add(new MailAddress(c));
                if (cc.Count > 0)
                    foreach (string c in cc) mail.CC.Add(new MailAddress(c));

                System.Net.ServicePointManager.SecurityProtocol = System.Net.SecurityProtocolType.Tls | System.Net.SecurityProtocolType.Tls11 | System.Net.SecurityProtocolType.Tls12;
                System.Net.ServicePointManager.SecurityProtocol = System.Net.SecurityProtocolType.Tls | System.Net.SecurityProtocolType.Tls11 | System.Net.SecurityProtocolType.Tls12;
                mail.IsBodyHtml = true;
                   server.Send(mail);
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
        public static string[] GetSearching1Data(string SearchKey, string QueryFlag, string QueryID, string dep)
        {
            ITService.ITServiceClient obj = new ITService.ITServiceClient();
            List<string> SearchArray = new List<string>();
            DataSet ds = new DataSet();
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



        [WebMethod(EnableSession = true)]
        public static string RequestNoteConfirm(string pageVal, string pageval1, string pageval2, string pageval3)
        {
            DataSet ds, ds1, ds2,ds3;
            string str = "", details = "";
            string[] array = new string[5];
            DataTable dt1, dt2, dt3=null, dHeads;
            List<string> toList = new List<string>();
            List<string> ccList = new List<string>();
            List<string> counts = new List<string>();
            ITService.ITServiceClient obj1 = new ITService.ITServiceClient();
            try {
                ds = obj1.TrackerSelect(pageVal, pageVal, pageval1, pageval2, pageval3);

                if (ds.Tables[0].Rows.Count > 0)
                {
                    str = ds.Tables[0].Rows[0][0].ToString();
                    dt3 = obj1.TrackerSelect("RANDDWORKMAIL", str, "", "", "").Tables[0];
                    dt2 = obj1.TrackerSelect("RANDDWORKMAILTOANDCC", str, "", "", "").Tables[0];
                    details = dt2.Rows[0][0].ToString();
                    array = details.Split('^');
                    counts = array[1].Split('~').ToList();
                }
                else str = "";
                if (pageval3 == "Close")
                {
                    string bdy = "<p style='font-family: Calibri,Arial,Helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0);'>Dear Sir/Madam,<br/><br/> The R&D work has been Closed.! Also waiting for your action..</b><br/>Kindly find the same in IT Tracker and do your part without any delay... <br/> <br/><br/><u><b>Work Details</b></u><br/><br/> " + dt3 + " <br/><br/> Thanks & Regards,<br/>IT Portal<br/><span style = 'font-size:11.0pt; font-family:&quot;Calibri&quot;,sans-serif; color:gray' lang='EN-IN'>Please do not reply to this email ID as this is an automatically generated email and reply to this ID is not being monitored</span></p><p><span style = 'color:rgb(105,105,105); font-size:7pt; font-family:arial,sans-serif; line-height:normal; background-color:rgba(0,0,0,0)' >Please be aware that this email/attachment contains MAFIL confidential/sensitive data. You are requested to follow MAFIL Information Security and data sharing policies in case the data is shared further. Feel free to contact AGM Information Security when youare in doubt.</span></p>";
                    string subj = "R&D WorkID -: " + str + " - Closed";
                    ccList.Add(array[0]);
                    ccList.Add(array[2].Split('~')[0]);
                    toList.Add(array[2].Split('~')[1]);
                    foreach (string c in counts)
                    {
                        toList.Add(c);
                    }
                    SendMail(toList, ccList, bdy, subj);
                }
                else if (pageval3 == "Cancel")
                {
                    string bdy = "<p style='font-family: Calibri,Arial,Helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0);'>Dear Sir/Madam,<br/><br/> The R&D work has been Cancelled.!</b><br/><br/><u><b>Work Details</b></u><br/><br/> " + dt3 + " <br/><br/> Thanks & Regards,<br/>IT Portal<br/><span style = 'font-size:11.0pt; font-family:&quot;Calibri&quot;,sans-serif; color:gray' lang='EN-IN'>Please do not reply to this email ID as this is an automatically generated email and reply to this ID is not being monitored</span></p><p><span style = 'color:rgb(105,105,105); font-size:7pt; font-family:arial,sans-serif; line-height:normal; background-color:rgba(0,0,0,0)' >Please be aware that this email/attachment contains MAFIL confidential/sensitive data. You are requested to follow MAFIL Information Security and data sharing policies in case the data is shared further. Feel free to contact AGM Information Security when youare in doubt.</span></p>";
                    string subj = "R&D WorkID -: " + str + " - Cancelled";
                    ccList.Add(array[0]);
                    ccList.Add(array[2].Split('~')[0]);
                    ccList.Add(array[2].Split('~')[1]);
                    foreach (string c in counts)
                    {
                        toList.Add(c);
                    }
                    SendMail(toList, ccList, bdy, subj);
                }
                else if (pageval3 == "Return")
                {
                    string bdy = "<p style='font-family: Calibri,Arial,Helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0);'>Dear Sir/Madam,<br/><br/> The R&D work has been Returned.! Also waiting for your action..</b><br/>Kindly find the same in IT Tracker and do your part without any delay... <br/> <br/><br/><u><b>Work Details</b></u><br/><br/> " + dt3 + " <br/><br/> Thanks & Regards,<br/>IT Portal<br/><span style = 'font-size:11.0pt; font-family:&quot;Calibri&quot;,sans-serif; color:gray' lang='EN-IN'>Please do not reply to this email ID as this is an automatically generated email and reply to this ID is not being monitored</span></p><p><span style = 'color:rgb(105,105,105); font-size:7pt; font-family:arial,sans-serif; line-height:normal; background-color:rgba(0,0,0,0)' >Please be aware that this email/attachment contains MAFIL confidential/sensitive data. You are requested to follow MAFIL Information Security and data sharing policies in case the data is shared further. Feel free to contact AGM Information Security when youare in doubt.</span></p>";
                    string subj = "R&D WorkID -: " + str + " - Returned";
                    ccList.Add(array[0]);
                    ccList.Add(array[2].Split('~')[0]);
                    ccList.Add(array[2].Split('~')[1]);
                    foreach (string c in counts)
                    {
                        toList.Add(c);
                    }
                    SendMail(toList, ccList, bdy, subj);
                }
                else if(pageval3.Contains("CTOHODAPPROVE"))
                {
                    string bdy = "";
                    string subj = "";
                    if (pageval3.Contains("$$")) //HOD
                    {
                         bdy = "<p style='font-family: Calibri,Arial,Helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0);'>Dear Sir/Madam,<br/><br/> The R&D work has been Approved by R&D Head.!</b><br/>Kindly find the same in IT Tracker and do your part without any delay... <br/> <br/><br/><u><b>Work Details</b></u><br/><br/> " + dt3 + " <br/><br/> Thanks & Regards,<br/>IT Portal<br/><span style = 'font-size:11.0pt; font-family:&quot;Calibri&quot;,sans-serif; color:gray' lang='EN-IN'>Please do not reply to this email ID as this is an automatically generated email and reply to this ID is not being monitored</span></p><p><span style = 'color:rgb(105,105,105); font-size:7pt; font-family:arial,sans-serif; line-height:normal; background-color:rgba(0,0,0,0)' >Please be aware that this email/attachment contains MAFIL confidential/sensitive data. You are requested to follow MAFIL Information Security and data sharing policies in case the data is shared further. Feel free to contact AGM Information Security when youare in doubt.</span></p>";
                        subj = "R&D WorkID -: " + str + " - Approved by R&D Head";
                        ccList.Add(array[0]);
                        toList.Add(array[2].Split('~')[0]);
                        ccList.Add(array[2].Split('~')[1]);
                        foreach (string c in counts)
                        {
                            ccList.Add(c);
                        }
                    }
                    else
                    {
                         bdy = "<p style='font-family: Calibri,Arial,Helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0);'>Dear Sir/Madam,<br/><br/> The R&D work has been Approved by CTO.!</b><br/>Kindly find the same in IT Tracker and do your part without any delay... <br/> <br/><br/><u><b>Work Details</b></u><br/><br/> " + dt3 + " <br/><br/> Thanks & Regards,<br/>IT Portal<br/><span style = 'font-size:11.0pt; font-family:&quot;Calibri&quot;,sans-serif; color:gray' lang='EN-IN'>Please do not reply to this email ID as this is an automatically generated email and reply to this ID is not being monitored</span></p><p><span style = 'color:rgb(105,105,105); font-size:7pt; font-family:arial,sans-serif; line-height:normal; background-color:rgba(0,0,0,0)' >Please be aware that this email/attachment contains MAFIL confidential/sensitive data. You are requested to follow MAFIL Information Security and data sharing policies in case the data is shared further. Feel free to contact AGM Information Security when youare in doubt.</span></p>";
                         subj = "R&D WorkID -: " + str + " - Approved by CTO";
                        ccList.Add(array[0]);
                        ccList.Add(array[2].Split('~')[0]);
                        ccList.Add(array[2].Split('~')[1]);
                        foreach (string c in counts)
                        {
                            toList.Add(c);
                        }
                    }
                    
                    ccList.Add(array[0]);
                    ccList.Add(array[2].Split('~')[0]);
                    ccList.Add(array[2].Split('~')[1]);
                    foreach (string c in counts)
                    {
                        toList.Add(c);
                    }
                    SendMail(toList, ccList, bdy, subj);
                }
                else if (pageval3 == "CTOHODRETURN")
                {
                    string bdy = "<p style='font-family: Calibri,Arial,Helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0);'>Dear Sir/Madam,<br/><br/> The R&D work has been Returned.! Also waiting for your action..</b><br/>Kindly find the same in IT Tracker and do your part without any delay... <br/> <br/><br/><u><b>Work Details</b></u><br/><br/> " + dt3 + " <br/><br/> Thanks & Regards,<br/>IT Portal<br/><span style = 'font-size:11.0pt; font-family:&quot;Calibri&quot;,sans-serif; color:gray' lang='EN-IN'>Please do not reply to this email ID as this is an automatically generated email and reply to this ID is not being monitored</span></p><p><span style = 'color:rgb(105,105,105); font-size:7pt; font-family:arial,sans-serif; line-height:normal; background-color:rgba(0,0,0,0)' >Please be aware that this email/attachment contains MAFIL confidential/sensitive data. You are requested to follow MAFIL Information Security and data sharing policies in case the data is shared further. Feel free to contact AGM Information Security when youare in doubt.</span></p>";
                    string subj = "R&D WorkID -: " + str + " - Returned";
                    ccList.Add(array[0]);
                    ccList.Add(array[2].Split('~')[0]);
                    ccList.Add(array[2].Split('~')[1]);
                    foreach (string c in counts)
                    {
                        toList.Add(c);
                    }
                    //SendMail(toList, ccList, bdy, subj);
                }
                else
                {
                    string bdy = "<p style='font-family: Calibri,Arial,Helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0);'>Dear Sir/Madam,<br/><br/> The R&D work has been Created.! Also waiting for your action..</b><br/>Kindly find the same in IT Tracker and do your part without any delay... <br/> <br/><br/><u><b>Work Details</b></u><br/><br/> " + dt3 + " <br/><br/> Thanks & Regards,<br/>IT Portal<br/><span style = 'font-size:11.0pt; font-family:&quot;Calibri&quot;,sans-serif; color:gray' lang='EN-IN'>Please do not reply to this email ID as this is an automatically generated email and reply to this ID is not being monitored</span></p><p><span style = 'color:rgb(105,105,105); font-size:7pt; font-family:arial,sans-serif; line-height:normal; background-color:rgba(0,0,0,0)' >Please be aware that this email/attachment contains MAFIL confidential/sensitive data. You are requested to follow MAFIL Information Security and data sharing policies in case the data is shared further. Feel free to contact AGM Information Security when youare in doubt.</span></p>";
                    string subj = "R&D WorkID -: " + str + " - Created";
                    ccList.Add(array[0]);
                    ccList.Add(array[2].Split('~')[0]);
                    ccList.Add(array[2].Split('~')[1]);
                    foreach (string c in counts)
                    {
                        toList.Add(c);
                    }
                    SendMail(toList, ccList, bdy, subj);
                }
            }
            catch(Exception e)
            {
                //throw e;
            }
            
            
            return str;
        }
    }
}