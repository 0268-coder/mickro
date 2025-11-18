const express = require('express')
const router = express.Router()
const upload = require(`../../multer`)
const path = require('path')
const fs = require('fs/promises')
const productModel = require('../../models/product')
const IMAGE_DIR = 'public/images/product'
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
    .post(upload.single('image'), async (req, res) => {
        const file = req.file; 
    
        if (file) {
            console.log("Original Filename:", file.originalname);
            console.log("MIME Type:", file.mimetype);
            console.log("Saved Path on Server:", file.path); // The temporary path/filename
            console.log("File Size:", file.size);
            
        } else 
        {
            console.log("No file was attached to the request.");
        }
        
            const { name, price, length, height, width} = req.body;

            const finalImagePath = sepPublicPath(file)            
            const result = await productModel.addProduct(name, price, length, height, width, finalImagePath);
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
    .post(upload.single('image'), async (req, res) => {
        const id = req.params.id;
        const file = req.file; // New file metadata (or undefined)
        const { name, price, length, height, width } = req.body;
        
        let pathImageToStore = null; // Path to update in the database
        let oldImagePathOnDisk = null; // Path of the file to potentially delete


        try {
            // 1. Check for Old Image Path (before updating)
            // You need to know the existing image path to delete it later
            const existingProduct = await productModel.getProductByID(id);
            const oldImagePathDB = existingProduct ? existingProduct.image : null;
            // 2. Handle New File Upload
            if (file) {
                // A. Calculate the final file name (e.g., product.ID.ext)
                const tempFileName = req.tempFileName || file.filename;
                const fileExtension = path.extname(file.originalname);
                const finalImageName = `product.${id}${fileExtension}`;
                
                const oldPath = path.join(IMAGE_DIR, tempFileName);
                const newPath = path.join(IMAGE_DIR, finalImageName);
                console.log('old',oldPath,'new',newPath)

                // B. Rename the file using the final Product ID
                await fs.rename(oldPath, newPath);

                // C. Set the database path (use sepPublicPath to ensure web-friendly format)
                // Note: sepPublicPath expects the Multer file object
                // We'll pass a mock object here based on the final name if sepPublicPath relies on file.path
                // Simpler: Just store the finalImageName string if that's your convention
                pathImageToStore = sepPublicPath({path: newPath, originalname: finalImageName}); 
                
                // 3. Delete Old Image (if a new one was uploaded)
                if (oldImagePathDB) {
                    oldImagePathOnDisk = path.join(IMAGE_DIR, path.basename(oldImagePathDB));
                    await fs.unlink(oldImagePathOnDisk).catch(err => console.warn(`Failed to delete old image ${oldImagePathOnDisk}: ${err.message}`));
                }

            } else {
                // If NO new file was uploaded, retain the existing database path
                pathImageToStore = oldImagePathDB;
            }

            // 4. Update Database
            const result = await productModel.updateProductByID(id,name,price,length,height,width,pathImageToStore);
            
            if (result.affectedRows === 0) {
                 return res.status(404).send(`Product ID ${id} not found or no changes made.`);
            }
            
            console.log(`Product ID ${id} updated.`);
            res.redirect('/admin/product'); 
            
        } catch (error) {
            console.error("Error updating product:", error);
            
            // Clean up the NEWLY uploaded file if the DB update failed
            if (file) {
                 const tempPath = path.join(IMAGE_DIR, req.tempFileName || file.filename);
                 await fs.unlink(tempPath).catch(err => console.error("Cleanup failed:", err));
            }
            
            res.status(500).send("Error updating product. Check server logs.");
        }
    });


// --- POST /admin/product/delete/:id (Delete Resource) ---
// Note: We keep this as a separate router.post since DELETE is not part of the standard resource update/fetch pattern
router.post("/delete/:id", async (req, res) => {
    const { id } = req.params;

    try {
       
        deleteImage(id)

        // 2. Delete the product record from the database
        const result = await productModel.deleteProductByID(id);

        if (result.affectedRows === 0) {
            return res.status(404).send(`Product ID ${id} not found.`);
        }
        console.log(`Product ID ${id} deleted successfully.`);
        res.redirect('/admin/product'); 

    } catch (error) {
        // If the file delete fails (e.g., file doesn't exist), we log a warning but proceed
        // If the DB delete fails, we catch the error here.
        console.error(`Error deleting product ID ${id}:`, error.message);
        res.status(500).send("Error processing deletion. Check server logs.");
    }
});

function sepPublicPath(file) {
    if (!file || !file.path) {
        // Handle case where req.file is undefined or null gracefully
        return null;
    }

    const fullPath = file.path; 

    // Define the prefix to remove: 'public/' or 'public\'
    // path.join('public', path.sep) handles the correct separator for the OS.
    const prefixToRemove = path.join('public', path.sep); 

    let relativePath = fullPath;
    
    // Check if the path starts with the expected prefix and remove it
    if (fullPath.startsWith(prefixToRemove)) {
        relativePath = fullPath.substring(prefixToRemove.length);
    }
    
    // Convert backslashes (Windows) to forward slashes (web standard)
    const webPath = relativePath.replace(/\\/g, '/');

    console.log("Full Path:", fullPath);
    console.log("Final Image Path:", webPath);
    
    return webPath;
}

async function deleteImage(id){
     // 1. Get the image path from the database BEFORE deletion
    // Assume this function returns the product's image path string or null
    const productData = await productModel.getImagePathByID(id);

    let imagePathToDelete = null;
    console.log("Product_DATA",productData) 
    if (productData && productData.image) {
        imagePathToDelete = productData.image;
    }
    // 3. Delete the file from the disk (if a path was found)
    console.log("imagePath to delete",imagePathToDelete)
    if (imagePathToDelete) {
        // Construct the full path to the file on the server
        // Note: We use path.basename to ensure we only use the filename stored in DB
        const fullPath = path.join(IMAGE_DIR, path.basename(imagePathToDelete));
        console.log("FullPath",fullPath)
            
        // fs.promises.unlink deletes the file
        await fs.unlink(fullPath);
        console.log(`Successfully deleted file: ${fullPath}`);
    }
}
module.exports = router;