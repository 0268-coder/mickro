document.querySelectorAll('.decrease-btn').forEach(button => {
    button.addEventListener('click', function() {
        const itemId = this.dataset.itemId;
        const url = `/cart/remove/${itemId}`; // New route URL

        fetch(url, { method: "PUT" })
        .then(response => {
            if (response.status === 200) {
                return response.json();
            }
            throw new Error(`Server status: ${response.status}. Failed to update.`);
        })
        .then(data => {
            const itemElement = document.getElementById(`item${itemId}`);
            
            // A. Handle Item Deletion
            if (data.deleted === true && itemElement) {
                itemElement.remove(); // Remove the entire item row from the DOM
            } 
            // B. Handle Quantity Decrease
            else if (itemElement) {
                const qtySpan = itemElement.querySelector(".quantity-display");
                if (qtySpan) {
                    qtySpan.textContent = data.newQty; // Update the displayed quantity
                }
            }
            
            // C. Update Grand Total Price (Same as increase logic)
            const totalElement = document.getElementById("total-price");
            if (totalElement) {
                totalElement.textContent = data.newTotal; 
            }
        })
        .catch(err => {
            console.error("Decrease Error:", err);
            alert("Could not decrease item quantity. Please try again.");
        });
    });
});