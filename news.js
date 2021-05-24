let queryString = window.location.search;
let urlParams = new URLSearchParams(queryString);
let id = urlParams.get('id_news');
const form=document.forms['commenta'];
form.addEventListener("submit", aggiungiCommento);
fetch("fetch_news.php").then(fetchResponse).then(fetchNewsJson);
fetch("fetch_commenti.php").then(fetchResponse).then(fetchCommentiJson);
function fetchResponse(response){
    if (!response.ok) {return null};
    return response.json();
}

function fetchNewsJson(json){
    for(let i in json)
    {
        if(json[i].id==id)
        {
            const container=document.createElement("div");
            const titolo=document.createElement("h1");
            titolo.textContent=json[i].titolo;
            const contenuto=document.createElement("div");
            contenuto.classList.add("news_contenuto");
            const img=document.createElement("img");
            img.src=json[i].img;
            const desc=document.createElement("p");
            desc.textContent=json[i].descrizione;
            container.appendChild(titolo);
            container.appendChild(contenuto);
            contenuto.appendChild(img);
            contenuto.appendChild(desc);
            document.getElementById("open_news").appendChild(container);
        }
    }
}
function fetchCommentiJson(json){
    for(let i=json.length-1;i>=0; i--)
    {
        if(json[i].cod_news==id)
        {
            const container=document.createElement("div");
            container.classList.add("commento");
            const nome=document.createElement("h1");
            nome.textContent=json[i].username+" :";
            const commento=document.createElement("p");
            commento.textContent=json[i].commento;
            container.appendChild(nome);
            container.appendChild(commento);
            document.querySelector(".commenti_content").appendChild(container);
        }
    }
}
function aggiungiCommento(event){
    event.preventDefault();
    fetch("add_commento.php?commento="+form.commento.value+"&id_news="+id).then(fetchResponse).then(commentoJson);
}
function commentoJson(json){
    console.log(json);
            const container=document.createElement("div");
            container.classList.add("commento");
            const nome=document.createElement("h1");
            nome.textContent=json[0].username+" :";
            const commento=document.createElement("p");
            commento.textContent=form.commento.value;
            container.appendChild(nome);
            container.appendChild(commento);
            document.querySelector(".commenti_content").prepend(container);
            form.commento.value="";
}