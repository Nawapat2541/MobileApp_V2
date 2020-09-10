<?php
include 'DatabaseConfig.php';
 
// Creating connection
	$conn = new mysqli($HostName, $HostUser, $HostPass, $DatabaseName);
 
if ($conn->connect_error) {
 
	die("Connection failed: " . $conn->connect_error);
} 
 
	// Creating SQL command to fetch all records from Student_Data Table.
	$sql = "SELECT expense_id,user_id,amount FROM expense ORDER BY expense.expense_id DESC LIMIT 200";
	 
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