using Microsoft.Reporting.WebForms;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ITTracker
{
    public partial class RandDApprovedView : System.Web.UI.Page
    {
        string _paraBreak = "\r\n\r\n";
        string _link = "<a href=\"{0}\">{1}</a>";
        string _linkNoFollow = "<a href=\"{0}\" rel=\"nofollow\">{1}</a>";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                PWA_Service.PWA_ServiceClient obj1 = new PWA_Service.PWA_ServiceClient();
                //string noteid = Decrypt(HttpUtility.UrlDecode(Request.QueryString["noteid"]));
                //string noteid = "MAFIL/FY19-20/000315";
                string noteid = Request.QueryString["mnuid"];
                // string qrystr = Request.QueryString["noteid"];
                // string note[];
                //  note= qrystr.Split('-');



                int statuscnt = 0;
                DataSet datasetStatus = new DataSet();
                datasetStatus = obj1.PwaSelectData("PWAAPP", "GetRandDStatus", noteid, "", "");

                if (datasetStatus.Tables[0].Rows.Count > 0)
                {
                    statuscnt = Int32.Parse(datasetStatus.Tables[0].Rows[0][0].ToString());
                }
                if (statuscnt > 0)
                {
                    ReportViewer1.LocalReport.DataSources.Clear();
                    ReportViewer1.Visible = false;
                    ReportViewer1.LocalReport.EnableExternalImages = true;
                    ReportViewer1.LocalReport.ReportPath = Server.MapPath("RandDWorkApprove.rdlc");

                    DataSet datasetContent = new DataSet();
                    DataSet datasetApprovers = new DataSet();
                    DataSet datasetHeader = new DataSet();
                    DataSet datasetFooter = new DataSet();
                    DataSet datasetImgStat = new DataSet();
                    string str = "";
                    datasetContent = obj1.PwaSelectData("PWAAPP", "GetApprovedRandDContent", noteid, "", "");


                    if (datasetContent.Tables[0].Rows.Count > 0)
                    {
                        str = datasetContent.Tables[0].Rows[0][0].ToString();
                    }
                    string username = Session["user_name"].ToString();
                    string systemip = Session["system_ip"].ToString();
                    // string username = "John K Thomas";
                    //string systemip = "10.6.16.150";

                    datasetApprovers = obj1.PwaSelectData("PWAAPP", "getapprovedrandd", noteid, "", "");
                    datasetHeader = obj1.PwaSelectData("PWAAPP", "GetApprovedRandDheader", noteid, "", "");
                    datasetFooter = obj1.PwaSelectData("PWAAPP", "GetApprovedRandDfooter", noteid, "", "");
                    
                    DataTable dtApprovers = new DataTable();
                    DataTable dtHeader = new DataTable();
                    DataTable dtFooter = new DataTable();

                    dtApprovers = datasetApprovers.Tables[0];
                    dtHeader = datasetHeader.Tables[0];
                    dtFooter = datasetFooter.Tables[0];


                    ReportDataSource dsApprovers = new ReportDataSource("NoteApprovers", dtApprovers);
                    ReportDataSource dsHeader = new ReportDataSource("NoteApproverHeader", dtHeader);
                    ReportDataSource dsFooter = new ReportDataSource("NoteApproverFooter", dtFooter);


                    ReportViewer1.LocalReport.DataSources.Clear();
                    ReportViewer1.LocalReport.DataSources.Add(dsApprovers);
                    ReportViewer1.LocalReport.DataSources.Add(dsHeader);
                    ReportViewer1.LocalReport.DataSources.Add(dsFooter);


                    ReportParameterCollection ReportParameterCollection = new ReportParameterCollection();
                    ReportParameterCollection.Add(new ReportParameter("Note_content", str));
                    ReportParameterCollection.Add(new ReportParameter("username", username));
                    ReportParameterCollection.Add(new ReportParameter("systemip", systemip));
                    ReportParameterCollection.Add(new ReportParameter("Note_id", noteid));
                    this.ReportViewer1.LocalReport.SetParameters(ReportParameterCollection);


                    ReportViewer1.SizeToReportContent = true;
                    ReportViewer1.LocalReport.Refresh();

                    Warning[] warnings;
                    string[] streamIds;
                    string mimeType = string.Empty;
                    string encoding = string.Empty;
                    string extension = string.Empty;

                    byte[] bytes = ReportViewer1.LocalReport.Render("PDF", null, out mimeType, out encoding, out extension, out streamIds, out warnings);
                    // byte[] bytes = viewer.LocalReport.Render("Excel", null, out mimeType, out encoding, out extension, out streamIds, out warnings);
                    // Now that you have all the bytes representing the PDF report, buffer it and send it to the client.          
                    // System.Web.HttpContext.Current.Response.Cache.SetCacheability(HttpCacheability.NoCache);

                    //--------------view as pdf
                    Response.Buffer = true;
                    Response.Clear();
                    Response.ContentType = "application/pdf";
                    //Response.AddHeader("content-disposition", "attachment; filename= filename" + "." + extension);
                    Response.OutputStream.Write(bytes, 0, bytes.Length); // create the file  
                    Response.Flush(); // send it to the client to download  
                    Response.End();
                    //--------------view as pdf
                    //string result = "";
                    //string InputData= noteid + "µ50µpdfµ" + noteid +".pdf";
                    //result = obj1.PwaDocumentUpload("1", InputData, bytes);
                    //Response.Redirect("Approve2.aspx");


                }

            }

        }

        private string Decrypt(string cipherText)
        {
            string EncryptionKey = "S1SE9NL6RH7EP5OAPJ";
            cipherText = cipherText.Replace(" ", "+");
            byte[] cipherBytes = Convert.FromBase64String(cipherText);
            using (Aes encryptor = Aes.Create())
            {
                Rfc2898DeriveBytes pdb = new Rfc2898DeriveBytes(EncryptionKey, new byte[] { 0x49, 0x76, 0x61, 0x6e, 0x20, 0x4d, 0x65, 0x64, 0x76, 0x65, 0x64, 0x65, 0x76 });
                encryptor.Key = pdb.GetBytes(32);
                encryptor.IV = pdb.GetBytes(16);
                using (MemoryStream ms = new MemoryStream())
                {
                    using (CryptoStream cs = new CryptoStream(ms, encryptor.CreateDecryptor(), CryptoStreamMode.Write))
                    {
                        cs.Write(cipherBytes, 0, cipherBytes.Length);
                        cs.Close();
                    }
                    cipherText = Encoding.Unicode.GetString(ms.ToArray());
                }
            }
            return cipherText;
        }

        /// <summary>
        /// Returns a copy of this string converted to HTML markup.
        /// </summary>
        public string ToHtml(string s)
        {
            return ToHtml(s, false);
        }

        public string ToHtml(string s, bool nofollow)
        {
            StringBuilder sb = new StringBuilder();

            int pos = 0;
            while (pos < s.Length)
            {
                // Extract next paragraph
                int start = pos;
                pos = s.IndexOf(_paraBreak, start);
                if (pos < 0)
                    pos = s.Length;
                string para = s.Substring(start, pos - start).Trim();

                // Encode non-empty paragraph
                if (para.Length > 0)
                    EncodeParagraph(para, sb, nofollow);

                // Skip over paragraph break
                pos += _paraBreak.Length;
            }
            // Return result
            return sb.ToString();
        }

        private void EncodeParagraph(string s, StringBuilder sb, bool nofollow)
        {
            // Start new paragraph
            sb.AppendLine("<p>");

            // HTML encode text
            s = HttpUtility.HtmlEncode(s);

            // Convert single newlines to <br>
            s = s.Replace(Environment.NewLine, "<br />\r\n");

            // Encode any hyperlinks
            EncodeLinks(s, sb, nofollow);

            // Close paragraph
            sb.AppendLine("\r\n</p>");
        }

        private void EncodeLinks(string s, StringBuilder sb, bool nofollow)
        {
            // Parse and encode any hyperlinks
            int pos = 0;
            while (pos < s.Length)
            {
                // Look for next link
                int start = pos;
                pos = s.IndexOf("[[", pos);
                if (pos < 0)
                    pos = s.Length;
                // Copy text before link
                sb.Append(s.Substring(start, pos - start));
                if (pos < s.Length)
                {
                    string label, link;

                    start = pos + 2;
                    pos = s.IndexOf("]]", start);
                    if (pos < 0)
                        pos = s.Length;
                    label = s.Substring(start, pos - start);
                    int i = label.IndexOf("][");
                    if (i >= 0)
                    {
                        link = label.Substring(i + 2);
                        label = label.Substring(0, i);
                    }
                    else
                    {
                        link = label;
                    }
                    // Append link
                    sb.Append(String.Format(nofollow ? _linkNoFollow : _link, link, label));

                    // Skip over closing "]]"
                    pos += 2;
                }
            }
        }
    }
}