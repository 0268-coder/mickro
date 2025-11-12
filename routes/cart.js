const express = require('express')
const router = express.Router();
const db = require('../db')

router
    .route("/")
    .get(async(req,res)=>{
        try{    
            //inititialize cart
            const cart = req.session.cart || []

            if (cart.length === 0){
                return res.render('cart',{cartItems: [],total: 0.00, message: "your cart is currently emtpy"})
            }
            let totalprice = 0

            for(const item of cart){
                //change item.id to int
                id = parseInt(item.id)
                //get each product price
                const [results] = await db.query("SELECT Product_Price FROM Product WHERE Product_ID = ?",id)

                //console.log(results[0].Product_Price+" "+item.qty)
                //calculate total price
                totalprice += results[0].Product_Price * item.qty    
            }

            return res.render('cart',{cartItems: [], total: totalprice})
        }
        catch(err){
            console.log("error occur during GET/cart",err)
        }

    })
    .post((req,res)=>{
        try{
            const product_ID = parseInt(req.body.Product_ID)
            const quantity = parseInt(req.body.quantity)
            //initialize cart if it is not exist
            if (!req.session.cart){
                req.session.cart = []
            }
            
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
                    qty: quantity,
                }) 
            }
            
            console.log("product add to cart",req.session.cart)
            return res.redirect('/product')
        }
        catch(err){
            console.error("error",err.message)
            return res.redirect('/product')
        }
    })
    
    
router.delete("/:itemId", (req, res) => {
    try {
        // 1. Get the item ID from the URL path
        const itemToDeleteId = parseInt(req.params.itemId) 

        // 2. Find the index of the item to delete
        const cart = req.session.cart || [];
        const itemIndex = cart.findIndex(item => item.id === itemToDeleteId);
        
        if (itemIndex > -1) {
            // 3. Remove one item from the session cart array
            cart.splice(itemIndex, 1);
            req.session.cart = cart; // Re-assigning might be necessary depending on session store
            
            console.log("Product deleted from cart:", itemToDeleteId);
            return res.sendStatus(204); // Success, No Content
        } else {
            return res.status(404).send("Item not found in cart.");
        }
    } catch (err) {
        console.error("Error during DELETE /cart/:itemId", err);
        return res.sendStatus(500);
    }
});

router.put("/add/:itemID", async (req, res) => {
    try {
        // FIX: paramID is the Number from the URL
        const paramID = parseInt(req.params.itemID, 10); 

        const cart = req.session.cart || [];
        
        // FIX: Convert item.id (which might be a string) to a Number for comparison
        const existing = cart.find(item => parseInt(item.id) === paramID); 
        
        if (existing) {
            existing.qty++;

            req.session.cart = cart; 
            
            // --- Calculate New Total Price ---
            let newTotal = 0;
            
            for (const item of cart) {
                // Ensure itemID is a number for the DB query
                const itemID = parseInt(item.id, 10); 
                const [results] = await db.query(
                    "SELECT Product_Price FROM Product WHERE Product_ID = ?", 
                    itemID
                );

                if (results.length > 0) {
                    const price = results[0].Product_Price;
                    newTotal += price * item.qty;
                }
            }

            return res.status(200).json({ 
                newQty: existing.qty,
                newTotal: newTotal.toFixed(2)
            });

        } else {
            return res.status(404).send("Item not found in cart.");
        }
    } catch (err) {
        console.error("Error in PUT /add/:itemID:", err);
        return res.sendStatus(500);
    }
});

router.put("/remove/:itemID", async (req, res) => {
    try {
        const paramID = parseInt(req.params.itemID, 10);
        const cart = req.session.cart || [];
        
        // FIX: Find the item, converting session ID if necessary (as determined previously)
        const itemIndex = cart.findIndex(item => parseInt(item.id) === paramID); 
        const existing = cart[itemIndex];

        if (existing) {
            existing.qty--;

            // 🛑 CRITICAL CHECK: If quantity drops to 0, delete the item
            if (existing.qty <= 0) {
                cart.splice(itemIndex, 1); // Delete the item from the array
            }

            req.session.cart = cart; // Ensure session saves the changes
            
            // --- Calculate New Total Price ---
            let newTotal = 0;
            // Loop through the (potentially smaller) cart array to get the new total
            for (const item of cart) {
                const itemID = parseInt(item.id, 10);
                const [results] = await db.query(
                    "SELECT Product_Price FROM Product WHERE Product_ID = ?", itemID
                );

                if (results.length > 0) {
                    newTotal += results[0].Product_Price * item.qty;
                }
            }

            // If the item was deleted, newQty should be 0 or handled gracefully
            const newQty = existing.qty > 0 ? existing.qty : 0; 

            // Return status 200 with updated data (or 204 if item was deleted and you skip data return)
            return res.status(200).json({ 
                newQty: newQty,
                newTotal: newTotal.toFixed(2),
                deleted: newQty === 0 // Flag to tell the client to remove the row
            });

        } else {
            return res.status(404).send("Item not found in cart.");
        }
    } catch (err) {
        console.error("Error in PUT /remove/:itemID:", err);
        return res.sendStatus(500);
    }
});

module.exports = router