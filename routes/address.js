const express = require('express')
const router = express.Router()
const addressModel = require('../models/address');
const { authenticateUser } = require('../middleware/auth');

router.get("/", authenticateUser, async (req,res)=>{
    const userId = req.session.user.id;
    const address = await addressModel.getAddress(userId);
    res.render("address", { address });
})

router.post("/", authenticateUser, async (req,res)=>{
    const { address } = req.body;
    const userId = req.session.user.id;
    const result = await addressModel.updateAddress(address, userId);
    const updatedAddress = await addressModel.getAddress(userId);
    //store address in session
    req.session.address = updatedAddress
    //check
    console.log(req.session.address)
    if(result) {
        res.render("address", { message: "Address added successfully", success: true, address: updatedAddress });
    } else {
        res.render("address", { message: "Failed to add address", success: false, address: address });
    }
})

module.exports = router;