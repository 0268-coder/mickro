document.querySelectorAll('.increase-btn').forEach(button => {
    button.addEventListener('click', function() {
        const itemId = this.dataset.itemId;
        const url = `/cart/add/${itemId}`;
        
        fetch(url, { method: "PUT" })
        .then(response => {
            if (response.status === 200) {
                return response.json(); 
            }
            // If server returns 404 or 500, throw error to catch block
            throw new Error(`Server update failed with status: ${response.status}`);
        })
        .then(data => {
            // A. Update Individual Item Quantity
            const itemElement = document.getElementById(`item${itemId}`);
            if (itemElement) {
                const qtySpan = itemElement.querySelector(".quantity-display");
                if (qtySpan) {
                    // Update quantity with number sent from server
                    qtySpan.textContent = data.newQty; 
                }
            }
            
            // B. Update Grand Total Price
            const totalElement = document.getElementById("total-price");
            if (totalElement) {
                // FIX: Remove .toFixed(2) because the server already did it (or should have)
                // This prevents errors if data.newTotal is already a string
                totalElement.textContent = data.newTotal; 
            }
        })
        .catch(err => {
            // This catches the error if the PUT route returned 404/500, or if the server crashed.
            console.error("Cart Update Error:", err);
            alert("Could not update cart quantity. Please try again.");
        });
    });
});