<?php
include 'auth.php';
if (!checkAuth()) {
    header('Location: index.php');
    exit;
}
    header('Content-Type: application/json');
    $id_log=$_SESSION['log'];
    $conn=mysqli_connect("localhost","root","","fantacalcio2");
    $query="SELECT nome,modalità,num_max_partecipanti,img,cod FROM fantacalcio";
    $res= mysqli_query($conn,$query) or die(mysqli_error($conn));;
    $query2="SELECT fantacalcio FROM squadra s join edizione_fantacalcio e on s.edizione_fantacalcio=e.id where s.fantallenatore='$id_log'";
    $res2= mysqli_query($conn,$query2) or die(mysqli_error($conn));;
    $legheArray = array();
    $legheF = array();
    while($entry2 = mysqli_fetch_assoc($res2)){ $legheF[] = array('val' => $entry2['fantacalcio']); }
    while($entry = mysqli_fetch_assoc($res)) {
        $flag=0;
        foreach($legheF as $value) {
                if($entry['cod']==$value['val'])
                {   
                    $flag=1;
                    $legheArray[] = array('nome' => $entry['nome'],'modalita' => $entry['modalità'],'num_max_partecipanti' => $entry['num_max_partecipanti'], 'img' => $entry['img'], 'cod' => $entry['cod'],'presente' => true);
                }
        }
        if($flag!=1)
        {
        $legheArray[] = array('nome' => $entry['nome'],'modalita' => $entry['modalità'],'num_max_partecipanti' => $entry['num_max_partecipanti'], 'img' => $entry['img'], 'cod' => $entry['cod'],'presente' => false);
        }
    }
    echo json_encode($legheArray);
    mysqli_close($conn);
?>