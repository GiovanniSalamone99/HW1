<?php
  include 'auth.php';
  if (!checkAuth()) {
      header('Location: index.php');
      exit;
  }
  
  if(!empty($_GET["commento"]) && !empty($_GET["id_news"])){
    $id_news=$_GET["id_news"];
    $commento=$_GET["commento"];
    $fantallenatore=$_SESSION["log"];
    $conn=mysqli_connect("localhost","root","","fantacalcio2");
    $aggiunto = array();
    $query = "INSERT INTO commenti(cod_news,commento,cod_fantallenatore) VALUES('$id_news','$commento','$fantallenatore')";
    mysqli_query($conn, $query) or die(mysqli_error($conn));;
    $query = "SELECT username from fantallenatore where id='$fantallenatore'";
    $res=mysqli_query($conn, $query) or die(mysqli_error($conn));;
    $entry = mysqli_fetch_assoc($res);
    $aggiunto[] = array('username' => $entry['username']);

        echo json_encode($aggiunto);
        mysqli_close($conn);
  }
 

?>