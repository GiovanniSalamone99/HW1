<?php
  include 'auth.php';
  if (checkAuth()) {
      header('Location: index.php');
      exit;
  }
  
  if(!empty($_POST["username"]) && !empty($_POST["password"]) && !empty($_POST["nome"]) && !empty($_POST["cognome"]))
   {
     
     $conn=mysqli_connect("localhost","root","","fantacalcio2");
     $username=mysqli_real_escape_string($conn,$_POST["username"]);
     $query = "SELECT username FROM fantallenatore WHERE username = '$username'";
     $res = mysqli_query($conn, $query) or die(mysqli_error($conn));;
     if (mysqli_num_rows($res) > 0) {
        $error= "Username già utilizzato";
     }else{
        $password=mysqli_real_escape_string($conn,$_POST["password"]);
        $password = password_hash($password, PASSWORD_BCRYPT);
        $nome=mysqli_real_escape_string($conn,$_POST["nome"]);
        $cognome=mysqli_real_escape_string($conn,$_POST["cognome"]);
        $query="INSERT INTO fantallenatore(username,password,nome,cognome) VALUES('$username','$password','$nome','$cognome')";
        if( mysqli_query($conn,$query))
        {
          $_SESSION["iscrizione"]=true;
            header("Location: login.php");
            mysqli_close($conn);
            exit;
        }
      }
   }
?>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>FANTACALCIO</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://fonts.googleapis.com/css?family=Lora:400,400i|Open+Sans:400,700" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@300&display=swap" rel="stylesheet"> 
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans+Condensed:wght@700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="mhw1.css">
    <script src="validazione_iscrizione.js" defer="true"></script>
    <script src="tendina.js" defer="true"></script>
  </head>
  <body>
    <header>
      <nav>
      <div id="logo">
        
      <img src="img/logo.jpg" >
      </div>
        <div id="links">
          <a href="http://localhost/MHW1/podcast.php"><img src="img/Spotify_icon.png" id="spotify"></a>
          <a href="http://localhost/MHW1/index.php">Home</a>
          <a href="http://localhost/MHW1/highlights.php">Highlights</a>
          <button class='button' onclick='accedi()'>Accedi</button>
        </div>
		<div id="menu">
          <div></div>
          <div></div>
          <div></div>
        </div>
      </nav>

    </header>
    

    <section>
        
      <div id="iscriviti">

          <img src="https://content.fantacalcio.it/web/img/logo-fantacalcio.png" >

          <form action="" name="iscriviti2" method="POST">
              
                <label>Nome</label><br>
                <input type="text" name="nome" pattern="[A-Za-z ]{2,20}$" title="Il nome deve contenere solo lettere, deve avere una lunghezza minima di 2 e massima di 20">
              <br>
                <label>Cognome</label><br>
                <input type="text" name="cognome" pattern="[A-Za-z ]{2,20}$" title="Il cognome deve contenere solo lettere, deve avere una lunghezza minima di 2 e massima di 20">
              <br>
              <?php
                if (isset($error)) {
                    echo "<span class='error'>*Username già in uso</span><br>";
                }
              ?>
                <label id="username_label">Username</label><br>
                <input type="text" id="username" name="username" pattern="[A-Za-z0-9]{6,20}$" title="L'username deve contenere solo caratteri alfanumerici, deve avere una lunghezza minima di 6 e massima di 20">
              <br>
                <label>Password</label><br>
                <div class="password"><input type="password" name="password" id="password" pattern="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,20}$" title="La password deve contenere minimo 8, massimo 20 caratteri tra cui: una lettera maiuscola, una minuscola, un numero e un carattere speciale">
                <button class="submit" id="visible"></button></div>
                <br>
              
                <input type="submit" name="iscrizione" id="iscrizione" value="Iscriviti" disabled >
          </form>          
      </div>
    
    </section>

    <footer>
      <p>Giovanni Salamone O46002305</p>
    </footer>
  </body>
</html>
