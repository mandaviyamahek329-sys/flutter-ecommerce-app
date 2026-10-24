import 'package:flutter/material.dart';
import 'payment_screen.dart';

// ============================================================
// GLOBAL ORDERS LIST
// My Orders page aa list use karse
// ============================================================

final List<Map<String, dynamic>> appOrders = [];

class OrderSummaryScreen extends StatelessWidget {
  final Map<String, dynamic> product;
  final int quantity;

  const OrderSummaryScreen({
    super.key,
    required this.product,
    required this.quantity,
  });

  static const Color primaryColor = Color(0xFFE91E63);
  static const Color pageBackground = Color(0xFFFFF9F7);

  @override
  Widget build(BuildContext context) {
    final num price = product['price'] ?? 0;

    final num subtotal = price * quantity;

    const num deliveryCharge = 40;

    final num totalAmount =
        subtotal + deliveryCharge;

    return Scaffold(
      backgroundColor: pageBackground,

      // =========================================================
      // APP BAR
      // =========================================================

      appBar: AppBar(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,

        title: const Text(
          'Order Summary',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      // =========================================================
      // BODY
      // =========================================================

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            // ===================================================
            // PRODUCT CARD
            // ===================================================

            Card(
              elevation: 2,

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),

              child: Padding(
                padding: const EdgeInsets.all(12),

                child: Row(
                  children: [
                    // PRODUCT IMAGE
                    ClipRRect(
                      borderRadius:
                      BorderRadius.circular(12),

                      child: Image.asset(
                        product['image'].toString(),

                        width: 100,
                        height: 110,

                        fit: BoxFit.cover,

                        errorBuilder: (
                            context,
                            error,
                            stackTrace,
                            ) {
                          return Container(
                            width: 100,
                            height: 110,

                            color: Colors.grey.shade200,

                            alignment: Alignment.center,

                            child: const Icon(
                              Icons.image_outlined,
                              size: 45,
                              color: Colors.grey,
                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(width: 15),

                    // PRODUCT INFO
                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,

                        children: [
                          Text(
                            product['name'].toString(),

                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 5),

                          Text(
                            product['category'].toString(),

                            style: const TextStyle(
                              color: Colors.grey,
                            ),
                          ),

                          const SizedBox(height: 10),

                          Text(
                            '₹$price',

                            style: const TextStyle(
                              color: primaryColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 5),

                          Text(
                            'Quantity: $quantity',

                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 25),

            // ===================================================
            // PRICE DETAILS
            // ===================================================

            const Text(
              'Price Details',

              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            Card(
              elevation: 1,

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),

              child: Padding(
                padding: const EdgeInsets.all(18),

                child: Column(
                  children: [
                    _priceRow(
                      'Product Price',
                      '₹$price',
                    ),

                    const SizedBox(height: 14),

                    _priceRow(
                      'Quantity',
                      '$quantity',
                    ),

                    const SizedBox(height: 14),

                    _priceRow(
                      'Subtotal',
                      '₹$subtotal',
                    ),

                    const SizedBox(height: 14),

                    _priceRow(
                      'Delivery Charge',
                      '₹$deliveryCharge',
                    ),

                    const Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 15,
                      ),

                      child: Divider(),
                    ),

                    Row(
                      children: [
                        const Expanded(
                          child: Text(
                            'Total Amount',

                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        Text(
                          '₹$totalAmount',

                          style: const TextStyle(
                            color: primaryColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // ===================================================
            // DELIVERY CARD
            // ===================================================

            Card(
              child: ListTile(
                leading: const Icon(
                  Icons.local_shipping_outlined,
                  color: primaryColor,
                ),

                title: const Text(
                  'Delivery',

                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                subtitle: const Text(
                  'Standard Delivery',
                ),

                trailing: const Text(
                  '₹40',

                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 15),

            // ===================================================
            // PAYMENT CARD
            // ===================================================

            const Card(
              child: ListTile(
                leading: Icon(
                  Icons.payments_outlined,
                  color: primaryColor,
                ),

                title: Text(
                  'Payment Method',

                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                subtitle: Text(
                  'Choose on next screen',
                ),

                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                ),
              ),
            ),

            const SizedBox(height: 100),
          ],
        ),
      ),

      // =========================================================
      // BOTTOM BAR
      // =========================================================

      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(12),

          decoration: BoxDecoration(
            color: Colors.white,

            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 10,
                offset: const Offset(0, -2),
              ),
            ],
          ),

          child: Row(
            children: [
              // TOTAL
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,

                  crossAxisAlignment:
                  CrossAxisAlignment.start,

                  children: [
                    const Text(
                      'Total',

                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),

                    Text(
                      '₹$totalAmount',

                      style: const TextStyle(
                        color: primaryColor,
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              // PLACE ORDER
              Expanded(
                child: SizedBox(
                  height: 52,

                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,

                        MaterialPageRoute(
                          builder: (context) =>
                              PaymentScreen(
                                product: product,
                                quantity: quantity,
                                totalAmount: totalAmount,

                                // =====================================
                                // PAYMENT SUCCESS
                                // SAVE ORDER
                                // =====================================

                                onPaymentSuccess: () {
                                  final Map<String, dynamic>
                                  order =
                                  Map<String, dynamic>.from(
                                    product,
                                  );

                                  order['quantity'] = quantity;

                                  order['subtotal'] = subtotal;

                                  order['deliveryCharge'] =
                                      deliveryCharge;

                                  order['total'] = totalAmount;

                                  order['status'] =
                                  'Order Placed';

                                  appOrders.insert(
                                    0,
                                    order,
                                  );
                                },
                              ),
                        ),
                      );
                    },

                    icon: const Icon(
                      Icons.arrow_forward,
                    ),

                    label: const Text(
                      'Place Order',

                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,

                      foregroundColor: Colors.white,

                      shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // PRICE ROW
  // ============================================================

  static Widget _priceRow(
      String title,
      String value,
      ) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,

            style: const TextStyle(
              fontSize: 15,
            ),
          ),
        ),

        Text(
          value,

          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}