const express = require('express');
const router = express.Router();
const registerModel = require('../models/Register');

router.get("/",(req,res)=>{
    res.render("register")
})

module.exports = router;