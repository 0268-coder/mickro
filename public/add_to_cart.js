const addToCartBtn = document.getElementById('addToCartBtn');
const flashSuccessMsg = document.getElementById('flashSuccessMsg');

function showSuccessMessage(message, duration = 3000) {
    flashSuccessMsg.textContent = message;
    
    // Show the message
    flashSuccessMsg.style.display = 'block';

    // Hide the message after the specified duration (e.g., 3 seconds)
    setTimeout(() => {
        flashSuccessMsg.style.display = 'none';
    }, duration);
}


addToCartBtn.addEventListener('click', async () => {
    // 1. Prepare data to send (Example data)
    const productData = {
        id: 'SKU1234',
        quantity: 1
    };

    try {
        // 2. Send data to your Express server API endpoint
        const response = await fetch('/api/add-to-cart', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(productData)
        });

        // 3. Check for a successful server response (HTTP 200/201)
        if (response.ok) {
            // Server confirmed the item was added
            showSuccessMessage('✅ Product added to cart successfully!');
        } else {
            // Handle server-side errors
            alert('Failed to add item to cart. Server error.');
        }

    } catch (error) {
        // Handle network errors (e.g., server is offline)
        console.error('Network or communication error:', error);
        alert('Could not connect to the server.');
    }
});