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
	$begin =  $obj['start_date'];
	$end =  $obj['end_date'];
	// $begin = new DateTime('dt_start');
	// $begin = $begin->format('Y-m-d'); 
	// $end = new DateTime('dt_end');
	// $end = $end->format('Y-m-d'); 
 
	// Creating SQL command to fetch all records from Student_Data Table.
	// $sql = "SELECT expense_id,user_id,amount FROM expense WHERE user_id='$ID' ORDER BY expense.expense_id DESC";
    /* $sql = "SELECT leave_id,user_id,start_date,end_date 
			FROM leaves 
			WHERE (start_date AND end_date BETWEEN  '$begin' AND  '$end') 
			AND (user_id='$ID') ORDER BY leaves.leave_id DESC"; */
	// $sql = "SELECT leaves.leave_id, leaves.user_id, leaves.leave_type_id, leaves.start_date, leaves.end_date, leave_type.leave_type_name FROM leaves INNER JOIN leave_type ON leaves.leave_type_id = leave_type.leave_type_id WHERE (start_date AND end_date BETWEEN '$begin' AND '$end') AND (user_id='$ID') ORDER BY leaves.leave_id DESC";
	$sql = "SELECT leaves.leave_id, leaves.user_id, leaves.leave_type_id, leaves.start_date, leaves.end_date, leave_type.leave_type_name FROM leaves INNER JOIN leave_type ON leaves.leave_type_id = leave_type.leave_type_id WHERE (start_date AND end_date BETWEEN '2019-01-01' AND '2019-12-01') AND (user_id='apisit.s') ORDER BY leaves.leave_id DESC";
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