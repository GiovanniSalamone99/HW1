
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
    <script src="ultime_news.js" defer="true"></script>
    <script src="tendina.js" defer="true"></script>
  </head>
  <body>
    <header class="head">
      <nav>
        <div id="logo">
        
        
        </div>

        <div id="links">
          <a href="http://localhost/MHW1/podcast.php"><img src="img/Spotify_icon.png" id="spotify"></a>
          <a href="http://localhost/MHW1/index.php">Home</a>
          <a href="http://localhost/MHW1/highlights.php">Highlights</a>
          <?php
          include 'auth.php';
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
        
      <div id="main">
        <h1>Benvenuto su LEGHE FANTACALCIO</h1>
        <p>Qui potrai creare la tua squadra e competere nelle migliori leghe di fantacalcio.</p>
      </div>

      <div id="details">
        <div>
          <img src="img/leghe.jpg" />
          <h1>LEGHE</h1>
          <p>
		   Ecco qui l'elenco delle leghe già presenti all'interno della nostra app.
		  </p>
        </div>
        <div>
          <img src="img/tutorial.jpg" />
          <h1>INIZIA</h1>
          <p>
           Scopri come creare la tua lega ed iniziare a competere con i tuoi amici.
          </p>
        </div>
      </div>

      <div id="ultime_news">
        <p>Ultime news </p>
      </div>
      
        <div id="news">
              
        </div>
    
    </section>

    <footer>
      <p>Giovanni Salamone O46002305</p>
    </footer>
  </body>
</html>
