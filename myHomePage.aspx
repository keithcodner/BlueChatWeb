<%@ Page Language="C#" AutoEventWireup="true" CodeFile="myHomePage.aspx.cs" Inherits="myHomePage" EnableEventValidation="false"  %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server"> <link rel="shortcut icon" href="img/bcl.ico" />
    <title>Blue Chat Messenger [Online]</title>

    <script src="js/jquery.min.js"></script>
    <link rel="stylesheet" href="css/jquery-ui.css" />
    <script src="js/jquery-1.9.1.js"></script>
    <script src="js/jquery-ui.js"></script>
    <link rel="stylesheet" href="css/style.css" />
    

    <style>
        #abc:hover {
            background-color: #AEFFFD;
        }
        #userJoined {
            color:#0CED5B;
        }
         .footer
        {
            color: #000000;
            text-align: center;
            font-size: 90%;
        }
          .segoe
        {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
    </style>

    <script type="text/javascript">

    
      /*function oooVerified()
        {
            var items = sessionStorage.getItem('oooVerfiedVar');
            if ((sessionStorage.oooVerfiedVar == "NaN") || (items === null) || (items.length === 0)) {
                sessionStorage.oooVerfiedVar = "true";
            }
            else
            {
                sessionStorage.oooVerfiedVar = "true";
            }
        } */

        function storeRequesterName()
        {
            var items = sessionStorage.getItem('RequesterName');
            if ((sessionStorage.RequesterName == "NaN") || (items === null) || (items.length === 0)) {
                sessionStorage.RequesterName = $('#<%=requesterName.ClientID%>').text(); 
                sessionStorage.RequestedName = "";
            }
            else
            {
                sessionStorage.RequesterName = $('#<%=requesterName.ClientID%>').text(); 
                sessionStorage.RequestedName = "";
            }
        }

        function storeRequestedName()
        {
            var items = sessionStorage.getItem('RequestedName');
            if ((sessionStorage.RequestedName == "NaN") || (items === null) || (items.length === 0)) {
                sessionStorage.RequestedName = $('#<%=requestedName.ClientID%>').text();  
                sessionStorage.RequesterName = "";
            }
            else {
                sessionStorage.RequestedName = $('#<%=requestedName.ClientID%>').text();  
                sessionStorage.RequesterName = "";
            }

        }

        function busyUser() {

            alert("This user is busy please try again in a couple seconds.");
        };


        Sys.WebForms.PageRequestManager.getInstance().add_endRequest(InIEvent);
        $("#Div7").hide();
        $("#Div7").toggle();
        
    </script>
    <script>



        $(function () {
            $("#newChatWindow").draggable();
            $("#notification").draggable();
            $("#chatRoomsIMG").css('cursor', 'pointer');
            $("#privateRoomsIMG").css('cursor', 'pointer');

            var checkingTheAlert = $('#<%=checkingAlert.ClientID%>').text();

            //alert(checkingTheAlert.toString());
            //alert(checkingTheAlert);
            if (checkingTheAlert == "true") {
               // alert("asdsadasdd");

                if ($("#notification").is(":visible")) {
                    $("#notification").show("slide");
                    $("#notification").draggable();
                }
                else {
                    $("#notification").hide();
                    $("#notification").show("slide");
                    $("#notification").draggable();
                }

            }
            else {
                $("#notification").hide();
                $("#notification").draggable();
            }

            
            $("#notification").draggable();
        });
    </script>
    <script>

        function sameUser()
        {
            alert("Sorry, but you can't chat with yourself!");

        }


        function createChatWindow() {
          //  $("#newChatWindow").show();

        }

        function dragChatwindow() {
            $(function () {
                $("#notification").draggable();


            });
            

        }

        function focusHandler()
        {
            $(function () {

                if (true) {

                }

            });
        }
        </script>
    <!--****************TEXT GENERATOR HERE*********-->
    <script>
        function getTextGeneratorTwo() {
            $(function () {
                $("#getAllText").hide();
                $("#Label1").hide();
                $("#BtnOne").hide();


            });

            var dumpAllPrivateTextFromDB = $('#<%=getAllMyPrivateText.ClientID%>').text();  


            if (sessionStorage.g != dumpAllPrivateTextFromDB) {

                //sound for incoming message
                var myMP3 = document.getElementById("Mp3Me");
                myMP3.play();
                document.title = 'You have new messages!';
                document.title = 'Blue Chat Messenger [Online]';
                document.title = 'You have new messages!';
                document.title = 'Blue Chat Messenger [Online]';
                document.title = 'You have new messages!';
                
                //make the if statement true
                sessionStorage.g = dumpAllPrivateTextFromDB;
            }

            var stringToArrayTwo = new Array;
            stringToArrayTwo = dumpAllPrivateTextFromDB.split("~");

            var indexTwo;
            for (indexTwo = 0; indexTwo < stringToArrayTwo.length; ++indexTwo) {
                // alert(stringToArray[index]);

                //var txt1 = "<b>" + getUsername + ": </b>"
                //add the user and the user text and  combine it. while putting everything into a new div
                var txt2Two = $("<div ID='abc' ></div>").html(stringToArrayTwo[indexTwo].replace("{}", "<b>").replace("{{", "</b>").replace("{@}", "<i ID='userJoined'>").replace("{@@}", "</i>"));
                //nest the new div inside the div with the  id of 'container'

                $("#OOOContainer").append(txt2Two);


                //resets the text box to nothing
                $("#OOOMsg").val("");
                //sets focus to the textbox again
               // $("#OOOMsg").focus();

                //makes sure the scroll bar goes alll the way to the bottom of the div
                var objDiv = document.getElementById("OOOContainer");
                objDiv.scrollTop = objDiv.scrollHeight;
            }

        }


        function getTextGenerator() {
            $(function () {
                $("#getAllText").hide();
                $("#Label1").hide();
                $("#BtnOne").hide();

                
            });


            //get values from db though c# so they can be obtained by javascript to be manipulated
            var getUsername = $('#<%=welcomeName.ClientID%>').text();
            var dumpAllTextFromDB = $('#<%=getAllText.ClientID%>').text();
            //var dumpAllPrivateTextFromDB = $('#<%=getAllMyPrivateText.ClientID%>').text();  


            if (sessionStorage.e != dumpAllTextFromDB) {

                    //sound for incoming message
                    var myMP3 = document.getElementById("Mp3Me");
                    myMP3.play();
                    document.title = 'You have new messages!';
                    document.title = 'Blue Chat Messenger [Online]';
                    document.title = 'You have new messages!';
                    document.title = 'Blue Chat Messenger [Online]';
                    document.title = 'You have new messages!';
                
                    
                    //make the if statement true
                    sessionStorage.e = dumpAllTextFromDB;
                }
            
            

            //make a new javascript array and then split it and then test via alert
            var stringToArray = new Array;
            stringToArray = dumpAllTextFromDB.split("~");

            var index;
            for (index = 0; index < stringToArray.length; ++index) {
               // alert(stringToArray[index]);

                //var txt1 = "<b>" + getUsername + ": </b>"
                //add the user and the user text and  combine it. while putting everything into a new div
                var txt2 = $("<div ID='abc' ></div>").html(stringToArray[index].replace("{}", "<b>").replace("{{", "</b>").replace("{@}", "<i ID='userJoined'>").replace("{@@}", "</i>"));
                //nest the new div inside the div with the  id of 'container'

              

                $("#container").append(txt2);


                //resets the text box to nothing
                $("#msgUserText").val("");
                //sets focus to the textbox again
               // $("#msgUserText").focus();

                //makes sure the scroll bar goes alll the way to the bottom of the div
                var objDiv = document.getElementById("container");
                objDiv.scrollTop = objDiv.scrollHeight;
            }


            if (getUsername.length != 0) {
                //nothing for now

            }

            // var refreshId = setInterval(getTextGenerator, 3000);

        }

        function hideNotificationShowChat()
        {
            $("#notification").hide("slide");
            $("#newChatWindow").show();
        }
    </script>
    <script>
        function getDraggableDivAttr() {
            $(document).ready(function () {
               


            });
        }
    </script>
    <script>


        //better way to save the location of the new chat window
        $(function () {

            //load the location of the newchat window position via local storage
            $("#newChatWindow").css("top", sessionStorage.topVar );
            $("#newChatWindow").css("left", sessionStorage.leftVar );

            //focus handling via local storage
            if (sessionStorage.trueOrFalseStatement == "true") {
                $("#OOOMsg").focus();
            }
            if (sessionStorage.trueOrFalseStatement == "false") {
                $("#msgUserText").focus();
            }

            //*********for sounds**********
            $("#Div7").click(function () {

               

            });



            if (typeof (Storage) !== "undefined") {


                //////////////////////////////////////////
                ////////////////////////////////////////
                $("#OOOMsg").click(function () {

                    sessionStorage.trueOrFalseStatement = "true";

                });

                $("#msgUserText").click(function () {

                    sessionStorage.trueOrFalseStatement = "false";

                });

                $("#newChatWindow").click(function () {

                    sessionStorage.topVar = $("#newChatWindow")[0].style.top;
                    sessionStorage.leftVar = $("#newChatWindow")[0].style.left;

                   
                    //alert(getTop.replace("px", ""));

                });


            }
            else {
                document.getElementById("result").innerHTML = "Sorry, your browser does not support web storage...";
            }

        });        
    </script>
    <script>
        //****************PRIVATE ROOMS********************
        $(function () {
            $("#menu").menu().hide();


            function showRooms() {
                //$("#icon").hide();
                $("#menu").toggle("blind");
            }

            $("#privateRooms1").click(function () {

                showRooms();
            });


            $('#privateRooms').click(function (event) {
                event.stopPropagation();
            });

            $('html').click(function () {
                $("#privateRooms1").show();
                $('#menu').hide("blind");

            });

        });
    </script>
    <!--********Private MSG ID Array checker********-->
    <script>
        function inArray(array, el) {
            for (var i = array.length; i--;) {
                if (array[i] === el)
                {
                    return true;
                } 
            }
            return false;
        }

        function validateOOOChat()
        {
            var user1 = inArray(array, el);
            var user1 = inArray(array, el);
        }
    </script>
    <script>
        //**********LOCAL ROOMS*********************
        $(function () {
            $("#menu1").menu().hide();


            function showRooms() {
                //$("#icon").hide();
                $("#menu1").toggle("blind");
                sessionStorage.clear();
            }

            $("#chatRooms1").click(function () {

                showRooms();

            });


            $('#chatRooms').click(function (event) {
                event.stopPropagation();
            });

            $('html').click(function () {
                $("#chatRooms1").show();
                $('#menu1').hide("blind");
                $('#menu').hide("blind");
            });

        });
    </script>
    <!--*****************WINDOW GENERATION/CREATION/REQUESTING TO SERVER*********-->
    <script>
        /* * * * * * * * * * * ** * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 
         * 1.Stop the working on the fuction for creating the new windows the only thing that should be added to that *
         * function is the list for the window deletion/positioning of the windows when loaded                        *
         * 2.Next i neeed to work on the window deletion, then the window positioning in that order because one will  *
         * indeed lead to the other. So for the deletion, the algirithm will be  to to caputure the string and then   *
         * to split it into the array, then use the list from the window creation to match whats in the array and ethe*
         * delete the array for somehow modify the entire string(idk), then contact the string back toghter.          *
         * 3. the window positioning, will have to be done by the same as number 2 but the every time the string of   *
         * chat windows is loaded, it will create script or use the prior window created script LS values to and match*
         * them within the window string somehow, most likely usubg the id list via window creation.and again         *
         *4.when the window doesnt exist, remove thieir variables from local storage                                  *
         *       **DO NOT MODIFY THE NEW WIDNOW CREATION FUNTION, ITS ONLY PURPOSE IS TO CREATE WINDOWS!!!!!!**       *
         *                                                                                                            *
        */
        //*************create a new window dynamically, with functionality*****************************
        //*************************8###########*****test when page loads*******8################***************************
        $(function () {
            loadSavedWindow();
            
            init();
        });


        function init()
        {

            var curNumID = sessionStorage.storeNextID;

            var items = window.sessionStorage.getItem('tempWind');

            if ((sessionStorage.tempWind == "NaN") || items === null || items.length === 0) {

                sessionStorage.tempWind = "window1";
            }
            else {
                sessionStorage.tempWind = "window" + curNumID;

            }

            $('#<%= hiddenWindowTemp.ClientID %>').val("" + sessionStorage.tempWind + "," + sessionStorage.requestedName + sessionStorage.requesterName + "");
        }

        //maximum windows allowed is 5
            function myFunction() {
                              
                //
                var items = window.sessionStorage.getItem('storeNextID');

                if ((sessionStorage.storeNextID == "NaN") || items === null || items.length === 0) {
                    sessionStorage.storeNextID = 1;
                    newWind("blah", sessionStorage.storeNextID);

                   
                   //  var z = $('#<%= hiddenWindowTemp.ClientID %>').val();
                   // alert(z);
                   // sessionStorage.tempWind ="";

                }
                else {
                    var somevar = (sessionStorage.saveWindowString.split("*").length - 1);
                    if (somevar >= 4) {
                        alert("You have exceeded the number of chat windows allowed, please close atleast one to talk to someone different. Thank You!");
                    }
                    else {
                        newWind("blah", sessionStorage.storeNextID);
                   
                    }
                }
            }

            //get windows and credentials from local storage/ database when the page loads
            function loadSavedWindow()
            {
                var gotWindowString = sessionStorage.saveWindowString;

                // alert(gotWindowString);
                $("#form1").append(gotWindowString);

                //adjust positioning of each window by looping through number getting the highest id by local storage
                var topval = sessionStorage.storeNextID;
                for (var i = 0; i < topval; i++) {
                    $("#window" + i).css("top", sessionStorage.getItem('topwindow'+ i ));
                    $("#window" + i).css("left", sessionStorage.getItem('leftwindow' + i));
                }
               
            }
          
            //close the window
            function closeChatWind()
            {
                //get the window string
                var getWindowText = sessionStorage.saveWindowString;
                //split it into an array
                var splitWindowsArray = getWindowText.split('*');
                //search the array for the index with string, while also getting the right variable from LS
                var i;

                for (i = 0; i < splitWindowsArray.length; ++i) {
                    var textOfEachElement = splitWindowsArray[i];
                    var numberOfCharsTillID = textOfEachElement.search(sessionStorage.getNameForDeletion);

                    if (numberOfCharsTillID > 500) {
                        sessionStorage.thisIsTheElementForDeletion = i;

                    }
                }
                //delete the selected array element
                splitWindowsArray.splice(sessionStorage.thisIsTheElementForDeletion, 1);
                
                //put array back into string
                var windowsArrayBackToString = splitWindowsArray.join("*");
               // alert(windowsArrayBackToString);
                //update the saveWindowString in local storage
                sessionStorage.saveWindowString = windowsArrayBackToString;

            }

            function loadWindowToString() {

                //get value from local storage
                var items = window.sessionStorage.getItem('windString');

                if ((sessionStorage.windString == "NaN") || items === null)
                {
                    sessionStorage.windString = ",,,,,";
                }
                else
                {

                    var getWindString = sessionStorage.windString;



                    //get both arrays
                    var getWindStringArray = getWindString.split(",");
                    var isItPastMaxWindAllowed = false;

                    if ((getWindStringArray[0] != "") && (getWindStringArray[1] != "") && (getWindStringArray[2] != "") && (getWindStringArray[3] != "") && (getWindStringArray[4] != "") && (getWindStringArray[5] != "")) {
                        //alert("You need to close a window to talk to someone else!");
                    }
                    else {
                        isItPastMaxWindAllowed = true;
                    }

                    if (isItPastMaxWindAllowed === true) {
                        $('#<%= lbl1.ClientID %>').val("" + getWindStringArray[0] + "");
                        $('#<%= lbl2.ClientID %>').val("" + getWindStringArray[1] + "");
                        $('#<%= lbl3.ClientID %>').val("" + getWindStringArray[2] + "");
                        $('#<%= lbl4.ClientID %>').val("" + getWindStringArray[3] + "");
                        $('#<%= lbl5.ClientID %>').val("" + getWindStringArray[4] + "");
                        $('#<%= lbl6.ClientID %>').val("" + getWindStringArray[5] + "");

                    }
                }
                    //match arrays 
            }


                function saveGoingOutText(gotText)
                {
                    this.gotText =gotText;

                    var items = window.sessionStorage.getItem('goingOutText');

                    if ((sessionStorage.goingOutText == "NaN") || items === null || items.length === 0)
                    {
                        sessionStorage.goingOutText = gotText;
                        //alert("blah");
                    }
                    else
                    {
                        sessionStorage.goingOutText = gotText;
                       // alert("blah");
                    }
                }
           
                function stringWindowChecker(windowID) {
                    this.windowID = windowID;

                    var jqLbl1 = $('#<%= lbl1.ClientID %>').val();
                    var jqLbl2 = $('#<%= lbl2.ClientID %>').val();
                    var jqLbl3 = $('#<%= lbl3.ClientID %>').val();
                    var jqLbl4 = $('#<%= lbl4.ClientID %>').val();
                    var jqLbl5 = $('#<%= lbl5.ClientID %>').val();
                    var jqLbl6 = $('#<%= lbl6.ClientID %>').val();

                var assignWind = [jqLbl1, jqLbl2, jqLbl3, jqLbl4, jqLbl5, jqLbl6];
                var a;

                for (var item in assignWind) {
                    if (assignWind[item] == "") {

                        a = assignWind.indexOf(assignWind[item])
                        sessionStorage.windowStringEl = a;

                        //alert(a);
                        break;
                    }
                    
                }
                
                assignWind[a] = windowID;
                sessionStorage.windString = assignWind;

                }

                function getTextAreaID()
                {
                    var gotTAID = sessionStorage.gotCurrentTextArea;
                    gotTAID = gotTAID.replace("textArea", "");
                    //alert(gotTAID);
                    $('#<%= getTextAreaID.ClientID %>').text("" + gotTAID + "");
                    
                }

        function occurrences(string, subString, allowOverlapping) {

            string += ""; subString += "";
            if (subString.length <= 0) return string.length + 1;

            var n = 0, pos = 0;
            var step = (allowOverlapping) ? (1) : (subString.length);

            while (true) {
                pos = string.indexOf(subString, pos);
                if (pos >= 0) { n++; pos += step; } else break;
            }
            return (n);
        }

                function sendTextToServer()
                {
                    var windNUm = sessionStorage.gotCurrWindow;
                    var getWindID = sessionStorage.windString;
                    var splitGetWindID = getWindID.split(",");

                    for (var i in splitGetWindID) {
                        
                        //search if the split string contains the window id
                        if (splitGetWindID[i].indexOf(windNUm) !== -1) {

                            splitGetWindID[i] = windNUm + "~" + sessionStorage.goingOutText;
                            //get the index number of the element
                            var a = splitGetWindID.indexOf(splitGetWindID[i])
                           //alert(a);


                            $('#<%= lbl1.ClientID %>').val("");
                            $('#<%= lbl2.ClientID %>').val("");
                            $('#<%= lbl3.ClientID %>').val("");
                            $('#<%= lbl4.ClientID %>').val("");
                            $('#<%= lbl5.ClientID %>').val("");
                            $('#<%= lbl6.ClientID %>').val("");

                           // alert(splitGetWindID[0]);

                            if (a == "0")
                            {
                                $('#<%= lbl1.ClientID %>').val("" + splitGetWindID[0] + "");
                               
                                $("#ImageButton2").click();

                                // alert(bc);
                               // alert(splitGetWindID[0]);
                            }
                            else if (a == "1")
                            {
                                $('#<%= lbl2.ClientID %>').val("" + splitGetWindID[1] + "");
                                $("#ImageButton2").click();
                               // alert($('#<%= lbl2.ClientID %>').text());
                              //  alert(splitGetWindID[1]);
                            }
                            else if (a == "2")
                            {
                                $('#<%= lbl3.ClientID %>').val("" + splitGetWindID[2] + "");
                                $("#ImageButton2").click();
                             //   alert(splitGetWindID[2]);
                            }
                            else if (a == "3")
                            {
                                $('#<%= lbl4.ClientID %>').val("" + splitGetWindID[3] + "");
                                $("#ImageButton2").click();
                             //   alert(splitGetWindID[3]);
                            }
                            else if (a == "4")
                            {
                                $('#<%= lbl5.ClientID %>').val("" + splitGetWindID[4] + "");
                                $("#ImageButton2").click();
                              //  alert(splitGetWindID[4]);
                            }
                            else if (a == "5")
                            {
                                $('#<%= lbl6.ClientID %>').val("" + splitGetWindID[5] + "");
                                $("#ImageButton2").click();
                               // alert(splitGetWindID[5]);
                            }
                            else
                            {
                                alert("No text was sent to server");
                            }


                           
                            sessionStorage.windString = splitGetWindID;

                            
                                break;
                           
                          
                        }

                    }

                   

                }


            function sendStringViaPost(dataStr, windID)
            {
                    this.dataStr = dataStr;
                    this.windID = windID;

                    var goingOutTextToServ = this.dataStr;
                    var gotWindID = this.windID;
                    var getCurrentUserName = $('#<%=welcomeName.ClientID%>').val();
                    var getPrivateChatID = $('#<%=privateChatIDHF.ClientID%>').val();

                    var path = '../users/'+ getCurrentUserName+'/insertData/'+gotWindID+'.php';

                    $.ajax({
                    type: 'POST',
                    url: path,
                    data: { 
                        'goOutText': goingOutTextToServ, 
                         'PMID' : getPrivateChatID,
                    },
                    success: function(msg){
                        alert('wow' + msg);
                    }
                });

            }


            //create a new window, get proper credentials, store in local storage
            function newWind(partnerName, windNumID) {
               
                
                if (sessionStorage.storeNextID == "NaN")
                {
                    sessionStorage.storeNextID = 1;
                    var getCurrNumTwo = 0;
                }
                else
                {
                    
                    ////////////////////////////////////////////////
                    ///// VARIABLE DECLARATIONS
                        //get the current id from LS(local storage)
                        var curNumID = sessionStorage.storeNextID;

                        //create the id
                        var windowIDS = "window" + curNumID;
                        var lsLeftName = "left"+windowIDS;
                        var lsTopName = "top" + windowIDS;
                        

                       //checks to see which string streams are available
                    // this must be placed before the load window string
                        loadWindowToString();
                        stringWindowChecker("" + windowIDS + "");
                        
                                         

                        var leftty;
                        var toppy;

                        var leftItems = window.sessionStorage.getItem("left" + windowIDS);
                        var topItems = window.sessionStorage.getItem("top" + windowIDS);

                        if (leftItems === null || leftItems.length === 0 || topItems === null || topItems.length === 0) {

                            leftty = "645px";
                            toppy = "41px";

                        }
                        else {
                            leftty = sessionStorage.getItem("left" + windowIDS);
                            toppy = sessionStorage.getItem("top" + windowIDS);
                            
                        }
                        init();
                        

                        //sessionStorage.tempWind = windowIDS;
                        var getCurrentUserName = $('#<%=welcomeName.ClientID%>').text();
                    //some injecting
                        var ta = "<script> " + "  $(document).ready(function(){ $.ajaxSetup ({cache: false }); " + windowIDS + "refreshTable(); });  function " + windowIDS + "refreshTable(){ $('#" + windowIDS + "Hidden').load('../users/"+ getCurrentUserName+"/userData/"+windowIDS+".php', function(){ setTimeout(" + windowIDS + "refreshTable, 3000); }); var m =  $('#" + windowIDS + "Hidden').text(); localStorage.gotMahText = m; var getHFT = localStorage.gotMahText;  var splitHFT = getHFT.split('~'); $('#OOOContainer" + windowIDS + "').empty(); for (var i  in splitHFT) { var txt2Two = $(\"<div></div>\").html(splitHFT[i]);  $('#OOOContainer" + windowIDS + "').append(txt2Two); var objDiv = document.getElementById('OOOContainer" + windowIDS + "'); objDiv.scrollTop = objDiv.scrollHeight; };}"



                           + "   $('#textArea" + windowIDS + "').click(function(){ sessionStorage.gotCurrentTextArea = 'textArea" + windowIDS + "'; sessionStorage.gotCurrWindow = '" + windowIDS + "';  }); " +


                            //stuff that happens when the text area text and key 'enter' are pressed
                            //Note: initially was going to use c# but now am switching to ajax request
                            "  $('#textArea" + windowIDS + "').keyup(function(event){  if(event.keyCode == 13){   var gotText = $('textarea#textArea" + windowIDS + "').val();  sessionStorage.goingOutText = gotText;    $('textarea#textArea" + windowIDS + "').val(''); sendStringViaPost(sessionStorage.goingOutText, " + windowIDS + ");  } });            " +

                            //sendTextToServer();


                            "      $('#close" + windowIDS + "').click(function () { var getLSWindow = sessionStorage.getItem('" + windowIDS + "'); var splitGetLSWindow = getLSWindow.split(\",\");  var ElementToDel = splitGetLSWindow[2]; var getWindString = sessionStorage.getItem('windString');   var splitGetWindString = getWindString.split(\",\");  splitGetWindString[ElementToDel] = '';  sessionStorage.windString = splitGetWindString;  sessionStorage.getNameForDeletion = 'close" + windowIDS + "'; closeChatWind(); setTimeout(function () {$('#" + windowIDS + "').hide();  sessionStorage.removeItem('" + windowIDS + "'); sessionStorage.removeItem('top" + windowIDS + "'); sessionStorage.removeItem('left" + windowIDS + "'); }, 0);    }); </scr" + "ipt> " + //end of script tag
                            
                            //create form with hidden field for text..this is also a test
                            "<form id='" + windowIDS + "Form'><input type='hidden' id='" + windowIDS + "Hidden' value=''  /></form>"

                       + "<div  style=\"position: absolute; z-index: 10; top: 172px; left: 4px; width: 408px; height: 79px;\">  <textarea id='textArea" + windowIDS + "' cols='48' rows='5' Style='resize: none; width:407; height:75;' ></textarea></div><div id='banner' title='Give an extra click to save the position.' style='background-color: #0000FF; height: 23px; font-family: \"Segoe UI\", Tahoma, Geneva, Verdana, sans-serif; '><div class='segoe'><font color='white'>" + windowIDS + " - You are now chatting with " + sessionStorage.RequestedName + sessionStorage.RequesterName + "</font></div></div><div ID='close" + windowIDS + "' class='ui-widget-content' style='z-index: 200; border:0; width: 0px; height: 0px;  position: absolute; top: 8px; left: 380px;' ><img src='img/close.png' alt='Close' width='27' height='28'></div><div id='OOOContainer" + windowIDS + "' style='position: absolute; font-family: \"Segoe UI\", Tahoma, Geneva, Verdana, sans-serif; width: 403px; height: 139px; overflow-y: scroll; overflow-x: hidden;  top: 33px; left: 12px; z-index: 10'>   </div>";

                        var preMeta = "<div ID='" + windowIDS + "' class='ui-widget-content' style='z-index: 200; width: 405px; height: 250px; padding: 0.5em; position: absolute; top: 41px; left: 645px;' ></div>"
                        
                        var taAndPreMetaCombo = "<script>$(function () { $('#" + windowIDS + "').draggable();   if (typeof (Storage) !== 'undefined') { $('#" + windowIDS + "').click(function () { sessionStorage.setItem('top" + windowIDS + "', $('#" + windowIDS + "')[0].style.top); sessionStorage.setItem('left" + windowIDS + "', $('#" + windowIDS + "')[0].style.left); }); }else{sessionStorage.top" + windowIDS + " = '41px'; sessionStorage.left" + windowIDS + " = '645px';} }); </scr" + "ipt> <div ID='" + windowIDS + "' class='ui-widget-content' style='z-index: 200; width: 405px; height: 250px; padding: 0.5em; position: absolute; top: " + toppy + "; left: " + leftty + ";' > " + ta + "</div> *";

                        //create the div
                        var metaWindow = $(preMeta).html(ta);

                        //append the div to the form 
                         $("#form1").append(metaWindow);

                        //make the window dragable
                        $("#" + windowIDS + "").draggable();                

                        //keep track of the window name and associated information
                        sessionStorage.setItem("" + windowIDS + "", "" + sessionStorage.RequestedName + sessionStorage.RequesterName + ',' + windowIDS + ',' + sessionStorage.windowStringEl + "");

                       //append the windows
                        if (sessionStorage.saveWindowString == "NaN") {

                            sessionStorage.saveWindowString = taAndPreMetaCombo;
                        }
                        else
                        {
                            var prevSavedWindowString = sessionStorage.saveWindowString;
                            sessionStorage.saveWindowString = prevSavedWindowString + taAndPreMetaCombo;
    
                        }

                    //should be done last, updating local storage with a new id                       
                        var nextWindowNumID = windNumID;
                        nextWindowNumID++;
                        sessionStorage.storeNextID = nextWindowNumID;
                        
                }

            }

    </script>

    <script>
        
</script>


  <style>
  .ui-menu { width: 150px; }
  </style>


</head>
<body onload="getTextGenerator(); getTextGeneratorTwo();" style="background-color:#C2F0FF;"   > <!--  style="background-color:#C2F0FF;" for the body -->
    <form id="form1"  runat="server">

        <!---->
        <!--<div id="blockScreen" runat="server"  style="background-color: #000000; z-index:100; left: 13px; top: 13px;  width: 477px; height: 199px;"></div>-->

        <div>

            <div id="Div6" style="position: absolute; left: 13px; top: 13px; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; width: 376px; height: 56px; z-index: 3">
               <asp:Label ID="Label3" runat="server" Text="Welcome" Font-Size="X-Large"></asp:Label>
                <asp:Label ID="welcomeName" runat="server" Font-Size="X-Large" Font-Bold="True"></asp:Label>,
                
                <asp:ImageButton ID="ImageButton1" runat="server" OnClick="logoutBtn_Click1"   ImageUrl="~/img/lob.png" Height="33px" Width="74px" />
                <asp:ImageButton ID="ImageButton2" runat="server" OnClick="thisTest_Click"   ImageUrl="~/img/white.PNG" Height="33px" Width="74px"   />
               
                 <asp:Label ID="test12" runat="server" Text=""></asp:Label>


            </div>
             <div id="Div10" style="  z-index: 3; float: none; left: 200px; width: 443px;">
               <br />
                <asp:Image ID="Image1" runat="server" ImageUrl="~/img/bclogo-lounge.png" Width="1000px" /><!--    -->
               
                    </div>

            <div id="Div7"  runat="server" style="position: absolute; left: 31px; top: 284px; width: 223px; height: 241px; z-index: 3; display:none;">
                <audio id="Mp3Me" >
               
                <source src="sound/blop.mp3" />
                </audio>
                <br />
                <asp:ScriptManager ID="ScriptManager1" runat="server">
                </asp:ScriptManager>

                <asp:TextBox ID="TextBox3" runat="server"></asp:TextBox>

                <asp:Button ID="Button2" runat="server" OnClick="Button2_Click" Text="Button" />
                <asp:Button ID="Button3" runat="server" Text="extra" OnClientClick="appendText()" />
                <asp:Button ID="testbutton" runat="server" Text="Button" OnClientClick="getTextGenerator()" />
                <asp:Button ID="BtnOne" runat="server" Text="" OnClick="BtnOne_Click1" />
                <asp:Button ID="BtnTwo" runat="server" Text="" OnClick="BtnTwo_Click2" />
                <asp:Button ID="thisisATest" runat="server" Text="" style="display:none;" OnClick="thisTest_Click" />

                <asp:Label ID="rl" runat="server" Text="Label" Visible="true"></asp:Label>
                <asp:Label ID="Label1" runat="server" Text="Label" ForeColor="White"></asp:Label>


                <asp:Timer ID="Timer2" runat="server" Interval="10000000" OnTick="Timer2_Tick">
                </asp:Timer>

                <asp:Button ID="anotherButton" runat="server" Text="tef" OnClick="anotherButton_Click" />

            </div>

        </div>


        <input type="hidden" id="topValue" runat="server" name="topVal" value="" />
        <input type="hidden" id="leftValue" runat="server" name="leftVal" value="" />
        <input type="hidden" id="sadsad" runat="server" name="leftVal" value="" />
        
        
                <div id="newChatWindow"  class="ui-widget-content" runat="server" style="z-index: 9; width: 405px; height: 250px; padding: 0.5em; position: absolute; top: 41px; left: 645px;">
                     <div id="closeBtnDib" runat="server" style="position: absolute;  width: 27px; height: 28px;  top: 8px; left: 387px; z-index: 40" >
                        <asp:ImageButton ID="closeBtn" runat="server" OnClick="Button4_Click" ImageUrl="~/img/close.png" Style="float: right;" Width="28px" />
                        </div>
                    <asp:UpdatePanel ID="OOOUP"  runat="server" UpdateMode="Conditional">
            

            <ContentTemplate>


                <div id="banner" title="Give an extra click to save the position." style="background-color: #0000FF; height: 23px; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; ">
                        <asp:Label ID="Label2" runat="server" Text="You are now chatting with " ForeColor="White" ></asp:Label>
                        <asp:Label ID="getEndUserName" runat="server" ForeColor="White" ></asp:Label>
                        
                    </div>
                    <br />

                    <div id="OOOContainer" runat="server" style="position: absolute; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; width: 403px; height: 139px; overflow: auto; top: 33px; left: 12px; z-index: 10">
                        

                    </div>

                   

                <asp:Timer ID="Timer3" runat="server" Interval="3500" OnTick="Timer3_Tick" ></asp:Timer>
                <div id="Div2" style="position: absolute; left: -574px; top: 498px; width: 31px; height: 24px; z-index: 3; display:none;">
                <asp:Button ID="privateChatBtn" runat="server" Text="Button" Height="1px" OnClick="privateChatBtn_Click1" Width="1px" />
                    </div>
                 </ContentTemplate>
        </asp:UpdatePanel>
               

            <div id="oneOnOneMsg" style="position: absolute; z-index: 10; top: 182px; left: 4px; width: 408px; height: 79px;">
                        <asp:TextBox ID="OOOMsg" runat="server" Height="75px" TextMode="MultiLine" Width="407px" Style="resize: none;" onkeydown="if(event.keyCode == 13) document.getElementById('privateChatBtn').click()"></asp:TextBox>

                        &nbsp;&nbsp;&nbsp;
                

                    </div>
         </div>

        <asp:UpdatePanel ID="UpdatePanel2" style="position: absolute; left: 269px; top: 113px; width: 765px; height: 507px; z-index: 3"
            runat="server" UpdateMode="Conditional">

            <ContentTemplate>


                <asp:Timer ID="Timer1" runat="server" Interval="3500" OnTick="Timer1_Tick">
                </asp:Timer>

                <asp:Label ID="sum" runat="server" Text=""></asp:Label>
                <div id="notification" class="ui-widget-content" runat="server" style="position: absolute; bottom:214px; width: 340px; height: 122px; z-index: 20; left: 288px; background-color: #000080; color: #FFFFFF;">
                   
                    <div id="Div8" style="position: absolute; bottom:15px; width: 272px; height: 88px; z-index: 21; left: 41px; background-color: #000080; color: #FFFFFF; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;">
                        <asp:Label ID="alertName" runat="server" Text=""></asp:Label> wants to private chat with you!
                        <br /><br />
                        <div id="Div9" style="position: absolute; bottom:10px; width: 171px; height: 35px; z-index: 22; left: 55px; background-color: #000080; color: #FFFFFF;">

                    <asp:Button ID="acceptAlert" runat="server" Text="Accept" OnClick="alternantAcceptAlert_Click" />
                            &nbsp; <asp:Button ID="declineAlert" runat="server" Text="Decline" OnClick="declineAlert_Click" /></div>
                        &nbsp; </div>
                    
                     </div>
                <div id="Div1" style="position: absolute; left: 75px; bottom: 0px; width: 765px; height: 507px; z-index: 1">





                    <div id="Div4" style="position: absolute; left: 6px; top: 109px; width: 129px; height: 363px; z-index: 3; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;">
                        User's in Chat: <asp:Label ID="beep" runat="server" ForeColor="White"  > </asp:Label> <br />
                        <asp:ListBox ID="getContacts" runat="server" Height="298px" Width="120px" style="font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; " OnSelectedIndexChanged="getContacts_SelectedIndexChanged" ViewStateMode="Enabled"></asp:ListBox>
                    </div>


                    <asp:Label ID="test" runat="server" Text="" style = "display:none"></asp:Label>


                    <asp:Label ID="getAllText" runat="server" ForeColor="White" style = "display:none" > </asp:Label>
                    <asp:Label ID="getAllMyPrivateText" runat="server" ForeColor="White" style = "display:none" ></asp:Label>
                    <asp:Label ID="checkingAlert" runat="server" ForeColor="White" style = "display:none" ></asp:Label>

                    <!-- -->
                    
                    <asp:HiddenField  ID="lbl1" runat="server" />
                    <asp:HiddenField  ID="lbl2" runat="server" />
                    <asp:HiddenField  ID="lbl3" runat="server" />
                    <asp:HiddenField  ID="lbl4" runat="server" />
                    <asp:HiddenField  ID="lbl5" runat="server" />
                    <asp:HiddenField  ID="lbl6" runat="server" />
                    <asp:HiddenField  ID="hiddenWindowTemp" runat="server" />
                    <asp:HiddenField  ID="privateChatIDHF" runat="server" />
                    <asp:Label ID="getTextAreaID" runat="server" Text="" style = "display:none" ></asp:Label>

                </div>
                <div id="container" runat="server" style="position: absolute; background-color:white; border: solid; border-color: inherit; border-width: 1px; width: 553px; height: 199px; overflow-y: scroll; overflow-x: hidden; top: 133px; left: 213px; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; z-index: 8"></div>


                <asp:Label ID="requestedName" runat="server" Text="Label" Style="display:none;"></asp:Label>
                <asp:Label ID="requesterName" runat="server" Text="Label" Style="display:none;"></asp:Label>

            </ContentTemplate>
        </asp:UpdatePanel>

        <div id="Div3" style="position: absolute; left: 485px; top: 457px; width: 416px; height: 93px; z-index: 3; ">
            <asp:TextBox ID="msgUserText" runat="server" Height="75px" TextMode="MultiLine" Width="546px" Style="resize: none;" onkeydown="if(event.keyCode == 13) document.getElementById('Button1').click()"></asp:TextBox>

            <div id="Div5" style="position: absolute; left: -458px; top: 79px; width: 32px; height: 30px; z-index: 3; display:none;">
                <asp:Button ID="Button1" runat="server" Height="1px" Text="Send" Width="1px" OnClick="Button1_Click" OnClientClick="getDraggableDivAttr()" />
            </div>

        </div>
        <br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br />
        <br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br />
        

        <div class="footer" style="background-color: #000000; opacity:0.4; color: #FFFFFF;">
		<marquee>Announcements go here.</marquee>
        </div>
        <div class="footer">
		KJBlue BlueChat Messenger © 2013 · All rights reserved.
        </div>

        <div id="chatRooms"  style="position: absolute; left: 1035px; top: 320px; width: 1px; height: 1px; z-index: 5; ">
           
             <table>
                <tr>
                        <td> 
                            <div id="chatRooms1">
                                <asp:Image ID="privateRoomsIMG" title="Create or Join a public chat room." runat="server" ImageUrl="~/img/earth.png" Height="91px" Width="90px" />
                            </div>
                        </td>

                        <td>
                              <div id="Div12">
		                         <div id="myMenu1"> 
				                        <ul id="menu1">
				                          <li><a href="#">• Create a Room.</a></li>
				                          <li><a href="#">• See what's available.►</a>
                                              <ul>
					                          <li><a href="#">Prev</a></li>
					                          <li><a href="#">Stop</a></li>
					                          <li><a href="#">Play</a></li>
					                          <li><a href="#">Next</a></li>
					                        </ul>

				                          </li>
				                        
				                      <!--    <li class="ui-state-disabled">Print...</li> -->
				                         
				                        </ul>
		                        </div>
	                         </div>  

                        </td>
                </tr>
            </table>

            </div>
        <div id="Div13"  style="position: absolute; left: 45px; top: 253px; width: 81px; height: 44px; z-index: 5;">
            

          <!--  <asp:Button ID="cnw" runat="server" Text="create new window" OnClientClick="myFunction()" OnClick="multiChatClick_Click1" /> -->
            </div>

        <div id="privateRooms"  style="position: absolute; left: 1035px; top: 230px; width: 1px; height: 1px; z-index: 5;">
            
            <table style="width: 286px">
                <tr>
                        <td> 
                            <div id="privateRooms1">
                                <asp:Image ID="chatRoomsIMG" title="Make or Join a private chat room." runat="server" ImageUrl="~/img/people.jpg" Height="91px" Width="90px" />
                            </div>
                        </td>
                       
                    
                     <td>
                            <div id="Div11">
		                         <div id="myMenu"> 
				                        <ul id="menu">
				                          <li><a href="#">Save</a></li>
				                          <li><a href="#">Zoom In</a></li>
				                          <li><a href="#">Zoom Out</a></li>
				                          
				                          <li>
					                        <a href="#">Playback</a>
					                        <ul>
					                          <li><a href="#">Prev</a></li>
					                          <li><a href="#">Stop</a></li>
					                          <li><a href="#">Play</a></li>
					                          <li><a href="#">Next</a></li>
					                        </ul>
				                          </li>
				                        </ul>
		                        </div>
	                         </div>

                        </td>
                </tr>
            </table>
           
            </div>

    </form>
    
  <!--
      //reference

      <div id="Div12">
		                         <div id="myMenu1"> 
				                        <ul id="menu1">
				                          <li><a href="#">Save</a></li>
				                          <li><a href="#">Zoom In</a></li>
				                          <li><a href="#">Zoom Out</a></li>
				                        <li class="ui-state-disabled">Print...</li> 
				                          <li>
					                        <a href="#">Playback &nbsp;&nbsp;►</a>
					                        <ul>
					                          <li><a href="#">Prev</a></li>
					                          <li><a href="#">Stop</a></li>
					                          <li><a href="#">Play</a></li>
					                          <li><a href="#">Next</a></li>
					                        </ul>
				                          </li>
				                        </ul>
		                        </div>
	                         </div>  
      -->

</body>
</html>
