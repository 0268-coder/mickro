const express = require('express')
const app = express()
app.use(express.static("public"))
app.use(express.urlencoded({extended: true}))
app.use(express.json());

app.set('view engine','ejs')

app.get("/",(req,res)=>{
    res.render("index",{hey: "World"})
})
const usersrouter = require("./routes/users")

app.use("/users", usersrouter)
app.listen(3000)