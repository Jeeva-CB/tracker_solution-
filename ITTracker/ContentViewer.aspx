<%@ Page Title="" Language="C#" MasterPageFile="~/PWA_Master.Master" AutoEventWireup="true" CodeBehind="ContentViewer.aspx.cs" Inherits="ITTacker.ContentViewer" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
       <script>
$(document).ready(function() {
    $('.summernote').summernote({
        height: 350, // set editor height
        minHeight: null, // set minimum height of editor
        maxHeight: null, // set maximum height of editor
        focus: false, // set focus to editable area after initializing summernote
        toolbar: [
            //[ 'style', [ 'style' ] ],
            [ 'font', [ 'bold', 'italic', 'underline', 'strikethrough', 'superscript', 'subscript', 'clear'] ],
            [ 'fontname', [ 'fontname' ] ],
            [ 'fontsize', [ 'fontsize' ] ],
            [ 'color', [ 'color' ] ],
            [ 'para', [ 'ol', 'ul', 'paragraph', 'height','hr' ] ],
            ['table', ['table']],
            [ 'insert', ['picture'] ],
            ['view', ['undo', 'redo']]
            //['insert', ['image', 'doc']],
            //['view', ['undo', 'redo']]           
            //['insert', ['link','image', 'doc', 'video']], // image and doc are customized buttons
            //[ 'insert', [ 'link'] ],
            //[ 'view', [ 'undo', 'redo', 'fullscreen', 'codeview', 'help' ] ]
        ],
        popover: {
  image: [
    ['image', ['resizeFull', 'resizeHalf', 'resizeQuarter', 'resizeNone']],
    ['float', ['floatLeft', 'floatRight', 'floatNone']],
    ['remove', ['removeMedia']]
  ],
  table: [
    ['add', ['addRowDown', 'addRowUp', 'addColLeft', 'addColRight']],
    ['delete', ['deleteRow', 'deleteCol', 'deleteTable']],
    ['color'],
  ]
}
    });



    $('.summernoteview').summernote({
        height: 350, // set editor height
        minHeight: null, // set minimum height of editor
        maxHeight: null, // set maximum height of editor
        focus: false, // set focus to editable area after initializing summernote
        toolbar: [
        ]
    });
     $(".summernoteview").summernote("disable");
});
    /************************************/
    //inline-editor
    /************************************/
    $('.inline-editor').summernote({
        airMode: true
    });

    /************************************/
    //edit and save mode
    /************************************/
    window.edit = function() {
            $(".click2edit").summernote()
        },
        window.save = function() {
            $(".click2edit").summernote('destroy');
        }

    var edit = function() {
        $('.click2edit').summernote({ focus: true });
    };

    var save = function() {
        var markup = $('.click2edit').summernote('code');
        $('.click2edit').summernote('destroy');
    };

    /************************************/
    //airmode editor
    /************************************/
    $('.airmode-summer').summernote({
        airMode: true
        });

    function funcMyHtml() {
        //var markup = $('.summernote').summernote('code');
        // alert(markup);

        //var div = document.getElementById('summernoteview');

        //div.innerHTML = markup;
         $.ajax({
        type: "post",
        contentType: "application/json; charset=utf-8",
        url: "ContentViewer.aspx/getRequestNote",
        data: "{pageVal:'GetRequestNotes', pageval1:'1',pageval2:'gsdgdfdfdfdfdfdfdfdfdfdfdfdfdfdfdfdfdfdfdfdf'}",
        dataType: "json",
        success: function (Result) {
            Result = Result.d;
            //alert(Result);
            //Result = Result.d.split("~");
            //$.each(Result, function (key, value) {
            //    // $('#ddlDocType').append($("<option></option>").val(value.id).html(value.name));
            //    alert(value.name);
            //});
             $('.summernote').summernote('code', Result);
        }
        });

        //$('.summernoteview').summernote('code', markup);

       }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
 <div class="row">
<div class="col-md-12">
<div class="form-group">     
<div class="buttonbox"> 
<input id="btnconfirm" type="button" value="Confirm" class="btn-input" onclick="return funcMyHtml();" data-toggle="modal" data-backdrop="false"/>
                           
<input id="btnexit" type="button" value="Exit" class="btn-input" onclick="return funcMyHtml();" data-toggle="modal" data-backdrop="false"/>
</div>
</div>
</div>
</div>
    <div class="row">
                    <div class="col-12">
                        <div class="card">
                            <div class="card-body">
                                <h4 class="card-title"></h4>
                                <div class="summernote">
                                    <h4></h4>
                                </div>
                                
                            </div>
                        </div>
                    </div>
    </div>
<div class="row">
                    <div class="col-12">
                        <div class="card">
                            <div class="card-body">
                                <h4 class="card-title"></h4>
                                <div class="summernoteview">
                                </div>
                                
                            </div>
                        </div>
                    </div>
    </div>
</asp:Content>
