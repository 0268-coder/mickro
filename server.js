const express = require('express')
const path = require('path')
const app = express()
//require to use layout
const engine = require('ejs-mate')
//require session
const session = require('express-session')
require('dotenv').config()

//enable session middleware
app.use(session({
    secret: process.env.SECRET,
    resave: false,
    saveUninitialized: false,
}));

//for layout.ejs
app.engine('ejs',engine)
//setup
app.use(express.static("public"))
app.use(express.urlencoded({extended: true}))
app.use(express.json());
app.use((req,res,next)=>{
    res.locals.cart = req.session.cart || []
    next()
})
app.use((req,res,next)=>{
    res.locals.payment_type = req.session.payment_type || ""
    next()
})

//use ejs and views at directiory/views
app.set('view engine','ejs')
app.set('views', path.join(__dirname,"views"))


app.get("/",(req,res)=>{
    req.session.views = (req.session.views || 0) + 1;
    res.render("index",{hey: "World",session: req.session.views})
})

const usersRouter = require("./routes/users")
const loginRouter = require("./routes/login")
const orderRouter = require("./routes/order")
const productRouter = require("./routes/product")
const cartRouter = require("./routes/cart")
const paymentRouter = require("./routes/payment_method")

app.use("/users", usersRouter)
app.use("/login",loginRouter)
app.use("/order",orderRouter)
app.use("/product",productRouter)
app.use("/cart",cartRouter)
app.use("/payment_method",paymentRouter)

app.listen(process.env.PORT || 3000,()=>{
    console.log("server listen on port "+process.env.PORT)
})