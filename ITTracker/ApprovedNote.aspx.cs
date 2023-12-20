using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using iTextSharp.text;
using iTextSharp.text.html.simpleparser;
using iTextSharp.text.pdf;
using iTextSharp.tool.xml;
using System.Data;
using System.Data.OleDb;
using System.Text.RegularExpressions;
namespace ITTacker
{
    public partial class ApprovedNote : System.Web.UI.Page
    {
        private static readonly Regex InsignificantHtmlWhitespace = new Regex(@"(?<=>)\s+?(?=<)");

        protected void Page_Load(object sender, EventArgs e)
        {
            //if (!this.IsPostBack)
            //{
            //    DataTable dt = new DataTable();
            //    dt.Columns.AddRange(new DataColumn[3] { new DataColumn("Id"), new DataColumn("Name"), new DataColumn("Country") });
            //    dt.Rows.Add(1, "John Hammond", "United States");
            //    dt.Rows.Add(2, "Mudassar Khan", "India");
            //    dt.Rows.Add(3, "Suzanne Mathews", "France");
            //    dt.Rows.Add(4, "Robert Schidner", "Russia");
            //    GridView1.DataSource = dt;
            //    GridView1.DataBind();
            //}
        }

        //protected void btnExport_Click(object sender, EventArgs e)
        //{
        //    //Response.ContentType = "application/pdf";
        //    //Response.AddHeader("content-disposition", "attachment;filename=TestPage.pdf");
        //    //Response.Cache.SetCacheability(HttpCacheability.NoCache);
        //    StringWriter sw = new StringWriter();
        //    HtmlTextWriter hw = new HtmlTextWriter(sw);
        //    //this.Page.RenderControl(hw);
        //    //StringReader sr = new StringReader(sw.ToString());
        //    //Document pdfDoc = new Document(PageSize.A4, 10f, 10f, 100f, 0f);
        //    //HTMLWorker htmlparser = new HTMLWorker(pdfDoc);
        //    //PdfWriter.GetInstance(pdfDoc, Response.OutputStream);
        //    //pdfDoc.Open();
        //    //htmlparser.Parse(sr);
        //    //pdfDoc.Close();
        //    //Response.Write(pdfDoc);
        //    //Response.End();
        //    this.Page.RenderControl(hw);
        //    // GridView1.RenderControl(hw);
        //    StringReader sr = new StringReader(sw.ToString());
        //    Document pdfDoc = new Document(PageSize.A4, 10f, 10f, 10f, 0f);
        //    PdfWriter writer = PdfWriter.GetInstance(pdfDoc, Response.OutputStream);
        //    pdfDoc.Open();
        //    XMLWorkerHelper.GetInstance().ParseXHtml(writer, pdfDoc, sr);
        //    pdfDoc.Close();
        //    Response.ContentType = "application/pdf";
        //    Response.AddHeader("content-disposition", "attachment;filename=GridViewExport.pdf");
        //    Response.Cache.SetCacheability(HttpCacheability.NoCache);
        //    Response.Write(pdfDoc);
        //    Response.End();
        //}
        //        protected void btnExport_Click(object sender, EventArgs e)
        //        {
        //             string htmlstr = "<html><body><h1>My First Heading</h1><p>My first paragraph.</p><div><table border=\"1\"><tr><td>1st</td><td>2nd</td></tr><tr><td>3rd</td><td>4th</td></tr></table></div></body></html>";
        //            //string htmlstr = "<table border=1><tr><td>1st</td><td>2nd</td></tr><tr><td>3rd</td><td>4th</td></tr></table>";
        //          //  string htmlstr = "<div id=\"pnlPDF\"><div style = \"font-family:Arial\">This is a test page</div><div><table border = \"1\"><tr><td>Name</td><td>Age</td></tr><tr><td>John</td><td>11</td></tr><tr><td>Sam</td><td>13</td></tr><tr><td>Tony</td><td>12</td></tr></table></div><div><table cellspacing=\"0\" rules=\"all\" border=\"1\" id=\"GridView1\" style=\"border-collapse:collapse;\"><tr style=\"color:White;background-color:#666666;\"><th scope=\"col\">Customer Id</th><th scope=\"col\">Name</th><th scope=\"col\">Country</th></tr><tr style=\"background-color:#E4E4E4;\"><td style=\"width:100px;\">1</td><td style=\"width:120px;\">John Hammond</td><td style=\"width:120px;\">United States</td></tr><tr style=\"background-color:#E4E4E4;\"><td style=\"width:100px;\">2</td><td style=\"width:120px;\">Mudassar Khan</td><td style=\"width:120px;\">India</td></tr><tr style=\"background-color:#E4E4E4;\"><td style=\"width:100px;\">3</td><td style=\"width:120px;\">Suzanne Mathews</td><td style=\"width:120px;\">France</td></tr><tr style=\"background-color:#E4E4E4;\"><td style=\"width:100px;\">4</td><td style=\"width:120px;\">Robert Schidner</td><td style=\"width:120px;\">Russia</td></tr></table></div></div>";
        //            StringWriter sw = new StringWriter();
        //            HtmlTextWriter hw = new HtmlTextWriter(sw);
        //            pnlPDF.RenderControl(hw);
        //            string htmlstr1 = sw.ToString();
        //            htmlstr1 = RemoveInsignificantHtmlWhiteSpace(htmlstr1);
        //            //GridView1.RenderControl(hw);
        //            //We'll store our final PDF in this border = \"1\"
        //            byte[] bytes;

