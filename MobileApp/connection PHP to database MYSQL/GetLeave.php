<?php
 
// Importing DatabaseConfig.php file.
include 'DatabaseConfig.php';
 
// Creating MySQL Connection.
 $con = mysqli_connect($HostName, $HostUser, $HostPass, $DatabaseName);
 
 // Getting the received ID in JSON Format into $json variable.
 $json = file_get_contents('php://input');
 
 // Decoding the received JSON.
 $obj = json_decode($json,true);
 
 // Populate ID from JSON $obj array and store into $ID variable.
 $ID = $obj['id'];
 
 //Fetching the selected record as per ID.
 $CheckSQL = "SELECT leaves.leave_id, leaves.user_id, leaves.leave_type_id, leaves.start_date, leaves.end_date, leave_type.leave_type_name, leaves.no_day FROM leaves INNER JOIN leave_type ON leaves.leave_type_id = leave_type.leave_type_id WHERE leaves.leave_id = '$ID'";
 
 $result = $con->query($CheckSQL);
 
if ($result->num_rows >0) {
 
 while($row[] = $result->fetch_assoc()) {
 
 $Item = $row;
 
 $json = json_encode($Item, JSON_NUMERIC_CHECK);
 
 }
 
}else {
	
 echo "No Results Found.";
 
}
 
echo $json;
 
$con->close();
?>