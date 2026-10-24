import 'package:flutter/material.dart';

class PaymentScreen extends StatefulWidget {
  final Map<String, dynamic> product;
  final int quantity;
  final num totalAmount;
  final VoidCallback onPaymentSuccess;

  const PaymentScreen({
    super.key,
    required this.product,
    required this.quantity,
    required this.totalAmount,
    required this.onPaymentSuccess,
  });

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  static const Color primaryColor = Color(0xFFE91E63);

  String selectedPayment = 'cod';
  bool isProcessing = false;

  // ============================================================
  // DUMMY PAYMENT
  // ============================================================

  Future<void> makeDummyPayment() async {
    if (isProcessing) return;

    setState(() {
      isProcessing = true;
    });

    // Fake payment processing
    await Future.delayed(
      const Duration(seconds: 2),
    );

    if (!mounted) return;

    // Save order in My Orders
    widget.onPaymentSuccess();

    setState(() {
      isProcessing = false;
    });

    // Show success dialog
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),

          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircleAvatar(
                radius: 35,
                backgroundColor: Colors.green,
                child: Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 42,
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                'Order Successful!',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              Text(
                selectedPayment == 'cod'
                    ? 'Your order has been placed successfully.'
                    : 'Dummy payment of ₹${widget.totalAmount} was successful.',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(dialogContext);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Continue'),
                ),
              ),
            ],
          ),
        );
      },
    );

    if (!mounted) return;

    // Payment -> Order Summary -> Product Detail
    Navigator.pop(context);
    Navigator.pop(context);
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF9F7),

      appBar: AppBar(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        title: const Text(
          'Payment',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ====================================================
            // TOTAL AMOUNT
            // ====================================================

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),

              child: Column(
                children: [
                  const Text(
                    'Total Amount',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                    ),
                  ),

                  const SizedBox(height: 7),

                  Text(
                    '₹${widget.totalAmount}',
                    style: const TextStyle(
                      color: primaryColor,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              'Select Payment Method',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            // ====================================================
            // UPI
            // ====================================================

            _paymentOption(
              value: 'upi',
              icon: Icons.account_balance_wallet_outlined,
              title: 'UPI',
              subtitle: 'Google Pay, PhonePe, Paytm',
            ),

            const SizedBox(height: 12),

            // ====================================================
            // CARD
            // ====================================================

            _paymentOption(
              value: 'card',
              icon: Icons.credit_card,
              title: 'Credit / Debit Card',
              subtitle: 'Visa, Mastercard, RuPay',
            ),

            const SizedBox(height: 12),

            // ====================================================
            // NET BANKING
            // ====================================================

            _paymentOption(
              value: 'netbanking',
              icon: Icons.account_balance_outlined,
              title: 'Net Banking',
              subtitle: 'All major banks',
            ),

            const SizedBox(height: 12),

            // ====================================================
            // CASH ON DELIVERY
            // ====================================================

            _paymentOption(
              value: 'cod',
              icon: Icons.payments_outlined,
              title: 'Cash on Delivery',
              subtitle: 'Pay when product is delivered',
            ),

            const SizedBox(height: 25),

            // ====================================================
            // PRODUCT
            // ====================================================

            const Text(
              'Order Details',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(12),

                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),

                      child: Image.asset(
                        widget.product['image'].toString(),
                        width: 70,
                        height: 75,
                        fit: BoxFit.cover,

                        errorBuilder: (
                            context,
                            error,
                            stackTrace,
                            ) {
                          return Container(
                            width: 70,
                            height: 75,
                            color: Colors.grey.shade200,
                            alignment: Alignment.center,
                            child: const Icon(
                              Icons.image_outlined,
                            ),
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
                            widget.product['name'].toString(),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),

                          const SizedBox(height: 5),

                          Text(
                            'Quantity: ${widget.quantity}',
                            style: const TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Text(
                      '₹${widget.totalAmount}',
                      style: const TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 100),
          ],
        ),
      ),

      // ============================================================
      // PAY BUTTON
      // ============================================================

      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(12),
          color: Colors.white,

          child: SizedBox(
            height: 52,

            child: ElevatedButton(
              onPressed:
              isProcessing ? null : makeDummyPayment,

              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                foregroundColor: Colors.white,

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),

              child: isProcessing
                  ? const SizedBox(
                width: 25,
                height: 25,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 3,
                ),
              )
                  : Text(
                selectedPayment == 'cod'
                    ? 'Place Order'
                    : 'Pay ₹${widget.totalAmount}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ============================================================
  // PAYMENT OPTION
  // ============================================================

  Widget _paymentOption({
    required String value,
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    final bool selected =
        selectedPayment == value;

    return InkWell(
      onTap: () {
        setState(() {
          selectedPayment = value;
        });
      },

      borderRadius: BorderRadius.circular(15),

      child: Container(
        padding: const EdgeInsets.all(15),

        decoration: BoxDecoration(
          color: Colors.white,

          borderRadius: BorderRadius.circular(15),

          border: Border.all(
            color: selected
                ? primaryColor
                : Colors.grey.shade300,
            width: selected ? 2 : 1,
          ),
        ),

        child: Row(
          children: [
            Container(
              width: 45,
              height: 45,

              decoration: BoxDecoration(
                color: selected
                    ? primaryColor.withOpacity(0.10)
                    : Colors.grey.shade100,

                borderRadius: BorderRadius.circular(10),
              ),

              child: Icon(
                icon,
                color: selected
                    ? primaryColor
                    : Colors.grey.shade700,
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,

                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: selected
                          ? primaryColor
                          : Colors.black87,
                    ),
                  ),

                  const SizedBox(height: 3),

                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),

            Radio<String>(
              value: value,
              groupValue: selectedPayment,
              activeColor: primaryColor,

              onChanged: (value) {
                if (value == null) return;

                setState(() {
                  selectedPayment = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}