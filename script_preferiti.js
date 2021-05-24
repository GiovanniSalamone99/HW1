fetch("fetch_preferiti.php").then(fetchResponse).then(fetchPreferitiJson);
let a=0;
function fetchPreferitiJson(json){
    console.log(json);
    const highlight = document.querySelector('.highlights');
	if(json.length==0){document.getElementById("risultato").classList.remove("hidden");}
    for(let i in json){
            const contenuto=document.createElement("div");
            contenuto.dataset.idPref=json[i].id;
			const intestazione=document.createElement("span");
			const title=document.createElement("h1");
			title.textContent=json[i].titolo;
			const pref=document.createElement("img");
			pref.src="img/x.png";
            pref.classList.add("pointer");
			const img=document.createElement("img");
			img.src=json[i].img;
			const url=document.createElement("a");
			url.href=json[i].url;
			url.target="_blank";
			url.textContent="Clicca qui";
			intestazione.appendChild(title);
			intestazione.appendChild(pref);
			contenuto.appendChild(intestazione);
			contenuto.appendChild(img);
			contenuto.appendChild(url);
			highlight.appendChild(contenuto);
			a++;
			document.getElementById("risultato").classList.add("hidden");
			pref.addEventListener("click", eliminaPref);
    }

}
function fetchResponse(response){
    if (!response.ok) {return null};
    return response.json();
}
function eliminaPref(event){
    target=event.currentTarget;
    fetch("elimina_pref.php?idPref="+target.parentNode.parentNode.dataset.idPref).then(fetchResponse).then(function (json){ return aggiorna(json,target) });
}
function aggiorna(json,target){
    console.log(json[0].ok);
    if (!json[0].ok) return null;
    target.parentNode.parentNode.remove();
	a--;
	if(a==0){document.getElementById("risultato").classList.remove("hidden");}
    
}