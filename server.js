const express = require('express')
const path = require('path')
const app = express()
//load mysql
const mysql = require('mysql')
require('dotenv').config()

//setup
app.use(express.static("public"))
app.use(express.urlencoded({extended: true}))
app.use(express.json());

//setup mysql server
const connection = mysql.createConnection({
    host: process.env.DB_HOST,
    port: process.env.DB_PORT,
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_NAME
})

//connect to mamp
connection.connect(function(err) {
    if (err) throw err;
    console.log("Connected!")
})

connection.query('SELECT * from review where product_id = 1', (err, result, fields) => {
  if (err) throw err

  console.log(result)
})


//use ejs and views at directiory/views
app.set('view engine','ejs')
app.set('views', path.join(__dirname,"views"))

//
app.get("/",(req,res)=>{
    res.render("public",{hey: "World"})
})

const usersRouter = require("./routes/users")
const loginRouter = require("./routes/login")

app.use("/users", usersRouter)
app.use("/login",loginRouter)


app.listen(process.env.PORT || 3000,()=>{
    console.log("server listen on port "+process.env.PORT)
})