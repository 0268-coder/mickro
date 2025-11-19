const express = require('express')
const router = express.Router()
const registerModels = require('../models/register')
const db = require('../db')

// Fixed delivery fee (same as cart.js)
const DELIVERY_FEE = 15.00

// GET /checkout – show checkout page with summary
router.get('/', async (req, res) => {
    try {
        const cart = req.session.cart || []

        // If cart empty, render checkout with empty items
        if (cart.length === 0) {
            return res.render('checkout', {
                cartItems: [],
                subtotal: (0).toFixed(2),
                deliveryFee: DELIVERY_FEE.toFixed(2),
                total: (0).toFixed(2),
                message: "Your cart is empty. Please add some items before checking out."
            })
        }

        let subtotal = 0
        const cartItemsWithDetails = []

        // Same logic as cart.js to get details + compute subtotal
        for (const item of cart) {
            const id = parseInt(item.id, 10)

            const [results] = await db.query(
                "SELECT * FROM Product WHERE Product_ID = ?",
                id
            )

            if (results.length > 0) {
                const product = results[0]
                const price = parseFloat(product.Product_Price)
                const itemTotal = price * item.qty
                subtotal += itemTotal

                cartItemsWithDetails.push({
                    id: item.id,
                    name: item.name,
                    qty: item.qty,
                    price: price,
                    itemTotal: itemTotal.toFixed(2),
                    product: product
                })
            }
        }

        const total = subtotal + DELIVERY_FEE

        return res.render('checkout', {
            cartItems: cartItemsWithDetails,
            subtotal: subtotal.toFixed(2),
            deliveryFee: DELIVERY_FEE.toFixed(2),
            total: total.toFixed(2),
            message: null // or any message you want
        })
    } catch (err) {
        console.error("Error during GET /checkout:", err)
        return res.status(500).render('checkout', {
            cartItems: [],
            subtotal: (0).toFixed(2),
            deliveryFee: DELIVERY_FEE.toFixed(2),
            total: (0).toFixed(2),
            message: "Error loading checkout page. Please try again."
        })
    }
})

/**
 * POST /checkout – place order
 * Expecting fields from a checkout form, e.g.:
 *   req.body.fullName
 *   req.body.address
 *   req.body.phone
 *   req.body.paymentMethod
 */
router.post('/', async (req, res) => {
    const cart = req.session.cart || []
    
    if (cart.length === 0) {
        // Nothing to checkout
        return res.redirect('/cart')
    }
    const { fullName, address, phone, paymentMethod } = req.body

    const connection = db // in case you're using a pool / transaction, adjust here

    try {
        // Recalculate totals again for security
        let subtotal = 0

        for (const item of cart) {
            const itemID = parseInt(item.id, 10)
            const [results] = await connection.query(
                "SELECT Product_Price FROM Product WHERE Product_ID = ?",
                itemID
            )

            if (results.length > 0) {
                const price = parseFloat(results[0].Product_Price)
                subtotal += price * item.qty
            }
        }

        const total = subtotal + DELIVERY_FEE

        // OPTIONAL: If you have user login
        const userId = req.session.user ? req.session.user.id : null

        // 1) Insert into Orders table (change table/column names to match your DB)
        const [orderResult] = await connection.query(
            `INSERT INTO Orders 
                (User_ID, Order_Subtotal, Delivery_Fee, Order_Total, 
                 Full_Name, Address, Phone, Payment_Method, Order_Date)
             VALUES (?, ?, ?, ?, ?, ?, ?, ?, NOW())`,
            [
                userId,
                subtotal,
                DELIVERY_FEE,
                total,
                fullName,
                address,
                phone,
                paymentMethod
            ]
        )

        const orderId = orderResult.insertId

        // 2) Insert each cart item into OrderItems table
        for (const item of cart) {
            const itemID = parseInt(item.id, 10)

            const [results] = await connection.query(
                "SELECT Product_Price FROM Product WHERE Product_ID = ?",
                [itemID]
            )
            console.log(results)
            if (results.length === 0) continue

            const unitPrice = parseFloat(results[0].Product_Price)

            await connection.query(
                `INSERT INTO OrderItems 
                    (Order_ID, Product_ID, Quantity, Unit_Price) 
                 VALUES (?, ?, ?, ?)`,
                [orderId, itemID, item.qty, unitPrice]
            )
        }

        // 3) Clear the cart after successful order
        req.session.cart = []
        console.log("checkout POST")
        // 4) Show success page (or redirect)
        return res.render('checkout_success', {
            orderId: orderId,
            total: total.toFixed(2),
            subtotal: subtotal.toFixed(2),
            deliveryFee: DELIVERY_FEE.toFixed(2),
            fullName,
            address
        })
        // Or: return res.redirect('/orders/' + orderId)

    } catch (err) {
        console.error("Error during POST /checkout:", err)

        // Rebuild cartItemsWithDetails so checkout.ejs doesn't crash
        try {
            const cart = req.session.cart || []
            let subtotal = 0
            const cartItemsWithDetails = []

            for (const item of cart) {
                const id = parseInt(item.id, 10)

                const [results] = await db.query(
                    "SELECT * FROM Product WHERE Product_ID = ?",
                    id
                )

                if (results.length > 0) {
                    const product = results[0]
                    const price = parseFloat(product.Product_Price)
                    const itemTotal = price * item.qty
                    subtotal += itemTotal

                    cartItemsWithDetails.push({
                        id: item.id,
                        name: item.name,
                        qty: item.qty,
                        price: price,
                        itemTotal: itemTotal.toFixed(2),
                        product: product,
                        image: product.image
                    })
                }
            }

            const total = subtotal + DELIVERY_FEE

            return res.status(500).render('checkout', {
                cartItems: cartItemsWithDetails,
                subtotal: subtotal.toFixed(2),
                deliveryFee: DELIVERY_FEE.toFixed(2),
                total: total.toFixed(2),
                message: "Error placing order. Please try again."
            })
        } catch (innerErr) {
            console.error("Error rebuilding cart for error page:", innerErr)
            return res.status(500).render('checkout', {
                cartItems: [],
                subtotal: (0).toFixed(2),
                deliveryFee: DELIVERY_FEE.toFixed(2),
                total: (0).toFixed(2),
                message: "Error placing order. Please try again."
            })
        }
    }
})

module.exports = router