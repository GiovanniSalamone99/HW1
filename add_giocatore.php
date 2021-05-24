<?php
  include 'auth.php';
  if (!checkAuth()) {
      header('Location: index.php');
      exit;
  }
  
  if(!empty($_GET["id_squadra"]) && !empty($_GET["id_giocatore"])){
    $id_squadra=$_GET["id_squadra"];
    $id_giocatore=$_GET["id_giocatore"];
    $conn=mysqli_connect("localhost","root","","fantacalcio2");
    $query = "SELECT id FROM giocatori_appartenenti WHERE id = '$id_giocatore' and squadra='$id_squadra'";
    $res = mysqli_query($conn, $query) or die(mysqli_error($conn));;
    $aggiunto = array();
        if (mysqli_num_rows($res) > 0) {
            $aggiunto[] = array('ok' => false);
        }
        else
        {
            $query = "INSERT INTO giocatori_appartenenti(id,squadra) VALUES('$id_giocatore','$id_squadra')";
            mysqli_query($conn, $query) or die(mysqli_error($conn));;
            $aggiunto[] = array('ok' => true);
        }
        echo json_encode($aggiunto);
        mysqli_close($conn);
  }
 

?>