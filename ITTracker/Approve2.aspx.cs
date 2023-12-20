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
using System.IO;
using System.Configuration;
using System.Collections;
using System.Net.Mail;
using System.Drawing.Imaging;
using System.Text;
namespace ITTacker
{
    public partial class Approve2 : System.Web.UI.Page
    {
        public static string editContent;
        public void Page_Init(object o, EventArgs e)
        {

            Response.Cache.SetCacheability(HttpCacheability.NoCache);

            Response.Cache.SetExpires(DateTime.UtcNow.AddHours(-1));

            Response.Cache.SetNoStore();
        }
            protected void Page_Load(object sender, EventArgs e)
        {
            
            string usr, bid, fimid,ipaddres, sessn;
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
                this.hdBranchId.Value = bid;
                this.hdFirmId.Value = fimid;
                this.hdnSystemIP.Value = ipaddres;
                this.hdSesssion.Value = sessn;
                this.hdEditOption.Value= getEditOption("GetEditOption", usr, "");

                //hdPag.Value = Request.QueryString["pag"];
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
            ds = obj1.PwaSelectData("PWAAPP", pageVal, pageval1, "", "");
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
        public class getListData
        {
            public string lst { get; set; }
        }
        [WebMethod(EnableSession = true)]
        public static List<getListData> getListPending(string pageVal, string pageval1, string pageval2)
        {
            DataSet ds;
            List<getListData> getData = new List<getListData>();
            PWA_Service.PWA_ServiceClient obj1 = new PWA_Service.PWA_ServiceClient();
            ds = obj1.PwaSelectData("PWAAPP", pageVal, pageval1, pageval2,"");
            try
            {
                if (ds.Tables[0].Rows.Count > 0)
                {
                    foreach (DataRow dr in ds.Tables[0].Rows)
                    {
                        getData.Add(new getListData()
                        {
                            lst = dr[0].ToString()
                        });
                    }
                }
            }
            catch (Exception e)
            {
               // return e.Message;
            }
            return getData;
        }
        [WebMethod(EnableSession = true)]
        public static string setEditedContent(string content)
        {
            editContent = content;
            return "Success";
        }

        [WebMethod(EnableSession = true)]
        public static string getEditedContent(string noteid)
        {
           if(editContent!=null )
            {
               if(editContent.Split('~')[0].ToString()== noteid)
                {
                    return editContent.Split('~')[1].ToString();
                }
               else
                { return "NODATA"; }
            }
           else
            { return "NODATA"; }
        }

        [WebMethod(EnableSession = true)]
        public static string getTableData(string pageVal, string pageval1, string pageval2)
        {
            DataSet ds;
            string str = "";

            PWA_Service.PWA_ServiceClient obj1 = new PWA_Service.PWA_ServiceClient();
            ds = obj1.PwaSelectData("PWAAPP", pageVal, pageval1, pageval2, "");
            if (ds.Tables.Count > 0)
            {
                if (ds.Tables[0].Rows.Count > 0)
                {
                    foreach (DataRow dr in ds.Tables[0].Rows)
                    {
                        string row1 = "";
                        foreach (DataColumn dc in ds.Tables[0].Columns)
                        {
                            //str1 = dr[dc].ToString();
                            //1µ2µ3µ4µ8µ
                            row1 = row1 + dr[dc] + "µ";
                        }
                        str = str + row1 + "Θ";
                    }

                }

            }
            return str;
        }

        [WebMethod(EnableSession = true)]
        public static string getRequestNote(string pageVal, string pageval1, string pageval2)
        {
            DataSet ds;
            string str = "";

            PWA_Service.PWA_ServiceClient obj1 = new PWA_Service.PWA_ServiceClient();
            ds = obj1.PwaSelectData("PWAAPP", pageVal, pageval1, pageval2, "");
            try
            {
                if (ds.Tables[0].Rows.Count > 0)
                {
                    str = ds.Tables[0].Rows[0][0].ToString();
                }
            }
            catch (Exception e)
            {
                return e.Message;
            }
            return str;
        }

        [WebMethod(EnableSession = true)]
        public static string getFileData(string pageVal, string pageval1, string pageval2, string pageval3)
        {
            Approve2 f = new Approve2();
            f.deleteDownloadFileAll(pageval3);
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
                            else if (dc.ColumnName == "FILE_DATA")
                            {
                                fileByt = (byte[])(dr[dc]);
                                Approve2 d = new Approve2();
                                d.DownloadFile(pageval2 + DocFileName, fileByt);
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

        [WebMethod(EnableSession = true)]
        public static string NoteRecommendConfirm(string pageVal, string pageval1, string pageval2, string pageval3)
        {
            DataSet ds,ds1,ds2,ds3;
            string str = "",newcontent="";
            if (editContent == null)
            {
                newcontent="";
            }
            else if(editContent.Split('~')[0].ToString()!= pageval2)
            {
                newcontent = "";
            }
            else { newcontent = editContent.Split('~')[1].ToString(); }
            PWA_Service.PWA_ServiceClient obj1 = new PWA_Service.PWA_ServiceClient();
            ds = obj1.PwaSelectData("PWAAPP", pageVal, pageval1, pageval2, newcontent);

            string[] notes = pageval1.Split('µ');
            string noteid = notes[2].ToString();

          
            string docType = pageval3;
            try
            {
                if (ds.Tables[0].Rows.Count > 0)
                {
                    str = ds.Tables[0].Rows[0][0].ToString();

                    try
                    {
                        if (str.Contains("µ"))
                        {
                            string[] restat = str.Split('µ');
                            if(restat[0].ToString() == "1")
                            {                                
                                DataTable dt1, dt2, dt3;

                                ds = obj1.PwaSelectData("PWAAPP", "GetEmailReviewedList", noteid, "", "");
                                string tblApprove = ExportDatatableToHtmlApprovers(ds.Tables[0]);

                                dt2 = obj1.PwaSelectData("PWAAPP", "GetEmailReviewNext", noteid, "", "").Tables[0];
                                string NextReviewrsId = dt2.Rows[0][0].ToString();
                                string NextReviewrsName = dt2.Rows[0][1].ToString();
                               
                                dt3 = obj1.PwaSelectData("PWAAPP", "GetApprovedRDLCheader", noteid, "", "").Tables[0];
                                string tblHead = ExportDatatableToHtmlHeading(dt3);
                                if(NextReviewrsId!="0")
                                {
                                    string reqdate = dt2.Rows[0][2].ToString();
                                    string apprvType = dt2.Rows[0][3].ToString();
                                    string imageUrlLog = GetImageUrl("files/img/manappuram_logo.png");
                                    string imageContentLog = "<img src='" + imageUrlLog + "' alt='Alternate Text' />";

                                    string imageUrlPaperless = GetImageUrl("files/img/paperlessBanner1.png");
                                    string imageContentPaperless = "<img src='" + imageUrlPaperless + "' alt='Alternate Text' />";



                                    if (apprvType == "L")
                                    {
                                        string apprvStatus = dt2.Rows[0][4].ToString();
                                        string apprvBy = dt2.Rows[0][5].ToString();

                                        string revwmailid = NextReviewrsId + "@manappuram.com";
                                        string revwname = NextReviewrsName;
                                        string bdy = "";
                                        string cc = "";
                                       
                                        if (apprvStatus== "Need Discussion")
                                        {

                                            ds3 = obj1.PwaSelectData("PWAAPP", "GetHOD", dt3.Rows[0][6].ToString(), "", "");
                                            dt1 = ds3.Tables[0];
                                            string hod = dt1.Rows[0][0].ToString();

                                            bdy = "<p style='font-family: Calibri,Arial,Helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0);'>Dear " + revwname + ",<br/><br/>A discussion is required with <b>" + apprvBy + "</b>for the below file, kindly request the appointment and discuss at the earliest:<br/><br/> <u><b>Note Details</b></u><br/><br/> " + tblHead + " <br/><br/><u><b>Workflow History</b></u><br/><br/> " + tblApprove + " <br/><br/>Once the discussion is completed, please update the paperless note with the minutes of the meeting for final approval. <br/><br/>Thanks & Regards,<br/>Paperless Portal<br/><span style = 'font-size:11.0pt; font-family:&quot;Calibri&quot;,sans-serif; color:gray' lang='EN-IN'>Please do not reply to this email ID as this is an automatically generated email and reply to this ID is not being monitored</span></p>" + imageContentLog + "   " + imageContentPaperless + "<p><span style = 'color:rgb(105,105,105); font-size:7pt; font-family:arial,sans-serif; line-height:normal; background-color:rgba(0,0,0,0)' >Please be aware that this email/attachment contains MAFIL confidential/sensitive data. You are requested to follow MAFIL Information Security and data sharing policies in case the data is shared further. Feel free to contact AGM Information Security when youare in doubt.</span></p>";
                                            cc = "cmdoffice@manappuram.com;cmd@manappuram.com;"+ hod +"@manappuram.com";
                                        }
                                        else if (newcontent != "")
                                        {
                                            bdy = "<p style='font-family: Calibri,Arial,Helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0);'>Dear " + revwname + ",<br/><br/>Your Note has been <b>" + apprvStatus + " and edited </b> by <b>" + apprvBy + "</b> on <b>" + reqdate + ".</b><br/><br/> <u><b>Note Details</b></u><br/><br/> " + tblHead + " <br/><br/><u><b>Workflow History</b></u><br/><br/> " + tblApprove + " <br/><br/> Thanks & Regards,<br/>Paperless Portal<br/><span style = 'font-size:11.0pt; font-family:&quot;Calibri&quot;,sans-serif; color:gray' lang='EN-IN'>Please do not reply to this email ID as this is an automatically generated email and reply to this ID is not being monitored</span></p>" + imageContentLog + "   " + imageContentPaperless + "<p><span style = 'color:rgb(105,105,105); font-size:7pt; font-family:arial,sans-serif; line-height:normal; background-color:rgba(0,0,0,0)' >Please be aware that this email/attachment contains MAFIL confidential/sensitive data. You are requested to follow MAFIL Information Security and data sharing policies in case the data is shared further. Feel free to contact AGM Information Security when you are in doubt.</span></p>";
                                        }
                                        else if (apprvStatus == "Approved" && docType == "2")
                                        {
                                            bdy = "<p style='font-family: Calibri,Arial,Helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0);'>Dear " + revwname + ",<br/><br/>Your Note has been " + apprvStatus + " by <b>" + apprvBy + "</b> on <b>" + reqdate + ".</b><br/><br/> <u><b>Note Details</b></u><br/><br/> " + tblHead + " <br/><br/><u><b>Workflow History</b></u><br/><br/> " + tblApprove + " <br/><br/> Thanks & Regards,<br/>Paperless Portal<br/><span style = 'font-size:11.0pt; font-family:&quot;Calibri&quot;,sans-serif; color:gray' lang='EN-IN'>Please do not reply to this email ID as this is an automatically generated email and reply to this ID is not being monitored</span></p>" + imageContentLog + "   " + imageContentPaperless + "<p><span style = 'color:rgb(105,105,105); font-size:7pt; font-family:arial,sans-serif; line-height:normal; background-color:rgba(0,0,0,0)' >Please be aware that this email/attachment contains MAFIL confidential/sensitive data. You are requested to follow MAFIL Information Security and data sharing policies in case the data is shared further. Feel free to contact AGM Information Security when you are in doubt.</span></p>";
                                            cc = "344254@manappuram.com;300543@manappuram.com;352731@manappuram.com";
                                        }
                                        else
                                        {
                                            bdy = "<p style='font-family: Calibri,Arial,Helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0);'>Dear " + revwname + ",<br/><br/>Your Note has been " + apprvStatus + " by <b>" + apprvBy + "</b> on <b>" + reqdate + ".</b><br/><br/> <u><b>Note Details</b></u><br/><br/> " + tblHead + " <br/><br/><u><b>Workflow History</b></u><br/><br/> " + tblApprove + " <br/><br/> Thanks & Regards,<br/>Paperless Portal<br/><span style = 'font-size:11.0pt; font-family:&quot;Calibri&quot;,sans-serif; color:gray' lang='EN-IN'>Please do not reply to this email ID as this is an automatically generated email and reply to this ID is not being monitored</span></p>" + imageContentLog + "   " + imageContentPaperless + "<p><span style = 'color:rgb(105,105,105); font-size:7pt; font-family:arial,sans-serif; line-height:normal; background-color:rgba(0,0,0,0)' >Please be aware that this email/attachment contains MAFIL confidential/sensitive data. You are requested to follow MAFIL Information Security and data sharing policies in case the data is shared further. Feel free to contact AGM Information Security when you are in doubt.</span></p>";
 
                                        }
                                            
                                            
                                        string subj = "Paperless Note -: " + noteid + " - " + apprvStatus; 
                                        string dtls = "1µ" + revwmailid + "µ" + cc + "µµ" + subj + "µ" + noteid + "µPaperless";
                                        
                                        ds1 = obj1.PwaSelectData("PWAAPP", "InsertEmail", dtls, "", bdy);

                                      

                                    }
                                    else
                                    {                                        
                                      string[] NextReviewrs = NextReviewrsId.Split(',');
                                      if (NextReviewrs.Length > 0)
                                        {
                                            foreach (string i in NextReviewrs)
                                            {
                                                string[] reviwnames = i.Split('±');
                                                string revwmailid = reviwnames[0].ToString() + "@manappuram.com";
                                                string revwname = reviwnames[1].ToString();

                                                string bdy = "<p style='font-family: Calibri,Arial,Helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0);'>Dear " + revwname + ",<br/><br/> A note has been assigned for your review on <b>" + reqdate + ".</b><br/>Kindly process the same at the earliest. <br/> <br/><br/><u><b>Note Details</b></u><br/><br/> " + tblHead + " <br/><br/><u><b>Workflow History</b></u><br/><br/> " + tblApprove + " <br/><br/>  Thanks & Regards,<br/>Paperless Portal<br/><span style = 'font-size:11.0pt; font-family:&quot;Calibri&quot;,sans-serif; color:gray' lang='EN-IN'>Please do not reply to this email ID as this is an automatically generated email and reply to this ID is not being monitored</span></p>" + imageContentLog + "   " + imageContentPaperless + "<p><span style = 'color:rgb(105,105,105); font-size:7pt; font-family:arial,sans-serif; line-height:normal; background-color:rgba(0,0,0,0)' >Please be aware that this email/attachment contains MAFIL confidential/sensitive data. You are requested to follow MAFIL Information Security and data sharing policies in case the data is shared further. Feel free to contact AGM Information Security when youare in doubt.</span></p>";
                                                string subj = "Paperless Note -: " + noteid + " - Assigned for Review";
                                                string dtls = "1µ" + revwmailid + "µµµ" + subj + "µ" + noteid + "µPaperless";

                                                ds2 = obj1.PwaSelectData("PWAAPP", "InsertEmail", dtls,  "", bdy);


                                                //using (SmtpClient server = new SmtpClient("smtp.office365.com"))
                                                //{
                                                //    server.Port = 587;
                                                //    server.EnableSsl = true;
                                                //    server.UseDefaultCredentials = false;
                                                //    //server.Credentials = new System.Net.NetworkCredential("55323@manappuram.com", "Winter123*", "smtp.office365.com"); 
                                                //    server.Credentials = new System.Net.NetworkCredential("filetracker@manappuram.com", "QWpk@789", "smtp.office365.com");
                                                //    server.Timeout = 200000;
                                                //    server.TargetName = "STARTTLS/smtp.office365.com";
                                                //    server.DeliveryMethod = SmtpDeliveryMethod.Network;
                                                //    MailMessage mail = new MailMessage();
                                                //    mail.From = new MailAddress("filetracker@manappuram.com", "Paperless Portal", System.Text.Encoding.ASCII);

                                                //    mail.To.Add(revwmailid);
                                                //    //mail.CC.Add("itc@manappuram.com");
                                                //    //mail.CC.Add("techanalyst@manappuram.com");
                                                //    //mail.Bcc.Add("14955@manappuram.com");
                                                //    mail.Subject = "Paperless Note -: " + noteid + " - Assigned for Review";
                                                //    string imageUrlLog = GetImageUrl("files/img/manappuram_logo.png");
                                                //    string imageContentLog = "<img src='" + imageUrlLog + "' alt='Alternate Text' />";

                                                //    string imageUrlPaperless = GetImageUrl("files/img/paperlessBanner1.png");
                                                //    string imageContentPaperless = "<img src='" + imageUrlPaperless + "' alt='Alternate Text' />";
                                                //    //string tblApprove1 = "<table border='1' style='background-color: #f2f2f2;font - size: 10pt; border -color: #000 !important;'><thead><tr style='background-color: #89cc00;font - size: 12pt;'><th>Reviewer Name</th><th>Designation </th><th>Department</th><th>Status</th><th >Updated Date</th><th>Remarks</th></tr></thead><tbody><tr><td>John K Thomas</td><td>Manager</td><td>IT</td><td>Created</td><td>12/Nov/2019 10:10:10 AM</td><td>Recommended</td></tr></table>";
                                                //    //string reqname = ds1.Tables[0].Rows[0][2].ToString();
                                                //    //string reqdate = ds1.Tables[0].Rows[0][3].ToString();

                                                //    //" + imageContentLog +
                                                //    //note creation
                                                //    // mail.Body = "<p style='font-family: Calibri,Arial,Helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0);'>Dear " + reqname + ",<br/><br/>Paperless Note has been created by <b>" + reqname + "</b> on <b>" + reqdate + "</b> <br/><br/> <u><b>Note Details</b></u><br/><br/> " + tblHead + " <br/><br/> Thanks & Regards,<br/>Paperless Portal<br/><span style = 'font-size:11.0pt; font-family:&quot;Calibri&quot;,sans-serif; color:gray' lang='EN-IN'>Please do not reply to this email ID as this is an automatically generated email and reply to this ID is not being monitored</span></p>" + imageContentLog +"   "+ imageContentPaperless + "<p><span style = 'color:rgb(105,105,105); font-size:7pt; font-family:arial,sans-serif; line-height:normal; background-color:rgba(0,0,0,0)' >Please be aware that this email/attachment contains MAFIL confidential/sensitive data. You are requested to follow MAFIL Information Security and data sharing policies in case the data is shared further. Feel free to contact AGM Information Security when youare in doubt.</span></p>";
                                                //    //mail.Body = i + "@manappuram.com" + "<p style='font-family: Calibri,Arial,Helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0);'>Dear " + revwname + ",<br/><br/> A note has been assigned for your review on <b>" + reqdate + "</b><br/>Kindly process the same at the earliest. <br/> <br/><br/><u><b>Note Details</b></u><br/><br/> " + tblHead + " <br/><br/><u><b>Workflow History</b></u><br/><br/> " + tblApprove1 + " <br/><br/>  Thanks & Regards,<br/>Paperless Portal<br/><span style = 'font-size:11.0pt; font-family:&quot;Calibri&quot;,sans-serif; color:gray' lang='EN-IN'>Please do not reply to this email ID as this is an automatically generated email and reply to this ID is not being monitored</span></p>" + imageContentLog + "   " + imageContentPaperless + "<p><span style = 'color:rgb(105,105,105); font-size:7pt; font-family:arial,sans-serif; line-height:normal; background-color:rgba(0,0,0,0)' >Please be aware that this email/attachment contains MAFIL confidential/sensitive data. You are requested to follow MAFIL Information Security and data sharing policies in case the data is shared further. Feel free to contact AGM Information Security when youare in doubt.</span></p>";
                                                //    mail.Body = "<p style='font-family: Calibri,Arial,Helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0);'>Dear " + revwname + ",<br/><br/> A note has been assigned for your review on <b>" + reqdate + ".</b><br/>Kindly process the same at the earliest. <br/> <br/><br/><u><b>Note Details</b></u><br/><br/> " + tblHead + " <br/><br/><u><b>Workflow History</b></u><br/><br/> " + tblApprove + " <br/><br/>  Thanks & Regards,<br/>Paperless Portal<br/><span style = 'font-size:11.0pt; font-family:&quot;Calibri&quot;,sans-serif; color:gray' lang='EN-IN'>Please do not reply to this email ID as this is an automatically generated email and reply to this ID is not being monitored</span></p>" + imageContentLog + "   " + imageContentPaperless + "<p><span style = 'color:rgb(105,105,105); font-size:7pt; font-family:arial,sans-serif; line-height:normal; background-color:rgba(0,0,0,0)' >Please be aware that this email/attachment contains MAFIL confidential/sensitive data. You are requested to follow MAFIL Information Security and data sharing policies in case the data is shared further. Feel free to contact AGM Information Security when youare in doubt.</span></p>";



                                                //    //Recommend
                                                //    //mail.Body = "<p style='font-family: Calibri,Arial,Helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0);'>Dear "+ reqname + ",<br/><br/> A note has been assigned for your review on <b>"+ reqdate + "</b><br/>Kindly process the same at the earliest. <br/> <br/><br/><u><b>Note Details</b></u><br/><br/> " + tblHead + " <br/><br/><u><b>Reviewed Details</b></u><br/><br/> " + tblApprove + " <br/><br/>  Thanks & Regards,<br/>Paperless Portal<br/><span style = 'font-size:11.0pt; font-family:&quot;Calibri&quot;,sans-serif; color:gray' lang='EN-IN'>Please do not reply to this email ID as this is an automatically generated email and reply to this ID is not being monitored</span></p>" + imageContentLog + "   " + imageContentPaperless + "<p><span style = 'color:rgb(105,105,105); font-size:7pt; font-family:arial,sans-serif; line-height:normal; background-color:rgba(0,0,0,0)' >Please be aware that this email/attachment contains MAFIL confidential/sensitive data. You are requested to follow MAFIL Information Security and data sharing policies in case the data is shared further. Feel free to contact AGM Information Security when youare in doubt.</span></p>";


                                                //    //mail.Body = "<p style='font-family: Calibri,Arial,Helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0);'>Dear John K Thomas,<br/><br/> A note has been assigned for your recommendation on <b>25-Oct-2019 11.15 AM</b><br/>Kindly process the same at the earliest. <br/>. <br/><br/>Note ID: MAFIL/FY19-20/100001234<br/>Subject: <b>TESTING</b><br/>Priority: Medium <br/><br/>Last Reviewer: Jose <br/> Last Review Status : Recommended <br/> Last Reviewers Remarks : Recommended <br/><br/> "+ tblApprove + " <br/><br/>  Thanks & Regards,<br/>Paperless Portal<br/><span style = 'font-size:11.0pt; font-family:&quot;Calibri&quot;,sans-serif; color:gray' lang='EN-IN'>Please do not reply to this email ID as this is an automatically generated email and reply to this ID is not being monitored</span></p>" + imageContentLog + "   " + imageContentPaperless + "<p><span style = 'color:rgb(105,105,105); font-size:7pt; font-family:arial,sans-serif; line-height:normal; background-color:rgba(0,0,0,0)' >Please be aware that this email/attachment contains MAFIL confidential/sensitive data. You are requested to follow MAFIL Information Security and data sharing policies in case the data is shared further. Feel free to contact AGM Information Security when youare in doubt.</span></p>";

                                                //    //Recommend
                                                //    //mail.Body = "<p style='font-family: Calibri,Arial,Helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0);'>Dear John K Thomas,<br/><br/> A note has been assigned for your recommendation on <b>25-Oct-2019 11.15 AM</b><br/>Kindly process the same at the earliest. <br/>. <br/><br/><u><b>Note Details</b></u><br/><br/> " + tblHead + " <br/><br/><u><b>Reviewed Details</b></u><br/><br/> " + tblApprove + " <br/><br/>  Thanks & Regards,<br/>Paperless Portal<br/><span style = 'font-size:11.0pt; font-family:&quot;Calibri&quot;,sans-serif; color:gray' lang='EN-IN'>Please do not reply to this email ID as this is an automatically generated email and reply to this ID is not being monitored</span></p>" + imageContentLog + "   " + imageContentPaperless + "<p><span style = 'color:rgb(105,105,105); font-size:7pt; font-family:arial,sans-serif; line-height:normal; background-color:rgba(0,0,0,0)' >Please be aware that this email/attachment contains MAFIL confidential/sensitive data. You are requested to follow MAFIL Information Security and data sharing policies in case the data is shared further. Feel free to contact AGM Information Security when youare in doubt.</span></p>";


                                                //    //mail.Body = "<p style='font-family: Calibri,Arial,Helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0);'>Dear John K Thomas,<br/><br/>Paperless Note has been created by <b>John K Thomas</b> on <b>25-Oct-2019 11.15 AM</b>. <br/><br/>Note ID: <b>MAFIL/FY19-20/100001234</b><br/>Subject: <b>TESTING</b><br/>Priority: Medium <br/><br/>Consolidated Comments:<br/><br/> <b>Requester(John K Thomas) Comments</b>: New Note Created <br/><br/> Thanks & Regards,<br/>Paperless Portal<br/><span style = 'font-size:11.0pt; font-family:&quot;Calibri&quot;,sans-serif; color:gray' lang='EN-IN'>Please do not reply to this email ID as this is an automatically generated email and reply to this ID is not being monitored</span></p><br/>" + imageContentPaperless + "<p><span style = 'color:rgb(105,105,105); font-size:7pt; font-family:arial,sans-serif; line-height:normal; background-color:rgba(0,0,0,0)' >Please be aware that this email/attachment contains MAFIL confidential/sensitive data. You are requested to follow MAFIL Information Security and data sharing policies in case the data is shared further. Feel free to contact AGM Information Security when youare in doubt.</span></p>";
                                                //    //mail.Body = "<div>< div style = 'font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12pt; color:rgb(0,0,0)' >< p style = 'margin-top:0px; margin-bottom:0px; margin-top:0px; margin-bottom:0px; margin-top:0px; margin-bottom:0px' >< font size = '2' face = 'Calibri' >< font size = '3' >< span >< br ></ span ></ font ></ font ></ p >< p style = 'margin-top:0px; margin-bottom:0px; margin-top:0px; margin-bottom:0px; margin-top:0px; margin-bottom:0px' >< font size = '2' face = 'Calibri' >< font size = '3' >< span ></ span > Paperless Note has been created by<b> John K Thomas</ b > on 25 - Oct - 2019 & nbsp; 11.15 AM.</ font >< br >< br >< span > Note ID </ span >: < b > MAFIL / FY19 - 20 / 100001234 </ b >< br >Subject : TESTING </ font >< br ></ p >< font size = '2' face = 'Calibri' > Priority: Medium<br>Consolidated Comments:< br >< b >< u > Requester(John K Thomas) Comments:</ u ></ b > New Note Created</ font ></ div >< div style = 'font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12pt; color:rgb(0,0,0)' >< font size = '2' face = 'Calibri' >< br ></ font ></ div >< div style = 'font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12pt; color:rgb(0,0,0)' >< font size = '2' face = 'Calibri' >< p style = 'margin-top:0px; margin-bottom:0px; margin-top:0px; margin-bottom:0px; margin-top:0px; margin-bottom:0px' >< span style = 'color:#1f497d' > Thanks and Regards,</ span ></ p >< p style = 'margin-top:0px; margin-bottom:0px; margin-top:0px; margin-bottom:0px; margin-top:0px; margin-bottom:0px' >< strong >< span style = 'font-size:12.0pt; color:#1f497d' > Paperless Portal </ span ></ strong ></ p >< p style = 'margin-top:0px; margin-bottom:0px; margin-top:0px; margin-bottom:0px; margin-top:0px; margin-bottom:0px' >< strong >< span style = 'font-size:12.0pt; color:#1f497d' >< br ></ span ></ strong ></ p ></ font ></ div >< div id = 'x_Signature' >< p class='x_MsoNormal' style='margin-top:0px; margin-bottom:0px; margin-top:0px; margin-bottom:0px; margin-top:0px; margin-bottom:0px'><span style = 'font-size:11.0pt; font-family:&quot;Calibri&quot;,sans-serif; color:gray' lang='EN-IN'>Please do not reply to this email ID as this is an automatically generated email and reply to this ID is not being monitored.</span></p><p class='x_MsoNormal' style='margin-top:0px; margin-bottom:0px; margin-top:0px; margin-bottom:0px; margin-top:0px; margin-bottom:0px'><span style = 'font-size:11.0pt; font-family:&quot;Calibri&quot;,sans-serif; color:gray' lang='EN-IN'><br></span></p><p class='x_MsoNormal' style='margin-top:0px; margin-bottom:0px; margin-top:0px; margin-bottom:0px; margin-top:0px; margin-bottom:0px'><span style = 'font-size:11.0pt; font-family:&quot;Calibri&quot;,sans-serif; color:gray' lang='EN-IN'><img data-imagetype='AttachmentByCid' originalsrc='cid:404e74e1-191b-488e-8008-170f4449dd62' data-custom='AAMkADIzMjg4NTAzLTIyNGEtNDg1Yi05MTYzLWQxY2NlOWM0ZjkyYwBGAAAAAACTseMRo6paRalcR8ZX9vk%2FBwCspzUsnJKLQLm5jSoI2VRwAAAAAAEMAACspzUsnJKLQLm5jSoI2VRwAATzD9bcAAABEgAQADk2lMXzJ0JPpTIgUS9BaoM%3D' naturalheight='51' naturalwidth='171' src='https://attachments.office.net/owa/john.k%40manappuram.com/service.svc/s/GetAttachmentThumbnail?id=AAMkADIzMjg4NTAzLTIyNGEtNDg1Yi05MTYzLWQxY2NlOWM0ZjkyYwBGAAAAAACTseMRo6paRalcR8ZX9vk%2FBwCspzUsnJKLQLm5jSoI2VRwAAAAAAEMAACspzUsnJKLQLm5jSoI2VRwAATzD9bcAAABEgAQADk2lMXzJ0JPpTIgUS9BaoM%3D&amp;thumbnailType=2&amp;owa=outlook.office.com&amp;scriptVer=2019102103.07&amp;X-OWA-CANARY=puKpWtYrZky2nBtwIcJ6NkCX2WoeWdcYBVD7PW9G4tt2TaSTE7pwTO-E_aP6U4Vh5Xk6TmYuSOc.&amp;token=eyJhbGciOiJSUzI1NiIsImtpZCI6IjA2MDBGOUY2NzQ2MjA3MzdFNzM0MDRFMjg3QzQ1QTgxOENCN0NFQjgiLCJ4NXQiOiJCZ0Q1OW5SaUJ6Zm5OQVRpaDhSYWdZeTN6cmciLCJ0eXAiOiJKV1QifQ.eyJvcmlnaW4iOiJodHRwczovL291dGxvb2sub2ZmaWNlLmNvbSIsInZlciI6IkV4Y2hhbmdlLkNhbGxiYWNrLlYxIiwiYXBwY3R4c2VuZGVyIjoiT3dhRG93bmxvYWRAZDA1YTNjMjMtODFlNS00YTc3LTgwOTEtMTQxNDA3MzAwNjNiIiwiaXNzcmluZyI6IldXIiwiYXBwY3R4Ijoie1wibXNleGNocHJvdFwiOlwib3dhXCIsXCJwcmltYXJ5c2lkXCI6XCJTLTEtNS0yMS00MDE2MjE1ODcyLTQwNTY1NTQ4MjEtMTMwMjM3NjI5MC0zMzMyNzE3XCIsXCJwdWlkXCI6XCIxMTUzOTA2NjYwNzU1Mzc2NDMwXCIsXCJvaWRcIjpcIjQ4NGRjYWQ3LTJlYzktNDY5ZS1hYjZiLWVmNjdkODE2Yjk1YVwiLFwic2NvcGVcIjpcIk93YURvd25sb2FkXCJ9IiwibmJmIjoxNTcxOTg5MTQyLCJleHAiOjE1NzE5ODk3NDIsImlzcyI6IjAwMDAwMDAyLTAwMDAtMGZmMS1jZTAwLTAwMDAwMDAwMDAwMEBkMDVhM2MyMy04MWU1LTRhNzctODA5MS0xNDE0MDczMDA2M2IiLCJhdWQiOiIwMDAwMDAwMi0wMDAwLTBmZjEtY2UwMC0wMDAwMDAwMDAwMDAvYXR0YWNobWVudHMub2ZmaWNlLm5ldEBkMDVhM2MyMy04MWU1LTRhNzctODA5MS0xNDE0MDczMDA2M2IifQ.msmyFA9d3z6LNW9TT_Zl63U5tOSuibeWk4MY1HLE1mI_rAAafkRv3jcogA4KQo6eBwuMAKf_BscS_y35boqQxW_21P25bK2YKPV2ZAMi5PppsRjG7cVfFWiSSToGSFFJVMBKWmn8NXZNGRQgMYjxmzVRMZZBWXxq4aSkDE7K4GkVL5ucytWuVc4_N3ZY0W5mdwGKlMvRXL-hG__wdWAkVKQxONT_PG3eXwV6_sKE0smVH5A-8vb0vUdeK3l7ntL30y39m39TBaS5HHVuHG9l7iWfG6S6Xithpnwk7RIOarG-oK-0kr2vAmByQw0S81AqNWXuWCXf_uOGkcmyX3PgtQ&amp;animation=true' size='9186' tabindex='-1' data-outlook-trace='F:1|T:1' style='max-width: 100%; cursor: pointer; height: auto;' crossorigin='use-credentials'></span><span style = 'font-size:11.0pt; font-family:&quot;Calibri&quot;,sans-serif; color:gray' lang='EN-IN'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><span style = 'font-size:11.0pt; font-family:&quot;Calibri&quot;,sans-serif; color:gray' lang='EN-IN'><img data-imagetype='AttachmentByCid' originalsrc='cid:0c2acf51-e59d-4f36-878b-9e3d7b8599e6' data-custom='AAMkADIzMjg4NTAzLTIyNGEtNDg1Yi05MTYzLWQxY2NlOWM0ZjkyYwBGAAAAAACTseMRo6paRalcR8ZX9vk%2FBwCspzUsnJKLQLm5jSoI2VRwAAAAAAEMAACspzUsnJKLQLm5jSoI2VRwAATzD9bcAAABEgAQAKES1xBRzOFPju7MJje08SM%3D' naturalheight='90' naturalwidth='728' src='https://attachments.office.net/owa/john.k%40manappuram.com/service.svc/s/GetAttachmentThumbnail?id=AAMkADIzMjg4NTAzLTIyNGEtNDg1Yi05MTYzLWQxY2NlOWM0ZjkyYwBGAAAAAACTseMRo6paRalcR8ZX9vk%2FBwCspzUsnJKLQLm5jSoI2VRwAAAAAAEMAACspzUsnJKLQLm5jSoI2VRwAATzD9bcAAABEgAQAKES1xBRzOFPju7MJje08SM%3D&amp;thumbnailType=2&amp;owa=outlook.office.com&amp;scriptVer=2019102103.07&amp;X-OWA-CANARY=puKpWtYrZky2nBtwIcJ6NkCX2WoeWdcYBVD7PW9G4tt2TaSTE7pwTO-E_aP6U4Vh5Xk6TmYuSOc.&amp;token=eyJhbGciOiJSUzI1NiIsImtpZCI6IjA2MDBGOUY2NzQ2MjA3MzdFNzM0MDRFMjg3QzQ1QTgxOENCN0NFQjgiLCJ4NXQiOiJCZ0Q1OW5SaUJ6Zm5OQVRpaDhSYWdZeTN6cmciLCJ0eXAiOiJKV1QifQ.eyJvcmlnaW4iOiJodHRwczovL291dGxvb2sub2ZmaWNlLmNvbSIsInZlciI6IkV4Y2hhbmdlLkNhbGxiYWNrLlYxIiwiYXBwY3R4c2VuZGVyIjoiT3dhRG93bmxvYWRAZDA1YTNjMjMtODFlNS00YTc3LTgwOTEtMTQxNDA3MzAwNjNiIiwiaXNzcmluZyI6IldXIiwiYXBwY3R4Ijoie1wibXNleGNocHJvdFwiOlwib3dhXCIsXCJwcmltYXJ5c2lkXCI6XCJTLTEtNS0yMS00MDE2MjE1ODcyLTQwNTY1NTQ4MjEtMTMwMjM3NjI5MC0zMzMyNzE3XCIsXCJwdWlkXCI6XCIxMTUzOTA2NjYwNzU1Mzc2NDMwXCIsXCJvaWRcIjpcIjQ4NGRjYWQ3LTJlYzktNDY5ZS1hYjZiLWVmNjdkODE2Yjk1YVwiLFwic2NvcGVcIjpcIk93YURvd25sb2FkXCJ9IiwibmJmIjoxNTcxOTg5MTQyLCJleHAiOjE1NzE5ODk3NDIsImlzcyI6IjAwMDAwMDAyLTAwMDAtMGZmMS1jZTAwLTAwMDAwMDAwMDAwMEBkMDVhM2MyMy04MWU1LTRhNzctODA5MS0xNDE0MDczMDA2M2IiLCJhdWQiOiIwMDAwMDAwMi0wMDAwLTBmZjEtY2UwMC0wMDAwMDAwMDAwMDAvYXR0YWNobWVudHMub2ZmaWNlLm5ldEBkMDVhM2MyMy04MWU1LTRhNzctODA5MS0xNDE0MDczMDA2M2IifQ.msmyFA9d3z6LNW9TT_Zl63U5tOSuibeWk4MY1HLE1mI_rAAafkRv3jcogA4KQo6eBwuMAKf_BscS_y35boqQxW_21P25bK2YKPV2ZAMi5PppsRjG7cVfFWiSSToGSFFJVMBKWmn8NXZNGRQgMYjxmzVRMZZBWXxq4aSkDE7K4GkVL5ucytWuVc4_N3ZY0W5mdwGKlMvRXL-hG__wdWAkVKQxONT_PG3eXwV6_sKE0smVH5A-8vb0vUdeK3l7ntL30y39m39TBaS5HHVuHG9l7iWfG6S6Xithpnwk7RIOarG-oK-0kr2vAmByQw0S81AqNWXuWCXf_uOGkcmyX3PgtQ&amp;animation=true' size='34253' tabindex='-1' data-outlook-trace='F:1|T:1' style='width: 404.598px; height: 50px; cursor: pointer;' crossorigin='use-credentials' width='404.59770114942523' height='50'><br></span></p></div><span style = 'font-size:11.0pt; font-family:&quot;Calibri&quot;,sans-serif; color:gray' lang='EN-IN'><span style = 'font-size:7pt; font-family:Arial,sans-serif; color:#696969' >< span >< span style='color:rgb(128,128,128); font-size:11pt; font-family:&quot;calibri&quot;,sans-serif; line-height:normal; background-color:rgba(0,0,0,0)'>Note:</span><span style = 'color:rgb(105,105,105); font-size:7pt; font-family:arial,sans-serif; line-height:normal; background-color:rgba(0,0,0,0)' >Please be aware that this email/attachment contains MAFIL confidential/sensitive data. You are requested to follow MAFIL Information Security and data sharing policies in case the data is shared further. Feel free to contact AGM Information Security when youare in doubt.</span></span></span></span></div>";

                                                //    mail.IsBodyHtml = true;
                                                //    server.Send(mail);
                                                //}
                                            }
                                        }
                                    }
                                   
                                 
                                }

                                //dt3 = obj1.PwaSelectData("PWAAPP", "GetApprovedRDLCheader", noteid, "", "").Tables[0];
                                //string tblHead = ExportDatatableToHtmlHeading(dt3);

                            }

                        }
                    }
                    catch (Exception ef)
                    {
                        //return ef.Message;
                        string msg = ef.Message;
                    }

                    //SmtpClient server = new SmtpClient("smtp.office365.com");
                    //server.Port = 587;
                    //server.EnableSsl = true;
                    //server.UseDefaultCredentials = false;
                    ////server.Credentials = new System.Net.NetworkCredential("55323@manappuram.com", "Winter123*", "smtp.office365.com"); 
                    //server.Credentials = new System.Net.NetworkCredential("filetracker@manappuram.com", "QWpk@789", "smtp.office365.com");
                    //server.Timeout = 5000;
                    //server.TargetName = "STARTTLS/smtp.office365.com";
                    //server.DeliveryMethod = SmtpDeliveryMethod.Network;
                    //MailMessage mail = new MailMessage();
                    //mail.From = new MailAddress("filetracker@manappuram.com");

                    //mail.To.Add("19675@manappuram.com");

                    //mail.Subject = "PAPPERLESS TESTING";
                    //mail.Body = "<p style='font-family: Arial;font-size:14px;color:#565656;'>Dear ,<br/><br/>Below file has been <b>proceeded</b> further as  is on Tour<br/><br/>File Tracking ID: <b></b><br/>Subject: <br/>Status:<b></b><br/>Initiating Department:  <br/>Priority:<br/>Timestamp:<br/><br/>Thanks & Regards,<br/>File Tracking Team<br/>Please do not reply to this email ID as this is an automatically generated email and reply to this ID is not being monitored</p>";

                    //mail.IsBodyHtml = true;
                    //server.Send(mail);
                }
            }
            catch (Exception e)
            {
                return e.Message;
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
        public static string UploadingFile(string ImageData, string InputData)
        {
            String InputDataDecrypted = ClientsideEncryption.AESEncrytDecry.DecryptStringAES(InputData);
            //List<string> extentions = new List<string>();
            //extentions.Add("913020010321699");
            //String InputDataDecrypted = InputData;
            List<string> extentions = new List<string>();

            extentions.InsertRange(extentions.Count, new string[] { "pdf", "jpg", "gif", "jpeg", "bmp", "tif", "tiff", "png", "xps", "doc", "docx", "fax", "wmp", "ico", "txt", "rtf", "xls", "xlsx", "ppt", "pptx", "odp", "ott", "ods", "ots", "odm", "otp", "odt", "ott", "odg", "otg", "odf" });

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
                return "";
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
                    Approve2 d = new Approve2();
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

        [WebMethod(EnableSession = true)]
        public static string getApproveCount(string pageVal, string pageval1, string pageval2)
        {
            DataSet ds;
            string str = "";
            
            //Data = $("[id*=hdBranchId]").val() + 'µ' + $("[id*=hdFirmId]").val() + 'µ' + $("[id*=hdUserId]").val()
            PWA_Service.PWA_ServiceClient obj1 = new PWA_Service.PWA_ServiceClient();
            ds = obj1.PwaSelectData("PWAAPP", pageVal, pageval1, pageval2, "");
            try
            {
                if (ds.Tables[0].Rows.Count > 0)
                {
                    str = ds.Tables[0].Rows[0][0].ToString();
                }
            }
            catch (Exception e)
            {
                return e.Message;
            }
            return str;
        }

        [WebMethod(EnableSession = true)]
        public static string ExportDatatableToHtmlHeading(DataTable dt)
        {
            StringBuilder strHTMLBuilder = new StringBuilder();
            strHTMLBuilder.Append("<table style='border: 1px solid #ccc;width: 100%;'>");
            //strHTMLBuilder.Append("<thead><tr style='background-color: #f2f2f2;background-color: #3498db;color: white;font-size: 12pt;font-weight: bold; '><th>Reviewer Name</th><th>Designation </th><th>Department</th><th>Status</th><th >Updated Date</th><th>Remarks</th></tr></thead>");
            strHTMLBuilder.Append("<thead>");
            strHTMLBuilder.Append("<tr style='background-color: #fdd935;color: black;font-size: 10pt;font-weight: bold; border: 1px solid #ccc;' >");
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
                strHTMLBuilder.Append("<tr style='border: 1px solid #ccc; font-size: 12pt;'>");
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

        [WebMethod(EnableSession = true)]
        public static string ExportDatatableToHtmlApprovers(DataTable dt)
        {
            StringBuilder strHTMLBuilder = new StringBuilder();
            strHTMLBuilder.Append("<table style='border: 1px solid #ccc;width: 100%;'>");
            //strHTMLBuilder.Append("<thead><tr style='background-color: #f2f2f2;background-color: #3498db;color: white;font-size: 12pt;font-weight: bold; '><th>Reviewer Name</th><th>Designation </th><th>Department</th><th>Status</th><th >Updated Date</th><th>Remarks</th></tr></thead>");
            strHTMLBuilder.Append("<thead>");
            strHTMLBuilder.Append("<tr style='background-color: #3498db;color: white;font-size: 10pt;font-weight: bold; border: 1px solid #ccc;' >");
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
                strHTMLBuilder.Append("<tr style='border: 1px solid #ccc; font-size: 12pt;'>");
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


        public  string getEditOption(string pageVal, string pageval1, string pageval2)
        {
            DataSet ds;
            string str = "";

            PWA_Service.PWA_ServiceClient obj1 = new PWA_Service.PWA_ServiceClient();
            ds = obj1.PwaSelectData("PWAAPP", pageVal, pageval1, pageval2, "");
            try
            {
                if (ds.Tables[0].Rows.Count > 0)
                {
                    str = ds.Tables[0].Rows[0][0].ToString();
                }
            }
            catch (Exception e)
            {
                return e.Message;
            }
            return str;
        }

        //[WebMethod(EnableSession = true)]

        //public static string Smsmailsend(string maiid, string val1, string trackid, string empname, string desc, string priority, string DEPNAME, string DLVERTD, string DLVRDNAME, string retunmsg, string timestamp, string initiat)
        //{
        //    // ---------------------------------------------MAIL1 PART----------------------------------------------
        //    string msg = retunmsg;
        //    SmtpClient server = new SmtpClient("smtp.office365.com");
        //    server.Port = 587;
        //    server.EnableSsl = true;
        //    server.UseDefaultCredentials = false;
        //    //server.Credentials = new System.Net.NetworkCredential("55323@manappuram.com", "Winter123*", "smtp.office365.com"); 
        //    server.Credentials = new System.Net.NetworkCredential("filetracker@manappuram.com", "QWpk@789", "smtp.office365.com");
        //    server.Timeout = 5000;
        //    server.TargetName = "STARTTLS/smtp.office365.com";
        //    server.DeliveryMethod = SmtpDeliveryMethod.Network;
        //    MailMessage mail = new MailMessage();
        //    mail.From = new MailAddress("filetracker@manappuram.com");

        //    mail.To.Add(maiid);

        //    //  ----------------------------------------------mail body creation----------------------------------------------
        //    if (retunmsg == "Recommended Successfully")
        //    {
        //        msg = "Recommended";
        //    }
        //    else if (retunmsg == "Your Action has been processed")
        //    {
        //        msg = "Not Recommended";
        //    }
        //    else if (retunmsg == "File Approved Successfully")
        //    {
        //        msg = "Approved";
        //    }
        //    else if (retunmsg == "File Rejected")
        //    {
        //        msg = "Rejected";
        //    }

        //    if (val1 == "1")
        //    {
        //        mail.Subject = "File Tracker ID " + trackid + " Created";
        //        mail.Body = "<p style='font-family: Arial;font-size:14px;color:#565656;'>Dear " + empname + ",<br/><br/>A file has been <b>created</b> in File Tracking Application with the following details:<br/><br/>File Tracking ID: <b>" + trackid + "</b><br/>Description: " + desc + "<br/>Status: <b>Created</b><br/>Initiating Department: " + initiat + " <br/>Priority:" + priority + "<br/>Timestamp:" + timestamp + "<br/><br/>Thanks & Regards,<br/>File Tracking Team<br/>Please do not reply to this email ID as this is an automatically generated email and reply to this ID is not being monitored</p>";
        //    }
        //    else if (val1 == "2")
        //    {
        //        mail.Subject = "File Tracker ID " + trackid + " Received";
        //        mail.Body = "<p style='font-family: Arial;font-size:14px;color:#565656;'>Dear " + empname + ",<br/><br/>File Tracking ID: <b>" + trackid + "</b> has been <b>Received</b> in :" + DEPNAME + "<br/><br/>Subject: " + desc + "<br/>Status: <b>Received</b><br/>Initiating Department: " + initiat + " <br/>Priority:" + priority + "<br/>Timestamp:" + timestamp + "<br/><br/>Thanks & Regards,<br/>File Tracking Team<br/>Please do not reply to this email ID as this is an automatically generated email and reply to this ID is not being monitored</p>";
        //    }

        //    else if (val1 == "3")
        //    {

        //        mail.Subject = "File Tracker ID " + trackid + " Updated";
        //        mail.Body = "<p style='font-family: Arial;font-size:14px;color:#565656;'>Dear " + empname + ",<br/><br/>An action has been taken by  " + DEPNAME + " on the below file:<br/><br/>File Tracking ID: <b>" + trackid + "</b><br/>Subject: " + desc + "<br/>Status: <b>" + msg + "</b> <br/>Initiating Department: " + initiat + " <br/>Priority:" + priority + "<br/>Timestamp:" + timestamp + "<br/><br/>Thanks & Regards,<br/>File Tracking Team<br/>Please do not reply to this email ID as this is an automatically generated email and reply to this ID is not being monitored</p>";
        //    }
        //    else if (val1 == "4")
        //    {
        //        mail.Subject = "File Tracker ID " + trackid + " Delivered";
        //        mail.Body = "<p style='font-family: Arial;font-size:14px;color:#565656;'>Dear " + empname + ",<br/><br/>File Tracking ID: <b>" + trackid + "</b> has been <b>delivered</b> from  " + DEPNAME + " department and is handed over to:" + DLVRDNAME + "-" + DLVERTD + "<br/><br/>Subject: " + desc + "<br/>Status:<b>Delivered</b><br/>Initiating Department: " + initiat + " <br/>Priority:" + priority + "<br/>Timestamp:" + timestamp + "<br/><br/>Thanks & Regards,<br/>File Tracking Team<br/>Please do not reply to this email ID as this is an automatically generated email and reply to this ID is not being monitored</p>";
        //    }
        //    else if (val1 == "5")
        //    {
        //        mail.Subject = "File Tracker ID " + trackid + " Final Review";
        //        mail.Body = "<p style='font-family: Arial;font-size:14px;color:#565656;'>Dear " + empname + ",<br/><br/>File Tracking ID: <b>" + trackid + "</b> has been <b>Approved</b> by" + DEPNAME + "<br/><br/>File Tracking ID: <b>" + trackid + "</b><br/>Subject: " + desc + "<br/>Status:<b>" + msg + "</b><br/>Initiating Department: " + initiat + " <br/>Priority:" + priority + "<br/>Timestamp:" + timestamp + "<br/><br/>Thanks & Regards,<br/>File Tracking Team<br/>Please do not reply to this email ID as this is an automatically generated email and reply to this ID is not being monitored</p>";
        //    }
        //    else if (val1 == "6")
        //    {
        //        mail.Subject = "File Tracker ID " + trackid + " Final Review";
        //        mail.Body = "<p style='font-family: Arial;font-size:14px;color:#565656; '>Dear " + empname + ",<br/><br/>File Tracking ID: <b>" + trackid + "</b> has been <b>Rejected</b> by " + DEPNAME + "<br/><br/>File Tracking ID: <b>" + trackid + "</b><br/>Subject: " + desc + "<br/>Status:<b>" + msg + "</b><br/>Initiating Department: " + initiat + " <br/>Priority:" + priority + "<br/>Timestamp:" + timestamp + "<br/><br/>Thanks & Regards,<br/>File Tracking Team<br/>Please do not reply to this email ID as this is an automatically generated email and reply to this ID is not being monitored</p>";
        //    }
        //    else if (val1 == "9")//LEAVE - FORWARD TO NEXT LEVEL
        //    {
        //        string[] smsdataleavm = DEPNAME.Split('¥');

        //        mail.Subject = "File Tracker ID " + trackid + " Processed";
        //        mail.Body = "<p style='font-family: Arial;font-size:14px;color:#565656;'>Dear " + empname + ",<br/><br/>Below file has been <b>proceeded</b> further as " + smsdataleavm[0] + " is on Leave<br/><br/>File Tracking ID: <b>" + trackid + "</b><br/>Subject: " + desc + "<br/>Status:<b>" + msg + "</b><br/>Initiating Department: " + initiat + " <br/>Priority:" + priority + "<br/>Timestamp:" + timestamp + "<br/><br/>Thanks & Regards,<br/>File Tracking Team<br/>Please do not reply to this email ID as this is an automatically generated email and reply to this ID is not being monitored</p>";
        //    }
        //    else if (val1 == "10")//TOUR - FORWARD TO NEXT LEVEL
        //    {
        //        string[] smsdatatour = DEPNAME.Split('¥');
        //        mail.Subject = "File Tracker ID " + trackid + " Processed";
        //        mail.Body = "<p style='font-family: Arial;font-size:14px;color:#565656;'>Dear " + empname + ",<br/><br/>Below file has been <b>proceeded</b> further as " + smsdatatour[0] + " is on Tour<br/><br/>File Tracking ID: <b>" + trackid + "</b><br/>Subject: " + desc + "<br/>Status:<b>" + msg + "</b><br/>Initiating Department: " + initiat + " <br/>Priority:" + priority + "<br/>Timestamp:" + timestamp + "<br/><br/>Thanks & Regards,<br/>File Tracking Team<br/>Please do not reply to this email ID as this is an automatically generated email and reply to this ID is not being monitored</p>";
        //    }
        //    else if (val1 == "11")//DISCUSSION REQUIRED
        //    {
        //        string[] smsdatatour = DEPNAME.Split('¥');
        //        mail.Subject = "File Tracker ID " + trackid + " Processed (Discussion Required)";
        //        mail.Body = "<p style='font-family: Arial;font-size:14px;color:#565656;'>Dear " + empname + ",<br/><br/>has been  <b>Processed</b> from " + smsdatatour[1] + " but needs further discussion <br/><br/>File Tracking ID: <b>" + trackid + "</b><br/>Subject: " + desc + "<br/>Status:<b>" + msg + "</b><br/>Initiating Department: " + initiat + " <br/>Priority:" + priority + "<br/>Timestamp:" + timestamp + "<br/><br/>Thanks & Regards,<br/>File Tracking Team<br/>Please do not reply to this email ID as this is an automatically generated email and reply to this ID is not being monitored</p>";
        //    }
        //    //    -----------------------------------------------EndEventHandler ----------------------------------------------


        //    mail.IsBodyHtml = true;
        //    server.Send(mail);
        //    return "Mail Send";



        //}

    }
}