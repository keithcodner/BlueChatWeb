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
		        refreshTable();
		    });

		    function refreshTable() {
		        $('#tableHolder').load('a.php', function () {
		            setTimeout(refreshTable, 1000);
		        });
		    }

		</script>

		<script>
		    $(function () {
		        //insert a row
		        $("#btnInsert").submit(function (event) {
		            event.preventDefault();
		            $("#test").html('');
		            var values = $(this).serialize();


		            $.ajax({
		                url: "insert.php",
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
		<div>

		<form id="btnInsert">		
		Username: <input id="txtUsername" name="txtUsername" type="text" /><br />
		Password: <input id="txtPassword" name="txtPassword" type="password" /><br />
		Description: <input id="txtDescription" name="txtDescription" type="text" /><br />
		<input id="btn" type="submit" value="Insert" /><br />
		</form>

		<form id="btnDelete">	
		ID: <input id="txtDel" name="txtDel" type="text" style="width:30px;" />
		&nbsp; <input id="btnDel" type="submit" value="Delete" /><br />
		</form>

		</div><br />


			<div id="test"> </div>
			<div id="tableHolder"></div>


			
	</body>
</html>
