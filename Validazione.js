const form=document.forms['login'];
form.addEventListener("submit", validazione);

function validazione(event){
    if(form.username.value.length==0 || form.password.value.length==0)
    {
        alert("compilare tutti i campi");
        event.preventDefault();
    }
    
}
