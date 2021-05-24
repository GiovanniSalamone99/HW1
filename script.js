fetch("fetch_leghe.php").then(fetchResponse).then(fetchLegheJson);
document.getElementById("cerca").addEventListener("keyup", cerca);
let flag=0;
function fetchResponse(response){
    if (!response.ok) {return null};
    return response.json();
}

function fetchLegheJson(json)
{
    console.log(json);
    for(let i in json)
    {
        const leghe= document.querySelector(".leghe");
        const contenuto=document.createElement("div");
        const iscriviti=document.createElement("a");
        iscriviti.classList.add("iscrizione_lega");
        if(json[i].presente)
        {
            iscriviti.textContent="Iscritto";
            iscriviti.style.background='#f68e27';
            iscriviti.addEventListener("click", apriModale2);
        }else{
            iscriviti.textContent="Iscriviti";
            iscriviti.style.background='#2e6be6';
            iscriviti.addEventListener("click", apriModale);
        }
        const titolo=document.createElement("h1");
        titolo.textContent=json[i].nome;
        titolo.dataset.testoTitolo=json[i].nome;
        const img=document.createElement("img");
        img.src=json[i].img;
        const desc=document.createElement("p");
        desc.textContent="Dettagli";
        leghe.appendChild(contenuto);
        contenuto.appendChild(titolo);
        contenuto.appendChild(img);
        contenuto.appendChild(iscriviti);
        contenuto.appendChild(desc);
        contenuto.dataset.idLega=json[i].cod;
        desc.addEventListener("click", aggiornaDesc);
        iscriviti.classList.add("pointer");
        desc.classList.add("pointer");
    }
}
function apriModale2(event){
    idLega=event.currentTarget.parentNode.dataset.idLega;
    let modal = document.getElementById("myModal");
    let span = document.getElementsByClassName("close")[0];
    document.querySelector(".modal-header h2").textContent="Sei sicuro di voler eliminare la squadra dalla lega?";
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
    fetch("fetch_squadre.php").then(fetchResponse).then(function (json){ return carica2(json,idLega) });;
}
function carica2(json,id_lega){
    const modal_body = document.querySelector(".modal-body");
    const tabella=document.createElement("table");
    modal_body.innerHTML="";
    for(let i in json){
        if(json[i].lega==id_lega)
        {           
            const riga=document.createElement("tr");
            riga.dataset.idSquadra=json[i].id;
            const nome=document.createElement("td");
            nome.textContent=json[i].nome;
            const add=document.createElement("td");
            const imgadd=document.createElement("img");
            imgadd.src="img/cestino.png";
            add.appendChild(imgadd);
            tabella.appendChild(riga);
            riga.appendChild(nome);
            riga.appendChild(add);   
            imgadd.classList.add("pointer");
            imgadd.onclick = function() {
            fetch("elimina_iscrizione.php?id_squadra="+json[i].id+"&id_lega="+id_lega).then(fetchResponse).then(eliminaLegaJson);
          }
          modal_body.appendChild(tabella);
        }
    }
}
function eliminaLegaJson(json){
    if(json[0].ok!=false)
    {
        document.getElementById("myModal").style.display="none";
        document.body.style['overflow'] = 'auto';
        const modifica_lega= document.querySelectorAll(".iscrizione_lega");
        for(let i of modifica_lega){
            if(i.parentNode.dataset.idLega==json[0].lega){
                i.textContent="Iscriviti";
                i.style.background='#2e6be6';
                i.addEventListener("click", apriModale);
            }
        }
    }
}

function apriModale(event){
    idLega=event.currentTarget.parentNode.dataset.idLega;
    let modal = document.getElementById("myModal");
    let span = document.getElementsByClassName("close")[0];
    document.querySelector(".modal-header h2").textContent="Scegli quale squadra iscrivere alla lega";
    flag=0;
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
    fetch("fetch_squadre.php").then(fetchResponse).then(function (json){ return carica(json,idLega) });;
}
function carica(json,id_lega){
    const modal_body = document.querySelector(".modal-body");
    const tabella=document.createElement("table");
    let flag_squadra=0;
    modal_body.innerHTML="";
    for(let i in json){
        if(json[i].lega==null)
        {     
            flag_squadra=1      
            const riga=document.createElement("tr");
            riga.dataset.idSquadra=json[i].id;
            const nome=document.createElement("td");
            nome.textContent=json[i].nome;
            const add=document.createElement("td");
            const imgadd=document.createElement("img");
            imgadd.src="img/addgiocatore.png";
            add.appendChild(imgadd);
            tabella.appendChild(riga);
            riga.appendChild(nome);
            riga.appendChild(add);   
            imgadd.classList.add("pointer");
            imgadd.onclick = function() {
            fetch("add_lega.php?id_squadra="+json[i].id+"&id_lega="+id_lega).then(fetchResponse).then(addLegaJson);
          }
          modal_body.appendChild(tabella);
        }
    }
    if(flag_squadra==0){modal_body.append("Non hai squadre libere per essere iscritte a questa lega.")}
}
function addLegaJson(json){
    console.log(json);
    
    if(json[0].squadra!=false)
    {
        document.getElementById("myModal").style.display="none";
        document.body.style['overflow'] = 'auto';
        const modifica_lega= document.querySelectorAll(".iscrizione_lega");
        for(let i of modifica_lega){
            if(i.parentNode.dataset.idLega==json[0].lega){
                i.textContent="Iscritto";
                i.style.background='#f68e27';
                i.removeEventListener("click", apriModale);
                i.addEventListener("click", apriModale2);
            }
        }
    }else{
        if(flag!=0){
            document.querySelector(".error").remove();
        }
        const errore=document.createElement("p");
        errore.textContent="*Esiste già una squadra con questo nome";
        errore.classList.add("error");
        errore.style.padding="0px";
        errore.style.margin="0px";
        document.querySelector(".modal-body").appendChild(errore);
        flag=1;
    }
}

function aggiornaDesc(event){
    target=event.currentTarget;
    fetch("fetch_leghe.php").then(fetchResponse).then(function (json){ 
        
        for(let i in json){
            if(json[i].cod==target.parentNode.dataset.idLega)
            {    
                console.log(json);
                target.textContent="Modalità: "+json[i].modalita;
                target.classList.remove("pointer");
                const partecipanti=document.createElement("p");
                partecipanti.textContent="Max partecipanti: "+json[i].num_max_partecipanti;
                const meno=document.createElement("p");
                meno.classList.add("pointer");
                meno.textContent="Mostra meno";
                target.parentNode.appendChild(partecipanti);
                target.parentNode.appendChild(meno);
                target.removeEventListener("click", aggiornaDesc);
                meno.addEventListener("click", dettagli);
            }
        }
     });
}

function dettagli(event){
    event.currentTarget.textContent="Dettagli";
    event.currentTarget.removeEventListener("click", dettagli);
    event.currentTarget.addEventListener("click", aggiornaDesc);
    event.currentTarget.classList.add("pointer");
    event.currentTarget.previousSibling.previousSibling.remove();
    event.currentTarget.previousSibling.remove();
}

function cerca(){
    let valore = document.getElementById("cerca").value;
    const id=document.querySelectorAll(".leghe div");
    let a=0;
    for(let i of id)
    {   
        i.classList.add("hidden");
        if(i.firstChild.dataset.testoTitolo.startsWith(valore))
        {
            i.classList.remove("hidden");

            a=1;
            document.getElementById("risultato").classList.add("hidden");
        }
    }
    if(a==0)
    {
        document.getElementById("risultato").classList.remove("hidden");
    }
}
