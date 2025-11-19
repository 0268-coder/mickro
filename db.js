const mysql = require('mysql2')
require('dotenv').config()

//setup mysql server
//createPool so that it not multiple create connection
const userConnection = mysql.createPool({
    host: process.env.DB_HOST,
    port: process.env.DB_PORT,
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_NAME,
    waitForConnections: true,
    connectionLimit: 10,   // how many connections to keep open
    queueLimit: 0          // 0 = unlimited queued requests
}).promise();

const adminConnection = mysql.createPool({
    host: process.env.DB_HOST,
    port: process.env.DB_PORT,
    user: process.env.DB_ADMINUSER,
    password: process.env.DB_ADMINPASSWORD,
    database: process.env.DB_NAME,
    waitForConnections: true,
    connectionLimit: 10,   // how many connections to keep open
    queueLimit: 0 
}).promise()

const staffConnection = mysql.createPool({
    host: process.env.DB_HOST,
    port: process.env.DB_PORT,
    user: process.env.DB_STAFFUSER,
    password: process.env.DB_STAFFPASSWORD,
    database: process.env.DB_NAME,
    waitForConnections: true,
    connectionLimit: 10,   // how many connections to keep open
    queueLimit: 0 
}).promise()

module.exports = {userConnection, adminConnection, staffConnection};