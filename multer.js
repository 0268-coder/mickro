const multer = require('multer');
const path = require('path');

// Define the storage configuration
const storage = multer.diskStorage({
    destination: (req, file, cb) => {
        // Set the directory where files should be saved
        cb(null, 'public/images/product');
    },
    filename: (req, file, cb) => {
        // Use a simple naming convention (e.g., fieldname-timestamp.ext)
        const uniqueSuffix = Date.now() + '-' + Math.round(Math.random() * 1E9);
        const fileExtension = path.extname(file.originalname);
        cb(null, file.fieldname + '-' + uniqueSuffix + fileExtension);
    }
});

// Create the main Multer instance
const upload = multer({ 
    storage: storage,
    limits: { 
        fileSize: 5 * 1024 * 1024 // Optional: Limit file size to 5MB 
    }
});

// Export the configured Multer object
module.exports = upload;