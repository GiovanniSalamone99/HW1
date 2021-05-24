<?php
include 'auth.php';
if (!checkAuth()) {
    header('Location: index.php');
    exit;
}
    header('Content-Type: application/json');
    $conn=mysqli_connect("localhost","root","","fantacalcio2");
    $id=$_SESSION["log"];
    $id_squadra=$_POST["id"];
    $query="DELETE FROM squadra WHERE fantallenatore = '$id' AND cod_s = '$id_squadra'";
    $res= mysqli_query($conn,$query) or die(mysqli_error($conn));;
    $eliminata = array();
    if($res) {
        $eliminata[] = array('ok' => true);
    }else{
        $eliminata[] = array('ok' => false);
    }
    echo json_encode($eliminata);
    mysqli_close($conn);
?>