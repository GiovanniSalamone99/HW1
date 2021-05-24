<?php
    include 'auth.php';
    if (!checkAuth()) {
        header('Location: index.php');
        exit;
    }
    header('Content-Type: application/json');
    $conn=mysqli_connect("localhost","root","","fantacalcio2");
    $fantallenatore=$_SESSION["log"];
    $query="SELECT id,img,titolo,url FROM preferiti where fantallenatore='$fantallenatore'";
    $res= mysqli_query($conn,$query) or die(mysqli_error($conn));;
    $array = array();
    while($entry = mysqli_fetch_assoc($res)) {
        $array[] = array('id' => $entry['id'],'img' => $entry['img'], 'titolo' => $entry['titolo'],'url' => $entry['url']);
    }
    echo json_encode($array);
    mysqli_close($conn);
?>