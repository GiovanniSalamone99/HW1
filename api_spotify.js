
fetch("fetch_spotify.php").then(onResponse).then(onJson);

function onResponse(response)
{
    console.log('Risposta ricevuta');
 	return response.json();
}

function onJson(json)
{
    console.log(json);
    let array=[];
    for(let j=0; j < json.episodes.total; j++)
    {
        array.push(json.episodes.items[j].release_date);      
    }   
    array.sort();
    array.reverse();
    console.log(array);
    for(let j=0; j < json.episodes.total; j++)
    {
        for(let i=0; i < json.episodes.total; i++)
        {
            if(json.episodes.items[i].release_date==array[j]){
                const pod=document.querySelector(".podcast")
                const titolo=document.createElement("h1");
                titolo.textContent= json.episodes.items[i].name;
                const div=document.createElement("div");
                const link=document.createElement("a");
                const img=document.createElement("img");
                img.src=json.episodes.items[i].images[1].url;
                link.href=json.episodes.items[i].external_urls.spotify;
                link.target="_blank";
                const desc=document.createElement("p");
                desc.textContent=json.episodes.items[i].description;
                link.appendChild(img)
                div.appendChild(link)
                div.appendChild(desc);
                pod.appendChild(titolo);
                pod.appendChild(div);
            }
        }
    }
}