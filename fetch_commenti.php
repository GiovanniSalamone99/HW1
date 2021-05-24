<?php
include 'auth.php';
if (!checkAuth()) {
    header('Location: index.php');
    exit;
}
    header('Content-Type: application/json');
    $conn=mysqli_connect("localhost","root","","fantacalcio2");
    $query="SELECT c.commento,c.id,c.cod_news,c.cod_fantallenatore,f.username FROM commenti c join fantallenatore f on c.cod_fantallenatore=f.id order by c.id";
    $res= mysqli_query($conn,$query) or die(mysqli_error($conn));;
    $commentiArray = array();
    while($entry = mysqli_fetch_assoc($res)) {
        $commentiArray[] = array('commento' => $entry['commento'], 'id' => $entry['id'],'cod_news' => $entry['cod_news'],'cod_fantallenatore' => $entry['cod_fantallenatore'] ,'username' => $entry['username']);
    }
    echo json_encode($commentiArray);
    mysqli_close($conn);
?>