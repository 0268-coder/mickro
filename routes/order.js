const express = require('express')
const router = express.Router()
const db = require('../db')

router.get('/', async (req, res) => {
  const [rows] = await db.query('SELECT * FROM Product');
  res.json(rows);
});

//confirm order
router.post('/', async (req,res) =>{
    try{
      const sql = `INSERT INTO Order_Transaction(User_ID, Coupon_ID, Payment_Method_ID, Total_price, Status) VALUES (?,?,?,?,?)`;
      //test value
      const value = [2,1,1,10,"Pending"]
      //insert into query
      const [result] = await db.query(sql,value)

      return res.redirect(201).json({
        message:"1 record to order"
      })
    }
    //if fails
    catch(err){
      console.error('Database query error:',err)

      return res.status(500).json({
        error: 'failed to insert to order_transaction',
        details: err.message
      })
    }
})

module.exports = router