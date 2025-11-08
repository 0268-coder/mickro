const express = require('express')
const router = express.Router();

router
    .route("/")
    .get((req,res)=>{
        res.send(req.session.cart)
    })
    .post((req,res)=>{
        const product_ID = req.body.Product_ID
        const quantity = parseInt(req.body.quantity)

        //check is cart empty
        req.session.cart = req.session.cart || []

        //check is product existing in cart
        const existing = req.session.cart.find(item => item.id === product_ID)
        
        if (existing){
            //add only quantity
            existing.qty += quantity
        }
        else{
            //add new product and quantity
            req.session.cart.push({
                id: product_ID,
                qty: quantity
            }) 
        }
        
        res.redirect('/product')
        console.log("product add to cart",res.session.cart)
    })
    

module.exports = router