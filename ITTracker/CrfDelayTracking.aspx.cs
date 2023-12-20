﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Drawing.Imaging;
using System.IO;
using System.Text;
using System.Web;
using System.Web.Services;

namespace ITTracker
{
    public partial class CrfDelayTracking : System.Web.UI.Page
    {
        public void Page_Init(object o, EventArgs e)
        {

            Response.Cache.SetCacheability(HttpCacheability.NoCache);

            Response.Cache.SetExpires(DateTime.UtcNow.AddHours(-1));

            Response.Cache.SetNoStore();
        }
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
                this.hdBranchId.Value = bid;
                this.hdFirmId.Value = fimid;
                this.hdSesssion.Value = sessn;


                //hdPag.Value = Request.QueryString["pag"];
            }
        }
        public class getDropDownData
        {
            public string id { get; set; }
            public string name { get; set; }
        }

        [WebMethod(EnableSession = true)]
        public static List<getDropDownData> getFillData(string pageVal, string pageval1, string pageval2)
        {
            DataSet ds;
            List<getDropDownData> getData = new List<getDropDownData>();
            ITService.ITServiceClient obj1 = new ITService.ITServiceClient();
            ds = obj1.TrackerSelect(pageVal, pageval1, pageval2, "", "");
            //PWA_Service.PWA_ServiceClient obj1 = new PWA_Service.PWA_ServiceClient();
            //ds = obj1.PwaSelectData("PWAAPP", pageVal, pageval1, "", "");
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
        public static string getAccessibility(string pageval, string pageval1)
        {
            string result = "";


            try
            {
                DataTable dt = new DataTable();
                ITTracker.ITService.ITServiceClient obj = new ITTracker.ITService.ITServiceClient();
                dt = obj.TrackerSelect(pageval, pageval1, "", "", "").Tables[0];
                if (dt.Rows.Count > 0)
                {
                    result = dt.Rows[0][0].ToString();
                }
                else
                {
                    result = "";
                }

            }
            catch (Exception e)
            {

            }
            return result;
        }
        [WebMethod(EnableSession = true)]
        public static string getRequestNote(string pageVal, string pageval1, string pageval2)
        {
            DataSet ds;
            string str = "";
            ITService.ITServiceClient obj1 = new ITService.ITServiceClient();
            ds = obj1.TrackerSelect(pageVal, pageval1, pageval2, "", "");

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
        public static string GetNewNoteID(string pageVal, string pageval1, string pageval2)
        {

            DataSet ds;
            DataTable dt = new DataTable();

            ITService.ITServiceClient obj1 = new ITService.ITServiceClient();
            ds = obj1.TrackerSelect(pageVal, pageval1, pageval2, "", "");
            dt = ds.Tables[0];
            if (dt.Rows.Count > 0)
            {
                return dt.Rows[0][0].ToString();
            }
            else

            { return "NA"; }

        }
        [WebMethod(EnableSession = true)]
        public static string getFileData(string pageVal, string pageval1, string pageval2)
        {
            try
            {

                DataSet ds;
                string str = "";
                byte[] fileByt;
                ITService.ITServiceClient obj1 = new ITService.ITServiceClient();
                ds = obj1.TrackerSelect(pageVal, pageval1, "", "", "");
                //PWA_Service.PWA_ServiceClient obj1 = new PWA_Service.PWA_ServiceClient();
                //ds = obj1.PwaSelectData("PWAAPP", pageVal, pageval1, pageval2, "");
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
                                    CRFHODApprove d = new CRFHODApprove();
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
            catch (Exception ex)
            {
                return ex.Message;
            }
        }

        [WebMethod(EnableSession = true)]
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
        public static string fillTable(string pageVal, string pageval1)
        {
            DataSet ds;
            string str = "";
            ITService.ITServiceClient obj1 = new ITService.ITServiceClient();
            ds = obj1.TrackerSelect(pageVal, pageval1, "", "", "");
            if (ds.Tables[0].Rows.Count > 0)
            {
                foreach (DataRow dr in ds.Tables[0].Rows)
                {
                    str = str + dr[0].ToString() + "^" + dr[1].ToString() + "^" + dr[2].ToString() + "^" + dr[3].ToString() + "§";
                }

                return str;
            }
            else
            {
                return "";
            }
        }
        // for fill the  business hour text box
        [WebMethod(EnableSession = true)]
        public static string getBugCount(string pageVal, string pageval1, string pageval2)
        {
            DataSet ds;
            string str = "";
            ITService.ITServiceClient obj1 = new ITService.ITServiceClient();
            ds = obj1.TrackerSelect(pageVal, pageVal, pageval1, "", "");
            if (ds != null)
            {
                if (ds.Tables[0].Rows.Count > 0)
                {
                    foreach (DataRow dr in ds.Tables[0].Rows)
                    {
                        str = str + dr[0].ToString();
                    }

                    return str;
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
        [WebMethod(EnableSession = true)]
        public static string CheckEmpAccess(string pageVal, string pageval1, string pageval2)

        {

            DataSet ds;
            DataTable dt = new DataTable();

            ITService.ITServiceClient obj1 = new ITService.ITServiceClient();
            ds = obj1.TrackerSelect(pageVal, pageVal, pageval1, "", "");
            dt = ds.Tables[0];
            if (dt.Rows.Count > 0)
            {
                return dt.Rows[0][0].ToString();
            }
            else

            { return "NA"; }

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
            ITTracker.ITService.ITServiceClient obj1 = new ITTracker.ITService.ITServiceClient();
            ds = obj1.TrackerSelect(pageVal, pageval1, pageval2, "", "");
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
        public static string getBussinessHours(string pageVal, string pageval1, string pageval2)
        {
            DataSet ds;
            string str = "";
            ITService.ITServiceClient obj1 = new ITService.ITServiceClient();
            ds = obj1.TrackerSelect(pageVal, pageval1, pageval2, "", "");
            if (ds.Tables[0].Rows.Count > 0)
            {
                foreach (DataRow dr in ds.Tables[0].Rows)
                {
                    str = str + dr[0].ToString();
                }

                return str;
            }
            else
            {
                return "";
            }
        }
        // for checking the date difference and assigned time for TA-Testing
        [WebMethod(EnableSession = true)]
        public static string TimeComparing(string pageVal, string pageval1, string pageval2)
        {
            DataSet ds;
            string str = "";
            ITService.ITServiceClient obj1 = new ITService.ITServiceClient();
            ds = obj1.TrackerSelect(pageVal, pageval1, pageval2, "", "");
            if (ds.Tables[0].Rows.Count > 0)
            {
                foreach (DataRow dr in ds.Tables[0].Rows)
                {
                    str = str + dr[0].ToString();
                }

                return str;
            }
            else
            {
                return "";
            }
        }


        [WebMethod(EnableSession = true)]
        public static string UploadingFile(string ImageData, string InputData)
        {
            String InputDataDecrypted = ClientsideEncryption.AESEncrytDecry.DecryptStringAES(InputData);
            //List<string> extentions = new List<string>();
            //extentions.Add("913020010321699");

            List<string> extentions = new List<string>();

            extentions.InsertRange(extentions.Count, new string[] { "pdf", "jpg", "gif", "jpeg", "bmp", "tif", "tiff", "png", "xps", "doc", "docx", "fax", "wmp", "ico", "txt", "rtf", "xls", "xlsx", "ppt", "pptx", "odt", "ods" });

            string InputDataExt = InputDataDecrypted.Split('µ')[2];

            if (extentions.Contains(InputDataExt))
            {
                string result = "";
                string InputString = ImageData.Split(',')[1];
                Byte[] imgByte = Convert.FromBase64String(InputString);
                ITService.ITServiceClient obj1 = new ITService.ITServiceClient();

                result = obj1.TrackerDocumentUpload("2", InputDataDecrypted, imgByte);
                return result;
            }
            else
            {
                return "666";
            }

        }

        [WebMethod(EnableSession = true)]
        public static string ExportDatatableToHtmlHeading(DataTable dt)
        {
            StringBuilder strHTMLBuilder = new StringBuilder();
            strHTMLBuilder.Append("<table style='border: 1px solid #ccc;width: 100%;'>");
            //strHTMLBuilder.Append("<thead><tr style='background-color: #f2f2f2;background-color: #3498db;color: white;font-size: 12pt;font-weight: bold; '><th>Reviewer Name</th><th>Designation </th><th>Department</th><th>Status</th><th >Updated Date</th><th>Remarks</th></tr></thead>");
            strHTMLBuilder.Append("<thead>");
            strHTMLBuilder.Append("<tr style='background-color: #d98fe3;color: black;font-size: 10pt;font-weight: bold; border: 1px solid #ccc;' >");
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

        [WebMethod(EnableSession = true)]
        public static string ActionConfirm(string pageVal, string pageval1, string pageval2, string pageval3)
        {
            DataSet ds, ds1, ds2, ds3;
            string str = "", newcontent = "", cc = "", ccc = "";
            string NextReviewrsId = "";
            string NextReviewrsName = "";
            ITTracker.ITService.ITServiceClient obj1 = new ITTracker.ITService.ITServiceClient();
            ds = obj1.TrackerSelect(pageVal, pageval3, pageval1, pageval2, "");

            string[] Data = pageval2.Split('µ');
            string noteid = Data[0].ToString();
            string ReqId = Data[1].ToString();
            string EmpStatus = Data[3].ToString();
            string MdOffice = "md-tech@manappuram.com;";
            string bdy = "";
            string subj = "";
            string dtls = "";

            try
            {
                if (ds != null)
                {
                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        str = ds.Tables[0].Rows[0][0].ToString();
                        if (pageval3 == "Escalate")
                        {
                            try
                            {
                                DataTable dt1, dt2, dt3, dt4;
                                dt1 = obj1.TrackerSelect("GetAMSHead", ReqId, "", "", "").Tables[0];
                                string AMSHead = dt1.Rows[0][0].ToString() + "@manappuram.com";
                                string AMSHeadName = dt1.Rows[0][1].ToString();
                                dt4 = obj1.TrackerSelect("GetCTO", ReqId, "", "", "").Tables[0];
                                string CTO = dt1.Rows[0][0].ToString() + "@manappuram.com";
                                string CTOName = dt1.Rows[0][1].ToString();
                                dt2 = obj1.TrackerSelect("GetDevAgainstReqId", ReqId, "", "", "").Tables[0];
                                if (dt2.Rows.Count > 1)
                                {
                                    foreach (DataRow dr in dt2.Rows)
                                    {
                                        if (dr["ASSIGN_TO"].ToString() != "")
                                        {
                                            NextReviewrsId = NextReviewrsId + Convert.ToString(dr["ASSIGN_TO"]) + "@manappuram.com;";
                                            NextReviewrsName = NextReviewrsName + Convert.ToString(dr["EMP_NAME"]) + "@manappuram.com;";
                                        }

                                    }
                                }
                                else
                                {
                                    NextReviewrsId = dt2.Rows[0][0].ToString() + "@manappuram.com;";
                                    NextReviewrsName = dt2.Rows[0][1].ToString() + "@manappuram.com;";
                                }

                                dt3 = obj1.TrackerSelect("GetApprovedRDLCheader", noteid, "", "", "").Tables[0];
                                string tblHead = ExportDatatableToHtmlHeading(dt3);
                                string[] NextReviewrs = NextReviewrsId.Split(',');
                                string[] reviwnames = NextReviewrsName.Split(',');

                                var usermailid = pageval1 + "@manappuram.com;";
                                var cccc = NextReviewrsId + pageval1 + MdOffice;                             

                                string imageUrlLog = GetImageUrl("files/img/manappuram_logo.png");
                                string imageContentLog = "<img src='" + imageUrlLog + "' alt='Alternate Text' />";

                                string imageUrlPaperless = GetImageUrl("files/img/paperlessBanner1.png");
                                string imageContentPaperless = "<img src='" + imageUrlPaperless + "' alt='Alternate Text' />";


                                if (EmpStatus == "TECHLEAD")
                                {
                                    bdy = "<p style='font-family: Calibri,Arial,Helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0);'>Dear " + AMSHeadName + ",<br/><br/> A CRF escalated from TeachLead for your Action. <br/>Kindly process the same at the earliest. <br/> <br/><br/><u><b>CRF Details</b></u><br/><br/> " + tblHead + " <br/><br/><br/><br/>  Thanks & Regards,<br/>IT Portal<br/><span style = 'font-size:11.0pt; font-family:&quot;Calibri&quot;,sans-serif; color:gray' lang='EN-IN'>Please do not reply to this email ID as this is an automatically generated email and reply to this ID is not being monitored</span></p>" + imageContentLog + "   " + imageContentPaperless + "<p><span style = 'color:rgb(105,105,105); font-size:7pt; font-family:arial,sans-serif; line-height:normal; background-color:rgba(0,0,0,0)' >Please be aware that this email/attachment contains MAFIL confidential/sensitive data. You are requested to follow MAFIL Information Security and data sharing policies in case the data is shared further. Feel free to contact AGM Information Security when youare in doubt.</span></p>";
                                    subj = "CRF -: " + noteid + " - Delay Action Needed";
                                    dtls = "10µ" + AMSHead + "µ" + cccc + "µµ" + subj + "µ" + noteid + "µAMS";
                                    ds2 = obj1.TrackerSelect("InsertEmail", "InsertEmail", dtls, "", bdy);
                                }
                                else if (EmpStatus == "AMSHEAD")
                                {
                                    bdy = "<p style='font-family: Calibri,Arial,Helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0);'>Dear " + CTOName + ",<br/><br/> A CRF escalated from AMS Head for your Action. <br/>Kindly process the same at the earliest. <br/> <br/><br/><u><b>CRF Details</b></u><br/><br/> " + tblHead + " <br/><br/><br/><br/>  Thanks & Regards,<br/>IT Portal<br/><span style = 'font-size:11.0pt; font-family:&quot;Calibri&quot;,sans-serif; color:gray' lang='EN-IN'>Please do not reply to this email ID as this is an automatically generated email and reply to this ID is not being monitored</span></p>" + imageContentLog + "   " + imageContentPaperless + "<p><span style = 'color:rgb(105,105,105); font-size:7pt; font-family:arial,sans-serif; line-height:normal; background-color:rgba(0,0,0,0)' >Please be aware that this email/attachment contains MAFIL confidential/sensitive data. You are requested to follow MAFIL Information Security and data sharing policies in case the data is shared further. Feel free to contact AGM Information Security when youare in doubt.</span></p>";
                                    subj = "CRF -: " + noteid + " - Delay Action Needed";
                                    dtls = "10µ" + AMSHead + "µ" + cccc + "µµ" + subj + "µ" + noteid + "µAMS";
                                    ds2 = obj1.TrackerSelect("InsertEmail", "InsertEmail", dtls, "", bdy);
                                }

                            }
                            catch (Exception ef)
                            {
                                string msg = ef.Message;
                            }
                        }



                    }
                    else
                    {
                        str = "0";
                    }
                }
                else
                {
                    str = "0";
                }
            }
            catch (Exception e)
            {
                return e.Message;
            }
            return str;
        }
        [WebMethod(EnableSession = true)]
        public static string ConfirmEnquiry(string pageVal, string pageval1, string pageval2, string pageval3)
        {
            DataSet ds, ds1, ds2, ds3;
            string str = "", newcontent = "", cc = "", ccc = "";
            string NextReviewrsId = "";
            string NextReviewrsName = "";
            ITTracker.ITService.ITServiceClient obj1 = new ITTracker.ITService.ITServiceClient();
            ds = obj1.TrackerSelect(pageVal, pageval3, pageval1, pageval2, "");

            string[] Data = pageval1.Split('µ');
            string noteid = Data[0].ToString();
            string ReqId = Data[1].ToString();
            string Message = Data[2].ToString();
            string MdOffice = "md-tech@manappuram.com;";
            string FromUser = Data[4].ToString() + "@manappuram.com;";
            string bdy = "";
            string subj = "";
            string dtls = "";

            try
            {
                if (ds != null)
                {
                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        str = ds.Tables[0].Rows[0][0].ToString();

                        try
                        {
                            DataTable dt1, dt2, dt3, dt4;

                            dt3 = obj1.TrackerSelect("GetApprovedRDLCheader", noteid, "", "", "").Tables[0];
                            string tblHead = ExportDatatableToHtmlHeading(dt3);

                            dt2 = obj1.TrackerSelect("GetEmailReviewNextEnq", ReqId, "", "", "").Tables[0];
                            NextReviewrsId = dt2.Rows[0][0].ToString();
                            NextReviewrsName = dt2.Rows[0][1].ToString();


                            var cccc = FromUser + MdOffice;                     
                
                            string imageUrlLog = GetImageUrl("files/img/manappuram_logo.png");
                            string imageContentLog = "<img src='" + imageUrlLog + "' alt='Alternate Text' />";

                            string imageUrlPaperless = GetImageUrl("files/img/paperlessBanner1.png");
                            string imageContentPaperless = "<img src='" + imageUrlPaperless + "' alt='Alternate Text' />";

                            bdy = "<p style='font-family: Calibri,Arial,Helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0);'>Dear " + NextReviewrsName + ",<br/><br/> "+ Message +" <br/>Kindly process the same at the earliest. <br/> <br/><br/><u><b>CRF Details</b></u><br/><br/> " + tblHead + " <br/><br/><br/><br/>  Thanks & Regards,<br/>IT Portal<br/><span style = 'font-size:11.0pt; font-family:&quot;Calibri&quot;,sans-serif; color:gray' lang='EN-IN'>Please do not reply to this email ID as this is an automatically generated email and reply to this ID is not being monitored</span></p>" + imageContentLog + "   " + imageContentPaperless + "<p><span style = 'color:rgb(105,105,105); font-size:7pt; font-family:arial,sans-serif; line-height:normal; background-color:rgba(0,0,0,0)' >Please be aware that this email/attachment contains MAFIL confidential/sensitive data. You are requested to follow MAFIL Information Security and data sharing policies in case the data is shared further. Feel free to contact AGM Information Security when youare in doubt.</span></p>";
                            subj = "CRF -: " + noteid + " - Respond to your Enquiry";
                            dtls = "10µ" + NextReviewrsId + "µ" + cccc + "µµ" + subj + "µ" + noteid + "µAMS";
                            ds2 = obj1.TrackerSelect("InsertEmail", "InsertEmail", dtls, "", bdy);

                        }
                        catch (Exception ef)
                        {
                            string msg = ef.Message;
                        }




                    }
                    else
                    {
                        str = "0";
                    }
                }
                else
                {
                    str = "0";
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