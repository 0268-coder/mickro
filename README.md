#Mickro

##Installation guide

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
