<?php  $a = date("d-m-y", time());  $b = date("G:i:s", time());   $timeDate = $a." ".$b;  $goingOutText = $_POST['txtDescription']; $privateChatID = $_POST['txtUsername']; $getUName = 'kjblue'; $con=mysqli_connect("localhost","root","root","bluechat"); if (mysqli_connect_errno()) { echo "Failed to connect to MySQL: " . mysqli_connect_error();}    $sql="INSERT INTO userMessages (msgUserID, msgText, msgPrivate, msgPrivateMsgID ) VALUES ('".$getUName."','".$goingOutText."','Yes','".$privateChatID."')"   if (!mysqli_query($con,$sql)){ die('Error: ' . mysqli_error($con)); } mysqli_close($con); echo 'something'; ?>