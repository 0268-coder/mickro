document.querySelectorAll('.delete-btn').forEach(button => {
    button.addEventListener('click', function() {
        // Access the item ID using the standard .dataset property
        const itemId = this.dataset.itemId;
        const url = `/cart/${itemId}`; 

        fetch(url, { method: 'DELETE' })
        .then(response => {
            if (response.status === 200) {
                console.log(`Item ${itemId} deleted.`);
                // The correct class for the parent container is '.cart-item'
                const cartItem = this.closest('.cart-item');
                if (cartItem) {
                    cartItem.remove();
                }
                return response.json();         
            } else {
                alert('Failed to delete item.');
            }
        }).then(data => {
            if (data) {
                const totalElement = document.getElementById("total-price");
                if (totalElement) {
                    totalElement.textContent = data.newTotal; 
                }
                const checkoutTotal = document.getElementById("checkout-total");
                if (checkoutTotal) {
                    checkoutTotal.textContent = data.newTotal;
                }
                // Update cart count
                const cartItems = document.querySelectorAll('.cart-item');
                const cartCount = document.getElementById("cart-count");
                if (cartCount) {
                    cartCount.textContent = cartItems.length;
                }
                // If cart is empty, reload page
                if (cartItems.length === 0) {
                    window.location.reload();
                }
            }
        })
        .catch(error => {
            console.error('Error:', error);
        });
    });
});