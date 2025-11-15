const express = require('express')
const router = express.Router()
const db = require('../db')

router.get("/",async (req,res)=>{
    try{ 
        const sql = "SELECT * FROM Payment_Method"
        const [result] = await db.query(sql)
        //set to locals so that ejs could call

        console.log('found method_type')
        return res.render('payment_method',{
            get_payment_method: result,
            payment_type: req.session.payment_type || null
        })
    }catch(err){
        console.error("error select method",err)
        return res.render('payment_method',{
            get_payment_method: [],
            payment_type: null
        })
    }

})

router.get("/type/:id",async(req,res)=>{
    try{
        const payment_id = parseInt(req.params.id)
        const sql = "SELECT Method_TYPE FROM Payment_Method WHERE Payment_Method_ID = ?;"

        //make sure the payment_type session is available
        if(!req.session.payment_type){
            req.session.payment_type = ""
        }
        //find the payment_type
        const [result] = await db.query(sql,payment_id)
        req.session.payment_type = result[0].Method_TYPE
        //check the result
        console.log(req.session.payment_type)
        return res.redirect('/cart')
    }
    catch(err){
        console.error("error find payment_method",err)
    }
})

module.exports = router