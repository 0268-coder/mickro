const express = require('express')
const router = express.Router()
const {userConnection,adminConnection,staffConnection} = require('../../db')
const db = adminConnection

// GET all orders for admin
router.get("/", async (req, res) => {
    try {
        // Fetch all orders
        const [orders] = await db.query(`
            SELECT 
                Order_ID,
                Full_Name,
                Phone,
                Address,
                Order_Date,
                Payment_Method,
                Order_Total
            FROM orders
            ORDER BY Order_Date DESC
        `)
        
        // Calculate total revenue
        const [revenueResult] = await db.query(`
            SELECT COALESCE(SUM(Order_Total), 0) as totalRevenue
            FROM orders
        `)
        const totalRevenue = revenueResult[0].totalRevenue
        
        // Calculate today's revenue
        const [todayRevenueResult] = await db.query(`
            SELECT COALESCE(SUM(Order_Total), 0) as todayRevenue
            FROM orders
            WHERE DATE(Order_Date) = CURDATE()
        `)
        const todayRevenue = todayRevenueResult[0].todayRevenue
        
        // Count all orders
        const [orderCountResult] = await db.query(`
            SELECT COUNT(*) as totalOrders
            FROM orders
        `)
        const totalOrders = orderCountResult[0].totalOrders
        
        // Count today's orders
        const [todayOrdersResult] = await db.query(`
            SELECT COUNT(*) as todayOrders
            FROM orders
            WHERE DATE(Order_Date) = CURDATE()
        `)
        const todayOrders = todayOrdersResult[0].todayOrders
        
        // Count all users
        const [userCountResult] = await db.query(`
            SELECT COUNT(*) as totalUsers
            FROM user
        `)
        const totalUsers = userCountResult[0].totalUsers
        
        // Count today's new users
        const [todayUsersResult] = await db.query(`
            SELECT COUNT(*) as todayUsers
            FROM user
            WHERE DATE(DOB) = CURDATE()
        `)
        const todayUsers = todayUsersResult[0].todayUsers
        
        // Count all products
        const [productCountResult] = await db.query(`
            SELECT COUNT(*) as totalProducts
            FROM product
        `)
        const totalProducts = productCountResult[0].totalProducts
        
        res.render("admin/adminpage", { 
            orders: orders,
            totalRevenue: totalRevenue,
            todayRevenue: todayRevenue,
            totalOrders: totalOrders,
            todayOrders: todayOrders,
            totalUsers: totalUsers,
            todayUsers: todayUsers,
            totalProducts: totalProducts
        })
    } catch (error) {
        console.error("Error fetching orders:", error)
        res.status(500).send("Error fetching orders")
    }
})

module.exports = router

