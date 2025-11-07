const mysql = require('mysql2')
require('dotenv').config()

//setup mysql server
//createPool so that it not multiple create connection
const connection = mysql.createPool({
    host: process.env.DB_HOST,
    port: process.env.DB_PORT,
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_NAME,
    waitForConnections: true,
    connectionLimit: 10,   // how many connections to keep open
    queueLimit: 0          // 0 = unlimited queued requests
});

module.exports = connection.promise();