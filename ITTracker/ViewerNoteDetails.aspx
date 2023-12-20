<%@ Page Title="" Language="C#" MasterPageFile="~/PWA_Master.Master" AutoEventWireup="true" CodeBehind="ViewerNoteDetails.aspx.cs" Inherits="ITTacker.ViewerNoteDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="StyleAutoComplete.css" rel="stylesheet" />
    <style>
        .card-body {
            background: #fff;
        }

        .timeline1 {
            position: relative;
            padding: 50px 0;
        }

        header.note-toolbar {
            padding: 0 0 5px 5px;
            margin: 0;
            background: #197969;
        }

        .container {
            border: none !important;
        }

        .shadow {
            box-shadow: 5px 15px 5px 3px #0017304d;
        }

        .bg-success {
            background-color: #197969 !important;
        }

        .bg-success {
            background-color: #197969 !important;
        }

        .timeline1::before {
            content: '';
            background: #C5CAE9;
            width: 5px;
            height: 95%;
            position: absolute;
            left: 50%;
            transform: translateX(-50%);
        }

        .timeline-item {
            width: 100%;
            margin-bottom: 5px;
        }

            .timeline-item:nth-child(even) .timeline-content {
                float: right;
                padding: 40px 30px 10px 30px;
            }

                .timeline-item:nth-child(even) .timeline-content .wf-date {
                    right: auto;
                    left: 0;
                }

                .timeline-item:nth-child(even) .timeline-content::after {
                    content: '';
                    position: absolute;
                    border-style: solid;
                    width: 0;
                    height: 0;
                    top: 30px;
                    left: -15px;
                    border-width: 10px 15px 10px 0;
                    border-color: transparent #f5f5f5 transparent transparent;
                }

            .timeline-item::after {
                content: '';
                display: block;
                clear: both;
            }

        .timeline-content {
            position: relative;
            width: 45%;
            padding: 10px 15px;
            border-radius: 4px;
            background: #fff;
            box-shadow: 0 20px 25px -15px rgba(0, 0, 0, 0.3);
        }

            .timeline-content::after {
                content: '';
                position: absolute;
                border-style: solid;
                width: 0;
                height: 0;
                top: 30px;
                right: -15px;
                border-width: 10px 0 10px 15px;
                border-color: transparent transparent transparent #f5f5f5;
            }

        .timeline-img {
            width: 30px;
            height: 30px;
            background: #197969;
            border-radius: 70%;
            position: absolute;
            left: 50%;
            margin-top: 25px;
            margin-left: -15px;
            color: #fff;
            text-align: center;
            padding-top: 7px;
        }

        .bnt-more {
            cursor: pointer;
            background: #3F51B5;
            color: #FFFFFF;
            padding: 3px 10px;
            text-transform: uppercase;
            font-size: 12px;
            display: inline-block;
            border-radius: 2px;
            box-shadow: 0 1px 3px -1px rgba(0, 0, 0, 0.6);
        }

            .bnt-more:hover, .bnt-more:active, .bnt-more:focus {
                background: #32408f;
                color: #FFFFFF;
                text-decoration: none;
            }

        .timeline-card {
            padding: 0 !important;
        }

            .timeline-card p {
                padding: 0 20px;
            }

            .timeline-card a {
                margin-left: 20px;
            }

        .timeline-item .timeline-img-header {
            background: linear-gradient(rgba(0, 0, 0, 0), rgba(0, 0, 0, 0.4)), url("https://picsum.photos/1000/800/?random") center center no-repeat;
            background-size: cover;
        }

        .timeline-img-header {
            height: 200px;
            position: relative;
            margin-bottom: 20px;
        }

            .timeline-img-header h2 {
                color: #FFFFFF;
                position: absolute;
                bottom: 5px;
                left: 20px;
            }

        .note-editor.note-frame .note-editing-area .note-editable[contenteditable="false"] {
            background-color: #a3e39a0a !important;
        }



        .card {
            border: none !important;
        }

        .card-body {
            border: none !important;
        }

        .wf-date {
            background: #197969;
            display: inline-block;
            color: #FFFFFF;
            padding: 5px;
            position: absolute;
            top: 0;
            right: 0;
            font-size: .75rem;
        }

        @media screen and (max-width: 768px) {
            .timeline::before {
                left: 50px;
            }

            .timeline1 .timeline-img {
                left: 50px;
            }

            .timeline1 .timeline-content {
                max-width: 100%;
                width: auto;
                margin-left: 70px;
            }

            .timeline1 .timeline-item:nth-child(even) .timeline-content {
                float: none;
            }

            .timeline1 .timeline-item:nth-child(odd) .timeline-content::after {
                content: '';
                position: absolute;
                border-style: solid;
                width: 0;
                height: 0;
                top: 30px;
                left: -15px;
                border-width: 10px 15px 10px 0;
                border-color: transparent #f5f5f5 transparent transparent;
            }
        }

        .read-more-state {
            display: none;
        }

        .read-more-target {
            opacity: 0;
            max-height: 0;
            font-size: 0;
            transition: .25s ease;
        }

        .read-more-state:checked ~ .read-more-wrap .read-more-target {
            opacity: 1;
            font-size: inherit;
            max-height: 999em;
        }

        .read-more-state ~ .read-more-trigger:before {
            content: 'Show more';
        }

        .read-more-state:checked ~ .read-more-trigger:before {
            content: 'Show less';
        }
    </style>
    <script>
        var EmpStatus = "";
        var DelayEnq = "";
        $(window).on('load', function () {
            let querystring = window.location.search.substring(1);
            $("#rbOther").prop("checked", true);
            // $("#showCancelBtn").hide();
            if (querystring == '0' || querystring == '' || querystring == 'undefined' || querystring == null) {
                $("[id*=hdnquerynoteid]").val("");
            }
            else {
                let querynoteid = Decrypt(querystring.split("=")[1]);
                //let querynoteid = querystring.split("=")[1]; 
                //let querynoteid = querystring.split("=")[1]; 
                $("[id*=hdnquerynoteid]").val(querynoteid);


            }
            //////
            $('.summernoteview').summernote({
                height: 200, // set editor height
                minHeight: null, // set minimum height of editor
                maxHeight: null, // set maximum height of editor
                focus: false, // set focus to editable area after initializing summernote
                toolbar: [
                ]
            });
            $(".summernoteview").summernote("disable");
            $("#summernoteview").summernote("fullscreen.toggle");
            setInterval("getPendingCount();", 1000);

            ContentFill($("[id*=hdnquerynoteid]").val());
            var noteid = $("[id*=hdnquerynoteid]").val();
            cancelButtonLoad(noteid);
            detailsLoad(noteid);
            filesFill(noteid);
            TestCaseFileLoad(noteid);
            Tafill(noteid);
            TargetDateAndStatus(noteid);
            fillTADetails(noteid);

            fillDveloperwise(noteid);
            WorkFlowFill(noteid);
            ChangeDocFileLoad(noteid);
            TestingArtiFactLoad(noteid);
            ReleaseNoteLoad(noteid);
            otherDocLoad(noteid);
            GetEmpStatusView(noteid);
            TestresultLoad(noteid);
            TestRequestform(noteid);
            BAUploadDocuments(noteid);
           
            codeReviewDoc(noteid); // get code review

            var Data = '';
            Data = $("[id*=hdnquerynoteid]").val() + 'µ' + $("[id*=hdUserId]").val();

        });
        $(document).ready(function () {
            $('.summernoteview').summernote({
                height: 200, // set editor height
                minHeight: null, // set minimum height of editor
                maxHeight: null, // set maximum height of editor
                focus: false, // set focus to editable area after initializing summernote
                toolbar: [
                ]
            });
            $(".summernoteview").summernote("disable");
            $("#summernoteview").summernote("fullscreen.toggle");
            //GetEmpStatus($("[id*=hdnquerynoteid]").val());
        });
        function getPendingCount() {
            var Data = '';
            Data = '' + 'µ' + '' + 'µ' + $("[id*=hdUserId]").val()
            $.ajax({
                type: "post",
                contentType: "application/json; charset=utf-8",
                url: "ViewerNoteDetails.aspx/getBugCount",
                data: "{pageVal:'GetEnquiryCountViwer', pageval1:'" + Data + "',pageval2:''}",
                dataType: "json",
                async: false,
                success: function (Result) {
                    Result = Result.d;
                    document.getElementById("pendCntView").innerHTML = Result;



                }
            });
        }
        function Decrypt(value) {
            var result = "";
            var array = value.split("-");

            for (i = 0; i < array.length; i++) {
                result += String.fromCharCode(array[i] - 10);
            }
            return result;
        }

        function viewReport() {

            window.open("testwbs.aspx?mnuId=" + $("[id*=hdnquerynoteid]").val() + "");
            // window.open("testwbs.aspx?mnuId=" + Result + "");
        }

        function viewBug() {

            window.open("BugDetails.aspx?mnuId=" + $("[id*=hdnquerynoteid]").val() + "");
            // window.open("testwbs.aspx?mnuId=" + Result + "");
        }



        function cancelButtonLoad(noteid) {

            $.ajax({
                type: "post",
                contentType: "application/json; charset=utf-8",
                url: "ViewerNoteDetails.aspx/CheckEmpAccessNew",
                data: "{pageVal:'UserCheckCRF', pageval1:'" + noteid + "',pageval2:'" + $("[id*=hdUserId]").val() + "'}",
                dataType: "json",
                async: false,
                success: function (Result) {
                    Result = Result.d;

                    if (Result == "1") {
                        $("#showDeleteButton").show();
                    }
                    else {
                        $("#showDeleteButton").hide();
                    }
                }
            });
        }
        function ContentFill(noteid) {
            $(".loaderColorCont").show();
            $('.radio-button').prop('checked', false);

            var Data = '';
            Data = $("[id*=hdBranchId]").val() + 'µ' + $("[id*=hdFirmId]").val() + 'µ' + $("[id*=hdUserId]").val();
            $.ajax({
                type: "post",
                contentType: "application/json; charset=utf-8",
                url: "ViewerNoteDetails.aspx/getTableData",
                data: "{pageVal:'GetNoteDetails', pageval1 :'" + noteid + "', pageval2 :'" + Data + "'}",
                dataType: "json",
                success: function (Result) {
                    Result = Result.d;
                  
                    //alert(Result);
                    var contentDtl = Result.split('µ');
                    //alert(contentDtl);
                    document.getElementById("sNameDiv").innerHTML = "";
                    var snDiv = document.createElement("div");
                    snDiv.className = "ms-Persona-imageArea";
                    snDiv.setAttribute('style', 'float: left;');
                    var snItemDiv = document.createElement("div");
                    if (contentDtl[15] == 1) { snItemDiv.className = "ms-Persona-initials ms-Persona-initials--red"; }
                    else if (contentDtl[15] == 2) { snItemDiv.className = "ms-Persona-initials ms-Persona-initials--orange"; }
                    else if (contentDtl[15] == 3) { snItemDiv.className = "ms-Persona-initials ms-Persona-initials--yellow"; }


                    snItemDiv.innerHTML = contentDtl[14];
                    snDiv.appendChild(snItemDiv);
                    document.getElementById("sNameDiv").appendChild(snDiv);

                    document.getElementById("lblNoteId").innerHTML = contentDtl[0];
                    $("[id*=hdnNoteId]").val(contentDtl[0]);
                    document.getElementById("lblSubject").innerHTML = contentDtl[2];

                    document.getElementById("lblFirm").innerHTML = contentDtl[1];
                    document.getElementById("lblDocType").innerHTML = contentDtl[7];
                    document.getElementById("lblCreateBy").innerHTML = contentDtl[4];

                    document.getElementById("lblDepartment").innerHTML = contentDtl[12];
                    document.getElementById("lblobj").innerHTML = contentDtl[19];
                    document.getElementById("lblimpact").innerHTML = contentDtl[20];
                    document.getElementById("lblTester").innerHTML = contentDtl[21];
                    document.getElementById("lblsuggestion").innerHTML = contentDtl[22];
                    document.getElementById("costid").innerHTML = contentDtl[23];
                    document.getElementById("USERPHNNUM").innerHTML = contentDtl[24];
                    document.getElementById("circularid").innerHTML = contentDtl[25];



                    document.getElementById("lblCreateDate").innerHTML = contentDtl[5];
                    document.getElementById("lblNature").innerHTML = contentDtl[8];
                    document.getElementById("divRemarks").innerHTML = "";

                    var remkDiv = document.createElement("div");
                    var remkChk = document.createElement("input");
                    remkChk.setAttribute('type', 'checkbox');
                    remkChk.setAttribute('id', 'post-' + contentDtl[0]);
                    remkChk.className = "read-more-state";
                    remkDiv.appendChild(remkChk);


                    var remkP = document.createElement("p");
                    remkP.className = "read-more-wrap text-maroon";
                    remkP.setAttribute('style', 'margin-bottom: 0;');
                    var x1 = 'Remarks :' + contentDtl[3];
                    var c1 = x1.split(' ').length;
                    var y1 = x1.split(' ').slice(0, 30).join(' ');
                    var z1 = x1.split(' ').slice(30, c1).join(' ');


                    remkP.innerHTML = y1;
                    if (c1 > 30) {
                        var remkSpanP = document.createElement("span");
                        remkSpanP.className = "read-more-target";
                        remkSpanP.innerHTML = z1;
                        remkP.appendChild(remkSpanP);

                    }
                    remkDiv.appendChild(remkP);
                    if (c1 > 30) {

                        var remkLbl = document.createElement("label");
                        remkLbl.setAttribute('for', 'post-' + contentDtl[0]);
                        remkLbl.className = "read-more-trigger bnt-more";
                        remkDiv.appendChild(remkLbl);
                    }


                    document.getElementById("divRemarks").appendChild(remkDiv);


                    priority = document.getElementById("lblPriority");
                    if (contentDtl[9] == 1) {
                        document.getElementById("lblPriority").innerHTML = "High";
                        priority.classList.remove('label-medium');
                        priority.classList.remove('label-low');
                        priority.classList.add('label-high');
                    }
                    else if (contentDtl[9] == 2) {
                        document.getElementById("lblPriority").innerHTML = "Medium";
                        priority.classList.remove('label-high');
                        priority.classList.remove('label-low');
                        priority.classList.add('label-medium');
                    }
                    else if (contentDtl[9] == 3) {
                        document.getElementById("lblPriority").innerHTML = "Low";
                        priority.classList.remove('label-high');
                        priority.classList.remove('label-medium');
                        priority.classList.add('label-low');
                    }
                    nature = document.getElementById("lblNature");
                    if (contentDtl[17] == "Y") {
                        nature.classList.remove('label-primary');
                        nature.classList.add('label-high');
                    }
                    else {
                        nature.classList.remove('label-high');
                        nature.classList.add('label-primary');
                    }


                    $("[id*=hdnNoteOrderId]").val(contentDtl[11]);

                    ContentAprroverFill(noteid);

                    detailsLoad(noteid);
                    filesFill(noteid);
                    WorkFlowFill(noteid);


                    $(".loaderColorCont").fadeOut();
                },
                error: function (Result) {
                }
            });
        }
        function detailsLoad(noteid) {
            $.ajax({
                type: "post",
                contentType: "application/json; charset=utf-8",
                url: "ViewerNoteDetails.aspx/getRequestNote",
                data: "{pageVal:'GetRequestNotes', pageval1:'" + noteid + "',pageval2:'2'}",
                dataType: "json",
                success: function (Result) {
                    Result = Result.d;
                    $('.summernoteview').summernote('code', Result);
                }
            });
        }

        function filesFill(noteid) {

            $("#tblFiles").empty();
            var filenm = $("[id*=hdUserId]").val() + noteid.replace(/[^a-zA-Z0-9]/g, '') + "_";
            $.ajax({
                type: "post",
                contentType: "application/json; charset=utf-8",
                url: "ViewerNoteDetails.aspx/getFileData",
                async: false,
                data: "{pageVal:'GetAttachList', pageval1 :'" + noteid + "', pageval2 :'" + filenm + "'}",
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
                            myUrl = applicationName + "Images/" + filename;
                        }
                        else {
                            myUrl = applicationName + "AMS/Images/" + filename;
                        }

                        $('#tblFiles').append('<tbody><tr>' +
                            '<td>' + contentDtl[0] + '</td>' +
                            '<td><a href="' + myUrl + '" download="' + filename + '" class="file-list1">' + contentDtl[1] + '</a></td>' +
                            '</tr> </tbody>');
                    }


                },
                error: function (Result) {

                }
            });

            if ($("#tblFiles tr").length > 1) {
                $("#attFiles").show();
            }
            else $("#attFiles").hide();
        }
        function TestCaseFileLoad(noteid) {

            //lblTestCase
            $("#tblTestCase").empty();
            var filenm = "TestCases_" + noteid.replace(/[^a-zA-Z0-9]/g, '') + "_";
            $.ajax({
                type: "post",
                contentType: "application/json; charset=utf-8",
                url: "ViewerNoteDetails.aspx/getFileData",
                async: false,
                data: "{pageVal:'GetAttachListTestCases1', pageval1 :'" + noteid + "', pageval2 :'" + filenm + "'}",
                dataType: "json",
                success: function (Result) {

                    Result = Result.d;

                    var valData, valData1;
                    var n = 0;
                    valData = Result.split('Θ');
                    if ($("#tblTestCase tr").length == 0) {
                        $('#tblTestCase').append('<thead class="bg-success text-white"><tr><th scope="col">File No</th><th scope="col">File Name</th></tr></thead>');
                    }

                    for (j = 0; j < valData.length - 1; j++) {

                        var contentDtl = valData[j].split('µ');

                        var binaryString = contentDtl[3];
                        var filename = filenm + contentDtl[1];
                        var extension = contentDtl[2];
                        var _location = document.location.toString();
                        var applicationNameIndex = _location.indexOf('/', _location.indexOf('://') + 3);
                        var applicationName = _location.substring(0, applicationNameIndex) + '/';
                        var myUrl;
                        if (document.location.hostname === "localhost") {
                            myUrl = applicationName + "Images/" + filename;
                        }
                        else {
                            myUrl = applicationName + "ams/Images/" + filename;
                        }

                        $('#tblTestCase').append('<tbody><tr>' +
                            '<td>' + contentDtl[0] + '</td>' +
                            '<td><a href="' + myUrl + '" download="' + filename + '" class="file-list1">' + contentDtl[1] + '</a></td>' +
                            '</tr> </tbody>');
                    }


                },
                error: function (Result) {

                }
            });

            if ($("#tblTestCase tr").length > 1) {
                $("#testCases").show();
            }
            else $("#testCases").hide();

        }
        function ChangeDocFileLoad(noteid) {
            $("#tblChange_doc").empty();
            var filenm = "releaseArtifact_" + noteid.replace(/[^a-zA-Z0-9]/g, '') + "_";
            $.ajax({
                type: "post",
                contentType: "application/json; charset=utf-8",
                url: "ViewerNoteDetails.aspx/getFileData",
                async: false,
                data: "{pageVal:'GetAttachChangeDoc1', pageval1 :'" + noteid + "', pageval2 :'" + filenm + "'}",
                dataType: "json",
                success: function (Result) {
                    Result = Result.d;
                    var valData, valData1;
                    var n = 0;
                    valData = Result.split('Θ');
                    if ($("#tblChange_doc tr").length == 0) {
                        $('#tblChange_doc').append('<thead class="bg-success text-white"><tr><th scope="col">File No</th><th scope="col">RequestID</th><th scope="col">File Name</th></tr></thead>');
                    }
                    for (j = 0; j < valData.length - 1; j++) {
                        var contentDtl = valData[j].split('µ');
                        var binaryString = contentDtl[3];
                        var filename = filenm + contentDtl[1];
                        var extension = contentDtl[2];
                        var _location = document.location.toString();
                        var applicationNameIndex = _location.indexOf('/', _location.indexOf('://') + 3);
                        var applicationName = _location.substring(0, applicationNameIndex) + '/';
                        var myUrl;
                        if (document.location.hostname === "localhost") {
                            myUrl = applicationName + "Images/" + filename;
                        }
                        else {
                            myUrl = applicationName + "ams/Images/" + filename;
                        }
                        $('#tblChange_doc').append('<tbody><tr>' +
                            '<td>' + contentDtl[0] + '</td>' +
                            '<td>' + contentDtl[4] + '</td>' +
                            '<td><a href="' + myUrl + '" download="' + filename + '" class="file-list1">' + contentDtl[1] + '</a></td>' +
                            '</tr> </tbody>');
                    }
                },
                error: function (Result) {
                }
            });
            if ($("#tblChange_doc tr").length > 1) {
                $("#attChange_doc").show();
            }
            else $("#attChange_doc").hide();
        }
        function TestingArtiFactLoad(noteid) {
            $("#tblTestArtifact").empty();
            var filenm = "TestingArtifact_" + noteid.replace(/[^a-zA-Z0-9]/g, '') + "_";
            $.ajax({
                type: "post",
                contentType: "application/json; charset=utf-8",
                url: "ViewerNoteDetails.aspx/getFileData",
                async: false,
                data: "{pageVal:'GetTestingArtiFact1', pageval1 :'" + noteid + "', pageval2 :'" + filenm + "'}",
                dataType: "json",
                success: function (Result) {
                    Result = Result.d;
                    var valData, valData1;
                    var n = 0;
                    valData = Result.split('Θ');
                    if ($("#tblTestArtifact tr").length == 0) {
                        $('#tblTestArtifact').append('<thead class="bg-success text-white"><tr><th scope="col">File No</th><th scope="col">RequestID</th><th scope="col">File Name</th></tr></thead>');
                    }
                    for (j = 0; j < valData.length - 1; j++) {
                        var contentDtl = valData[j].split('µ');
                        var binaryString = contentDtl[3];
                        var filename = filenm + contentDtl[1];
                        var extension = contentDtl[2];
                        var _location = document.location.toString();
                        var applicationNameIndex = _location.indexOf('/', _location.indexOf('://') + 3);
                        var applicationName = _location.substring(0, applicationNameIndex) + '/';
                        var myUrl;
                        if (document.location.hostname === "localhost") {
                            myUrl = applicationName + "Images/" + filename;
                        }
                        else {
                            myUrl = applicationName + "ams/Images/" + filename;
                        }
                        $('#tblTestArtifact').append('<tbody><tr>' +
                            '<td>' + contentDtl[0] + '</td>' +
                            '<td>' + contentDtl[4] + '</td>' +
                            '<td><a href="' + myUrl + '" download="' + filename + '" class="file-list1">' + contentDtl[1] + '</a></td>' +
                            '</tr> </tbody>');
                    }
                },
                error: function (Result) {
                }
            });
            if ($("#tblTestArtifact tr").length > 1) {
                $("#testArtifacts").show();
            }
            else $("#testArtifacts").hide();
        }
        function ReleaseNoteLoad(noteid) {
            $("#tblReleaseDoc").empty();
            var filenm = "ReleaseDoc_" + noteid.replace(/[^a-zA-Z0-9]/g, '') + "_";
            $.ajax({
                type: "post",
                contentType: "application/json; charset=utf-8",
                url: "ViewerNoteDetails.aspx/getFileData",
                async: false,
                data: "{pageVal:'GetReleasDoc1', pageval1 :'" + noteid + "', pageval2 :'" + filenm + "'}",
                dataType: "json",
                success: function (Result) {
                    Result = Result.d;
                    var valData, valData1;
                    var n = 0;
                    valData = Result.split('Θ');
                    if ($("#tblReleaseDoc tr").length == 0) {
                        $('#tblReleaseDoc').append('<thead class="bg-success text-white"><tr><th scope="col">File No</th><th scope="col">RequestID</th><th scope="col">File Name</th></tr></thead>');
                    }
                    for (j = 0; j < valData.length - 1; j++) {
                        var contentDtl = valData[j].split('µ');
                        var binaryString = contentDtl[3];
                        var filename = filenm + contentDtl[1];
                        var extension = contentDtl[2];
                        var _location = document.location.toString();
                        var applicationNameIndex = _location.indexOf('/', _location.indexOf('://') + 3);
                        var applicationName = _location.substring(0, applicationNameIndex) + '/';
                        var myUrl;
                        if (document.location.hostname === "localhost") {
                            myUrl = applicationName + "Images/" + filename;
                        }
                        else {
                            myUrl = applicationName + "ams/Images/" + filename;
                        }
                        $('#tblReleaseDoc').append('<tbody><tr>' +
                            '<td>' + contentDtl[0] + '</td>' +
                            '<td>' + contentDtl[4] + '</td>' +
                            '<td><a href="' + myUrl + '" download="' + filename + '" class="file-list1">' + contentDtl[1] + '</a></td>' +
                            '</tr> </tbody>');
                    }
                },
                error: function (Result) {
                }
            });
            if ($("#tblReleaseDoc tr").length > 1) {
                $("#attReleaseDoc").show();
            }
            else $("#attReleaseDoc").hide();
        }
        function otherDocLoad(noteid) {
            $("#tblotherDoc").empty();
            var filenm = "OtherDoc_" + noteid.replace(/[^a-zA-Z0-9]/g, '') + "_";
            $.ajax({
                type: "post",
                contentType: "application/json; charset=utf-8",
                url: "ViewerNoteDetails.aspx/getFileData",
                async: false,
                data: "{pageVal:'GetOtherDoc1', pageval1 :'" + noteid + "', pageval2 :'" + filenm + "'}",
                dataType: "json",
                success: function (Result) {
                    Result = Result.d;
                    var valData, valData1;
                    var n = 0;
                    valData = Result.split('Θ');
                    if ($("#tblotherDoc tr").length == 0) {
                        $('#tblotherDoc').append('<thead class="bg-success text-white"><tr><th scope="col">File No</th><th scope="col">RequestID</th><th scope="col">File Name</th></tr></thead>');
                    }
                    for (j = 0; j < valData.length - 1; j++) {
                        var contentDtl = valData[j].split('µ');
                        var binaryString = contentDtl[3];
                        var filename = filenm + contentDtl[1];
                        var extension = contentDtl[2];
                        var _location = document.location.toString();
                        var applicationNameIndex = _location.indexOf('/', _location.indexOf('://') + 3);
                        var applicationName = _location.substring(0, applicationNameIndex) + '/';
                        var myUrl;
                        if (document.location.hostname === "localhost") {
                            myUrl = applicationName + "Images/" + filename;
                        }
                        else {
                            myUrl = applicationName + "ams/Images/" + filename;
                        }
                        $('#tblotherDoc').append('<tbody><tr>' +
                            '<td>' + contentDtl[0] + '</td>' +
                            '<td>' + contentDtl[4] + '</td>' +
                            '<td><a href="' + myUrl + '" download="' + filename + '" class="file-list1">' + contentDtl[1] + '</a></td>' +
                            '</tr> </tbody>');
                    }
                },
                error: function (Result) {
                }
            });
            if ($("#tblotherDoc tr").length > 1) {
                $("#otherDoc").show();
            }
            else $("#otherDoc").hide();
        }
        function Tafill(noteid) {
            $.ajax({
                type: "post",
                contentType: "application/json; charset=utf-8",
                url: "ViewerNoteDetails.aspx/getTableData",
                data: "{pageVal:'TACompleteData', pageval1 :'" + noteid + "', pageval2:''}",
                dataType: "json",
                success: function (Result) {
                    Result = Result.d;
                    fillTATable(Result);
                }
            });
        }

        function TargetDateAndStatus(noteid) {
            $.ajax({
                type: "post",
                contentType: "application/json; charset=utf-8",
                url: "ViewerNoteDetails.aspx/getTableData",
                data: "{pageVal:'TargetDateAndStatus', pageval1 :'" + noteid + "', pageval2:''}",
                dataType: "json",
                success: function (Result) {
                    Result = Result.d;
                    var valData, valData1, tarDate = "", Status = "";
                    Result = Result + '¶';
                    valData = Result.split('¶');
                    if ($("#tblTarStatus tr").length == 0) {
                        $("#tblTarStatus").empty();
                        $('#tblTarStatus').append('<tr style="background-color:#197969;color:white"><th class="text-center">RequestId</th><th class="text-center">TechLead</th><th class="text-center">Status</th><th class="text-center">Target Date</th></tr>');
                    }
                    for (i = 0; i < valData.length - 1; i++) {
                        valData1 = valData[i].split('µ');

                        $('#tblTarStatus').append('<tbody><tr class="text-center" style="background-color:#fff;color:#7460ee; font-weight:bold;" >' +
                            '<td>' + valData1[0] + '</td>' +
                            '<td>' + valData1[2] + '</td>' +
                            '<td>' + valData1[3] + '</td>' +
                            '<td>' + valData1[1] + '</td></tr > </tbody > ');
                    }

                }
            });
        }

        function fillTATable(data) {
            var valData, valData1;
            valData = data.split('Θ');

            if ($("#tabChange tr").length == 0) {
                $("#tabChange").empty();
                $('#tabChange').append('<tr style="background-color:#197969;color:white"><th class="text-center">REQUEST ID</th><th class="text-center">TECHLEAD</th><th class="text-center">DEVELOPER</th><th class="text-center">START DATE</th><th class="text-center">END DATE</th><th class="text-center">PHASE</th><th class="text-center">TECHCHANGES</th><th class="text-center">DESCRIPTION</th><th class="text-center">NO OF CHANGES</th><th class="text-center">TOTAL HOURS</th></tr>');
            }
            for (i = 0; i < valData.length - 1; i++) {
                valData1 = valData[i].split('µ');

                $('#tabChange').append('<tbody><tr class="text-center" style="background-color:#fff" >' +


                    '<td>' + valData1[0] + '</td>' +
                    '<td>' + valData1[1] + '</td>' +
                    '<td>' + valData1[2] + '</td>' +
                    '<td>' + valData1[3] + '</td>' +
                    '<td>' + valData1[4] + '</td>' +
                    '<td>' + valData1[5] + '</td>' +
                    '<td>' + valData1[6] + '</td>' +
                    '<td>' + valData1[7] + '</td>' +
                    '<td>' + valData1[8] + '</td>' +
                    '<td>' + valData1[9] + '</td></tr > </tbody > ');
            }
            if ($("#tabChange tr").length > 1) {
                $("#taDetails").show();
            }
            else $("#taDetails").hide();
        }




        function TestresultLoad(noteid) {
            $("#tbltestresult").empty();
            var filenm = "testresult_" + noteid.replace(/[^a-zA-Z0-9]/g, '') + "_";
            $.ajax({
                type: "post",
                contentType: "application/json; charset=utf-8",
                url: "ViewerNoteDetails.aspx/getFileData",
                async: false,
                data: "{pageVal:'GetTestresult', pageval1 :'" + noteid + "', pageval2 :'" + filenm + "'}",

                dataType: "json",

                success: function (Result) {
                    $("#testresult").show();
                    Result = Result.d;
                    // alert(Result);
                    var valData, valData1;
                    var n = 0;
                    valData = Result.split('Θ');
                    if ($("#tbltestresult tr").length == 0) {
                        $('#tbltestresult').append('<thead class="bg-success text-white"><tr><th scope="col">File No</th><th scope="col">RequestID</th><th scope="col">File Name</th></tr></thead>');
                    }
                    for (j = 0; j < valData.length - 1; j++) {
                        var contentDtl = valData[j].split('µ');
                        // alert(valData[j]);
                        var binaryString = contentDtl[3];
                        var filename = filenm + contentDtl[1];
                        var extension = contentDtl[2];
                        var _location = document.location.toString();
                        var applicationNameIndex = _location.indexOf('/', _location.indexOf('://') + 3);
                        var applicationName = _location.substring(0, applicationNameIndex) + '/';
                        var myUrl;
                        if (document.location.hostname === "localhost") {
                            myUrl = applicationName + "Images/" + filename;
                        }
                        else {
                            myUrl = applicationName + "ams/Images/" + filename;
                        }
                        $('#tbltestresult').append('<tbody><tr>' +
                            '<td>' + contentDtl[0] + '</td>' +
                            '<td>' + contentDtl[4] + '</td>' +
                            '<td><a href="' + myUrl + '" download="' + filename + '" class="file-list1">' + contentDtl[1] + '</a></td>' +
                            '</tr> </tbody>');
                    }
                },

                error: function (Result) {

                }
            });

            // alert(length);
            if ($("#tbltestresult tr").length > 1) {
                $("#testresult").show();

            }
            else $("#testresult").hide();
        }



        //Testrequestform//


        function TestRequestform(noteid) {
            $("#tblTestrqstfrm").empty();
            var filenm = "testreqst_" + noteid.replace(/[^a-zA-Z0-9]/g, '') + "_";
            $.ajax({
                type: "post",
                contentType: "application/json; charset=utf-8",
                url: "ViewerNoteDetails.aspx/getFileData",
                async: false,
                data: "{pageVal:'GetTestrequest', pageval1 :'" + noteid + "', pageval2 :'" + filenm + "'}",

                dataType: "json",

                success: function (Result) {
                    $("#Testrequestform").show();
                    Result = Result.d;
                    //alert(Result);
                    var valData, valData1;
                    var n = 0;
                    valData = Result.split('Θ');
                    if ($("#tblTestrqstfrm tr").length == 0) {
                        $('#tblTestrqstfrm').append('<thead class="bg-success text-white"><tr><th scope="col">File No</th><th scope="col">RequestID</th><th scope="col">File Name</th></tr></thead>');
                    }
                    for (j = 0; j < valData.length - 1; j++) {
                        var contentDtl = valData[j].split('µ');
                        // alert(valData[j]);
                        var binaryString = contentDtl[3];
                        var filename = filenm + contentDtl[1];
                        var extension = contentDtl[2];
                        var _location = document.location.toString();
                        var applicationNameIndex = _location.indexOf('/', _location.indexOf('://') + 3);
                        var applicationName = _location.substring(0, applicationNameIndex) + '/';
                        var myUrl;
                        if (document.location.hostname === "localhost") {
                            myUrl = applicationName + "Images/" + filename;
                        }
                        else {
                            myUrl = applicationName + "ams/Images/" + filename;
                        }
                        $('#tblTestrqstfrm').append('<tbody><tr>' +
                            '<td>' + contentDtl[0] + '</td>' +
                            '<td>' + contentDtl[4] + '</td>' +
                            '<td><a href="' + myUrl + '" download="' + filename + '" class="file-list1">' + contentDtl[1] + '</a></td>' +
                            '</tr> </tbody>');
                    }
                },

                error: function (Result) {

                }
            });

            // alert(length);
            if ($("#tblTestrqstfrm tr").length > 1) {
                $("#Testrequestform").show();

            }
            else $("#Testrequestform").hide();
        }
        function BAUploadDocuments(noteid) {
           
            $("#BADocments").empty();
            var filenm = "BAUploadDocuments_" + noteid.replace(/[^a-zA-Z0-9]/g, '') + "_";
            $.ajax({
                type: "post",
                contentType: "application/json; charset=utf-8",
                url: "ViewerNoteDetails.aspx/getFileData",
                async: false,
                data: "{pageVal:'BAUploadDocuments', pageval1 :'" + noteid + "', pageval2 :'" + filenm + "'}",

                dataType: "json",

                success: function (Result) {
                    $("#BADoc").show();
                    Result = Result.d;
                    //alert(Result);
                    var valData, valData1;
                    var n = 0;
                    valData = Result.split('Θ');
                    if ($("#BADocments tr").length == 0) {
                        $('#BADocments').append('<thead class="bg-success text-white"><tr><th scope="col">File No</th><th scope="col">RequestID</th><th scope="col">File Name</th></tr></thead>');
                    }
                    for (j = 0; j < valData.length - 1; j++) {
                        var contentDtl = valData[j].split('µ');
                        // alert(valData[j]);
                        var binaryString = contentDtl[3];
                        var filename = filenm + contentDtl[1];
                        var extension = contentDtl[2];
                        var _location = document.location.toString();
                        var applicationNameIndex = _location.indexOf('/', _location.indexOf('://') + 3);
                        var applicationName = _location.substring(0, applicationNameIndex) + '/';
                        var myUrl;
                        if (document.location.hostname === "localhost") {
                            myUrl = applicationName + "Images/" + filename;
                        }
                        else {
                            myUrl = applicationName + "ams/Images/" + filename;
                        }
                        $('#BADocments').append('<tbody><tr>' +
                            '<td>' + contentDtl[0] + '</td>' +
                            '<td>' + contentDtl[4] + '</td>' +
                            '<td><a href="' + myUrl + '" download="' + filename + '" class="file-list1">' + contentDtl[1] + '</a></td>' +
                            '</tr> </tbody>');
                    }
                },

                error: function (Result) {

                }
            });

            // alert(length);
            if ($("#BADocments tr").length > 1) {
                $("#BADoc").show();

            }
            else $("#BADoc").hide();
        }

               //define get sourse Doc
        function codeReviewDoc(noteid) {

            $("#tblCodeReview").empty();
            var filenm = "codeReviewDocs_" + noteid.replace(/[^a-zA-Z0-9]/g, '') + "_";
            $.ajax({
                type: "post",
                contentType: "application/json; charset=utf-8",
                url: "ViewerNoteDetails.aspx/getCodeReviewData",
                async: false,
                data: "{pageVal:'sourcecodeUploadDocuments', pageval1 :'" + noteid + "', pageval2 :'" + filenm + "'}",

                dataType: "json",

                success: function (Result) {
                    debugger;
                    $("#codeReviewRmkDiv").show();
                    Result = Result.d;
                    //alert(Result);
                    var valData, valData1;
                    var n = 0;
                    valData = Result.split('Θ');
                    if ($("#tblCodeReview tr").length == 0) {
                        $('#tblCodeReview').append('<thead class="bg-success text-white"><tr><th scope="col">File No</th><th scope="col">RequestID</th><th scope="col">File Name</th></tr></thead>');
                    }
                    for (j = 0; j < valData.length - 1; j++) {
                        var contentDtl = valData[j].split('µ');
                        // alert(valData[j]);
                        var binaryString = contentDtl[3];
                        var filename = filenm + contentDtl[1];
                        var extension = contentDtl[2];
                        var _location = document.location.toString();
                        var applicationNameIndex = _location.indexOf('/', _location.indexOf('://') + 3);
                        var applicationName = _location.substring(0, applicationNameIndex) + '/';
                        var myUrl;
                        if (document.location.hostname === "localhost") {
                            myUrl = applicationName + "Images/" + filename;
                        }
                        else {
                            myUrl = applicationName + "ams/Images/" + filename;
                        }
                        $('#tblCodeReview').append('<tbody><tr>' +
                            '<td>' + contentDtl[0] + '</td>' +
                            '<td>' + contentDtl[4] + '</td>' +
                            '<td><a href="' + myUrl + '" download="' + filename + '" class="file-list1">' + contentDtl[1] + '</a></td>' +
                            '</tr> </tbody>');
                    }
                },

                error: function (Result) {

                }
            });

            // alert(length);
            if ($("#tblCodeReview tr").length > 1) {
                $("#codeReviewRmkDiv").show();

            }
            else $("#codeReviewRmkDiv").hide();
        }

        function fillTADetails(req) {
            $.ajax({
                type: "post",
                contentType: "application/json; charset=utf-8",
                url: "ViewerNoteDetails.aspx/TestingTADtls",
                data: "{pageVal:'TestingTADtls1', pageval1 :'" + req + "', pageval2:''}",
                dataType: "json",
                success: function (Result) {
                    Result = Result.d;

                    if (Result != "" && Result != null) {
                        // alert(Result);
                        var valData, valData1, valData2;
                        valData2 = Result.split('¶');
                        $("#test_TA").show();
                        $("#tblTestingTADtls").empty();
                        if ($("#tblTestingTADtls tr").length == 0) {
                            $('#tblTestingTADtls').append('<tr style="background-color:#197969;color:white"><th class="text-center">REQUEST ID</th><th class="text-center">TEST LEAD</th><th class="text-center">TEST ENGINEER</th><th class="text-center">PROJECT TYPE</th><th class="text-center">PHASE</th><th class="text-center">DESCRIPTION</th><th class="text-center">TEST STARTDATE</th><th class="text-center">TEST ENDDATE</th><th class="text-center">WORK HOURS</th></tr>');
                        }
                        for (i = 0; i < valData2.length; i++) {
                            valData1 = valData2[i].split('µ');
                            $('#tblTestingTADtls').append('<tbody><tr class="text-center" style="background-color:#fff" >' +
                                '<td>' + valData1[9] + '</td>' +
                                '<td>' + valData1[0] + '</td>' +
                                '<td>' + valData1[1] + '</td>' +
                                '<td>' + valData1[4] + '</td>' +
                                '<td>' + valData1[5] + '</td>' +
                                '<td>' + valData1[6] + '</td>' +
                                '<td>' + valData1[2] + '</td>' +
                                '<td>' + valData1[3] + '</td>' +
                                '<td>' + valData1[8] + '</td></tr > </tbody > ');
                        }

                    }
                    else {
                        $("#test_TA").hide();
                    }

                }
            });


        }
        function fillDveloperwise(noteid) {
            $.ajax({
                type: "post",
                contentType: "application/json; charset=utf-8",
                url: "ViewerNoteDetails.aspx/TestingTADtls",
                data: "{pageVal:'Developerdetails', pageval1 :'" + noteid + "', pageval2:''}",
                dataType: "json",
                success: function (Result) {
                    Result = Result.d;
                    // alert("hai");
                    // alert(Result);
                    if (Result != "" && Result != null) {

                        var valData, valData1, valData2;
                        valData2 = Result.split('¶');
                        $("#Devlp_wise").show();
                        $("#tblDeveloperwise").empty();
                        // if ($("#tblDeveloperwise").length == 0) {
                        $('#tblDeveloperwise').append('<tr style="background-color:#197969;color:white"><th class="text-center">Developer Name </th><th class="text-center">Assigned Days </th><th class="text-center">Manhour</th><th class="text-center">Started Date</th><th class="text-center">End Date </th><th class="text-center">Delay starting Date </th><th class="text-center">Delay completing Date </th></tr>');
                        //  }
                        for (i = 0; i < valData2.length; i++) {
                            valData1 = valData2[i].split('µ');
                            $('#tblDeveloperwise').append('<tbody><tr class="text-center" style="background-color:#fff" >' +
                                '<td>' + valData1[0] + '</td>' +
                                '<td>' + valData1[1] + '</td>' +
                                '<td>' + valData1[2] + '</td>' +
                                '<td>' + valData1[3] + '</td>' +
                                '<td>' + valData1[4] + '</td>' +
                                '<td>' + valData1[5] + '</td>' +
                                '<td>' + valData1[6] + '</td></tr > </tbody > ');
                        }

                    }
                    else {
                        $("#Devlp_wise").hide();
                    }

                }
            });


        }
        function WorkFlowFill(noteid) {
            //a.note_id,e.firm_abbr Firm,a.subject,a.remarks,initcap(d.EMP_NAME) Created_by,to_char(a.created_date, 'dd-Mon-yyyy hh:mi:ss am') createdDate,to_char(b.received_date, 'dd-Mon-yyyy hh:mi:ss am') received_date,c.doc_name,decode(a.nature, 'Y', 'Confidential', 'Non Confidential') nature,a.priority,decode(a.circular, 'Y', 'Yes', 'No') circular
            $.ajax({
                type: "post",
                contentType: "application/json; charset=utf-8",
                url: "ViewerNoteDetails.aspx/getListPending",
                data: "{pageVal:'GetWorkFlowList', pageval1 :'" + noteid + "', pageval2 :''}",
                dataType: "json",
                success: function (Result) {
                    Result = Result.d;
                    document.getElementById("WorkFlowSection").innerHTML = "";
                    var parentSec = document.createElement("section");
                    parentSec.className = "timeline1";

                    var parentDiv = document.createElement("div");
                    parentDiv.className = "container";
                    var sideNum = 1;
                    $.each(Result, function (key, value) {

                        var listOfApprove = value.lst;
                        var workflowList = listOfApprove.split('µ');

                        var tlitemDiv = document.createElement("div");
                        tlitemDiv.className = "timeline-item";
                        var tlimgDiv = document.createElement("div");
                        tlimgDiv.className = "timeline-img";
                        tlimgDiv.innerHTML = workflowList[0];
                        tlitemDiv.appendChild(tlimgDiv);

                        var tlConDiv = document.createElement("div");

                        tlConDiv.className = "timeline-content js--fadeInLeft";

                        var tlConDateDiv = document.createElement("div");
                        tlConDateDiv.className = "wf-date";
                        tlConDateDiv.innerHTML = workflowList[1];

                        var tlConHead = document.createElement("h6");
                        tlConHead.innerHTML = workflowList[2];
                        var tlConHead1 = document.createElement("h7");
                        tlConHead1.setAttribute('style', 'color:#e32bb5;');
                        tlConHead1.innerHTML = workflowList[3];

                        tlConDiv.appendChild(tlConDateDiv);
                        tlConDiv.appendChild(tlConHead);
                        tlConDiv.appendChild(tlConHead1);

                        var tlInChk = document.createElement("input");
                        tlInChk.setAttribute('type', 'checkbox');
                        tlInChk.setAttribute('id', 'post-' + sideNum);
                        tlInChk.className = "read-more-state";
                        tlConDiv.appendChild(tlInChk);

                        var tlConP = document.createElement("p");
                        tlConP.className = "read-more-wrap";
                        var x = workflowList[4];
                        var c = x.split(' ').length;
                        var y = x.split(' ').slice(0, 10).join(' ');
                        var z = x.split(' ').slice(10, c).join(' ');


                        tlConP.innerHTML = y;
                        if (c > 10) {
                            var tlConSpanP = document.createElement("span");
                            tlConSpanP.className = "read-more-target";
                            tlConSpanP.innerHTML = z;
                            tlConP.appendChild(tlConSpanP);
                        }
                        tlConDiv.appendChild(tlConP);
                        if (c > 10) {
                            var tlLbl = document.createElement("label");
                            tlLbl.setAttribute('for', 'post-' + sideNum);
                            tlLbl.className = "read-more-trigger bnt-more";
                            tlConDiv.appendChild(tlLbl);
                        }


                        tlitemDiv.appendChild(tlConDiv);
                        parentDiv.appendChild(tlitemDiv);
                        sideNum = sideNum + 1;

                    });
                    parentSec.appendChild(parentDiv);
                    document.getElementById("WorkFlowSection").appendChild(parentSec);


                },
                error: function (Result) {
                }
            });
        }

        function ContentAprroverFill(noteid) {
            // alert(noteid);
            $.ajax({
                type: "post",
                contentType: "application/json; charset=utf-8",
                url: "ViewerNoteDetails.aspx/getListPending",
                data: "{pageVal:'GetApproversList', pageval1 :'" + noteid + "', pageval2 :''}",
                dataType: "json",
                success: function (Result) {
                    Result = Result.d;

                    document.getElementById("lstApprovers").innerHTML = "";
                    var parentUl = document.createElement("ul");
                    parentUl.className = "multi-steps";

                    $.each(Result, function (key, value) {

                        var listOfApprove = value.lst;
                        var approveList = listOfApprove.split('µ');

                        // create list item for every element --a.order_id,a.approver_name,decode(a.status_id,0,'Recommended',1,'Assigned',2,'Not Assigned',3,'Not Assigned',9,'Rejected') status,to_char(a.received_date,'dd-Mon-yyyy hh:mi:ss am') received_date,to_char(a.updated_date,'dd-Mon-yyyy hh:mi:ss am') updated_date
                        var listItem = document.createElement("li");
                        //debugger;
                        //alert(approveList[5]+approveList[6]);
                        //alert($("[id*=hdUserId]").val());
                        if (approveList[5] == "1" || approveList[5] == "5") {
                            //alert(approveList[6]);
                            listItem.className = "li-bar recommend is-active";
                        }
                        else if (approveList[5] == "3") {
                            listItem.className = "li-bar notrecommend";
                        }
                        else if (approveList[5] == "6") {
                            listItem.className = "li-bar  autoskip";
                        }
                        else {
                            listItem.className = "li-bar recommend";
                        }
                        listItem.setAttribute('data-toggle', 'tooltip');
                        listItem.setAttribute('title', approveList[2]);
                        var lValue = document.createTextNode(approveList[1]);
                        listItem.appendChild(lValue);
                        parentUl.appendChild(listItem);
                    });
                    document.getElementById("lstApprovers").appendChild(parentUl);

                },
                error: function (Result) {
                }
            });
        }

        function noteDelete() {
            var noteid = $("[id*=hdnquerynoteid]").val();
            // alert(noteid);
            Swal.fire({
                title: 'Are you sure?',
                text: 'Please enter reason !',
                type: 'warning',
                input: 'text',
                showCancelButton: true,
                showLoaderOnConfirm: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Yes, delete it!',
                cancelButtonText: 'No, keep it',
                showLoaderOnConfirm: true,
                preConfirm: function (result) {
                    return new Promise(function (resolve, reject) {
                        setTimeout(function () {
                            var Data;
                            var remarks = result;
                            Data = '';
                            Data = noteid + "µ" + $("[id*=hdUserId]").val() + 'µ' + remarks + 'µ' + $("[id*=hdBranchId]").val() + 'µ' + $("[id*=hdFirmId]").val()
                            $.ajax({
                                type: "post",
                                contentType: "application/json; charset=utf-8",
                                url: "ViewerNoteDetails.aspx/NoteDeleteConfirm",
                                data: "{pageVal:'CancelCRFConfirm', pageval1 :'" + Data + "', pageval2 :'', pageval3 :''}",
                                dataType: "json",
                                success: function (Result) {
                                    Result = Result.d;

                                    var msg = Result.split("µ");
                                    var stat = msg[0];
                                    var content = msg[1];
                                    if (stat == "1") {
                                        Swal.fire(
                                            'Deleted!',
                                            content,
                                            'success'
                                        )
                                        window.open('Index.aspx', '_self');
                                    }
                                    else {
                                        Swal.fire(
                                            'Error',
                                            'Not Deleted',
                                            'error'
                                        )
                                    }
                                },
                                error: function (Result) {
                                    Swal.fire(
                                        'Error',
                                        'Not Deleted',
                                        'error'
                                    )
                                }
                            });
                        }, 2000)
                    })
                },
                allowOutsideClick: false
            }).then(function (result) {

            })

        }
        function ModFill() {
            $("#txtMessage").val("");
            $("#ddlToUser").val("-1");
            $('#ddlToUser').val("-1");
            DdlRequestAgnstCRFFill();
        }
        function EnquiryConfirm() {
            var EnqType = "";
            if ($("#ddlToUser").val() == -1) {
                swal.fire("Please Select EnquiryTo User");
                return false;
            }
            if ($("#txtMessage").val() == "") {
                swal.fire("Please Type a Message");
                return false;
            }
            var reqid = $("#ddlCrfReq").val();
            var Enqstatus;
            if ($("#rbDelay").prop("checked")) {
                EnqType = "Delay";
                GetDelayEnqStatus(reqid);
                if (DelayEnq == "YES") {
                    Swal.fire("Delay already Notified..!!");
                    return false;
                }
            }
            else if ($("#rbOther").prop("checked")) {
                EnqType = "Other";
            }

            if ($("#chkConfirm").prop("checked")) {
                Enqstatus = "11";
                var proceed = confirm(' Are you sure you want to Finish this?');
                if (proceed) { } else { return false; }

            }
            else {
                Enqstatus = "00";
            }
            Data = $("[id*=hdnquerynoteid]").val() + 'µ' + $("#ddlCrfReq").val() + 'µ' + $("#txtMessage").val() + 'µ' + $("#ddlToUser").val() + 'µ' + $("[id*=hdUserId]").val() + 'µ' + $('#ddlToUser option:selected').text() + 'µ' + Enqstatus + 'µ' + EnqType;

            $.ajax({
                type: "post",
                contentType: "application/json; charset=utf-8",
                url: "ViewerNoteDetails.aspx/ConfirmEnquiry",
                data: "{pageVal:'EnquiryConfirm', pageval1 :'" + Data + "',pageval2:'',pageval3:'EnquiryTo'}",
                dataType: "json",
                async: false,
                success: function (Result) {
                    $('.block-ui').addClass('clear');
                    Result = Result.d;
                    var noteid = Result;
                    if (noteid.includes("µ")) {
                        var msg = noteid.split("µ");
                        var stat = msg[0];
                        var content = msg[1];
                        if (stat == "9") {
                            dangerAlert(content, 5000);
                            return false;
                        }
                    }
                    if (noteid != "0") {
                        let timerInterval
                        Swal.fire({
                            width: 400,
                            type: 'success',
                            title: 'Success!',
                            html: "Success ",
                            //showConfirmButton: false,
                            allowOutsideClick: false,
                            timer: 10000,
                            onBeforeOpen: () => {
                                //Swal.showLoading()
                                timerInterval = setInterval(() => {
                                    Swal.getContent().querySelector('strong')
                                        .textContent = Swal.getTimerLeft()
                                }, 100)
                            },
                            onClose: () => {
                                clearInterval(timerInterval)
                                EnquiryWorkFlowFill(reqid);
                            }
                        }).then((result) => {
                            if (
                                // Read more about handling dismissals
                                result.dismiss === Swal.DismissReason.timer
                            ) {
                                EnquiryWorkFlowFill(reqid);
                            }
                        })
                    }
                    else {
                        alert("Something went wrong.! Please contact IT support..")
                    }
                }
            });
        }

        function EnquiryWorkFlowFill(noteid) {
            $.ajax({
                type: "post",
                contentType: "application/json; charset=utf-8",
                url: "ViewerNoteDetails.aspx/getListPending",
                data: "{pageVal:'GetEnqWorkFlowList', pageval1 :'" + noteid + "', pageval2 :''}",
                dataType: "json",
                success: function (Result) {
                    Result = Result.d;
                    document.getElementById("WorkFlowSectionPop").innerHTML = "";
                    var parentSec = document.createElement("section");
                    parentSec.className = "timeline1";

                    var parentDiv = document.createElement("div");
                    parentDiv.className = "container";
                    var sideNum = 1;
                    $.each(Result, function (key, value) {

                        var listOfApprove = value.lst;
                        var workflowList = listOfApprove.split('µ');

                        var tlitemDiv = document.createElement("div");
                        tlitemDiv.className = "timeline-item";
                        var tlimgDiv = document.createElement("div");
                        tlimgDiv.className = "timeline-img";
                        tlimgDiv.innerHTML = workflowList[0];
                        tlitemDiv.appendChild(tlimgDiv);

                        var tlConDiv = document.createElement("div");

                        tlConDiv.className = "timeline-content js--fadeInLeft";

                        var tlConDateDiv = document.createElement("div");
                        tlConDateDiv.className = "wf-date";
                        tlConDateDiv.innerHTML = workflowList[1];

                        var tlConHead = document.createElement("h6");
                        tlConHead.innerHTML = workflowList[2];
                        var tlConHead1 = document.createElement("h7");
                        tlConHead1.setAttribute('style', 'color:#e32bb5;');
                        tlConHead1.innerHTML = workflowList[3];

                        tlConDiv.appendChild(tlConDateDiv);
                        tlConDiv.appendChild(tlConHead);
                        tlConDiv.appendChild(tlConHead1);

                        var tlInChk = document.createElement("input");
                        tlInChk.setAttribute('type', 'checkbox');
                        tlInChk.setAttribute('id', 'post-' + sideNum);
                        tlInChk.className = "read-more-state";
                        tlConDiv.appendChild(tlInChk);

                        var tlConP = document.createElement("p");
                        tlConP.className = "read-more-wrap";
                        var x = workflowList[4];
                        var c = x.split(' ').length;
                        var y = x.split(' ').slice(0, 10).join(' ');
                        var z = x.split(' ').slice(10, c).join(' ');


                        tlConP.innerHTML = y;
                        if (c > 10) {
                            var tlConSpanP = document.createElement("span");
                            tlConSpanP.className = "read-more-target";
                            tlConSpanP.innerHTML = z;
                            tlConP.appendChild(tlConSpanP);
                        }
                        tlConDiv.appendChild(tlConP);
                        if (c > 10) {
                            var tlLbl = document.createElement("label");
                            tlLbl.setAttribute('for', 'post-' + sideNum);
                            tlLbl.className = "read-more-trigger bnt-more";
                            tlConDiv.appendChild(tlLbl);
                        }


                        tlitemDiv.appendChild(tlConDiv);
                        parentDiv.appendChild(tlitemDiv);
                        sideNum = sideNum + 1;

                    });
                    parentSec.appendChild(parentDiv);
                    document.getElementById("WorkFlowSectionPop").appendChild(parentSec);


                },
                error: function (Result) {
                }
            });
        }
        function GetEmpStatusView(crfIdStatus) {

            $.ajax({
                type: "post",
                contentType: "application/json; charset=utf-8",
                url: "ViewerNoteDetails.aspx/CheckEmpAccessNew",
                async: false,
                data: "{pageVal:'CheckEmpAccessForEnquiry', pageval1 :'" + $("[id*=hdUserId]").val() + "', pageval2 :'" + crfIdStatus + "'}",
                dataType: "json",
                success: function (Result) {
                    Result = Result.d;
                    EmpStatus = Result;
                    if (EmpStatus == "1") {
                        $("#btnEnQuiry").show();
                    }
                }
            });
        }
        function GetDelayEnqStatus(ReqID) {

            $.ajax({
                type: "post",
                contentType: "application/json; charset=utf-8",
                url: "ViewerNoteDetails.aspx/CheckEmpAccessNew",
                async: false,
                data: "{pageVal:'GetDelayEnqExist', pageval1 :'" + ReqID + "', pageval2 :''}",
                dataType: "json",
                success: function (Result) {
                    Result = Result.d;
                    DelayEnq = Result;


                }
            });
        }


        function DdlEnquiryToFill() {

            var usr = $("[id*=hdUserId]").val() + 'µ' + $("[id*=hdnquerynoteid]").val() + 'µ' + $('#ddlCrfReq').val();
            var reqid = $('#ddlCrfReq').val();

            $('#ddlToUser').empty();
            $.ajax({
                type: "post",
                contentType: "application/json; charset=utf-8",
                url: "ViewerNoteDetails.aspx/getFillData",
                data: "{pageVal:'EnquiryUserFill', pageval1 :'" + usr + "',pageval2 :''}",
                async: false,
                dataType: "json",
                success: function (Result) {
                    Result = Result.d;
                    $('#ddlToUser').append($("<option selected></option>").val("-1").html("Choose Reciever"));
                    $.each(Result, function (key, value) {
                        $('#ddlToUser').append($("<option></option>").val(value.id).html(value.name));
                    });
                }
            });

            if ($('#ddlCrfReq').val() == -1) {
                $("#IdTree").hide();
            }
            else {
                $("#IdTree").show();
                EnquiryWorkFlowFill(reqid)
            }
        }
        function DdlRequestAgnstCRFFill() {
            var usr = $("[id*=hdUserId]").val() + 'µ' + $("[id*=hdnquerynoteid]").val();
            $("#txtMessage").val("");
            $('#ddlCrfReq').empty();
            $.ajax({
                type: "post",
                contentType: "application/json; charset=utf-8",
                url: "ViewerNoteDetails.aspx/getFillData",
                data: "{pageVal:'RquestAgainstCRF', pageval1 :'" + usr + "',pageval2 :''}",
                async: false,
                dataType: "json",
                success: function (Result) {
                    Result = Result.d;
                    $('#ddlCrfReq').append($("<option selected disabled></option>").val("-1").html("Choose Request"));
                    $.each(Result, function (key, value) {
                        $('#ddlCrfReq').append($("<option></option>").val(value.id).html(value.name));
                    });
                }
            });
        }

        function ClearPopUp() {
            $("#IdModTree").hide();
            $('#txtMessage').val("");
            $("#btnReply").val("-1");
            $("#btnSent").hide("-1");

        }

    </script>


    <style>
        .radio-tile-group {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
        }

            .radio-tile-group .input-container {
                position: relative;
                height: 2.5rem;
                width: 9rem;
                margin: 0.5rem;
            }

                .radio-tile-group .input-container .radio-button {
                    opacity: 0;
                    position: absolute;
                    top: 0;
                    left: 0;
                    height: 100%;
                    width: 100%;
                    margin: 0;
                    cursor: pointer;
                }

                .radio-tile-group .input-container .radio-tile {
                    display: flex;
                    flex-direction: column;
                    align-items: center;
                    justify-content: center;
                    /*width: 100%;*/
                    height: 100%;
                    border: 2px solid #079ad9;
                    border-radius: 5px;
                    /*padding: 1rem;*/
                    transition: transform 300ms ease;
                }

                .radio-tile-group .input-container .radio-tile-label {
                    text-align: center;
                    font-size: 0.75rem;
                    font-weight: 400;
                    /*text-transform: uppercase;*/
                    letter-spacing: 1px;
                    color: #079ad9;
                    margin-bottom: 0;
                }

                .radio-tile-group .input-container .radio-tile-i {
                    color: #079ad9;
                }

                .radio-tile-group .input-container .radio-button:checked + .radio-tile {
                    background-color: #079ad9;
                    border: 2px solid #079ad9;
                    color: white;
                    transform: scale(1.1, 1.1);
                }

                    .radio-tile-group .input-container .radio-button:checked + .radio-tile .icon svg {
                        fill: white;
                        background-color: #079ad9;
                    }

                    .radio-tile-group .input-container .radio-button:checked + .radio-tile .radio-tile-label {
                        color: white;
                        background-color: #079ad9;
                    }

                    .radio-tile-group .input-container .radio-button:checked + .radio-tile .radio-tile-i {
                        color: white;
                    }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">





    <form class="form-inline" runat="server" method="post" enctype="multipart/form-data">
        <div class="loaderColorCont">
            <div class="loaderColorCont--dot"></div>
            <div class="loaderColorCont--dot"></div>
            <div class="loaderColorCont--dot"></div>
            <div class="loaderColorCont--dot"></div>
            <div class="loaderColorCont--dot"></div>
            <div class="loaderColorCont--dot"></div>
            <div class="loaderColorCont--text"></div>
        </div>
        <div class="card-body">
            <div class="card-body shadow" style="background: #fff;">
                <div class="row">
                    <div class="col-md-4 text-left font-12">
                        <div class="form-group">
                            <div class="col-md-3" id="sNameDiv">
                            </div>
                            <div class="col-md-9">
                                <strong><span id="lblCreateBy" class="head5 text-primary" style="margin-left: 10px; margin-top: -40px;"></span>
                                    <br />
                                    <span id="lblDepartment" style="margin-left: 10px; margin-top: -40px;" class="head7"></span></strong>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label style="font-size: 14px;">SUBJECT :</label>
                            <span id="lblSubject" class="head5 text-primary"></span>
                        </div>
                    </div>
                    <div class="col-md-2 align-left" style="display: none;" id="btnEnQuiry">
                        <a href="#" class="btn btn-block btn-danger btn-flat" data-target="#ModeModal" data-toggle="modal" onclick="ModFill();" style="width: 100%; margin: 0px;">
                            <i class="fa fa-reply-all"></i>&nbsp;&nbsp;Enquiry&nbsp;&nbsp;<span class=" flashit badge badge-light animation-fadeIn" id="pendCntView">0</span></a>
                    </div>

                </div>
                <hr />
                <div class="row">
                    <div class="col-md-4">
                        <label style="font-size: 14px;">CRF ID :</label>
                        <span id="lblNoteId" class="head5 text-primary"></span>
                        <input type="hidden" name="NoteId" id="hdnNoteId" /><input type="hidden" name="NoteOrderId" id="hdnNoteOrderId" />
                        &nbsp&nbsp&nbsp&nbsp<strong><span class="label label-rounded" id="lblPriority"></span></strong>
                    </div>
                    <div class="col-md-4 font-10">
                        <div class="form-group">
                            <label style="font-size: 14px;">CREATED DATE  : </label>
                            <strong><span id="lblCreateDate" class="font-14 text-primary"></span></strong>
                        </div>
                    </div>

                    <div class="col-md-4 font-10">
                        <div class="form-group">
                            <label style="font-size: 14px;">TECHLEAD :</label>
                            <strong><span id="lblDocType" class="font-14 text-primary"></span></strong>
                        </div>
                    </div>
                </div>
                <br />
                <div class="row">
                    <div class="col-md-6 font-10">
                        <div class="form-group">
                            <label style="font-size: 14px;">DEVELOPER : </label>
                            <strong><span id="lblFirm" class="font-14 text-primary"></span></strong>
                        </div>
                    </div>
                    <div class="col-md-6 font-10">
                        <div class="form-group">
                            <label style="font-size: 14px;">TESTER : </label>
                            <strong><span id="lblTester" class="font-14 text-primary"></span></strong>
                        </div>
                    </div>
                </div>

                <div class="row col-md-2 col-sm-2 col-xs-4" id="showDeleteButton" style="display: none">
                    <a href="#" class="btn btn-block btn-outline-danger btn-flat" style="width: 100%; margin: 0px;"
                        onclick="return noteDelete();" id="showCancelBtn"><i class="fa fa-trash"></i>&nbsp;&nbsp;Delete</a>
                </div>
                <br />
                <div class="row">
                    <div class="col-md-6 font-10">
                        <div class="form-group">
                            <label style="font-size: 14px;">OBJECTIVE : </label>
                            <strong><span id="lblobj" class="font-14 text-primary"></span></strong>
                        </div>
                    </div>

                    <div class="col-md-4 font-10">
                        <div class="form-group">
                            <label style="font-size: 14px;">CRF COST :</label>
                           <strong><span id="costid" class="font-14 text-primary"></span></strong>
                        </div>
                    </div>

                    <div class="col-md-2 p-1 row-sm-4 col-xs-2">
                        <a href="#" class="btn btn-block btn-outline-success btn-flat" style="width: 98%; margin: 0px;"
                            onclick="viewReport();" id="btnSubmit"><i class="fa fa-briefcase"></i>&nbsp;&nbsp;WBS</a>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-6 font-10">
                        <div class="form-group">
                            <label style="font-size: 14px;">IMPACTING MODULE  :</label>
                            <strong><span id="lblimpact" class="font-14 text-primary"></span></strong>
                        </div>
                    </div>

                   <div class="col-md-4 font-10">
                        <div class="form-group">
                            <label style="font-size: 14px;">USER NUMBER :</label>
                           <strong><span id="USERPHNNUM" class="font-14 text-primary"></span></strong>
                        </div>
                    </div>
                    <div class="col-md-2 p-1 row-sm-4 col-xs-2">
                        <a href="#" class="btn btn-block btn-outline-success btn-flat" style="width: 98%; margin: 0px;"
                            onclick="viewBug();" id="btnbug"><i class="fa fa-bug"></i>&nbsp;&nbsp;BugDetails</a>
                    </div>

                </div>

                <div class="row">
                    <div class="col-md-6 font-10">
                        <div class="form-group">
                            <label style="font-size: 14px;">TESTER SUGGESTION  :</label>
                            <strong><span id="lblsuggestion" class="font-14 text-primary"></span></strong>
                        </div>
                    </div>
                      <div class="col-md-4 font-10">
                        <div class="form-group">
                            <label style="font-size: 14px;">CIRCULAR_ID/PAPERLESS_ID :</label>
                           <strong><span id="circularid" class="font-14 text-primary"></span></strong>
                        </div>
                    </div>
                </div>

               <%-- <div class="row">
                    <div class="col-md-6 font-10">
                        <div class="form-group">
                            <label style="font-size: 14px;">CRF COST :</label>
                        </div>
                    </div>
                    <div class="col-md-6 align-left">
                        <div class="form-group">
                            <strong><span id="costid" class="font-14 text-primary"></span></strong>
                        </div>
                    </div>
                </div>--%>
            </div>
            <br />
            <div class="row">
                <div class="col-md-12">
                    <div class="table-responsive">
                        <table class="table1 table-hover" id="tblTarStatus">
                        </table>
                    </div>
                </div>
            </div>
            <div class="animated bounceIn" style="background-color: #e5e5e5;">

                <div class="row">
                    <div class="col-md-12" id="lstApprovers">
                    </div>
                </div>
            </div>



            <div class="card-body shadow">
                <h5 class="modal-title" id="myLargeModalLabel">CRF Content</h5>
                <hr />
                <div class="row">
                    <div class="col-md-12">

                        <div class="summernoteview">
                        </div>
                    </div>
                </div>
            </div>
            <br />
            <div class="card-body shadow">

                <h3 class="panel-title align-left">Attachments</h3>

                <hr />
                <div class="row ">
                    <div class="col-md-6" id="attFiles" style="display: none">
                        <h6 class="modal-title" id="lblFiles">Requirement</h6>
                        <div class="table-responsive">
                            <table class="table1 table-hover" id="tblFiles">
                            </table>
                        </div>
                    </div>
                    <div class="col-md-6" id="testCases" style="display: none">
                        <h6 class="modal-title" id="lblTestCase">Test Cases</h6>
                        <div class="table-responsive">
                            <table class="table1 table-hover" id="tblTestCase">
                            </table>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-6" id="attChange_doc" style="display: none">
                        <h6 class="modal-title" id="lblChange_doc">Change Documents</h6>
                        <div class="table-responsive">
                            <table class="table1 table-hover" id="tblChange_doc">
                            </table>
                        </div>
                    </div>
                    <div class="col-md-6" id="testArtifacts" style="display: none">
                        <h6 class="modal-title" id="lblTestArtifact">Testing Artifacts</h6>
                        <div class="table-responsive">
                            <table class="table1 table-hover" id="tblTestArtifact">
                            </table>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6" id="attReleaseDoc" style="display: none">
                        <h6 class="modal-title" id="lblReleaseDoc">Release Notes</h6>
                        <div class="table-responsive">
                            <table class="table1 table-hover" id="tblReleaseDoc">
                            </table>
                        </div>
                    </div>
                    <div class="col-md-6" id="otherDoc" style="display: none">
                        <h6 class="modal-title" id="lblotherDoc">Other Documents/Approvals</h6>
                        <div class="table-responsive">
                            <table class="table1 table-hover" id="tblotherDoc">
                            </table>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-6" id="testresult" style="display: none">
                        <h6 class="modal-title" id="lbltestresult">TestResult Form</h6>
                        <div class="table-responsive">
                            <table class="table1 table-hover" id="tbltestresult">
                            </table>
                        </div>
                    </div>
                    <div class="col-md-6" id="Testrequestform" style="display: none">
                        <h6 class="modal-title" id="lblTestrqstfrm">Test Request Form </h6>
                        <div class="table-responsive">
                            <table class="table1 table-hover" id="tblTestrqstfrm">
                            </table>
                        </div>
                    </div>
                </div>
                <div class="row">
                     <div class="col-md-6" id="BADoc" style="display: none">
                        <h6 class="modal-title" id="BADocment">BA ATTACHED FILES</h6>
                        <div class="table-responsive">
                            <table class="table1 table-hover" id="BADocments">
                            </table>
                        </div>
                    </div>
                   
                    </div>
                      <%--  code review attachments  --%>
                <div class="row">
                    <div class="col-md-6" id="codeReviewRmkDiv" style="display: none">
                        <h6 class="modal-title" id="hRemarks"> Source Code Review </h6>
                        <div class="table-responsive">
                            <table class="table1 table-hover" id="tblCodeReview">
                            </table>
                        </div>
                    </div>
                </div>

            </div>
            <br />
            <div class="card-body shadow">
                <div class="row" id="taDetails" style="display: none">
                    <div id="devTA" class="panel-group col-md-12 align-center padding-bottom-10px">


                        <h3 class="panel-title align-left">Development TA Details</h3>

                        <hr />
                        <table class="table table-hover align-center " id="tabChange">
                            <tbody>
                            </tbody>
                        </table>

                    </div>
                </div>
            </div>
            <br />
            <div class="card-body shadow">
                <div class="row">

                    <div class="col-md-12" id="test_TA" style="display: none">
                        <h5 class="modal-title" id="lblFdiles">Testing TA Details</h5>
                        <hr />
                        <div class="table-responsive">
                            <table class="table1 table-hover" id="tblTestingTADtls">
                            </table>
                        </div>
                    </div>

                </div>
            </div>
            <br />
            <div class="card-body shadow">
                <div class="row">

                    <div class="col-md-12" id="Devlp_wise">
                        <h5 class="modal-title" id="lblF">Developers Details </h5>
                        <hr />
                        <div class="table-responsive">
                            <table class="table1 table-hover" id="tblDeveloperwise">
                            </table>
                        </div>
                    </div>

                </div>
            </div>

            <br />
            <div class="card-body shadow">
                <h5 class="modal-title" id="lblWrkFlow">Work Flow</h5>
                <hr />
                <div class="row">
                    <div class="col-md-12">
                        <div class="card animated bounceIn" style="background-color: #fff;" id="WorkFlowSection">
                            <section class="timeline1">
                            </section>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Modal -->
            <div id="ModeModal" class="modal fade" role="dialog">
                <div class="modal-dialog">
                    <!-- Modal content-->
                    <div class="modal-content">
                        <div class="modal-header">
                            <div class="row col-md-12">
                                <h4 <%--style="font-size:30%; width:100%;"--%> class="col-md-11 align-left ">Ask Here.!</h4>
                                <div class="col-md-1 col-sm-2 col-xs-4">
                                    <button type="button" class="btn btn-block btn-outline-danger btn-sm" onclick="ClearPopUp();" style="text-align: center;" data-dismiss="modal">x</button>
                                </div>
                            </div>
                        </div>
                        <div class="modal-body">

                            <!-- Main content -->
                            <section class="content">
                                <%--<div class="container-fluid">--%>
                                <%--<div class="row">
                        <div class="col-md-12">--%>
                                <!-- Default box -->
                                <div class="card">
                                    <div class="card-body">
                                        <form role="form">

                                            <div class="row col-md-12" style="padding-bottom: 10px;">
                                                <label class="col-md-2 align-left ">Choose Request</label>
                                                <div class="form-group col-md-4" style="padding-left: 0;">
                                                    <select class="form-control tlead select2" style="width: 100%;" onchange="DdlEnquiryToFill();" id="ddlCrfReq">
                                                    </select>
                                                </div>
                                                <label class="col-md-2 align-left ">Enquiry To</label>

                                                <div class="form-group col-md-4" style="padding-left: 0;">
                                                    <select class="form-control tlead select2" style="width: 102%;" onchange="" id="ddlToUser">
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="row col-md-12" style="padding-bottom: 10px;">
                                                <label class="col-md-2 align-left ">Message</label>
                                                <div class="form-group col-md-10" style="padding-left: 0;">
                                                    <textarea rows="1" cols="" class="form-control" style="width: 100%" name="Remarks" id="txtMessage" title="Remarks" oninput="this.value = this.value.replace(/[^-@.,/#&+\w\s]/g, '');">
                                                </textarea>
                                                </div>
                                            </div>
                                            <div class="row col-md-12" style="padding-bottom: 10px;">
                                                <label class=" col-md-2 align-right">Type of Enquiry </label>
                                                <div class="col-md-2 align-left ">
                                                    <input type="radio" name="rbEnqType" id="rbDelay" /><span style="color: blue"> &nbsp;&nbsp;Delay &nbsp;&nbsp;&nbsp;&nbsp; </span>
                                                    <input type="radio" name="rbEnqType" id="rbOther" /><span style="color: blue"> &nbsp;&nbsp;Other</span>
                                                </div>
                                            </div>

                                            <div class="row col-md-12" style="padding-bottom: 10px;">
                                                <label class="col-md-2 align-left "></label>
                                                <div class="form-group col-md-2" style="padding-left: 0;">
                                                    <button type="button" class="btn btn-block btn-outline-info btn-flat" onclick="return EnquiryConfirm();"><i class="fa  fa-envelope">&nbsp;&nbsp;</i>Sent</button>
                                                </div>
                                                <div class="form-group col-md-2" style="padding-left: 0;">
                                                    <button type="button" class="btn btn-block btn-outline-danger btn-flat" data-dismiss="modal" onclick="return ClearPopUp();">Exit</button>
                                                </div>
                                                <div class="form-group col-md-2" style="padding-left: 0;">
                                                </div>
                                                <div class="form-group col-md-4" style="padding-left: 0;">
                                                    <input class="" type="checkbox" id="chkConfirm" />
                                                    <label for="chkConfirm" class="">&nbsp;&nbsp;Enquiry Fininshed</label>
                                                </div>
                                            </div>
                                        </form>
                                    </div>
                                </div>

                            </section>
                        </div>
                        <div class="modal-footer">
                            <div class="card-body shadow" id="IdTree" style="display: none; padding-bottom: 10px;">
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class=" animated bounceIn" style="background-color: #fff;" id="WorkFlowSectionPop">
                                            <section class="timeline1 card">
                                            </section>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>

        </div>
    </form>



    <input id="hdUserId" type="hidden" runat="server" />
    <input id="hdBranchId" type="hidden" runat="server" />
    <input id="hdFirmId" type="hidden" runat="server" />
    <input id="hdnReturnStatus" type="hidden" runat="server" />
    <input id="hdnAllEmployees" type="hidden" runat="server" />
    <input id="hdnquerynoteid" type="hidden" runat="server" />
    <input id="hdnReqID" type="hidden" runat="server" />
</asp:Content>
