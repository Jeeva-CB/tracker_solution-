function autocomplete(inp, arr, hiddenVariable, ShowValVariable) {
   

    var currentFocus;

    if (arr.length > 0) {
        var a, b, i, val;
        val = document.getElementById('' + inp + '').value
        closeAllLists();
        if (!val) { return false; }
        currentFocus = -1;
        a = document.createElement("DIV");
        a.setAttribute("id", inp + "autocomplete-list");
        a.setAttribute("class", "autocomplete-items");
        document.getElementById('' + inp + '').parentNode.appendChild(a);

        for (i = 0; i < arr.length; i++) {
            /*check if the item starts with the same letters as the text field value:*/
            //if (arr[i].split("ʒ")[1].substr(0, val.length).toUpperCase() == val.toUpperCase()) {
            /*create a DIV element for each matching element:*/
            b = document.createElement("DIV");
            b.setAttribute("class", "task-style");
            /*make the matching letters bold:*/
            //b.innerHTML = "<strong>" + arr[i].split("ʒ")[1].substr(0, val.length) + "</strong>";
            //b.innerHTML += arr[i].split("ʒ")[1].substr(val.length);
            b.innerHTML = arr[i].split("ʒ")[0];
            /*insert a input field that will hold the current array item's value:*/
            b.innerHTML += "<input type='hidden' value='" + arr[i].split("ʒ")[0] + "'>";
            b.innerHTML += "<input type='hidden' value='" + arr[i].split("ʒ")[1] + "'>";

            // alert(arr[i].split("ʒ")[0]);
            // alert(arr[i].split("ʒ")[1]);
            /*execute a function when someone clicks on the item value (DIV element):*/
            b.addEventListener("click", function (e) {
                /*insert the value for the autocomplete text field:*/



                document.getElementById('' + inp + '').value = this.getElementsByTagName("input")[0].value;
                //alert(this.getElementsByTagName("input")[0].value);
                $("[id*=work_id]").val((this.getElementsByTagName("input")[1].value + '~' + this.getElementsByTagName("input")[0].value));
                //document.getElementById('' + hiddenVariable + '').value = this.getElementsByTagName("input")[1].value;
                $("[id*=" + hiddenVariable + "]").val(this.getElementsByTagName("input")[0].value);
                document.getElementById('' + ShowValVariable + '').innerHTML = this.getElementsByTagName("input")[0].value;
                $("[id*=work_id]").val(this.getElementsByTagName("input")[1].value);
                /*close the list of autocompleted values,
                (or any other open lists of autocompleted values:*/
                closeAllLists();
            });
            a.appendChild(b);
            //}
        }
    } else {
        closeAllLists();
        $("[id*=" + hiddenVariable + "]").val("");
        $("[id*=work_id]").val("");
    }
    /*execute a function presses a key on the keyboard:*/
    document.getElementById('' + inp + '').addEventListener("keydown", function (e) {

        var x = document.getElementById(inp + "autocomplete-list");
        if (x) x = x.getElementsByTagName("div");
        if (e.keyCode == 40) {
            /*If the arrow DOWN key is pressed,
            increase the currentFocus variable:*/
            currentFocus++;
            /*and and make the current item more visible:*/
            addActive(x);
        } else if (e.keyCode == 38) { //up
            /*If the arrow UP key is pressed,
            decrease the currentFocus variable:*/
            currentFocus--;
            /*and and make the current item more visible:*/
            addActive(x);
        } else if (e.keyCode == 13) {
            /*If the ENTER key is pressed, prevent the form from being submitted,*/
            e.preventDefault();
            if (currentFocus > -1) {
                /*and simulate a click on the "active" item:*/
                if (x) x[currentFocus].click();
            }
        } else if (e.keyCode == 8 || e.keyCode == 46) {
            document.getElementById('' + hiddenVariable + '').value = "";
        }
    });
    function addActive(x) {
        /*a function to classify an item as "active":*/
        if (!x) return false;
        /*start by removing the "active" class on all items:*/
        removeActive(x);
        if (currentFocus >= x.length) currentFocus = 0;
        if (currentFocus < 0) currentFocus = (x.length - 1);
        /*add class "autocomplete-active":*/
        x[currentFocus].classList.add("autocomplete-active");
    }
    function removeActive(x) {
        /*a function to remove the "active" class from all autocomplete items:*/
        for (var i = 0; i < x.length; i++) {
            x[i].classList.remove("autocomplete-active");
        }
    }
    function closeAllLists(elmnt) {

        /*close all autocomplete lists in the document,
        except the one passed as an argument:*/
        var x = document.getElementsByClassName("autocomplete-items");
        for (var i = 0; i < x.length; i++) {
            if (elmnt != x[i] && elmnt != inp) {
                x[i].parentNode.removeChild(x[i]);
            }
        }
    }
    /*execute a function when someone clicks in the document:*/
    document.addEventListener("click", function (e) {
        closeAllLists(e.target);
    });
    $("[id*=" + hiddenVariable + "]").val("");
}


function LoadingDataAutoComplete(ControlID, SearchKey, SrchStringLen, hiddenVariable, QueryFlag, QueryID, ShowValue) {
   
    var ArrayList = [];
   // ShowValue = $("[id*=Hddepart]").val();
    
    if (SearchKey.length >= SrchStringLen) {
        alert("2");
        alert(ControlID);
        alert(SearchKey);
        alert(ShowValue);
        alert(QueryFlag);
        alert(QueryID);

        $.ajax({
            type: "post",
            contentType: "application/json; charset=utf-8",
            url: "ServiceAutoComplete.asmx/GetGateSearchData",
            data: "{SearchKey:'" + SearchKey + "',QueryFlag:'" + QueryFlag + "',QueryID:'" + QueryID + "',dep:'" + ShowValue + "'}",
            dataType: "json",
            async:false,
            success: function (Result) {
                alert("1");
                ArrayList = Result.d;
                autocomplete(ControlID, ArrayList, hiddenVariable, ShowValue);
               // alert("in ajax sucess");
            },
            error: function (Result) {
                alert(Result.d);
                alert('in error partt');
            }
        });
    } else if (SearchKey.length == 0) {
        ArrayList = [];
        autocomplete(ControlID, ArrayList, hiddenVariable, ShowValue);
    }

}

