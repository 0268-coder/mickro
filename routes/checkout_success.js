res.render('checkout_success', {
  orderId,
  total: total.toFixed(2),
  subtotal: subtotal.toFixed(2),
  deliveryFee: DELIVERY_FEE.toFixed(2),
  fullName,
  address
})