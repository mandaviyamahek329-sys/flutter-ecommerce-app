import 'package:flutter/material.dart';
import 'order_summary_screen.dart';

class ProductDetailScreen extends StatefulWidget {
  final Map<String, dynamic> product;

  final Function(
      Map<String, dynamic> product,
      int quantity,
      ) onAddToCart;

  final Function(
      Map<String, dynamic> product,
      ) onToggleWishlist;

  final bool isWishlisted;
  final int initialQuantity;

  const ProductDetailScreen({
    super.key,
    required this.product,
    required this.onAddToCart,
    required this.onToggleWishlist,
    required this.isWishlisted,
    this.initialQuantity = 0,
  });

  @override
  State<ProductDetailScreen> createState() =>
      _ProductDetailScreenState();
}

class _ProductDetailScreenState
    extends State<ProductDetailScreen> {
  static const Color primaryColor = Color(0xFFE91E63);

  late int quantity;
  late bool liked;

  @override
  void initState() {
    super.initState();

    quantity = widget.initialQuantity;
    liked = widget.isWishlisted;
  }

  @override
  Widget build(BuildContext context) {
    final double price =
    (widget.product['price'] as num).toDouble();

    final double oldPrice =
    (widget.product['oldPrice'] as num).toDouble();

    final int discount = oldPrice > price
        ? (((oldPrice - price) / oldPrice) * 100).round()
        : 0;

    final double savingPerItem =
    oldPrice > price ? oldPrice - price : 0;

    final double mrpTotal =
        oldPrice * quantity;

    final double offerTotal =
        price * quantity;

    final double totalSaving =
        savingPerItem * quantity;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),

      appBar: AppBar(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        title: const Text(
          'Product Details',
        ),
        actions: [
          IconButton(
            onPressed: () {
              widget.onToggleWishlist(
                widget.product,
              );

              setState(() {
                liked = !liked;
              });
            },
            icon: Icon(
              liked
                  ? Icons.favorite
                  : Icons.favorite_border,
              color: Colors.white,
            ),
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [
            // ==================================================
            // PRODUCT IMAGE
            // ==================================================

            Container(
              width: double.infinity,
              height: 280,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                BorderRadius.circular(12),
              ),
              child: Image.asset(
                widget.product['image'].toString(),
                fit: BoxFit.contain,
                errorBuilder: (
                    context,
                    error,
                    stackTrace,
                    ) {
                  return const Center(
                    child: Icon(
                      Icons
                          .image_not_supported_outlined,
                      size: 60,
                      color: Colors.grey,
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 15),

            // ==================================================
            // NAME
            // ==================================================

            Text(
              widget.product['name'].toString(),
              style: const TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 5),

            // ==================================================
            // SUB CATEGORY
            // ==================================================

            Text(
              widget.product['subCategory']
                  ?.toString() ??
                  '',
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 13,
              ),
            ),

            const SizedBox(height: 14),

            // ==================================================
            // MAIN PRICE ROW
            // ==================================================

            Wrap(
              crossAxisAlignment:
              WrapCrossAlignment.center,
              spacing: 10,
              runSpacing: 6,
              children: [
                Text(
                  '₹${price.toStringAsFixed(0)}',
                  style: const TextStyle(
                    color: primaryColor,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                if (oldPrice > price)
                  Text(
                    '₹${oldPrice.toStringAsFixed(0)}',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                      decoration:
                      TextDecoration.lineThrough,
                    ),
                  ),

                if (discount > 0)
                  Container(
                    padding:
                    const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color:
                      Colors.green.shade50,
                      borderRadius:
                      BorderRadius.circular(5),
                    ),
                    child: Text(
                      '$discount% OFF',
                      style: TextStyle(
                        color:
                        Colors.green.shade700,
                        fontSize: 12,
                        fontWeight:
                        FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),

            // ==================================================
            // YOU SAVE
            // ==================================================

            if (savingPerItem > 0) ...[
              const SizedBox(height: 10),

              Container(
                padding:
                const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius:
                  BorderRadius.circular(7),
                ),
                child: Row(
                  mainAxisSize:
                  MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.local_offer_outlined,
                      size: 16,
                      color:
                      Colors.green.shade700,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      'You save ₹${savingPerItem.toStringAsFixed(0)}',
                      style: TextStyle(
                        color:
                        Colors.green.shade800,
                        fontSize: 12,
                        fontWeight:
                        FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],

            const SizedBox(height: 22),

            // ==================================================
            // QUANTITY
            // ==================================================

            const Text(
              'Quantity',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 8),

            _quantityButton(),

            const SizedBox(height: 24),

            // ==================================================
            // PRICE DETAILS TITLE
            // ==================================================

            const Text(
              'Price Details',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            // ==================================================
            // PRICE DETAILS CARD
            // ==================================================

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  _priceDetailRow(
                    'MRP',
                    '₹${oldPrice.toStringAsFixed(0)}',
                  ),

                  const SizedBox(height: 11),

                  _priceDetailRow(
                    'Offer Price',
                    '₹${price.toStringAsFixed(0)}',
                    valueColor: primaryColor,
                  ),

                  const SizedBox(height: 11),

                  _priceDetailRow(
                    'Discount',
                    '$discount% OFF',
                    valueColor:
                    Colors.green.shade700,
                  ),

                  const SizedBox(height: 11),

                  _priceDetailRow(
                    'You Save',
                    '₹${savingPerItem.toStringAsFixed(0)}',
                    valueColor:
                    Colors.green.shade700,
                  ),

                  // Quantity 0 karta vadhu hoy tyare
                  // total price details show thase
                  if (quantity > 0) ...[
                    const Padding(
                      padding:
                      EdgeInsets.symmetric(
                        vertical: 13,
                      ),
                      child: Divider(
                        height: 1,
                      ),
                    ),

                    _priceDetailRow(
                      'Quantity',
                      '$quantity',
                    ),

                    const SizedBox(height: 11),

                    _priceDetailRow(
                      'MRP Total',
                      '₹${mrpTotal.toStringAsFixed(0)}',
                    ),

                    const SizedBox(height: 11),

                    _priceDetailRow(
                      'Total Discount',
                      '- ₹${totalSaving.toStringAsFixed(0)}',
                      valueColor:
                      Colors.green.shade700,
                    ),

                    const SizedBox(height: 11),

                    _priceDetailRow(
                      'Total Price',
                      '₹${offerTotal.toStringAsFixed(0)}',
                      valueColor:
                      primaryColor,
                      isBold: true,
                    ),
                  ],
                ],
              ),
            ),

            const SizedBox(height: 90),
          ],
        ),
      ),

      // ========================================================
      // BOTTOM BUTTONS
      // ========================================================

      bottomNavigationBar: SafeArea(
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.fromLTRB(
            10,
            9,
            10,
            9,
          ),
          child: Row(
            children: [
              // ADD TO CART
              Expanded(
                child: OutlinedButton(
                  onPressed:
                  addProductToCart,
                  style:
                  OutlinedButton.styleFrom(
                    foregroundColor:
                    primaryColor,
                    side:
                    const BorderSide(
                      color: primaryColor,
                    ),
                    minimumSize:
                    const Size(
                      0,
                      48,
                    ),
                    shape:
                    RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(
                        8,
                      ),
                    ),
                  ),
                  child: const Text(
                    'Add to Cart',
                    style: TextStyle(
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 8),

              // PROCEED TO BUY
              Expanded(
                child: ElevatedButton(
                  onPressed:
                  proceedToBuy,
                  style:
                  ElevatedButton.styleFrom(
                    backgroundColor:
                    primaryColor,
                    foregroundColor:
                    Colors.white,
                    minimumSize:
                    const Size(
                      0,
                      48,
                    ),
                    shape:
                    RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(
                        8,
                      ),
                    ),
                  ),
                  child: const Text(
                    'Proceed to Buy',
                    style: TextStyle(
                      fontWeight:
                      FontWeight.bold,
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
  // QUANTITY BUTTON
  // ============================================================

  Widget _quantityButton() {
    return Container(
      width: 105,
      height: 34,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: primaryColor,
          width: 1.2,
        ),
        borderRadius:
        BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          // MINUS
          Expanded(
            child: InkWell(
              onTap: quantity > 0
                  ? () {
                setState(() {
                  quantity--;
                });
              }
                  : null,
              child: SizedBox(
                height: double.infinity,
                child: Center(
                  child: Icon(
                    Icons.remove,
                    size: 17,
                    color: quantity > 0
                        ? primaryColor
                        : Colors
                        .grey
                        .shade400,
                  ),
                ),
              ),
            ),
          ),

          // QUANTITY
          SizedBox(
            width: 30,
            child: Center(
              child: Text(
                '$quantity',
                style: const TextStyle(
                  color: primaryColor,
                  fontSize: 13,
                  fontWeight:
                  FontWeight.bold,
                ),
              ),
            ),
          ),

          // PLUS
          Expanded(
            child: InkWell(
              onTap: () {
                setState(() {
                  quantity++;
                });
              },
              child: const SizedBox(
                height: double.infinity,
                child: Center(
                  child: Icon(
                    Icons.add,
                    size: 17,
                    color: primaryColor,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // PRICE DETAIL ROW
  // ============================================================

  Widget _priceDetailRow(
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
              fontSize:
              isBold ? 15 : 13,
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
            fontSize:
            isBold ? 16 : 13,
            fontWeight:
            isBold
                ? FontWeight.bold
                : FontWeight.w600,
            color:
            valueColor ??
                Colors.black87,
          ),
        ),
      ],
    );
  }

  // ============================================================
  // ADD TO CART
  // ============================================================

  void addProductToCart() {
    if (quantity <= 0) {
      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            'Please select quantity',
          ),
        ),
      );

      return;
    }

    widget.onAddToCart(
      widget.product,
      quantity,
    );

    ScaffoldMessenger.of(context)
        .showSnackBar(
      SnackBar(
        content: Text(
          '${widget.product['name']} added to cart - Qty $quantity',
        ),
      ),
    );
  }

  // ============================================================
  // PROCEED TO BUY
  // ============================================================

  void proceedToBuy() {
    if (quantity <= 0) {
      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            'Please select quantity',
          ),
        ),
      );

      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            OrderSummaryScreen(
              product: widget.product,
              quantity: quantity,
            ),
      ),
    );
  }
}