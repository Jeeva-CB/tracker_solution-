using System;
using System.Data;
using System.Drawing.Imaging;
using System.IO;
using System.Text;
using System.Web.Services;

namespace ITTracker
{
    public partial class CRBApproval : System.Web.UI.Page
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
                this.hdBranchId.Value = bid;
                this.hdFirmId.Value = fimid;
                this.hdnSystemIP.Value = ipaddres;
                this.hdSesssion.Value = sessn;


                //hdPag.Value = Request.QueryString["pag"];
            }
        }
             [WebMethod(EnableSession = true)]
        public static string GetData( string val)
        {
            string str = "";
            int i = 0;
            DataSet ds = new DataSet();
            ITService.ITServiceClient obj1 = new ITService.ITServiceClient();
            ds = obj1.TrackerSelect("CRBRECOMMENT", val,"", "", "");
            if (ds.Tables[0].Rows.Count > 0)
            {
                foreach (DataRow dr in ds.Tables[0].Rows)
                {
                    str = str + ds.Tables[0].Rows[i][0].ToString() + "^" + ds.Tables[0].Rows[i][1].ToString() + "^" + ds.Tables[0].Rows[i][2].ToString() + "^" + ds.Tables[0].Rows[i][3].ToString() + "^" + ds.Tables[0].Rows[i][4].ToString() + "^" + ds.Tables[0].Rows[i][5].ToString()+ "^" + ds.Tables[0].Rows[i][6].ToString() + "^" + ds.Tables[0].Rows[i][7].ToString() + "^" + ds.Tables[0].Rows[i][8].ToString() + "§";
                    i++;
                }
                return str;
            }
            else
            {
                return "";
            }
        }
        
        [WebMethod(EnableSession = true)]
        public static string GetData1(string val)
        {
            string str = "";
            int i = 0;
            DataSet ds = new DataSet();
            ITService.ITServiceClient obj1 = new ITService.ITServiceClient();
            ds = obj1.TrackerSelect("CRBRECOMMENT", val, "", "", "");
            if (ds.Tables[0].Rows.Count > 0)
            {
                foreach (DataRow dr in ds.Tables[0].Rows)
                {
                    str = str + ds.Tables[0].Rows[i][0].ToString() + "^" + ds.Tables[0].Rows[i][1].ToString() + "^" + ds.Tables[0].Rows[i][2].ToString() + "^" + ds.Tables[0].Rows[i][3].ToString() + "^" + ds.Tables[0].Rows[i][4].ToString() + "^" + ds.Tables[0].Rows[i][5].ToString() + "^" + ds.Tables[0].Rows[i][6].ToString() + "^" + ds.Tables[0].Rows[i][7].ToString() + "^" + ds.Tables[0].Rows[i][8].ToString()+ "§";
                    i++;
                }
                return str;
            }
            else
            {
                return "";
            }
        }
        
        [WebMethod(EnableSession = true)]
        public static string ctoselection(string typ)
        {
            string result = "";
         
            DataSet ds = new DataSet();
            ITService.ITServiceClient obj1 = new ITService.ITServiceClient();
            ds = obj1.TrackerSelect(typ, "", "", "", "");
            if (ds.Tables[0].Rows.Count > 0)
            {
                result = ds.Tables[0].Rows[0]["order_by"].ToString();
                return result;
            }
            else
            {
                return "";
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
        public static string CRBRecommendation(string pageVal, string pageval1, string pageval2, string pageval3)
        {
            DataSet ds, ds1, ds2, ds3;
            string str = "", newcontent = "";
            ITService.ITServiceClient obj1 = new ITService.ITServiceClient();
            ds = obj1.TrackerSelect(pageVal, pageval1, pageval2, pageval3, "");

            //string[] notes = pageval2.Split('µ');
            //string noteid = notes[0].ToString();

            try
            {
                if (ds.Tables[0].Rows.Count > 0)
                {
                    str = ds.Tables[0].Rows[0][0].ToString();

                    try
                    {

                        DataTable dt1, dt2, dt3;
                        dt1 = obj1.TrackerSelect("CRBRecommendEmailRequest", str, "", "", "").Tables[0];
                        string reqmailid = dt1.Rows[0][0].ToString();
                        

                         dt2 = obj1.TrackerSelect("CRBReccomendEmailNext", str, "", "", "").Tables[0];
                        string NextReviewrsId = dt2.Rows[0][0].ToString();
                        string NextReviewrsName = dt2.Rows[0][1].ToString();

                        dt3 = obj1.TrackerSelect("CRBRECOMRDLCheader", str, "", "", "").Tables[0];
                        string tblHead = ExportDatatableToHtmlHeading(dt3);
                        string[] NextReviewrs = NextReviewrsId.Split(',');
                        string[] reviwnames = NextReviewrsName.Split(',');
                        int j = 0;

                        if (NextReviewrs.Length > 0)
                        {
                            foreach (string i in NextReviewrs)
                            {

                                string revwmailid = i.ToString() + "@manappuram.com";
                                string revwname = reviwnames[j].ToString();
                                string imageUrlLog = GetImageUrl("files/img/manappuram_logo.png");
                                string imageContentLog = "<img src='" + imageUrlLog + "' alt='Alternate Text' />";

                                string imageUrlPaperless = GetImageUrl("files/img/paperlessBanner.png");
                                string imageContentPaperless = "<img src='" + imageUrlPaperless + "' alt='Alternate Text' />";

                                string bdy = "<p style='font-family: Calibri,Arial,Helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0);'>Dear " + revwname + ",<br/><br/> CRB recommendation list for  today.<br/>Kindly process the same at the earliest. <br/> <br/><br/><u><b>CRF Details</b></u><br/><br/> " + tblHead + " <br/><br/><br/><br/>  Thanks & Regards,<br/>IT Portal<br/><span style = 'font-size:11.0pt; font-family:&quot;Calibri&quot;,sans-serif; color:gray' lang='EN-IN'>Please do not reply to this email ID as this is an automatically generated email and reply to this ID is not being monitored</span></p>" + imageContentLog + "   " + imageContentPaperless + "<p><span style = 'color:rgb(105,105,105); font-size:7pt; font-family:arial,sans-serif; line-height:normal; background-color:rgba(0,0,0,0)' >Please be aware that this email/attachment contains MAFIL confidential/sensitive data. You are requested to follow MAFIL Information Security and data sharing policies in case the data is shared further. Feel free to contact AGM Information Security when youare in doubt.</span></p>";
                                string subj = "CRB -: " + str + " - CRB Recommendation";
                                string dtls = "10µ" + revwmailid + "µ" + reqmailid + "µµ" + subj + "µ" + str + "µAMS";

                                ds2 = obj1.TrackerSelect("InsertEmail", "InsertEmail", dtls, "", bdy);
                                j = j + 1;
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
        [WebMethod(EnableSession = true)]
        public static string CRBRequestApproval(string pageVal, string pageval1, string pageval2, string pageval3)
        {
            DataSet ds, ds1, ds2, ds3;
            string str = "", newcontent = "";
            ITService.ITServiceClient obj1 = new ITService.ITServiceClient();
            ds = obj1.TrackerSelect(pageVal, pageval1, pageval2, pageval3, "");

            //string[] notes = pageval2.Split('µ');
            //string noteid = notes[0].ToString();

            try
            {
                if (ds.Tables[0].Rows.Count > 0)
                {
                    str = ds.Tables[0].Rows[0][0].ToString();

                    try
                    {

                        DataTable dt1, dt2, dt3;
                        dt1 = obj1.TrackerSelect("CRBAprrovalEmailRequest", str, "", "", "").Tables[0];
                        string reqmailid = dt1.Rows[0][0].ToString();
                        reqmailid = reqmailid + ";ppadman4@in.ibm.com;smithsub@in.ibm.com";

                        dt2 = obj1.TrackerSelect("CRBApproveEmailNext", str, "", "", "").Tables[0];
                        string NextReviewrsId = dt2.Rows[0][0].ToString();
                        string NextReviewrsName = dt2.Rows[0][1].ToString();

                        dt3 = obj1.TrackerSelect("CRBApproveRDLCheader", str, "", "", "").Tables[0];
                        string tblHead = ExportDatatableToHtmlHeading(dt3);
                        string[] NextReviewrs = NextReviewrsId.Split(',');
                        string[] reviwnames = NextReviewrsName.Split(',');
                        int j = 0;

                        if (NextReviewrs.Length > 0)
                        {
                            foreach (string i in NextReviewrs)
                            {

                                string revwmailid = i.ToString() + "@manappuram.com";
                                string revwname = reviwnames[j].ToString();
                                string imageUrlLog = GetImageUrl("files/img/manappuram_logo.png");
                                string imageContentLog = "<img src='" + imageUrlLog + "' alt='Alternate Text' />";

                                string imageUrlPaperless = GetImageUrl("files/img/paperlessBanner.png");
                                string imageContentPaperless = "<img src='" + imageUrlPaperless + "' alt='Alternate Text' />";

                                string bdy = "<p style='font-family: Calibri,Arial,Helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0);'>Dear " + revwname + ",<br/><br/> CRB approved list for  today.<br/>Kindly process the same at the earliest. <br/> <br/><br/><u><b>CRF Details</b></u><br/><br/> " + tblHead + " <br/><br/><br/><br/>  Thanks & Regards,<br/>IT Portal<br/><span style = 'font-size:11.0pt; font-family:&quot;Calibri&quot;,sans-serif; color:gray' lang='EN-IN'>Please do not reply to this email ID as this is an automatically generated email and reply to this ID is not being monitored</span></p>" + imageContentLog + "   " + imageContentPaperless + "<p><span style = 'color:rgb(105,105,105); font-size:7pt; font-family:arial,sans-serif; line-height:normal; background-color:rgba(0,0,0,0)' >Please be aware that this email/attachment contains MAFIL confidential/sensitive data. You are requested to follow MAFIL Information Security and data sharing policies in case the data is shared further. Feel free to contact AGM Information Security when youare in doubt.</span></p>";
                                string subj = "CRB -: " + str + " - CRB Approved";
                                string dtls = "10µ" + revwmailid + "µ" + reqmailid + "µµ" + subj + "µ" + str + "µAMS";

                                ds2 = obj1.TrackerSelect("InsertEmail", "InsertEmail", dtls, "", bdy);
                                j = j + 1;
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
