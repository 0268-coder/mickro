const connection = require('../db')

const productModel = {
    getAllProduct: async()=>{
        const [result] = await connection.query("SELECT * FROM Product")
        return result
    },

    getProductByID: async(id)=>{
        const [result] = await connection.query(
            `SELECT * FROM Product WHERE Product_ID = ?`,
        [id])
        return result[0]
    },

    getImagePathByID: async(id)=>{
        const [result] = await connection.query(
            `SELECT image FROM Product WHERE Product_ID = ?`,
        [id])
        return result[0]
    },

    addProduct: async(name,price,length,height,width,image)=>{
        const [result] = await connection.query(`
            INSERT INTO Product(Product_Name,Product_Price,Length,Height,Width,image)
            VALUES(?,?,?,?,?,?)`,
        [name,price,length,height,width,image])
        
        return {message: "insert to product", product: result.insertId}
    },
    
    updateProductByID: async(id,name,price,length,height,width,image)=>{
        console.log("updateProductModel",name,price,length,height,width,image,id)
        const[result] = await connection.query(`
            UPDATE product
            SET 
                Product_Name = ?,
                Product_Price = ?,
                Length = ?,
                Height = ?,
                Width = ?,
                image = ?
            WHERE Product_ID = ?`,
        [name,price,length,height,width,image,id])
        return {message: "update product",product: result.affectedRows}
    },
    
    deleteProductByID: async(id)=>{
        const [result] = await connection.query(`
            DELETE FROM Product
            WHERE Product_ID = ?`,
        [id])

        return {message: "delete product", product: result.insertId}
    }

}

module.exports = productModel