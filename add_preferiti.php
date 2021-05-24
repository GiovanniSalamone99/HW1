<?php
  include 'auth.php';
  if (!checkAuth()) {
      header('Location: index.php');
      exit;
  }
  
  if(!empty($_GET["titolo"]) && !empty($_GET["img"]) && !empty($_GET["url"])){

    $titolo=$_GET["titolo"];
    $img=$_GET["img"];
    $url=$_GET["url"];
    $fantallenatore=$_SESSION["log"];
    $conn=mysqli_connect("localhost","root","","fantacalcio2");
    $aggiunto = array();
    $query = "SELECT id from preferiti where titolo='$titolo' and img='$img' and url='$url' and fantallenatore='$fantallenatore'";
    $res=mysqli_query($conn, $query) or die(mysqli_error($conn));;
    if(mysqli_num_rows($res) > 0){
      $aggiunto[] = array('ok' => false);
    }else{
      $query = "INSERT INTO preferiti(titolo,img,url,fantallenatore) VALUES('$titolo','$img','$url','$fantallenatore')";
      mysqli_query($conn, $query) or die(mysqli_error($conn));;
      $aggiunto[] = array('ok' => true);
    }
    echo json_encode($aggiunto);
    mysqli_close($conn);
  }
 

?>