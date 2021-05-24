<?php
  include 'auth.php';
  if (checkAuth()) {
      header('Location: index.php');
      exit;
  }
  if(!empty($_POST["username"]) && !empty($_POST["password"]))
   {
     
     $conn=mysqli_connect("localhost","root","","fantacalcio2");
     $username=mysqli_real_escape_string($conn,$_POST["username"]);
     $password=mysqli_real_escape_string($conn,$_POST["password"]);
     $query="SELECT id,username,password FROM fantallenatore WHERE username='$username'";
     $res= mysqli_query($conn,$query) or die(mysqli_error($conn));;
     if(mysqli_num_rows($res)>0)
     {
      $entry = mysqli_fetch_assoc($res);
      if (password_verify($_POST['password'], $entry['password'])) {
        $_SESSION["username"]=$_POST["username"];
        $_SESSION['log']=$entry['id'];
        header("Location: index.php");
        mysqli_free_result($res);
        mysqli_close($conn);
        exit;
      }
      else{
        $error=true;
      }
     }
     else{
       $error=true;
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
    <script src="Validazione.js" defer="true"></script>
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
        
      <div id="login">

          <img src="https://content.fantacalcio.it/web/img/logo-fantacalcio.png" >
          <?php
                if (isset($error)) {
                    echo "<span class='error'>Username o password errati</span> ";                   
                }  
                
                if (isset($_SESSION["iscrizione"])) {
                    echo "<span class='iscrizione_effettuata'> Iscrizione effettuata </span>";                   
                }           
            ?>
          <form action="" name="login" method="POST">
              <label>Username</label><br>
                <input type="text" name="username" ><br>
              <label>Password</label><br>
                <input type="password" name="password" ><br>
              <input type="submit" name="submit" id="submit_log" value="Login">
          </form>
          <br>
          <br>
          <form action="http://localhost/MHW1/iscrizione.php" name="iscriviti" method="POST">
            <label>Non sei ancora iscritto?</label><br>
            <input type="submit" name="iscrizione" id="iscrizione" value="Iscriviti">
          </form>
          
      </div>
    
    </section>

    <footer>
      <p>Giovanni Salamone O46002305</p>
    </footer>
  </body>
</html>
