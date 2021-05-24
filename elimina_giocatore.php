<?php
include 'auth.php';
if (!checkAuth()) {
    header('Location: index.php');
    exit;
}
    header('Content-Type: application/json');
    $conn=mysqli_connect("localhost","root","","fantacalcio2");
    $squadra=$_POST["squadra"];
    $id_giocatore=$_POST["id"];
    $query="DELETE FROM giocatori_appartenenti WHERE squadra = '$squadra' AND id = '$id_giocatore'";
    $res= mysqli_query($conn,$query) or die(mysqli_error($conn));;
    $eliminato = array();
    if($res) {
        $eliminato[] = array('ok' => true);
    }else{
        $eliminato[] = array('ok' => false);
    }
    echo json_encode($eliminato);
    mysqli_close($conn);
?>