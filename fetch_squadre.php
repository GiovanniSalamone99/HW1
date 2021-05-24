<?php
     include 'auth.php';
     if (!checkAuth()) {
         header('Location: index.php');
         exit;
     }
    header('Content-Type: application/json');
    $id=$_SESSION['log'];
    $conn=mysqli_connect("localhost","root","","fantacalcio2");
    $query="SELECT cod_s,nome_squadra,edizione_fantacalcio FROM squadra where fantallenatore='$id'";
    $res= mysqli_query($conn,$query) or die(mysqli_error($conn));;
    $squadreArray = array();
    while($entry = mysqli_fetch_assoc($res)) {
        $squadreArray[] = array('id' => $entry['cod_s'],'nome' => $entry['nome_squadra'], 'lega' => $entry['edizione_fantacalcio']);
    }
    echo json_encode($squadreArray);
    mysqli_close($conn);
?>