const express = require('express')
const router = express.Router()
console.log('hello world')
router.get('/',(req,res)=>{
    res.send("users")
})

router.get('/news',(req,res)=>{
    res.send("users and new")
})

router.post('/',(req,res)=>{
    res.send("create users")
})

router.get("/news/:id",(req,res) =>{

    res.send(`get user id with ${req.params.id}`)
})

module.exports = router