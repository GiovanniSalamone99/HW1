<?php
  include 'auth.php';
  if (!checkAuth()) {
      header('Location: index.php');
      exit;
  }
  ?>
<!DOCTYPE html>
<html>

  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width,initial-scale=1.0">
    <title>FANTACALCIO</title>
    <link href="https://fonts.googleapis.com/css?family=Lora:400,400i|Open+Sans:400,700" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@300&display=swap" rel="stylesheet"> 
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans+Condensed:wght@700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="mhw1.css">
    <script src="script.js" defer="true"></script>
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
          <?php
          
          if (checkAuth()) {
            $username= $_SESSION["username"];
            echo "<a href='http://localhost/MHW1/squadra.php'>Squadra</a>";
            echo "<a href='http://localhost/MHW1/mhw2.php'>Leghe</a>";
            echo "<div class='dropdown'>
                    <button onclick='showTendina()' class='button' >$username</button>
                    <div id='myDropdown' class='dropdown-content'>
                      <a href='http://localhost/MHW1/preferiti.php'>Preferiti <img id='preferiti' src='img/star.png'></a>
                      <a href='http://localhost/MHW1/logout.php'>Logout <img id='logout' src='img/logout.png'></a>
                    </div>
                  </div>";
        }else{
          echo "<button class='button' onclick='accedi()'>Accedi</button>";
        }
          ?>
          </div>
          <div id="menu">
            <div></div>
            <div></div>
            <div></div>
          </div>
        </nav>
    </header>
  
    <section>

      <div id="ricerca">
        <h1>Leghe ufficiali</h1>
        <div>
          Cerca: <input type="text" id="cerca" name="cerca"  >
        </div>
        
      </div>

      <div class="leghe" >
          

      </div>
      
      <p id="risultato" class="hidden">Nessun risultato</p>
      <!-- Modal POPUP -->
      <div id="myModal" class="modal">
          
          <div class="modal-content">
            <div class="modal-header">
              <span class="close">&times;</span>
              <h2></h2>
            </div>

            <div class="modal-body">
                
            </div>
            
            <div class="modal-footer">
              <img src="https://content.fantacalcio.it/web/img/logo-fantacalcio.png">
            </div>
          </div>

        </div>
      
    </section>
  
      <footer>
        <p>Giovanni Salamone O46002305</p>
      </footer>

  </body>

</html>