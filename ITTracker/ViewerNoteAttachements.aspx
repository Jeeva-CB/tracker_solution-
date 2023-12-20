<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ViewerNoteAttachements.aspx.cs" Inherits="ITTacker.ViewerNoteAttachements" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<!-- Tell the browser to be responsive to screen width -->
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0" />
  
<title>Note Attachement Viewer</title>
<link href="css/style.min.css" rel="stylesheet"/>
<link href="css/c3.min.css" rel="stylesheet"/>
<link href="css/jquery-jvectormap-2.0.2.css" rel="stylesheet" />
<link href="css/jquery-ui.css" rel="stylesheet" />
<link href="css/morris.css" rel="stylesheet"/>
<link rel="stylesheet" type="text/css" href="css/summernote-bs4.css"/>
<script src="js/angular.min.js"></script>
<script src ="js/jquery-latest.js"></script> 
<script type="text/javascript" src="js/jquery-1.10.2.min.js"></script>
<script type="text/javascript" src="js/jquery-ui-1.10.2.custom.min.js"></script>  
<script src="js/jquery.min.js"></script> 
<script src="js/jquery-ui.js"></script>  
<script src="js/xlsx.core.min.js"></script>
<script src="js/xls.core.min.js"></script>
<script src="js/raphael.min.js"></script>
<script src="js/morris.min.js"></script>
<script src="js/summernote-bs4.min.js"></script>
<script>
$(window).on('load', function () {
    let querystring = window.location.search.substring(1);
    let searchKey = Decrypt(querystring.split("=")[1]); 
    let noteid = searchKey;
    filesFill(noteid);
});
function Decrypt(value)
{
  var result="";
  var array = value.split("-");
  for(i=0;i<array.length;i++)
  {
    result+=String.fromCharCode(array[i]-10);
  }
  return result;
}
function filesFill(noteid) {
    $("#tblFiles").empty();
    var filenm = $("[id*=hdUserId]").val() + noteid.replace(/[^a-zA-Z0-9]/g, '')+"_";
             $.ajax({
                type: "post",
                contentType: "application/json; charset=utf-8",
                url: "Approve2.aspx/getFileData",
                data: "{pageVal:'GetAttachList', pageval1 :'" + noteid + "', pageval2 :'" + filenm + "', pageval3 :'" + $("[id*=hdUserId]").val() + "'}",
                dataType: "json",
                success: function (Result) {
                    Result = Result.d;
                    var valData, valData1;
                    var n = 0;
                    valData = Result.split('Θ');
                    if ($("#tblFiles tr").length == 0) {
                        $('#tblFiles').append('<thead class="bg-success text-white"><tr><th scope="col">File No</th><th scope="col">File Name</th></tr></thead>');
                    }
                    for (j = 0; j < valData.length - 1; j++) {
                        
                        var contentDtl = valData[j].split('µ');
                        //alert(contentDtl[3]);
                        var binaryString = contentDtl[3];
                        var filename = filenm + contentDtl[1];
                        var extension = contentDtl[2];
                        var _location = document.location.toString();
                        var applicationNameIndex = _location.indexOf('/', _location.indexOf('://') + 3);
                        var applicationName = _location.substring(0, applicationNameIndex) + '/';
                        var myUrl;
                        if (document.location.hostname === "localhost") {
                            myUrl = applicationName+"Images/" + filename;
                        }
                        else {
                            myUrl = applicationName+"paperless/Images/" + filename;
                        }                        
                        $('#tblFiles').append('<tbody><tr>' +
                            '<td>' + contentDtl[0] + '</td>' +
                            '<td><a href="' + myUrl + '" download="' + filename + '" class="file-list1">' + contentDtl[1] + '</a></td>' +
                            '</tr> </tbody>');
                    }

                }
            });
}
</script>
</head>
<body>
<form id="form1" runat="server">
<div>
<div class="table-responsive">
<table class="table1 table-hover" id="tblFiles" > 
</table> 
</div>
</div>
    
<input id="hdUserId" type="hidden" runat="server"/>
        <input id="hdBranchId" type="hidden" runat="server"/>
        <input id="hdFirmId" type="hidden" runat="server"/>
</form>
</body>
</html>
