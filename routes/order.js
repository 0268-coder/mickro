// routes/order.js
const express = require('express')
const router = express.Router()
const db = require('../db')

// POST /order/:orderId/received
router.post('/:orderId/received', async (req, res) => {
    const orderId = parseInt(req.params.orderId, 10)

    try {
        // If you have a Status column, you can update it:
        // await db.query(
        //   "UPDATE Orders SET Status = 'RECEIVED' WHERE Order_ID = ?",
        //   [orderId]
        // )

        // After confirming received, send to review page:
        return res.redirect(`/review/${orderId}`)
        // or: return res.redirect('/')
    } catch (err) {
        console.error('Error marking order as received:', err)
        return res.status(500).send('Could not confirm order received.')
    }
})

module.exports = router