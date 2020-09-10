<?php
include 'DatabaseConfig.php';
 
// Creating connection
	$conn = new mysqli($HostName, $HostUser, $HostPass, $DatabaseName);
 
if ($conn->connect_error) {
 
	die("Connection failed: " . $conn->connect_error);
} 


	$json = file_get_contents('php://input');
	
	// Decoding the received JSON.
	$obj = json_decode($json,true);

	// Populate ID from JSON $obj array and store into $ID variable.
	$ID = $obj['id'];
	$begin =  $obj['dt_start'];
	$end =  $obj['dt_end'];
	// $begin = new DateTime('dt_start');
	// $begin = $begin->format('Y-m-d'); 
	// $end = new DateTime('dt_end');
	// $end = $end->format('Y-m-d'); 
 
	// Creating SQL command to fetch all records from Student_Data Table.
	// $sql = "SELECT expense_id,user_id,amount FROM expense WHERE user_id='$ID' ORDER BY expense.expense_id DESC";
    $sql = "SELECT expense_id,user_id,dt_start,dt_end,amount FROM expense WHERE (dt_start AND dt_end BETWEEN  '$begin' AND  '$end') 
				AND (user_id='$ID') ORDER BY expense.expense_id DESC";

	$result = $conn->query($sql);
 
if ($result->num_rows >0) {
 
	 while($row[] = $result->fetch_assoc()) {
	 
	 $item = $row;
	 
	 $json = json_encode($item, JSON_NUMERIC_CHECK);

 }
 
} else {
	echo "No Data Found.";
}
echo $json;
$conn->close();

?>