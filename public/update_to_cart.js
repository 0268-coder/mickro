document.querySelectorAll('.increase-btn').forEach(button=>{
    button.addEventListener('click',function(){
        const itemID = this.dataset.itemID

        fetch(`/cart/${itemID}`,{method: "PUT"})
        .then(response=>{
            if (response.status===204){
                console.log("increase cart complete")
            }
            else{
                console.log("failed add to cart")
            }
        }).catch(err =>{
            console.log("Error",err)
        })

    })
})

