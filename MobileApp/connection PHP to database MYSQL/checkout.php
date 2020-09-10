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
    $datetime = $obj['datetime'];
    $work_hour_type = $obj['work_hour_type'];

    $query = "INSERT INTO work_hours(work_hours_id,work_hours_type,work_hours_time_work,user_agent,ip_address,user_create,time_create,workinghours) 
    VALUES((SELECT MAX( work_hours_id )+1 FROM work_hours wh),'$work_hour_type','$datetime','$userAgent','$ip','$id','$datetime',(SELECT TIMEDIFF('$datetime',(SELECT work_hours_time_work FROM work_hours whs WHERE user_create = 'apichat.s' AND work_hours_type = '1' ORDER BY work_hours_id DESC LIMIT 1))))";
    $results= $conn->query($query);

    //if($conn->query($query) === TRUE)
    if($results>0)
    {
        $checkinSuccess = "Checkout Success";
        $SuccessMSG = json_encode($checkinSuccess);
        echo $SuccessMSG ; 
    }
    else
    {
        $InvalidMSG = 'Checkout Fail' ;
		$InvalidMSGJSon = json_encode($InvalidMSG);
		 
		// Echo the message.
		 echo $InvalidMSGJSon ;
    }
    $conn->close();
?>