const express = require('express');
const router = express.Router();
const upload = require(`../../multer`);
const path = require('path');
const fs = require('fs/promises'); // Use promises version
const productModel = require('../../models/product');
const IMAGE_DIR = 'public/images/product';

//cut public from images
function sepPublicPath(fullPath) {
    if (!fullPath) return null;

    // 1. Remove 'public' from the start
    // path.join creates 'public/' on Mac/Linux and 'public\' on Windows
    const prefixToRemove = 'public' + path.sep; 
    
    let relativePath = fullPath;
    if (fullPath.startsWith(prefixToRemove)) {
        relativePath = fullPath.substring(prefixToRemove.length);
    }

    // 2. CRITICAL: Force forward slashes for URLs (Standardizes Windows paths)
    return relativePath.split(path.sep).join('/'); 
}

//delete image
async function deleteImage(id) {
    try {
        // Get path from DB
        const productData = await productModel.getImagePathByID(id);
        if (!productData || !productData.image) return;

        // Construct full system path
        // productData.image is like "images/product/foo.jpg"
        // We need to add "public/" back to it to find it on the disk
        const fullPath = path.join('public', productData.image);

        // Check if file exists before trying to delete
        await fs.access(fullPath); 
        await fs.unlink(fullPath);
        console.log(`Deleted file: ${fullPath}`);
    } catch (error) {
        // It is okay if file doesn't exist (ENOENT), otherwise log it
        if (error.code !== 'ENOENT') {
            console.warn(`Failed to delete image for ID ${id}:`, error.message);
        }
    }
}

// ================= ROUTES =================

router.route("/")
    .get(async (req, res) => {
        try {
            const allProduct = await productModel.getAllProduct();
            res.render("staff/product/product", { product: allProduct });
        } catch (err) {
            console.error(err);
            res.status(500).send("Database Error");
        }
    });

router.route("/add")
    .get((req, res) => {
        res.render("staff/product/addPage");
    })
    .post(upload.single('image'), async (req, res) => {
        try {
            const file = req.file;
            const { name, price, length, height, width } = req.body;

            let finalImagePath = null;
            if (file) {
                // Pass file.path (string) to the helper
                finalImagePath = sepPublicPath(file.path); 
            }

            await productModel.addProduct(name, price, length, height, width, finalImagePath);
            res.redirect('/staff/product');
        } catch (err) {
            console.error("Add Product Error:", err);
            res.status(500).send("Failed to add product.");
        }
    });

router.route("/update/:id")
    .get(async (req, res) => {
        try {
            const product = await productModel.getProductByID(req.params.id);
            if (!product) return res.status(404).send("Product not found.");
            res.render("staff/product/updatePage", { product });
        } catch (error) {
            console.error(error);
            res.status(500).send("Server Error");
        }
    })
    .post(upload.single('image'), async (req, res) => {
        const id = req.params.id;
        const file = req.file;
        const { name, price, length, height, width } = req.body;

        try {
            let pathImageToStore = null; // New path to save to DB

            // 1. Handle File Upload (If a new file exists)
            if (file) {
                // A. Get the old image path from DB so we can delete it later
                const existingProduct = await productModel.getProductByID(id);
                const oldDbImage = existingProduct ? existingProduct.image : null;

                // B. Rename the NEW file to be cleaner (Optional step you had)
                // Multer saves as "fieldname-timestamp.ext"
                // We want "product.ID.ext"
                const fileExtension = path.extname(file.originalname);
                const newFileName = `product.${id}${fileExtension}`;
                const newPath = path.join(IMAGE_DIR, newFileName);

                // Rename the file on disk
                await fs.rename(file.path, newPath);

                // C. Generate web-ready path
                pathImageToStore = sepPublicPath(newPath);

                // D. Delete the OLD image from disk
                if (oldDbImage) {
                   const oldFullPath = path.join('public', oldDbImage);
                   await fs.unlink(oldFullPath).catch(err => {}); // Ignore if old file missing
                }
            } else {
                // If no new file, keep the old path from DB
                // (You might need to fetch it again if your DB update requires the image field)
                const existingProduct = await productModel.getProductByID(id);
                pathImageToStore = existingProduct.image;
            }

            // 2. Update Database
            await productModel.updateProductByID(id, name, price, length, height, width, pathImageToStore);
            res.redirect('/staff/product');

        } catch (error) {
            console.error("Update Error:", error);
            // Cleanup: If the process failed but we uploaded a file, delete the orphan file
            if (file) await fs.unlink(file.path).catch(() => {});
            res.status(500).send("Error updating product");
        }
    });

router.post("/delete/:id", async (req, res) => {
    const { id } = req.params;
    try {
        // 1. Delete the image first
        await deleteImage(id); // <--- ADDED AWAIT HERE

        // 2. Delete from DB
        const result = await productModel.deleteProductByID(id);
        
        if (result.affectedRows === 0) {
             return res.status(404).send(`Product ID ${id} not found.`);
        }
        
        res.redirect('/staff/product');
    } catch (error) {
        console.error(error);
        res.status(500).send("Error processing deletion.");
    }
});

module.exports = router;