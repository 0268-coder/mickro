// routes/review.js
const express = require('express')
const router = express.Router()
const db = require('../db')

// GET /review/:orderId – show review form for that order
router.get('/:orderId', async (req, res) => {
    const orderId = parseInt(req.params.orderId, 10)

    return res.render('review', {
        orderId,
        message: null,
        rating: null,
        comment: ""
    })
})

// POST /review/:orderId – submit review
router.post('/:orderId', async (req, res) => {
    const orderId = parseInt(req.params.orderId, 10) // just for display / linking
    const { rating, comment } = req.body

    if (!rating) {
        return res.status(400).render('review', {
            orderId,
            message: "Please select a rating.",
            rating: null,
            comment
        })
    }

    try {
        // Your Review table: Review_No, User_ID, Review_date, Review_text, Rating
        // Since login is not ready, store User_ID as NULL for now.
        await db.query(
            `INSERT INTO Review
                (User_ID, Review_date, Review_text, Rating)
             VALUES (NULL, NOW(), ?, ?)`,
            [comment, rating]
        )

        // Show success page
        return res.render('review_success', {
            orderId,
            rating,
            comment
        })
    } catch (err) {
        console.error("Error submitting review:", err)
        return res.status(500).render('review', {
            orderId,
            message: "Error saving review. Please try again.",
            rating,
            comment
        })
    }
})

module.exports = router