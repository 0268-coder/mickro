const express = require('express')
const path = require('path')
const app = express()
const addressModel = require("./models/address");
const db = require('./db')
//require to use layout
const engine = require('ejs-mate')
//require session
const session = require('express-session')
require('dotenv').config()
//use ejs and views at directiory/views
app.set('view engine', 'ejs')
app.set('views', path.join(__dirname, "views"))

//for layout.ejs
app.engine('ejs',engine)
//setup
app.use(express.static("public"))
app.use(express.urlencoded({extended: true}))
app.use(express.json());
//enable session
app.use(session({
    secret: process.env.SESSION_SECRET,
    resave: false,
    saveUninitialized: false,
    cookie: { maxAge: 1000 * 60 * 60 * 24 }
}));
app.use((req,res,next)=>{
    res.locals.cart = req.session.cart || []
    res.locals.payment_type = req.session.payment_type || ""
    res.locals.userAddress = req.session.address || ""
    next()
})


//middleware to check if user is logged in
function authenticateUser(req, res, next){
    console.log("funciton authenticateUser")
    if(!req.session.user) {
        return res.redirect("/login");
    }
    next();
};

function authenticateAdmin(req, res, next){
    if(!req.session.user.isAdmin) {
        return res.redirect("/login");
    }
    next();
};


const registerRouter = require("./routes/register");
const loginRouter = require("./routes/login")
const addressRouter = require("./routes/address");
const productRouter = require("./routes/product")
const cartRouter = require("./routes/cart")
const paymentRouter = require("./routes/payment_method")
const checkoutRouter = require("./routes/checkout")
const reviewRouter = require("./routes/review")
const orderRouter = require("./routes/order")
const adminProductRouter = require('./routes/adminFolder/adminProduct.js')
const adminOrderRouter = require('./routes/adminFolder/adminOrder.js')

app.use("/login",loginRouter)
app.use("/register", registerRouter);
app.use("/address", addressRouter);
app.use("/product",productRouter)
app.use("/cart",cartRouter)
app.use("/payment_method",paymentRouter)
app.use("/checkout",checkoutRouter)
app.use("/review",reviewRouter)
app.use("/order",orderRouter)
app.use("/admin/product",adminProductRouter)
app.use("/admin/order",adminOrderRouter)

app.get("/", authenticateUser, async (req,res)=>{

    const userAddr = await addressModel.getAddress(req.session.user.id);
    req.session.address = userAddr
    const [allProducts] = await db.query('SELECT * FROM Product')

    res.render("product/product", { userAddress: userAddr, user: req.session.user,product: allProducts })
});

app.get("/admin", authenticateUser,authenticateAdmin, async (req,res)=>{
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
        
        // Count today's new users (assuming users have a date field, or using ID as proxy)
        // If user table has a created_at or registration_date field, use that
        // For now, I'll count users with today's date if DOB is used as registration
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
        });
    } catch (error) {
        console.error("Error fetching admin data:", error)
        res.render("admin/adminpage", { 
            orders: [],
            totalRevenue: 0,
            todayRevenue: 0,
            totalOrders: 0,
            todayOrders: 0,
            totalUsers: 0,
            todayUsers: 0,
            totalProducts: 0
        });
    }
});

app.listen(process.env.PORT || 3000,()=>{
    console.log("server listen on port " + process.env.PORT)
})