const express = require('express')
const router = express.Router()
const paymentMethodModel = require('../../models/admin_payment_method')
const { authenticateUser, authenticateAdmin } = require('../../middleware/auth')

// GET all payment methods (for displaying in admin page)
router.get("/", authenticateUser, authenticateAdmin, async (req, res) => {
    try {
        const paymentMethods = await paymentMethodModel.getPaymentMethod()
        res.json(paymentMethods)
    } catch (error) {
        console.error("Error fetching payment methods:", error)
        res.status(500).json({ error: "Error fetching payment methods" })
    }
})

// POST add new payment method
router.post("/add", authenticateUser, authenticateAdmin, async (req, res) => {
    try {
        const { methodType } = req.body
        await paymentMethodModel.addMethod(methodType)
        res.redirect("/admin#payment-method")
    } catch (error) {
        console.error("Error adding payment method:", error)
        res.status(500).redirect("/admin#payment-method")
    }
})

// POST update payment method
router.post("/update/:id", authenticateUser, authenticateAdmin, async (req, res) => {
    try {
        const id = parseInt(req.params.id)
        const { methodType } = req.body
        await paymentMethodModel.updateMethod(id, methodType)
        res.redirect("/admin#payment-method")
    } catch (error) {
        console.error("Error updating payment method:", error)
        res.status(500).redirect("/admin#payment-method")
    }
})

// POST delete payment method
router.post("/delete/:id", authenticateUser, authenticateAdmin, async (req, res) => {
    try {
        const id = parseInt(req.params.id)
        await paymentMethodModel.deleteMethod(id)
        res.redirect("/admin#payment-method")
    } catch (error) {
        console.error("Error deleting payment method:", error)
        res.status(500).redirect("/admin#payment-method")
    }
})

module.exports = router

