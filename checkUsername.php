<?php
     
    header('Content-Type: application/json');
    $conn=mysqli_connect("localhost","root","","fantacalcio2");
    $username=mysqli_real_escape_string($conn,$_GET["username"]);
    $query = "SELECT username FROM fantallenatore WHERE username = '$username'";
    $res = mysqli_query($conn, $query) or die(mysqli_error($conn));;
    $array = array();
    if (mysqli_num_rows($res) > 0){
        $array[] = array('username' => true);
     }else{
        $array[] = array('username' => false);
     }
     echo json_encode($array);
     mysqli_close($conn);
?>