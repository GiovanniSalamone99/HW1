<?php
  include 'auth.php';
  if (!checkAuth()) {
      header('Location: index.php');
      exit;
  }
  
  if(!empty($_GET["id_squadra"]) && !empty($_GET["id_lega"])){
    $id_log=$_SESSION['log'];
    $id_squadra=$_GET["id_squadra"];
    $id_lega=$_GET["id_lega"];
    $conn=mysqli_connect("localhost","root","","fantacalcio2");

    $query = "SELECT fantallenatore FROM squadra WHERE edizione_fantacalcio='$id_lega' and fantallenatore='$id_log'";
    $res = mysqli_query($conn, $query) or die(mysqli_error($conn));;
    $aggiunto = array();
        if (mysqli_num_rows($res) > 0) {
            $aggiunto[] = array('squadra' => false);
        }
        else
        {
            $query = "UPDATE squadra set edizione_fantacalcio='$id_lega' where cod_s='$id_squadra' ";
            if(mysqli_query($conn, $query))
            {
                $aggiunto[] = array('squadra' => $id_squadra,'lega'=>$id_lega);
            }else{$aggiunto[] = array('squadra' => false);}
        }
        echo json_encode($aggiunto);
        mysqli_close($conn);
  }
 

?>