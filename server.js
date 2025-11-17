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

app.use("/login",loginRouter)
app.use("/register", registerRouter);
app.use("/address", addressRouter);
app.use("/order",orderRouter)
app.use("/product",productRouter)
app.use("/cart",cartRouter)
app.use("/payment_method",paymentRouter)
app.use("/checkout",checkoutRouter)
app.use("/review",reviewRouter)
app.use("/order",orderRouter)
app.use("/admin/product",adminProductRouter)

app.get("/", authenticateUser, async (req,res)=>{

    const userAddr = await addressModel.getAddress(req.session.user.id);
    req.session.address = userAddr
    const [allProducts] = await db.query('SELECT * FROM Product')

    res.render("product/product", { userAddress: userAddr, user: req.session.user,product: allProducts })
});

app.get("/admin", authenticateUser,authenticateAdmin, (req,res)=>{
    res.render("admin/adminpage");
});

app.listen(process.env.PORT || 3000,()=>{
    console.log("server listen on port " + process.env.PORT)
})