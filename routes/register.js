const express = require('express');
const router = express.Router();
const registerModel = require('../models/register');
const bcrypt = require('bcrypt');

router.get("/",(req,res)=>{
    res.render("register")
})

router.post("/", async (req,res)=>{
    const { firstName, lastName, username, email, password, confirmPassword, dateOfBirth, phoneNumber, address } = req.body;

    //check if username already exists
    const existingUser = await registerModel.getUserFromUsername(username);
    console.log(existingUser);
    if (existingUser) {
        return res.render("register", { message: "Username already exists" });
    }

    //check if email already exists
    if (await registerModel.getEmailFromEmail(email)) {
        return res.render("register", { message: "Email already exists" });
    }

    //check if date of birth is in the past
    if (dateOfBirth > new Date()) {
        return res.render("register", { message: "Date of birth is in the future" });
    }

    //check if phone number is valid
    if (phoneNumber.length !== 10) {
        return res.render("register", { message: "Invalid phone number" });
    }

    // check if passwords match
    if (password !== confirmPassword) {
        return res.render("register", { message: "Passwords do not match" });
    }

    //hash password
    const hashedPassword = await bcrypt.hash(password, 13);

    const result = await registerModel.register(firstName, lastName, username, email, hashedPassword, dateOfBirth, phoneNumber, address);
    res.redirect("/login");
})

module.exports = router;