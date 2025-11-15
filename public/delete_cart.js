document.querySelectorAll('.delete-btn').forEach(button => {
    button.addEventListener('click', function() {
        // Access the item ID using the standard .dataset property
        const itemId = this.dataset.itemId;
        const url = `/cart/${itemId}`; 

        fetch(url, { method: 'DELETE' })
        .then(response => {
            if (response.status === 204) {
                console.log(`Item ${itemId} deleted.`);
                // The correct class for the parent container is '.cart-item'
                this.closest('.cart-item').remove();         
            } else {
                alert('Failed to delete item.');
            }
        }).then(data => {
            const totalElement = document.getElementById("total-price");
            if (totalElement) {
                // FIX: Remove .toFixed(2) because the server already did it (or should have)
                // This prevents errors if data.newTotal is already a string
                totalElement.textContent = data.newTotal; 
            }
        
        })
        .catch(error => {
            console.error('Error:', error);
        });
    });
});