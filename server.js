const express = require('express')
const path = require('path')
const app = express()
const addressModel = require("./models/address");
const {userConnection,adminConnection,staffConnection} = require('./db.js')
const {authenticateUser,authenticateAdmin,authenticateStaff} = require('./middleware/auth.js')
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
const adminPaymentMethodRouter = require('./routes/adminFolder/adminPaymentMethod.js')
const staffOrderRouter = require('./routes/staffFolder/staffOrder.js')
const staffProductRouter = require('./routes/staffFolder/staffProduct.js')


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
app.use("/admin/payment-method",adminPaymentMethodRouter)
app.use("/staff/product",staffProductRouter)
app.use("/staff/order",staffOrderRouter)

app.get("/", authenticateUser, async (req,res)=>{

    const userAddr = await addressModel.getAddress(req.session.user.id);
    req.session.address = userAddr
    const [allProducts] = await adminConnection.query('SELECT * FROM Product')

    res.render("product/product", { userAddress: userAddr, user: req.session.user,product: allProducts })
});

app.get("/staff", authenticateUser,authenticateStaff, async (req,res)=>{
    try {
        // Fetch all orders
        const [orders] = await staffConnection.query(`
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
        const [revenueResult] = await staffConnection.query(`
            SELECT COALESCE(SUM(Order_Total), 0) as totalRevenue
            FROM orders
        `)
        const totalRevenue = revenueResult[0].totalRevenue
        
        // Calculate today's revenue
        const [todayRevenueResult] = await staffConnection.query(`
            SELECT COALESCE(SUM(Order_Total), 0) as todayRevenue
            FROM orders
            WHERE DATE(Order_Date) = CURDATE()
        `)
        const todayRevenue = todayRevenueResult[0].todayRevenue
        
        // Count all orders
        const [orderCountResult] = await staffConnection.query(`
            SELECT COUNT(*) as totalOrders
            FROM orders
        `)
        const totalOrders = orderCountResult[0].totalOrders
        
        // Count today's orders
        const [todayOrdersResult] = await staffConnection.query(`
            SELECT COUNT(*) as todayOrders
            FROM orders
            WHERE DATE(Order_Date) = CURDATE()
        `)
        const todayOrders = todayOrdersResult[0].todayOrders
        
        // Count all users
        const [userCountResult] = await staffConnection.query(`
            SELECT COUNT(*) as totalUsers
            FROM user
        `)
        const totalUsers = userCountResult[0].totalUsers
        
        // Count today's new users (assuming users have a date field, or using ID as proxy)
        // If user table has a created_at or registration_date field, use that
        // For now, I'll count users with today's date if DOB is used as registration
        const [todayUsersResult] = await staffConnection.query(`
            SELECT COUNT(*) as todayUsers
            FROM user
            WHERE DATE(DOB) = CURDATE()
        `)
        const todayUsers = todayUsersResult[0].todayUsers
        
        // Count all products
        const [productCountResult] = await staffConnection.query(`
            SELECT COUNT(*) as totalProducts
            FROM product
        `)
        const totalProducts = productCountResult[0].totalProducts
        
        res.render("staff/staff", { 
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
        console.error("Error fetching staff data:", error)
        res.render("staff/staff", { 
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

app.get("/admin", authenticateUser,authenticateAdmin, async (req,res)=>{
    try {
        // Fetch all orders
        const [orders] = await adminConnection.query(`
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
        const [revenueResult] = await adminConnection.query(`
            SELECT COALESCE(SUM(Order_Total), 0) as totalRevenue
            FROM orders
        `)
        const totalRevenue = revenueResult[0].totalRevenue
        
        // Calculate today's revenue
        const [todayRevenueResult] = await adminConnection.query(`
            SELECT COALESCE(SUM(Order_Total), 0) as todayRevenue
            FROM orders
            WHERE DATE(Order_Date) = CURDATE()
        `)
        const todayRevenue = todayRevenueResult[0].todayRevenue
        
        // Count all orders
        const [orderCountResult] = await adminConnection.query(`
            SELECT COUNT(*) as totalOrders
            FROM orders
        `)
        const totalOrders = orderCountResult[0].totalOrders
        
        // Count today's orders
        const [todayOrdersResult] = await adminConnection.query(`
            SELECT COUNT(*) as todayOrders
            FROM orders
            WHERE DATE(Order_Date) = CURDATE()
        `)
        const todayOrders = todayOrdersResult[0].todayOrders
        
        // Count all users
        const [userCountResult] = await adminConnection.query(`
            SELECT COUNT(*) as totalUsers
            FROM user
        `)
        const totalUsers = userCountResult[0].totalUsers
        
        // Count today's new users (assuming users have a date field, or using ID as proxy)
        // If user table has a created_at or registration_date field, use that
        // For now, I'll count users with today's date if DOB is used as registration
        const [todayUsersResult] = await adminConnection.query(`
            SELECT COUNT(*) as todayUsers
            FROM user
            WHERE DATE(DOB) = CURDATE()
        `)
        const todayUsers = todayUsersResult[0].todayUsers
        
        // Count all products
        const [productCountResult] = await adminConnection.query(`
            SELECT COUNT(*) as totalProducts
            FROM product
        `)
        const totalProducts = productCountResult[0].totalProducts
        
        // Fetch payment methods
        const paymentMethodModel = require('./models/admin_payment_method');
        const paymentMethods = await paymentMethodModel.getPaymentMethod();
        
        // Fetch user login status
        const adminLoginStatusModel = require('./models/admin_login_status');
        const loginStatus = await adminLoginStatusModel.getLoginStatus();
        
        res.render("admin/adminpage", { 
            orders: orders,
            totalRevenue: totalRevenue,
            todayRevenue: todayRevenue,
            totalOrders: totalOrders,
            todayOrders: todayOrders,
            totalUsers: totalUsers,
            todayUsers: todayUsers,
            totalProducts: totalProducts,
            paymentMethods: paymentMethods,
            loginStatus: loginStatus
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
            totalProducts: 0,
            paymentMethods: [],
            loginStatus: []
        });
    }
});

// Update user login status
app.post("/admin/user-status/update", authenticateUser, authenticateAdmin, async (req, res) => {
    try {
        const { username, status } = req.body;
        const adminLoginStatusModel = require('./models/admin_login_status');
        await adminLoginStatusModel.updateLoginStatus(username, status);
        res.redirect("/admin#user-status");
    } catch (error) {
        console.error("Error updating user status:", error);
        res.status(500).redirect("/admin#user-status");
    }
});

app.listen(process.env.PORT || 3000,()=>{
    console.log("server listen on port " + process.env.PORT)
})