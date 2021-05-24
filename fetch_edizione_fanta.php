<?php
     include 'auth.php';
     if (!checkAuth()) {
         header('Location: index.php');
         exit;
     }
    header('Content-Type: application/json');
    $id=$_GET["nome"];
    $conn=mysqli_connect("localhost","root","","fantacalcio2");
    $query="SELECT nome,max(id) FROM edizione_fantacalcio e join fantacalcio f on e.fantacalcio=f.cod where id='$id'";
    $res= mysqli_query($conn,$query) or die(mysqli_error($conn));;
    $nomeFantaArray = array();
    while($entry = mysqli_fetch_assoc($res)) {
        $nomeFantaArray[] = array('nome' => $entry['nome']);
    }
    echo json_encode($nomeFantaArray);
    mysqli_close($conn);
?>