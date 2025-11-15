const express = require('express')
const router = express.Router()
const loginModel = require('../models/login');
const bcrypt = require('bcrypt');

router.get("/",(req,res)=>{
    res.render("login")
})

router.post("/", async (req,res)=>{
    const { username, password } = req.body;

    const user = await loginModel.getUserLogin(username);
    if(!user) {
        return res.render("login", { message: "Invalid username" });
    }

    //compare password hash
    const isPasswordValid = await bcrypt.compare(password, user.Password);
    
    if(!isPasswordValid) {
        return res.render("login", { message: "Invalid password" });
    }

    res.redirect("/");
})

module.exports = router;