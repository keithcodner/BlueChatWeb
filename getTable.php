<?php
			$con=mysqli_connect("localhost","root","root","bluechat");
			// Check connection
			if (mysqli_connect_errno())
			  {
			  echo "Failed to connect to MySQL: " . mysqli_connect_error();
			  }

			$result = mysqli_query($con,"SELECT userid, uusername, upassword, uemail FROM users ");

			echo "<table border='1'>
			<tr>
			<th>ID</th>
			<th>Username</th>
			<th>Password</th>
			<th>Email</th>
			</tr>";

			while($row = mysqli_fetch_array($result))
			  {
			  echo "<tr>";
			  echo "<td>" . $row['userid'] . "</td>";
			  echo "<td>" . $row['uusername'] . "</td>";
			  echo "<td>" . $row['upassword'] . "</td>";
			  echo "<td>" . $row['uemail'] . "</td>";
			  echo "</tr>";
			  }
			echo "</table>";

			mysqli_close($con);
			?>