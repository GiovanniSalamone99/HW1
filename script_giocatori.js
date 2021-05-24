function apriModale(){
    let modal = document.getElementById("myModal");
    let span = document.getElementsByClassName("close")[0];
    modal.style.display = "block";
    document.body.style['overflow'] = 'hidden';
    window.onclick = function(event) 
    {
        if (event.target == modal) {
        modal.style.display = "none";
        document.body.style['overflow'] = 'auto';
        }
    }
    span.onclick = function() {
        modal.style.display = "none";
        document.body.style['overflow'] = 'auto';
      }
    fetch("fetch_giocatori_mancanti.php?id="+id).then(fetchResponse).then(carica);
}

function carica(json){
    const modal_body = document.querySelector(".modal-body");
    modal_body.innerHTML="";
    for(let i in json){
        const container=document.createElement("div");
        const img=document.createElement("img");
        img.src=json[i].img;
        container.appendChild(img);
        modal_body.appendChild(container);
        container.classList.add("pointer");
        container.onclick = function() {
            fetch("add_giocatore.php?id_squadra="+id+"&id_giocatore="+json[i].id).then(fetchResponse).then(addGiocatoreJson);
                addGiocatore(json[i].id,json[i].ruolo,json[i].nome);
          }
    }
}
function addGiocatoreJson(json){
    console.log(json);
    if(json.ok==true)
    {return true;}
    else
    {return false;}
}
function addGiocatore(id,_ruolo,_nome){
    document.getElementById("myModal").style.display="none";
    document.body.style['overflow'] = 'auto';
    const tabella= document.querySelector(".squadre table");
    const riga=document.createElement("tr");
    riga.dataset.idGiocatore=id;
    const ruolo=document.createElement("td");
    ruolo.textContent=_ruolo;
    const nome=document.createElement("td"); 
    nome.textContent=_nome;
    const elimina=document.createElement("td");
    const imgelimina=document.createElement("img");
    imgelimina.src="img/cestino.png";
    elimina.appendChild(imgelimina);
    tabella.appendChild(riga);
    riga.appendChild(ruolo);
    riga.appendChild(nome);
    riga.appendChild(elimina);   
    imgelimina.addEventListener("click", eliminaGiocatore);
    imgelimina.classList.add("pointer");
    numGiocatori=numGiocatori+1;
    document.getElementById("risultato").classList.add("hidden");
}

function eliminaGiocatore(event){
    button = event.currentTarget;
    const formData = new FormData();
    formData.append('id',button.parentNode.parentNode.dataset.idGiocatore);
    formData.append('squadra',id);
    fetch("elimina_giocatore.php", {method: 'post', body: formData}).then(fetchResponse)
    .then(function (json){ return aggiorna(json,button) });
}
function aggiorna(json,button){
    console.log(json.ok);
    if (json.ok) return null;
    button.parentNode.parentNode.remove();
    numGiocatori=numGiocatori-1;
    if(numGiocatori<=0)
    {
        document.getElementById("risultato").classList.remove("hidden");
    }
}
function fetchGiocatoriJson(json)
{
    console.log(json);
    if(json.length>0){
        for(let i in json)
        {
            addGiocatore(json[i].id,json[i].ruolo,json[i].nome);               
        }
    }
    else
    {
    document.getElementById("risultato").classList.remove("hidden");
    }
            const tabella= document.querySelector(".squadre ");
            const riga=document.createElement("div");
            riga.classList.add("addPlayer");
            const imgAdd=document.createElement("img");
            imgAdd.src="img/addGiocatore.png";
            tabella.appendChild(riga);
            riga.appendChild(imgAdd);   
            riga.addEventListener("click", apriModale);
            riga.classList.add("pointer");
}

function fetchResponse(response){
    if (!response.ok) {return null};
    return response.json();
}
let numGiocatori=0;
let queryString = window.location.search;
let urlParams = new URLSearchParams(queryString);
let id = urlParams.get('id_squadra');
let nome = urlParams.get('nome');
const squadra= document.querySelector("#ricerca h1");
squadra.textContent=nome;
fetch("fetch_giocatori.php?id="+id).then(fetchResponse).then(fetchGiocatoriJson);








