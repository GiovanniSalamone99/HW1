<?php
include 'auth.php';
if (!checkAuth()) {
    header('Location: index.php');
    exit;
}
    $id=$_GET["id"];
    header('Content-Type: application/json');
    $conn=mysqli_connect("localhost","root","","fantacalcio2");
    $query="SELECT g.id,g.nome,g.ruolo FROM giocatori g JOIN giocatori_appartenenti ga on g.id=ga.id where ga.squadra='$id'";
    $res= mysqli_query($conn,$query) or die(mysqli_error($conn));;
    $giocatoriArray = array();
    while($entry = mysqli_fetch_assoc($res)) {
        $giocatoriArray[] = array('id' => $entry['id'],'nome' => $entry['nome'], 'ruolo' => $entry['ruolo']);
    }
    echo json_encode($giocatoriArray);
    mysqli_close($conn);
?>