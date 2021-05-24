<?php
include 'auth.php';
if (!checkAuth()) {
    header('Location: index.php');
    exit;
}
    header('Content-Type: application/json');
    $conn=mysqli_connect("localhost","root","","fantacalcio2");
    $id_squadra=$_GET["id_squadra"];
    $id_lega=$_GET["id_lega"];
    $query="UPDATE squadra set edizione_fantacalcio=null where cod_s='$id_squadra'";
    $res= mysqli_query($conn,$query) or die(mysqli_error($conn));;
    $eliminata = array();
    if($res) {
        $eliminata[] = array('lega'=> $id_lega,'ok' => true);
    }else{
        $eliminata[] = array('lega'=> $id_lega,'ok' => false);
    }
    echo json_encode($eliminata);
    mysqli_close($conn);
?>