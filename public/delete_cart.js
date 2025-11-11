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
        })
        .catch(error => {
            console.error('Error:', error);
        });
    });
});