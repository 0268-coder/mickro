const express = require('express')
const router = express.Router()
const productModel = require('../../models/product')
const { authenticateAdmin, authenticateUser } = require('../../middleware/auth');

// --- /admin/product (Base Resource: List & Create) ---
router
    .route("/")
    
    // GET /admin/product (List all products)
    .get(async (req, res) => {
        const allProduct = await productModel.getAllProduct()
        res.render("admin/product/product",{product:allProduct});
    })     

router. 
    route("/add")
    .get(async(req,res)=>{
        res.render("admin/product/addPage")
    })
    // POST /admin/product (Add a new product - handles form submission)
    .post(async (req, res) => {
        const { name, price, length, height, width, image } = req.body;
        const finalImage = image === '' ? null : image;

        const result = await productModel.addProduct(name, price, length, height, width, finalImage);
        console.log("New Product Created:", result);
        res.redirect('/admin/product'); // Redirect to the list view
    });

// --- /admin/product/update/:id (Specific Resource: Fetch & Update) ---
router
    .route("/update/:id")
    .get(async (req, res) => {
        const id = req.params.id;
        try {
            const product = await productModel.getProductByID(id);
            
            if (!product) {
                return res.status(404).json({ message: "Product not found." });
            }
            
            // NOTE: Render the edit form in a real application
            console.log("get product/id",product)
            res.render("admin/product/updatePage",{product: product});
        } catch (error) {
            console.error("Error fetching product for update:", error);
            res.status(500).json({ message: "Failed to fetch product for editing." });
        }
    })
    
    // POST /admin/product/update/:id (Process update form submission)
    .post(async (req, res) => {
        const id = req.params.id;
        const {name,price,length,height,width,image} = req.body
        console.log("check for value",name,price,length,height,width,image)
        try {
            const result = await productModel.updateProductByID(id,name,price,length,height,width,image);
            
            if (result.affectedRows === 0) {
                 return res.status(404).send(`Product ID ${id} not found.`);
            }
            
            console.log(`Product ID ${id} updated.`);
            res.redirect('/admin/product'); 
        } catch (error) {
            console.error("Error updating product:", error);
            res.status(500).send("Error updating product. Check server logs.");
        }
    });


// --- POST /admin/product/delete/:id (Delete Resource) ---
// Note: We keep this as a separate router.post since DELETE is not part of the standard resource update/fetch pattern
router.post("/delete/:id", async (req, res) => {
    const id = req.params.id;
    const result = await productModel.deleteProductByID(id);
        
    console.log(`Product ID ${id} deleted successfully.`);
    res.redirect('/admin/product'); 
});


module.exports = router;