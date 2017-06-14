<%@ Page Language="C#" AutoEventWireup="true" CodeFile="tests.aspx.cs" Inherits="tests" %>

<!DOCTYPE html>


<html>
	<head>
		<title>Test of local storage and lists</title>
		<script src="js/jquery-1.9.1.js"></script>
		<script src="js/jquery-ui.js"></script>
		<script src="js/jquery.min.js"></script>

		<script>
		    $(document).ready(function () {
		    	
		    	 $.ajaxSetup ({cache: false });
		        refreshTable();

		        	$("#Button1").click(function (){

		        		var gotT = $("#txt1").val();

		        		sendStringViaPost(gotT, "window4");

		        	});

		    });

		    function refreshTable() {
		        $('#tableHolder').load('data.php', function () {
		            setTimeout(refreshTable, 1000);
		        });
		    }

		</script>

		<script>

		function sendStringViaPost(dataStr, windID)
            {
                    this.dataStr = dataStr;
                    this.windID = windID;

                    var goingOutTextToServ = this.dataStr;
                    var gotWindID = this.windID;
                    var getCurrentUserName = 'kjblue';
                    var getPrivateChatID = 'kjblue-mdice';

                    var path = '../users/'+ getCurrentUserName+'/insertData/'+gotWindID+'.php';

                    $.ajax({
                    type: 'POST',
                    url: '../users/'+ getCurrentUserName+'/insertData/'+gotWindID+'.php',
                    data: { 
                        'goOutText': goingOutTextToServ, 
                         'PMID' : getPrivateChatID,
                    },
                    success: function(msg){
                        alert('wow' + msg);
                    }
                });

            }


		    $(function () {
		        //insert a row
		        $("#btnInsert").submit(function (event) {
		            event.preventDefault();
		            $("#test").html('');
		            var values = $(this).serialize();


		            $.ajax({
		                url: "window4.php",
		                type: "post",
		                data: values,
		                success: function () {
		                    // alert("success");
		                    $("#test").html('Submitted successfully');
		                },
		                error: function () {
		                    // alert("failure");
		                    $("#test").html('There is error while submit');
		                }
		            });
		            $("#txtUsername").val('');
		            $("#txtPassword").val('');
		            $("#txtDescription").val('');

		        });

		        // delete a row
		        $("#btnDelete").submit(function (event) {
		            event.preventDefault();
		            $("#test").html('');
		            var values = $(this).serialize();


		            $.ajax({
		                url: "delete.php",
		                type: "post",
		                data: values,
		                success: function () {
		                    // alert("success");
		                    $("#test").html('Submitted successfully');
		                },
		                error: function () {
		                    // alert("failure");
		                    $("#test").html('There is error while submit');
		                }
		            });
		            $("#txtDel").val('');
		        });

		    });
		</script>

	</head>
	<body>
        <form id="form2" runat="server">

              <asp:Button ID="Button1" runat="server" Text="Button"  onclick="Button1_Click"/>
            <asp:Label ID="Label1" runat="server" Text=""></asp:Label>
            <asp:TextBox ID="txt1" runat="server" Text=""></asp:TextBox>
            <asp:HiddenField  ID="lbl3" runat="server" />
         </form>


		<form id="form1" >
		<div>

		Username: <input id="txtUsername" name="txtUsername" value = "kjblue-mdice" type="text" /><br />
		Password: <input id="txtPassword" name="txtPassword" type="password" /><br />
		Description: <input id="txtDescription" name="txtDescription" type="text" /><br />
		<input id="btn" type="submit" value="Insert" /><br />
		ID: <input id="txtDel" name="txtDel" type="text" style="width:30px;" />
		&nbsp; <input id="btnDel" type="submit" value="Delete" /><br />

		  
		</div><br />


			<div id="test"> </div>
			<div id="tableHolder"></div>


			
	    </form>


			
	</body>
</html>
