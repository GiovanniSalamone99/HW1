<?php

    header('Content-Type: application/json');
    $conn=mysqli_connect("localhost","root","","fantacalcio2");
    $query="SELECT img,titolo,id,descrizione FROM news";
    $res= mysqli_query($conn,$query) or die(mysqli_error($conn));;
    $newsArray = array();
    while($entry = mysqli_fetch_assoc($res)) {
        $newsArray[] = array('img' => $entry['img'], 'titolo' => $entry['titolo'],'id' => $entry['id'],'descrizione' => $entry['descrizione']);
    }
    echo json_encode($newsArray);
    mysqli_close($conn);
?>