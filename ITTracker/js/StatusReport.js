function grT() {
    //alert("Hii");
    $('#example').find('tr').click(function () {
        var row = $(this).find('td:eq(0)').text();
        //alert(row);
        //if (row != "") {
        //    var TaskId = row;
        //    window.location = "TaskAssigning.aspx?TaskId=" + TaskId + "=" + 2
        //} else {
        //    Swal.fire('Please create task first')
        //}
        $('#example').removeEventListener();
    });
}