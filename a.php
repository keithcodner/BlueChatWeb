<?php

//echo "beep";
    
$con=mysqli_connect("localhost","root","root","bluechat");
			// Check connection
			if (mysqli_connect_errno())
			  {
			  echo "Failed to connect to MySQL: " . mysqli_connect_error();
			  }

$result = mysqli_query($con,"SELECT  GROUP_CONCAT(msgtext ORDER BY msgid ASC SEPARATOR '~') FROM usermessages WHERE msguserid = 'rford'; ");
#""
#SELECT username FROM users WHERE uid = '1';
while($row = mysqli_fetch_array($result))
			  {
			  	echo $row[0];
			  }
			  mysqli_close($con);
			  

			  
?>