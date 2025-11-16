const express = require('express')
const router = express.Router()
const loginModel = require('../models/login');
const bcrypt = require('bcrypt');

router.get("/",(req,res)=>{
    res.render("login")
})

router.post("/", async (req,res)=>{
    const { username, password} = req.body
    
    const user = await loginModel.getUserLogin(username);
    //from buffer to string
    const strPassword = bufferToString(user.Password)
    if(!user) {
        return res.render("login", { message: "Invalid username" });
    }

    
    //compare password hash
    const isPasswordValid = await bcrypt.compare(password, strPassword);
    
    if(!isPasswordValid) {
        return res.render("login", { message: "Invalid password" });
    }

    req.session.user = { id: user.User_ID, username: user.Username, isAdmin: user.Status === 'admin' };

    if(user.Status === 'admin') {
        res.redirect("/admin");
    } else {
        res.redirect("/");
    }
})

function bufferToString(data) {
    if (data && Buffer.isBuffer(data)) {
        // Convert the Buffer object to a standard UTF-8 string
        return data.toString('utf8');
    }
    // Return the data as-is if it's already a string or null/undefined
    return data;
}

module.exports = router;