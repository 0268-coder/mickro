const express = require('express');
const router = express.Router();
const db = require('../db')

//list all product
router.get('/',async(req,res)=>{
    const [result] = await db.query('SELECT * FROM Product');
    res.render('product/product',{product:result})
})

//get product from id
router.get('/:id',async(req,res)=>{
    
    try{
        //sql query
        const [result] = await db.query('SELECT * FROM Product WHERE Product_ID = ?',req.params.id);
        console.log(result)
        //render product/id
        return res.render('product/detail', {product: result[0]})
    }
    catch(err){
        console.error("Error occur product id",err.message)
    }
})

module.exports = router;