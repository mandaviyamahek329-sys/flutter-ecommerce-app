import 'package:flutter/material.dart';
import 'payment_screen.dart';

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

  @override
  Widget build(BuildContext context) {
    final double price =
    (product['price'] as num).toDouble();

    final double oldPrice =
    (product['oldPrice'] as num).toDouble();

    final double mrpTotal =
        oldPrice * quantity;

    final double offerTotal =
        price * quantity;

    final double discountAmount =
        mrpTotal - offerTotal;

    final int discountPercent =
    oldPrice > price
        ? (((oldPrice - price) / oldPrice) * 100)
        .round()
        : 0;

    const double deliveryCharge = 40;

    final double finalTotal =
        offerTotal + deliveryCharge;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),

      appBar: AppBar(
        title: const Text('Order Summary'),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            // ==================================================
            // PRODUCT CARD
            // ==================================================

            Card(
              elevation: 1,

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),

              child: Padding(
                padding: const EdgeInsets.all(12),

                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Container(
                      width: 100,
                      height: 120,

                      padding: const EdgeInsets.all(5),

                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),

                      child: Image.asset(
                        product['image'].toString(),

                        fit: BoxFit.contain,

                        errorBuilder: (
                            context,
                            error,
                            stackTrace,
                            ) {
                          return const Icon(
                            Icons.image_not_supported_outlined,
                            color: Colors.grey,
                            size: 40,
                          );
                        },
                      ),
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,

                        children: [
                          Text(
                            product['name'].toString(),

                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 5),

                          Text(
                            product['subCategory']
                                ?.toString() ??
                                '',

                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),

                          const SizedBox(height: 10),

                          Row(
                            children: [
                              Text(
                                '₹${price.toStringAsFixed(0)}',

                                style: const TextStyle(
                                  color: primaryColor,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const SizedBox(width: 8),

                              if (oldPrice > price)
                                Text(
                                  '₹${oldPrice.toStringAsFixed(0)}',

                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                    decoration:
                                    TextDecoration.lineThrough,
                                  ),
                                ),
                            ],
                          ),

                          if (discountPercent > 0) ...[
                            const SizedBox(height: 5),

                            Text(
                              '$discountPercent% OFF',

                              style: TextStyle(
                                color: Colors.green.shade700,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ],

                          const SizedBox(height: 10),

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

            const SizedBox(height: 15),

            // ==================================================
            // PRICE DETAILS
            // ==================================================

            const Text(
              'Price Details',

              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Card(
              elevation: 1,

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),

              child: Padding(
                padding: const EdgeInsets.all(14),

                child: Column(
                  children: [
                    _priceRow(
                      'MRP ($quantity item${quantity > 1 ? 's' : ''})',
                      '₹${mrpTotal.toStringAsFixed(0)}',
                    ),

                    const SizedBox(height: 12),

                    _priceRow(
                      'Discount ($discountPercent% OFF)',
                      '- ₹${discountAmount.toStringAsFixed(0)}',
                      valueColor: Colors.green.shade700,
                    ),

                    const SizedBox(height: 12),

                    _priceRow(
                      'Offer Price',
                      '₹${offerTotal.toStringAsFixed(0)}',
                    ),

                    const SizedBox(height: 12),

                    _priceRow(
                      'Delivery Charge',
                      '₹${deliveryCharge.toStringAsFixed(0)}',
                    ),

                    const Padding(
                      padding:
                      EdgeInsets.symmetric(vertical: 12),

                      child: Divider(
                        height: 1,
                      ),
                    ),

                    _priceRow(
                      'Total Amount',
                      '₹${finalTotal.toStringAsFixed(0)}',
                      isBold: true,
                    ),
                  ],
                ),
              ),
            ),

            // ==================================================
            // SAVING MESSAGE
            // ==================================================

            if (discountAmount > 0)
              Container(
                width: double.infinity,

                margin: const EdgeInsets.only(top: 10),

                padding: const EdgeInsets.all(12),

                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),

                child: Text(
                  'You save ₹${discountAmount.toStringAsFixed(0)} on this order 🎉',

                  style: TextStyle(
                    color: Colors.green.shade800,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ),

            const SizedBox(height: 90),
          ],
        ),
      ),

      // ========================================================
      // BOTTOM PAYMENT BAR
      // ========================================================

      bottomNavigationBar: SafeArea(
        child: Container(
          color: Colors.white,

          padding: const EdgeInsets.fromLTRB(
            12,
            10,
            12,
            10,
          ),

          child: Row(
            children: [
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
                        fontSize: 11,
                      ),
                    ),

                    Text(
                      '₹${finalTotal.toStringAsFixed(0)}',

                      style: const TextStyle(
                        color: primaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: 48,

                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,

                      MaterialPageRoute(
                        builder: (context) =>
                            PaymentScreen(
                              product: product,
                              quantity: quantity,
                              totalAmount: finalTotal,

                              onPaymentSuccess: () {
                                appOrders.insert(
                                  0,
                                  {
                                    'name': product['name'],
                                    'image': product['image'],
                                    'price': product['price'],
                                    'oldPrice':
                                    product['oldPrice'],
                                    'category':
                                    product['category'],
                                    'subCategory':
                                    product['subCategory'],
                                    'quantity': quantity,
                                    'total': finalTotal,
                                  },
                                );
                              },
                            ),
                      ),
                    );
                  },

                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    foregroundColor: Colors.white,

                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                    ),

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),

                  child: const Text(
                    'Proceed to Payment',

                    style: TextStyle(
                      fontWeight: FontWeight.bold,
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

  Widget _priceRow(
      String title,
      String value, {
        Color? valueColor,
        bool isBold = false,
      }) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,

            style: TextStyle(
              fontSize: isBold ? 15 : 13,

              fontWeight:
              isBold
                  ? FontWeight.bold
                  : FontWeight.normal,
            ),
          ),
        ),

        Text(
          value,

          style: TextStyle(
            fontSize: isBold ? 17 : 13,

            color:
            valueColor ??
                (isBold
                    ? primaryColor
                    : Colors.black87),

            fontWeight:
            isBold
                ? FontWeight.bold
                : FontWeight.w500,
          ),
        ),
      ],
    );
  }
}