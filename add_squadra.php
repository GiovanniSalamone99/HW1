<?php
  include 'auth.php';
  if (!checkAuth()) {
      header('Location: index.php');
      exit;
  }
  
  if(!empty($_POST["nome_squadra"])){
  
    $id=$_SESSION["log"];
    $conn=mysqli_connect("localhost","root","","fantacalcio2");
    $nome_squadra=mysqli_real_escape_string($conn,$_POST["nome_squadra"]);
    $query = "SELECT * FROM squadra WHERE nome_squadra = '$nome_squadra' and fantallenatore='$id'";
    $res = mysqli_query($conn, $query) or die(mysqli_error($conn));;
    $squadreArray = array();
        if (mysqli_num_rows($res) > 0) {
            $squadreArray[] = array('ok' => true);
        }
        else
        {
            $query = "INSERT INTO squadra(nome_squadra,fantallenatore) VALUES('$nome_squadra','$id')";
            mysqli_query($conn, $query) or die(mysqli_error($conn));;
            $query="SELECT cod_s,nome_squadra,edizione_fantacalcio FROM squadra where fantallenatore='$id' and nome_squadra='$nome_squadra'";
            $res= mysqli_query($conn,$query) or die(mysqli_error($conn));;
            $entry = mysqli_fetch_assoc($res);
            $squadreArray[] = array('ok' => false,'id' => $entry['cod_s'],'nome' => $entry['nome_squadra'], 'lega' => $entry['edizione_fantacalcio']);
        }
        echo json_encode($squadreArray);
        mysqli_close($conn);
  }else{
    $squadreArray[] = array('ok' => true);
    echo json_encode($squadreArray);
  }
  

?>