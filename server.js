const express = require('express')
const path = require('path')
const app = express()
const connection = require('./db')
const session = require('express-session')
const addressModel = require("./models/address");

require('dotenv').config()


//setup
app.use(express.static("public"))
app.use(express.urlencoded({extended: true}))
app.use(express.json());

app.use(session({
    secret: process.env.SESSION_SECRET,
    resave: false,
    saveUninitialized: false,
    cookie: { maxAge: 1000 * 60 * 60 * 24 }
}));

//use ejs and views at directiory/views
app.set('view engine', 'ejs')
app.set('views', path.join(__dirname, "views"))

//middleware to check if user is logged in
function authenticateUser(req, res, next){
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

app.get("/", authenticateUser, async (req,res)=>{

    const userAddress = await addressModel.getAddress(req.session.user.id);

    res.render("homepage", { userAddress, user: req.session.user })
});

app.get("/admin", authenticateUser, (req,res)=>{
    res.render("adminpage");
});

const loginRouter = require("./routes/login");
const registerRouter = require("./routes/register");
const addressRouter = require("./routes/address");

app.use("/login",loginRouter)
app.use("/register", registerRouter);
app.use("/address", addressRouter);

app.listen(process.env.PORT || 3000,()=>{
    console.log("server listen on port " + process.env.PORT)
})