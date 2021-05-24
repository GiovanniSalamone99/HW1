function fetchNewsJson(json)
{
    console.log(json);
    for (let i=json.length-1; i>json.length-4;i--)
    {
        const news= document.querySelector("#news");
        const contenuto=document.createElement("div");
        const img=document.createElement("img");
        const link=document.createElement("p");
        img.src=json[i].img;
        link.textContent=json[i].titolo;
        news.appendChild(contenuto);
        contenuto.appendChild(img);
        contenuto.appendChild(link);
        contenuto.dataset.titoloId=json[i].id;
        contenuto.addEventListener("click",apriNews);
    }
}
function fetchResponse(response){
    if (!response.ok) {return null};
    return response.json();
}
function apriNews(event){
    id=event.currentTarget.dataset.titoloId;
    window.location="news.php?id_news="+id;
}
fetch("fetch_news.php").then(fetchResponse).then(fetchNewsJson);
