<<<<<<< HEAD
สำหรับที่เข้ามาใหม่วิธีเปิด

1) เข้า terminal
2) npm i express
3) npm i --save-dev nodemon
4) npm i ejs
5) npm i dotenv
6) 
=======
# Mickro

## Must-Do:
 - Must insert Authenticate User middleware by req.session.user before allowing user to enter any page. Ideally use Passport library

## Installation guide

1. npm i
2. npm run devStart

## File Structure Guide 
`server.js` --> **file** The server starts here. Integrate route redirection.  
`db.js` --> **file** Establish connection with mysql2 Promise based  
`public` --> **dir** Directory containing static files such as css and images.  
`models` --> **dir** Directory containing MySQL queries files for each particular webpage.  
`routes` --> **dir** Directory containing routes files to specific webpages separated from server.js  
`views` --> **dir** Directory containing .ejs file html and css tailwind webpages.  
`env_template` --> **file** environment template for initial setup  
`middleware` --> **dir** middleware folder stored middleware such as autheticateUser and authenticateAdmin
>>>>>>> Ping