        ////Read our HTML as a .Net stream
        //using (var sr = new StringReader(htmlstr)) {

        //    //Standard PDF setup using a MemoryStream, nothing special
        //    using (var ms = new MemoryStream()) {
        //        using (var pdfDoc = new Document(PageSize.A4, 10f, 10f, 100f, 0f)) {
        //                        PdfWriter writer = PdfWriter.GetInstance(pdfDoc, Response.OutputStream);
        //                        //pdfDoc.Open();
        //                        //pdfDoc.Close();
        //                        //bytes = ms.ToArray();
        //                        //Bind a parser to our PDF document
        //                        //using (var htmlparser = new XMLWorkerHelper..ParseXHtml(writer, pdfDoc, sr))
        //                        //{

        //                            //Bind the writer to our document and our final stream
        //                            using (var w = PdfWriter.GetInstance(pdfDoc, ms))
        //                            {

        //                                pdfDoc.Open();

        //                            //Parse the HTML directly into the document
        //                            // htmlparser.Parse(sr);
        //                            XMLWorkerHelper.GetInstance().ParseXHtml(writer, pdfDoc, sr);

        //                            pdfDoc.Close();

        //                                //Grab the bytes from the stream before closing it
        //                                bytes = ms.ToArray();
        //                            }
        //                        //}
        //                    }
        //                }
        //}

        ////Assuming that the above worked we can now finally modify the HTTP response
        //Response.Clear();
        //Response.ContentType = "application/pdf";
        //Response.AddHeader("content-disposition", "attachment;filename=BusinessUnit.pdf");
        //Response.Cache.SetCacheability(System.Web.HttpCacheability.NoCache);
        ////Send the bytes from the PDF
        //Response.BinaryWrite(bytes);
        //Response.End();
        //        }
        //public override void VerifyRenderingInServerForm(Control control)
        //{
        //    /* Verifies that the control is rendered */
        //}
        //public static string RemoveInsignificantHtmlWhiteSpace(string html)
        //{
        //    return InsignificantHtmlWhitespace.Replace(html, String.Empty).Trim();
        //}
        //protected void btnPdf_Click(object sender, EventArgs e)
        //{
        //    Response.ContentType = "application/pdf";
        //    Response.AddHeader("content-disposition", "inline;filename=Approved.pdf");
        //    Response.Cache.SetCacheability(HttpCacheability.NoCache);
        //    StringWriter sw = new StringWriter();
        //    HtmlTextWriter hw = new HtmlTextWriter(sw);
        //    pnlPDF.RenderControl(hw);

        //    StringReader sr = new StringReader(sw.ToString());
        //    Document pdfDoc = new Document(PageSize.A4, 10f, 10f, 100f, 0f);
        //    HTMLWorker htmlparser = new HTMLWorker(pdfDoc);
        //    PdfWriter.GetInstance(pdfDoc, Response.OutputStream);
        //    pdfDoc.Open();
        //    htmlparser.Parse(sr);
        //    pdfDoc.Close();
        //    Response.Write(pdfDoc);
        //    Response.End();

        //    sr.Close();
        //    hw.Close();
        //    sw.Close();
        //}
    }
}