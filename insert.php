<?php
$username = $_POST['txtUsername'];
$pass = $_POST['txtPassword'];
$desc = $_POST['txtDescription'];

$con=mysqli_connect("localhost","root","megaman","bluechat");
		// Check connection
		if (mysqli_connect_errno())
		  {
		  echo "Failed to connect to MySQL: " . mysqli_connect_error();
		  }

		$sql="INSERT INTO users (username, password, description)
		VALUES
		('".$username."','".$pass."','".$desc."')";

		if (!mysqli_query($con,$sql))
		  {
		  die('Error: ' . mysqli_error($con));
		  }
	//	echo "";

		mysqli_close($con);


		   echo "<b>1 record added!</b>"; 

?>