const express = require('express')
const router = express.Router()
const loginModel = require('../models/login');
const { authenticateAdmin, authenticateUser } = require('../middleware/auth');

router.get("/", authenticateUser, authenticateAdmin, (req,res)=>{
    res.render("adminpage");
})



module.exports = router;