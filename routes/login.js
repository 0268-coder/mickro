const express = require('express')
const router = express.Router()
const loginModel = require('../models/login');

router.get("/",(req,res)=>{
    res.render("login")
})

module.exports = router;