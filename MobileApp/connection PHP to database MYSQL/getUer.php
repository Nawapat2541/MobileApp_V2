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
 //  $ID = $obj['id'];
 
 //Fetching the selected record as per ID.
 $CheckSQL = "SELECT id FROM `user`";
 
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