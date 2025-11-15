const express = require('express')
const path = require('path')
const app = express()
const connection = require('./db')
require('dotenv').config()

//setup
app.use(express.static("public"))
app.use(express.urlencoded({extended: true}))
app.use(express.json());

//use ejs and views at directiory/views
app.set('view engine', 'ejs')
app.set('views', path.join(__dirname, "views"))

app.get("/", (req,res)=>{
    res.send("Home Page")
});

const loginRouter = require("./routes/login");
const registerRouter = require("./routes/register");

app.use("/login",loginRouter)
app.use("/register", registerRouter);

app.listen(process.env.PORT || 3000,()=>{
    console.log("server listen on port " + process.env.PORT)
})