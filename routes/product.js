const express = require('express');
const router = express.Router();
const db = require('../db')

//list all product
router.get('/',async(req,res)=>{
    try {
        const searchQuery = req.query.search || '';
        let result;
        
        if (searchQuery.trim()) {
            // Search for products matching the query
            result = await db.query(
                'SELECT * FROM Product WHERE Product_Name LIKE ?',
                [`%${searchQuery}%`]
            );
            result = result[0];
        } else {
            // Get all products if no search query
            const [allProducts] = await db.query('SELECT * FROM Product');
            result = allProducts;
        }
        
        res.render('product/product',{product:result, searchQuery: searchQuery})
    } catch(err) {
        console.error("Error fetching products:", err);
        const [result] = await db.query('SELECT * FROM Product');
        res.render('product/product',{product:result, searchQuery: ''})
    }
})

//get product from id
router.get('/product/:id',async(req,res)=>{
    
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

router.get('/search',async(req,res)=>{
    const searchQuery = req.query.search;

    try{
        const [result] = await db.query('SELECT * FROM Product WHERE Product_Name LIKE ?',[`%${searchQuery}%`]);
        res.render('product/product',{product:result, searchQuery: searchQuery})
    }
    catch(err){
        console.error("Error fetching products:", err);
        const [result] = await db.query('SELECT * FROM Product');
        res.render('product/product',{product:result, searchQuery: ''})
    }
})

module.exports = router;