const express = require('express')
const router = express.Router()

router.get("/",(req,res)=>{
    res.render("login")
})

router.post("/",(req,res)=>{
    res.send("hi")
})

router.get("/register",(req,res)=>{
    res.send("register")
})

router.post("/register",(req,res)=>{
    res.send("register")
})

module.exports = router