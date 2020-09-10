<?php
    include 'DatabaseConfig.php';
    $conn = new mysqli($HostName, $HostUser, $HostPass, $DatabaseName);
    
    if ($conn->connect_error) {
 
        die("Connection failed: " . $conn->connect_error);
    } 
    
    $json = file_get_contents('php://input');
    $obj = json_decode($json,true);

    $id = $obj['id'];
    $ip = $obj['ip'];
    $userAgent = $obj['userAgent'];
    $Agent = $obj['Agent'];
    $datetime = $obj['datetime'];
    $work_hour_type = $obj['work_hour_type'];
    $workinghours = $obj['workinghours'];

    $query = "INSERT INTO work_hours(work_hours_id,work_hours_type,work_hours_time_work,user_agent,ip_address,user_create,time_create,workinghours) 
    VALUES( (SELECT MAX( work_hours_id )+1 FROM work_hours wh),'$work_hour_type','$datetime','$userAgent','$ip','$id','$datetime','$workinghours')";
    $results= $conn->query($query);
    //if($conn->query($query) === TRUE)
    if($results>0)
    {
        $checkinSuccess = "Checkin Success";
        $SuccessMSG = json_encode($checkinSuccess);
        echo $SuccessMSG ; 
    }
    else
    {
        $InvalidMSG = 'Checkin Fail' ;
		$InvalidMSGJSon = json_encode($InvalidMSG);
		 
		// Echo the message.
		 echo $InvalidMSGJSon ;
    }
    $conn->close();
?>