<?php
$uid = $_POST['txtDel'];


$con=mysqli_connect("localhost","root","megaman","bluechat");
		// Check connection
		if (mysqli_connect_errno())
		  {
		  echo "Failed to connect to MySQL: " . mysqli_connect_error();
		  }

		$sql="DELETE FROM users WHERE uid = '".$uid."'; ";

		if (!mysqli_query($con,$sql))
		  {
		  die('Error: ' . mysqli_error($con));
		  }
	//	echo "";

		mysqli_close($con);


		   echo "<b>1 record removed!</b>"; 

?>