const express = require('express')
const path = require('path')
const app = express()
const connection = require('./db')
const session = require('express-session')

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

app.get("/", (req,res)=>{
    res.send("Home Page")
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