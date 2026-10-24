import 'dart:async';
import 'package:flutter/material.dart';

import 'categories_screen.dart';
import 'product_detail_screen.dart';
import 'order_summary_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const Color primaryColor = Color(0xFFE91E63);

  int selectedIndex = 0;

  final TextEditingController searchController =
  TextEditingController();

  final PageController bannerController =
  PageController();

  Timer? bannerTimer;

  int currentBanner = 0;

  bool showWishlistPage = false;

  String searchText = '';

  String selectedHomeCategory = 'All';

  bool categoryApplied = false;

  // ============================================================
  // PROFILE
  // ============================================================

  String profileFirstName = '';
  String profileLastName = '';
  String profilePhone = '';
  String profileEmail = '';
  String profileGender = '';
  String profileImage = '';

  // ============================================================
  // CART + WISHLIST
  // ============================================================

  final List<Map<String, dynamic>> cartItems = [];

  final List<Map<String, dynamic>> wishlistItems = [];

  // ============================================================
  // BANNERS
  // ============================================================

  final List<String> banners = [
    'assets/categories/download.jpg',
    'assets/categories/men.jpg',
    'assets/categories/kids.jpg',
  ];

  // ============================================================
  // HOME CATEGORIES
  // ============================================================

  final List<Map<String, String>> homeCategories = [
    {
      'name': 'Women',
      'image': 'assets/categories/download.jpg',
    },
    {
      'name': 'Men',
      'image': 'assets/categories/men.jpg',
    },
    {
      'name': 'Kids',
      'image': 'assets/categories/kids.jpg',
    },
    {
      'name': 'Beauty',
      'image': 'assets/categories/beauty.jpg',
    },
    {
      'name': 'Shoes',
      'image': 'assets/categories/shoes.jpg',
    },
    {
      'name': 'Bags',
      'image': 'assets/categories/bag.jpg',
    },
    {
      'name': 'Jewellery',
      'image': 'assets/categories/jewellery.jpg',
    },
    {
      'name': 'Phone',
      'image': 'assets/categories/p1.jpg',
    },
    {
      'name': 'Laptop',
      'image': 'assets/categories/l1.jpg',
    },
  ];

  // ============================================================
  // PRODUCTS
  // ============================================================

  final List<Map<String, dynamic>> products = [
    // ==========================================================
    // WOMEN
    // ==========================================================

    {
      'name': 'Floral Dress',
      'category': 'Women',
      'subCategory': 'Dresses',
      'price': 799,
      'oldPrice': 1099,
      'image': 'assets/categories/d1.jpg',
    },
    {
      'name': 'Casual Dress',
      'category': 'Women',
      'subCategory': 'Dresses',
      'price': 699,
      'oldPrice': 999,
      'image': 'assets/categories/111.jpg',
    },
    {
      'name': 'Black Party Dress',
      'category': 'Women',
      'subCategory': 'Party Wear',
      'price': 999,
      'oldPrice': 1399,
      'image': 'assets/categories/111.jpg',
    },
    {
      'name': 'Designer Party Wear',
      'category': 'Women',
      'subCategory': 'Party Wear',
      'price': 1299,
      'oldPrice': 1699,
      'image': 'assets/categories/22.jpg',
    },
    {
      'name': 'Office Formal Wear',
      'category': 'Women',
      'subCategory': 'Formal',
      'price': 899,
      'oldPrice': 1199,
      'image': 'assets/categories/22.jpg',
    },
    {
      'name': 'Formal Outfit',
      'category': 'Women',
      'subCategory': 'Formal',
      'price': 999,
      'oldPrice': 1299,
      'image': 'assets/categories/d1.jpg',
    },
    {
      'name': 'Red Silk Saree',
      'category': 'Women',
      'subCategory': 'Sarees',
      'price': 1199,
      'oldPrice': 1499,
      'image': 'assets/categories/s1.jpg',
    },
    {
      'name': 'Cotton Saree',
      'category': 'Women',
      'subCategory': 'Sarees',
      'price': 999,
      'oldPrice': 1299,
      'image': 'assets/categories/s1.jpg',
    },
    {
      'name': 'Banarasi Saree',
      'category': 'Women',
      'subCategory': 'Sarees',
      'price': 1699,
      'oldPrice': 1999,
      'image': 'assets/categories/s1.jpg',
    },
    {
      'name': 'Party Wear Saree',
      'category': 'Women',
      'subCategory': 'Sarees',
      'price': 1499,
      'oldPrice': 1799,
      'image': 'assets/categories/s1.jpg',
    },
    {
      'name': 'Printed Saree',
      'category': 'Women',
      'subCategory': 'Sarees',
      'price': 899,
      'oldPrice': 1099,
      'image': 'assets/categories/s1.jpg',
    },
    {
      'name': 'Designer Saree',
      'category': 'Women',
      'subCategory': 'Sarees',
      'price': 1899,
      'oldPrice': 2299,
      'image': 'assets/categories/s1.jpg',
    },
    {
      'name': 'Casual Top',
      'category': 'Women',
      'subCategory': 'Tops',
      'price': 499,
      'oldPrice': 699,
      'image': 'assets/categories/t1.jpg',
    },
    {
      'name': 'Printed Top',
      'category': 'Women',
      'subCategory': 'Tops',
      'price': 599,
      'oldPrice': 899,
      'image': 'assets/categories/t1.jpg',
    },
    {
      'name': 'Cotton Kurti',
      'category': 'Women',
      'subCategory': 'Kurtis',
      'price': 699,
      'oldPrice': 999,
      'image': 'assets/categories/k1.jpg',
    },
    {
      'name': 'Printed Kurti',
      'category': 'Women',
      'subCategory': 'Kurtis',
      'price': 799,
      'oldPrice': 1099,
      'image': 'assets/categories/k1.jpg',
    },
    {
      'name': 'Blue Jeans',
      'category': 'Women',
      'subCategory': 'Jeans',
      'price': 899,
      'oldPrice': 1199,
      'image': 'assets/categories/j1.jpg',
    },
    {
      'name': 'Black Jeans',
      'category': 'Women',
      'subCategory': 'Jeans',
      'price': 999,
      'oldPrice': 1299,
      'image': 'assets/categories/j1.jpg',
    },
    {
      'name': 'White T-Shirt',
      'category': 'Women',
      'subCategory': 'T-Shirts',
      'price': 399,
      'oldPrice': 599,
      'image': 'assets/categories/t2.jpg',
    },
    {
      'name': 'Printed T-Shirt',
      'category': 'Women',
      'subCategory': 'T-Shirts',
      'price': 499,
      'oldPrice': 699,
      'image': 'assets/categories/t2.jpg',
    },

    // ==========================================================
    // MEN
    // ==========================================================

    {
      'name': 'Men Black T-Shirt',
      'category': 'Men',
      'subCategory': 'T-Shirt',
      'price': 499,
      'oldPrice': 699,
      'image': 'assets/categories/tt.jpg',
    },
    {
      'name': 'Men Casual T-Shirt',
      'category': 'Men',
      'subCategory': 'T-Shirt',
      'price': 599,
      'oldPrice': 799,
      'image': 'assets/categories/tt.jpg',
    },
    {
      'name': 'Formal Shirt',
      'category': 'Men',
      'subCategory': 'Shirt',
      'price': 699,
      'oldPrice': 999,
      'image': 'assets/categories/s.jpg',
    },
    {
      'name': 'Casual Shirt',
      'category': 'Men',
      'subCategory': 'Shirt',
      'price': 599,
      'oldPrice': 899,
      'image': 'assets/categories/s.jpg',
    },
    {
      'name': 'Cotton Kurta',
      'category': 'Men',
      'subCategory': 'Kurta',
      'price': 799,
      'oldPrice': 1099,
      'image': 'assets/categories/kk.jpg',
    },
    {
      'name': 'Festive Kurta',
      'category': 'Men',
      'subCategory': 'Kurta',
      'price': 999,
      'oldPrice': 1399,
      'image': 'assets/categories/kk.jpg',
    },
    {
      'name': 'Traditional Ethnic Wear',
      'category': 'Men',
      'subCategory': 'Ethnic Wear',
      'price': 1299,
      'oldPrice': 1699,
      'image': 'assets/categories/e.jpg',
    },
    {
      'name': 'Wedding Ethnic Wear',
      'category': 'Men',
      'subCategory': 'Ethnic Wear',
      'price': 1599,
      'oldPrice': 2099,
      'image': 'assets/categories/e.jpg',
    },

    // ==========================================================
    // KIDS
    // ==========================================================

    {
      'name': 'Kids Blue Shorts',
      'category': 'Kids',
      'subCategory': 'Shorts',
      'price': 299,
      'oldPrice': 499,
      'image': 'assets/categories/1.jpg',
    },
    {
      'name': 'Kids Casual Shorts',
      'category': 'Kids',
      'subCategory': 'Shorts',
      'price': 349,
      'oldPrice': 549,
      'image': 'assets/categories/1.jpg',
    },
    {
      'name': 'Kids Printed T-Shirt',
      'category': 'Kids',
      'subCategory': 'Kids T-Shirt',
      'price': 299,
      'oldPrice': 499,
      'image': 'assets/categories/3.jpg',
    },
    {
      'name': 'Kids Cartoon T-Shirt',
      'category': 'Kids',
      'subCategory': 'Kids T-Shirt',
      'price': 349,
      'oldPrice': 549,
      'image': 'assets/categories/3.jpg',
    },
    {
      'name': 'Kids Ethnic Dress',
      'category': 'Kids',
      'subCategory': 'Ethnic Wear',
      'price': 699,
      'oldPrice': 999,
      'image': 'assets/categories/2.jpg',
    },
    {
      'name': 'Kids Traditional Wear',
      'category': 'Kids',
      'subCategory': 'Ethnic Wear',
      'price': 799,
      'oldPrice': 1099,
      'image': 'assets/categories/2.jpg',
    },
    {
      'name': 'Blue School Bag',
      'category': 'Kids',
      'subCategory': 'School Bag',
      'price': 499,
      'oldPrice': 699,
      'image': 'assets/categories/b.jpg',
    },
    {
      'name': 'Cartoon School Bag',
      'category': 'Kids',
      'subCategory': 'School Bag',
      'price': 599,
      'oldPrice': 799,
      'image': 'assets/categories/b.jpg',
    },

    // ==========================================================
    // BEAUTY
    // ==========================================================

    {
      'name': 'Red Lipstick',
      'category': 'Beauty',
      'subCategory': 'Lipstick',
      'price': 299,
      'oldPrice': 499,
      'image': 'assets/categories/b2.jpg',
    },
    {
      'name': 'Pink Lipstick',
      'category': 'Beauty',
      'subCategory': 'Lipstick',
      'price': 349,
      'oldPrice': 549,
      'image': 'assets/categories/b2.jpg',
    },
    {
      'name': 'Black Kajal',
      'category': 'Beauty',
      'subCategory': 'Kajal',
      'price': 199,
      'oldPrice': 299,
      'image': 'assets/categories/k.jpg',
    },
    {
      'name': 'Waterproof Kajal',
      'category': 'Beauty',
      'subCategory': 'Kajal',
      'price': 249,
      'oldPrice': 399,
      'image': 'assets/categories/k.jpg',
    },
    {
      'name': 'Makeup Kit',
      'category': 'Beauty',
      'subCategory': 'Makeup',
      'price': 899,
      'oldPrice': 1199,
      'image': 'assets/categories/m.jpg',
    },
    {
      'name': 'Party Makeup Kit',
      'category': 'Beauty',
      'subCategory': 'Makeup',
      'price': 1099,
      'oldPrice': 1499,
      'image': 'assets/categories/m.jpg',
    },
    {
      'name': 'Pink Blush',
      'category': 'Beauty',
      'subCategory': 'Blush',
      'price': 399,
      'oldPrice': 599,
      'image': 'assets/categories/bb.jpg',
    },
    {
      'name': 'Natural Blush',
      'category': 'Beauty',
      'subCategory': 'Blush',
      'price': 449,
      'oldPrice': 649,
      'image': 'assets/categories/bb.jpg',
    },

    // ==========================================================
    // SHOES
    // ==========================================================

    {
      'name': 'Kids Sports Shoes',
      'category': 'Shoes',
      'subCategory': 'Kids Shoes',
      'price': 599,
      'oldPrice': 899,
      'image': 'assets/categories/11.jpg',
    },
    {
      'name': 'Kids Casual Shoes',
      'category': 'Shoes',
      'subCategory': 'Kids Shoes',
      'price': 549,
      'oldPrice': 799,
      'image': 'assets/categories/11.jpg',
    },
    {
      'name': 'Men Sports Shoes',
      'category': 'Shoes',
      'subCategory': 'Men Shoes',
      'price': 999,
      'oldPrice': 1399,
      'image': 'assets/categories/m1.jpg',
    },
    {
      'name': 'Men Running Shoes',
      'category': 'Shoes',
      'subCategory': 'Men Shoes',
      'price': 1199,
      'oldPrice': 1599,
      'image': 'assets/categories/m1.jpg',
    },
    {
      'name': 'Women Sports Shoes',
      'category': 'Shoes',
      'subCategory': 'Women Shoes',
      'price': 899,
      'oldPrice': 1299,
      'image': 'assets/categories/w.jpg',
    },
    {
      'name': 'Women Running Shoes',
      'category': 'Shoes',
      'subCategory': 'Women Shoes',
      'price': 999,
      'oldPrice': 1399,
      'image': 'assets/categories/w.jpg',
    },
    {
      'name': 'White Casual Shoes',
      'category': 'Shoes',
      'subCategory': 'Casual Shoes',
      'price': 799,
      'oldPrice': 1099,
      'image': 'assets/categories/w2.jpg',
    },

    // ==========================================================
    // BAGS
    // ==========================================================

    {
      'name': 'Kids School Bag',
      'category': 'Bags',
      'subCategory': 'School Bags',
      'price': 499,
      'oldPrice': 699,
      'image': 'assets/categories/b3.jpg',
    },
    {
      'name': 'Large School Bag',
      'category': 'Bags',
      'subCategory': 'School Bags',
      'price': 699,
      'oldPrice': 899,
      'image': 'assets/categories/b3.jpg',
    },
    {
      'name': 'Women Hand Bag',
      'category': 'Bags',
      'subCategory': 'Women Bag',
      'price': 799,
      'oldPrice': 1099,
      'image': 'assets/categories/bbb.jpg',
    },
    {
      'name': 'Women Shoulder Bag',
      'category': 'Bags',
      'subCategory': 'Women Bag',
      'price': 899,
      'oldPrice': 1199,
      'image': 'assets/categories/bbb.jpg',
    },
    {
      'name': 'Men Travel Bag',
      'category': 'Bags',
      'subCategory': 'Men Bag',
      'price': 999,
      'oldPrice': 1399,
      'image': 'assets/categories/b4.jpg',
    },
    {
      'name': 'Formal Office Bag',
      'category': 'Bags',
      'subCategory': 'Formal Bag',
      'price': 1199,
      'oldPrice': 1599,
      'image': 'assets/categories/b5.jpg',
    },

    // ==========================================================
    // JEWELLERY
    // ==========================================================

    {
      'name': 'Gold Ring',
      'category': 'Jewellery',
      'subCategory': 'Ring',
      'price': 799,
      'oldPrice': 1099,
      'image': 'assets/categories/r1.jpg',
    },
    {
      'name': 'Designer Ring',
      'category': 'Jewellery',
      'subCategory': 'Ring',
      'price': 999,
      'oldPrice': 1299,
      'image': 'assets/categories/r1.jpg',
    },
    {
      'name': 'Gold Necklace',
      'category': 'Jewellery',
      'subCategory': 'Necklace',
      'price': 1499,
      'oldPrice': 1899,
      'image': 'assets/categories/r2.jpg',
    },
    {
      'name': 'Designer Necklace',
      'category': 'Jewellery',
      'subCategory': 'Necklace',
      'price': 1799,
      'oldPrice': 2199,
      'image': 'assets/categories/r2.jpg',
    },
    {
      'name': 'Silver Payal',
      'category': 'Jewellery',
      'subCategory': 'Payal',
      'price': 699,
      'oldPrice': 999,
      'image': 'assets/categories/r3.jpg',
    },
    {
      'name': 'Designer Bracelet',
      'category': 'Jewellery',
      'subCategory': 'Bracelet',
      'price': 599,
      'oldPrice': 899,
      'image': 'assets/categories/r5.jpg',
    },

    // ==========================================================
    // PHONE
    // ==========================================================

    {
      'name': 'Android Phone 128GB',
      'category': 'Phone',
      'subCategory': 'Android',
      'price': 12999,
      'oldPrice': 14999,
      'image': 'assets/categories/33.jpg',
    },
    {
      'name': 'Android Phone 256GB',
      'category': 'Phone',
      'subCategory': 'Android',
      'price': 15999,
      'oldPrice': 17999,
      'image': 'assets/categories/33.jpg',
    },
    {
      'name': 'iPhone 128GB',
      'category': 'Phone',
      'subCategory': 'iOS',
      'price': 49999,
      'oldPrice': 54999,
      'image': 'assets/categories/44.jpg',
    },
    {
      'name': 'iPhone 256GB',
      'category': 'Phone',
      'subCategory': 'iOS',
      'price': 59999,
      'oldPrice': 64999,
      'image': 'assets/categories/44.jpg',
    },
    {
      'name': 'OnePlus 128GB',
      'category': 'Phone',
      'subCategory': 'OnePlus',
      'price': 29999,
      'oldPrice': 32999,
      'image': 'assets/categories/444.jpg',
    },
    {
      'name': 'OnePlus 256GB',
      'category': 'Phone',
      'subCategory': 'OnePlus',
      'price': 34999,
      'oldPrice': 37999,
      'image': 'assets/categories/444.jpg',
    },

    // ==========================================================
    // LAPTOP
    // ==========================================================

    {
      'name': 'HP Laptop i5',
      'category': 'Laptop',
      'subCategory': 'HP',
      'price': 44999,
      'oldPrice': 49999,
      'image': 'assets/categories/l2.jpg',
    },
    {
      'name': 'HP Laptop i7',
      'category': 'Laptop',
      'subCategory': 'HP',
      'price': 59999,
      'oldPrice': 64999,
      'image': 'assets/categories/l2.jpg',
    },
    {
      'name': 'Dell Laptop i5',
      'category': 'Laptop',
      'subCategory': 'Dell',
      'price': 46999,
      'oldPrice': 51999,
      'image': 'assets/categories/l3.jpg',
    },
    {
      'name': 'Dell Gaming Laptop',
      'category': 'Laptop',
      'subCategory': 'Dell',
      'price': 69999,
      'oldPrice': 75999,
      'image': 'assets/categories/l3.jpg',
    },
    {
      'name': 'Acer Laptop i5',
      'category': 'Laptop',
      'subCategory': 'Acer',
      'price': 42999,
      'oldPrice': 47999,
      'image': 'assets/categories/l4.jpg',
    },
    {
      'name': 'Acer Gaming Laptop',
      'category': 'Laptop',
      'subCategory': 'Acer',
      'price': 64999,
      'oldPrice': 69999,
      'image': 'assets/categories/l4.jpg',
    },
  ];

  late List<Map<String, dynamic>> mixedProducts;

  // ============================================================
  // INIT
  // ============================================================

  @override
  void initState() {
    super.initState();

    mixedProducts =
    List<Map<String, dynamic>>.from(products);

    mixedProducts.shuffle();

    bannerTimer = Timer.periodic(
      const Duration(seconds: 3),
          (timer) {
        if (!mounted ||
            banners.isEmpty ||
            !bannerController.hasClients) {
          return;
        }

        int nextPage = currentBanner + 1;

        if (nextPage >= banners.length) {
          nextPage = 0;
        }

        bannerController.animateToPage(
          nextPage,
          duration: const Duration(
            milliseconds: 500,
          ),
          curve: Curves.easeInOut,
        );
      },
    );
  }

  @override
  void dispose() {
    bannerTimer?.cancel();
    bannerController.dispose();
    searchController.dispose();
    super.dispose();
  }

  // ============================================================
  // CART FUNCTIONS
  // ============================================================

  int getCartQuantity(
      Map<String, dynamic> product,
      ) {
    final int index = cartItems.indexWhere(
          (item) => item['name'] == product['name'],
    );

    if (index == -1) {
      return 0;
    }

    return (cartItems[index]['quantity'] as num?)
        ?.toInt() ??
        0;
  }

  void setCartQuantity(
      Map<String, dynamic> product,
      int quantity,
      ) {
    final int index = cartItems.indexWhere(
          (item) => item['name'] == product['name'],
    );

    setState(() {
      if (quantity <= 0) {
        if (index >= 0) {
          cartItems.removeAt(index);
        }
        return;
      }

      if (index >= 0) {
        cartItems[index]['price'] = product['price'];
        cartItems[index]['oldPrice'] =
        product['oldPrice'];
        cartItems[index]['image'] = product['image'];
        cartItems[index]['category'] =
        product['category'];
        cartItems[index]['subCategory'] =
        product['subCategory'];
        cartItems[index]['quantity'] = quantity;
      } else {
        final Map<String, dynamic> item =
        Map<String, dynamic>.from(product);

        item['quantity'] = quantity;

        cartItems.add(item);
      }
    });
  }

  void decreaseProductFromCart(
      Map<String, dynamic> product,
      ) {
    final int quantity =
    getCartQuantity(product);

    setCartQuantity(
      product,
      quantity - 1,
    );
  }

  int get totalCartQuantity {
    int total = 0;

    for (final item in cartItems) {
      total +=
          (item['quantity'] as num?)?.toInt() ?? 0;
    }

    return total;
  }

  // ============================================================
  // WISHLIST
  // ============================================================

  bool isInWishlist(
      Map<String, dynamic> product,
      ) {
    return wishlistItems.any(
          (item) => item['name'] == product['name'],
    );
  }

  void toggleWishlist(
      Map<String, dynamic> product,
      ) {
    final int index =
    wishlistItems.indexWhere(
          (item) => item['name'] == product['name'],
    );

    setState(() {
      if (index >= 0) {
        wishlistItems.removeAt(index);
      } else {
        wishlistItems.add(
          Map<String, dynamic>.from(product),
        );
      }
    });
  }

  // ============================================================
  // PROFILE
  // ============================================================

  void saveProfile(
      String firstName,
      String lastName,
      String phone,
      String email,
      String gender,
      String image,
      ) {
    setState(() {
      profileFirstName = firstName;
      profileLastName = lastName;
      profilePhone = phone;
      profileEmail = email;
      profileGender = gender;
      profileImage = image;
    });
  }

  // ============================================================
  // PRODUCT DETAIL
  // ============================================================

  void openProductDetail(
      Map<String, dynamic> product,
      ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            ProductDetailScreen(
              product: product,
              initialQuantity:
              getCartQuantity(product),
              isWishlisted:
              isInWishlist(product),
              onAddToCart: (
                  selectedProduct,
                  quantity,
                  ) {
                setCartQuantity(
                  selectedProduct,
                  quantity,
                );
              },
              onToggleWishlist: (
                  selectedProduct,
                  ) {
                toggleWishlist(
                  selectedProduct,
                );
              },
            ),
      ),
    ).then((_) {
      if (mounted) {
        setState(() {});
      }
    });
  }

  // ============================================================
  // DELETE CONFIRMATION POPUP
  // ============================================================

  void _showDeleteConfirmation(
      Map<String, dynamic> item,
      ) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (
          BuildContext dialogContext,
          ) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius:
            BorderRadius.circular(14),
          ),
          title: const Row(
            children: [
              Icon(
                Icons.delete_outline,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: 8),
              Text(
                'Remove Item',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight:
                  FontWeight.bold,
                ),
              ),
            ],
          ),
          content: Text(
            'Are you sure you want to delete ${item['name']} from your cart?',
            style: const TextStyle(
              fontSize: 13,
              height: 1.4,
            ),
          ),
          actions: [
            // NO

            TextButton(
              onPressed: () {
                Navigator.pop(
                  dialogContext,
                );
              },
              child: const Text(
                'No',
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight:
                  FontWeight.bold,
                ),
              ),
            ),

            // YES

            ElevatedButton(
              onPressed: () {
                Navigator.pop(
                  dialogContext,
                );

                setCartQuantity(
                  item,
                  0,
                );

                ScaffoldMessenger.of(context)
                    .showSnackBar(
                  SnackBar(
                    content: Text(
                      '${item['name']} removed from cart',
                    ),
                    duration:
                    const Duration(
                      seconds: 1,
                    ),
                  ),
                );
              },
              style:
              ElevatedButton.styleFrom(
                backgroundColor:
                primaryColor,
                foregroundColor:
                Colors.white,
                elevation: 0,
                shape:
                RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(
                    7,
                  ),
                ),
              ),
              child: const Text(
                'Yes',
                style: TextStyle(
                  fontWeight:
                  FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
      const Color(0xFFF7F7F7),
      appBar: _appBar(),
      body: _currentPage(),
      bottomNavigationBar:
      _bottomNavigationBar(),
    );
  }

  // ============================================================
  // APP BAR
  // ============================================================

  PreferredSizeWidget _appBar() {
    return AppBar(
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
      elevation: 0,
      leadingWidth: 45,
      leading: Padding(
        padding:
        const EdgeInsets.only(
          left: 8,
          top: 7,
          bottom: 7,
        ),
        child: CircleAvatar(
          backgroundColor: Colors.white,
          backgroundImage:
          profileImage.isNotEmpty
              ? AssetImage(
            profileImage,
          )
              : null,
          child: profileImage.isEmpty
              ? const Icon(
            Icons.person,
            color: primaryColor,
          )
              : null,
        ),
      ),
      title: const Text(
        'E-Com',
        style: TextStyle(
          fontSize: 18,
          fontWeight:
          FontWeight.bold,
        ),
      ),
      actions: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  showWishlistPage = true;
                  selectedIndex = 0;
                });
              },
              icon: const Icon(
                Icons.favorite_border,
              ),
            ),
            if (wishlistItems.isNotEmpty)
              Positioned(
                right: 5,
                top: 4,
                child: _badge(
                  wishlistItems.length,
                ),
              ),
          ],
        ),
        Stack(
          clipBehavior: Clip.none,
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  showWishlistPage =
                  false;
                  selectedIndex = 3;
                });
              },
              icon: const Icon(
                Icons
                    .shopping_cart_outlined,
              ),
            ),
            if (totalCartQuantity > 0)
              Positioned(
                right: 5,
                top: 4,
                child: _badge(
                  totalCartQuantity,
                ),
              ),
          ],
        ),
        const SizedBox(width: 4),
      ],
    );
  }

  Widget _badge(int count) {
    return Container(
      constraints:
      const BoxConstraints(
        minWidth: 17,
        minHeight: 17,
      ),
      padding:
      const EdgeInsets.symmetric(
        horizontal: 4,
      ),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
        BorderRadius.circular(10),
        border: Border.all(
          color: primaryColor,
        ),
      ),
      child: Text(
        '$count',
        style: const TextStyle(
          color: primaryColor,
          fontSize: 9,
          fontWeight:
          FontWeight.bold,
        ),
      ),
    );
  }

  // ============================================================
  // CURRENT PAGE
  // ============================================================

  Widget _currentPage() {
    if (showWishlistPage) {
      return _wishlistPage();
    }

    switch (selectedIndex) {
      case 0:
        return _homePage();

      case 1:
        return CategoriesScreen(
          products: products,
          onAddToCart:
          setCartQuantity,
          onRemoveFromCart:
          decreaseProductFromCart,
          getCartQuantity:
          getCartQuantity,
          onToggleWishlist:
          toggleWishlist,
          isInWishlist:
          isInWishlist,
        );

      case 2:
        return _ordersPage();

      case 3:
        return _cartPage();

      case 4:
        return ProfileScreen(
          firstName:
          profileFirstName,
          lastName:
          profileLastName,
          phone: profilePhone,
          email: profileEmail,
          gender: profileGender,
          profileImage:
          profileImage,
          onSave: saveProfile,
        );

      default:
        return _homePage();
    }
  }

  // ============================================================
  // HOME PAGE
  // ============================================================

  Widget _homePage() {
    List<Map<String, dynamic>>
    visibleProducts =
    List<Map<String, dynamic>>.from(
      mixedProducts,
    );

    if (categoryApplied &&
        selectedHomeCategory != 'All') {
      visibleProducts =
          visibleProducts.where(
                (product) {
              return product['category'] ==
                  selectedHomeCategory;
            },
          ).toList();
    }

    if (searchText.trim().isNotEmpty) {
      final String query =
      searchText
          .trim()
          .toLowerCase();

      visibleProducts =
          visibleProducts.where(
                (product) {
              final String name =
              product['name']
                  .toString()
                  .toLowerCase();

              final String category =
              product['category']
                  .toString()
                  .toLowerCase();

              final String subCategory =
              product['subCategory']
                  .toString()
                  .toLowerCase();

              return name.contains(query) ||
                  category.contains(query) ||
                  subCategory
                      .contains(query);
            },
          ).toList();
    }

    return SingleChildScrollView(
      physics:
      const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          // SEARCH

          Padding(
            padding:
            const EdgeInsets.fromLTRB(
              10,
              10,
              10,
              5,
            ),
            child: TextField(
              controller:
              searchController,
              onChanged: (value) {
                setState(() {
                  searchText = value;
                });
              },
              decoration:
              InputDecoration(
                hintText:
                'Search products...',
                prefixIcon:
                const Icon(
                  Icons.search,
                ),
                suffixIcon:
                searchText.isNotEmpty
                    ? IconButton(
                  onPressed:
                      () {
                    searchController
                        .clear();

                    setState(
                          () {
                        searchText =
                        '';
                      },
                    );
                  },
                  icon:
                  const Icon(
                    Icons.close,
                  ),
                )
                    : null,
                filled: true,
                fillColor:
                Colors.white,
                contentPadding:
                const EdgeInsets
                    .symmetric(
                  vertical: 0,
                ),
                border:
                OutlineInputBorder(
                  borderRadius:
                  BorderRadius
                      .circular(
                    10,
                  ),
                  borderSide:
                  BorderSide.none,
                ),
              ),
            ),
          ),

          // CATEGORY TITLE

          Padding(
            padding:
            const EdgeInsets.fromLTRB(
              12,
              9,
              12,
              5,
            ),
            child: Row(
              children: [
                const Expanded(
                  child: Text(
                    'Shop By Category',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      categoryApplied =
                      false;
                      selectedHomeCategory =
                      'All';
                    });
                  },
                  child: const Text(
                    'View All',
                    style: TextStyle(
                      color:
                      primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // CATEGORIES

          SizedBox(
            height: 94,
            child: ListView.builder(
              scrollDirection:
              Axis.horizontal,
              padding:
              const EdgeInsets
                  .symmetric(
                horizontal: 8,
              ),
              itemCount:
              homeCategories.length,
              itemBuilder:
                  (context, index) {
                final category =
                homeCategories[index];

                final bool selected =
                    categoryApplied &&
                        selectedHomeCategory ==
                            category['name'];

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      categoryApplied =
                      true;

                      selectedHomeCategory =
                          category['name'] ??
                              'All';
                    });
                  },
                  child: Container(
                    width: 70,
                    margin:
                    const EdgeInsets
                        .symmetric(
                      horizontal: 3,
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: 58,
                          height: 58,
                          padding:
                          const EdgeInsets
                              .all(
                            2,
                          ),
                          decoration:
                          BoxDecoration(
                            shape:
                            BoxShape.circle,
                            border:
                            Border.all(
                              color: selected
                                  ? primaryColor
                                  : Colors
                                  .grey
                                  .shade300,
                              width:
                              selected
                                  ? 2
                                  : 1,
                            ),
                          ),
                          child:
                          ClipOval(
                            child:
                            Image.asset(
                              category[
                              'image'] ??
                                  '',
                              fit:
                              BoxFit.cover,
                              errorBuilder:
                                  (
                                  context,
                                  error,
                                  stackTrace,
                                  ) {
                                return Container(
                                  color: Colors
                                      .grey
                                      .shade200,
                                  child:
                                  const Icon(
                                    Icons
                                        .image_outlined,
                                    color:
                                    Colors.grey,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          category['name'] ??
                              '',
                          maxLines: 1,
                          overflow:
                          TextOverflow
                              .ellipsis,
                          style:
                          TextStyle(
                            fontSize: 10,
                            fontWeight:
                            selected
                                ? FontWeight
                                .bold
                                : FontWeight
                                .normal,
                            color: selected
                                ? primaryColor
                                : Colors
                                .black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 8),

          // BANNER

          SizedBox(
            height: 150,
            child: PageView.builder(
              controller:
              bannerController,
              itemCount:
              banners.length,
              onPageChanged:
                  (index) {
                setState(() {
                  currentBanner =
                      index;
                });
              },
              itemBuilder:
                  (context, index) {
                return Container(
                  margin:
                  const EdgeInsets
                      .symmetric(
                    horizontal: 10,
                  ),
                  clipBehavior:
                  Clip.antiAlias,
                  decoration:
                  BoxDecoration(
                    color:
                    Colors.white,
                    borderRadius:
                    BorderRadius
                        .circular(
                      12,
                    ),
                  ),
                  child: Image.asset(
                    banners[index],
                    fit: BoxFit.cover,
                    errorBuilder:
                        (
                        context,
                        error,
                        stackTrace,
                        ) {
                      return Container(
                        color: Colors
                            .grey
                            .shade200,
                        alignment:
                        Alignment
                            .center,
                        child:
                        const Icon(
                          Icons
                              .image_not_supported_outlined,
                          color:
                          Colors.grey,
                          size: 40,
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 8),

          // DOTS

          Row(
            mainAxisAlignment:
            MainAxisAlignment.center,
            children:
            List.generate(
              banners.length,
                  (index) {
                final bool active =
                    currentBanner ==
                        index;

                return AnimatedContainer(
                  duration:
                  const Duration(
                    milliseconds: 200,
                  ),
                  width:
                  active ? 16 : 6,
                  height: 6,
                  margin:
                  const EdgeInsets
                      .symmetric(
                    horizontal: 3,
                  ),
                  decoration:
                  BoxDecoration(
                    color: active
                        ? primaryColor
                        : Colors
                        .grey
                        .shade300,
                    borderRadius:
                    BorderRadius
                        .circular(
                      10,
                    ),
                  ),
                );
              },
            ),
          ),

          // RECOMMENDED

          Padding(
            padding:
            const EdgeInsets.fromLTRB(
              12,
              16,
              12,
              8,
            ),
            child: Row(
              children: [
                const Expanded(
                  child: Text(
                    'Recommended',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),
                ),
                if (categoryApplied)
                  Text(
                    selectedHomeCategory,
                    style:
                    const TextStyle(
                      color:
                      primaryColor,
                      fontSize: 11,
                      fontWeight:
                      FontWeight.w600,
                    ),
                  ),
              ],
            ),
          ),

          if (visibleProducts.isEmpty)
            const Padding(
              padding:
              EdgeInsets.all(35),
              child: Center(
                child: Text(
                  'No products found',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
            )
          else
            GridView.builder(
              shrinkWrap: true,
              physics:
              const NeverScrollableScrollPhysics(),
              padding:
              const EdgeInsets.fromLTRB(
                10,
                0,
                10,
                20,
              ),
              gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio:
                0.82,
              ),
              itemCount:
              visibleProducts.length,
              itemBuilder:
                  (context, index) {
                return _homeProductCard(
                  visibleProducts[
                  index],
                );
              },
            ),
        ],
      ),
    );
  }

  // ============================================================
  // HOME PRODUCT CARD
  // ============================================================

  Widget _homeProductCard(
      Map<String, dynamic> product,
      ) {
    final bool liked =
    isInWishlist(product);

    return Card(
      margin: EdgeInsets.zero,
      elevation: 1,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius:
        BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: () {
          openProductDetail(product);
        },
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Padding(
                      padding:
                      const EdgeInsets
                          .all(
                        8,
                      ),
                      child: Image.asset(
                        product['image']
                            .toString(),
                        fit: BoxFit.contain,
                        errorBuilder:
                            (
                            context,
                            error,
                            stackTrace,
                            ) {
                          return Container(
                            color: Colors
                                .grey
                                .shade100,
                            alignment:
                            Alignment
                                .center,
                            child:
                            const Icon(
                              Icons
                                  .image_not_supported_outlined,
                              color:
                              Colors.grey,
                              size: 35,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: IconButton(
                      onPressed: () {
                        toggleWishlist(
                          product,
                        );
                      },
                      icon: Icon(
                        liked
                            ? Icons
                            .favorite
                            : Icons
                            .favorite_border,
                        size: 20,
                        color: liked
                            ? primaryColor
                            : Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding:
              const EdgeInsets
                  .fromLTRB(
                9,
                3,
                9,
                0,
              ),
              child: Text(
                product['subCategory']
                    .toString(),
                maxLines: 1,
                overflow:
                TextOverflow
                    .ellipsis,
                style:
                const TextStyle(
                  fontSize: 9,
                  color: Colors.grey,
                ),
              ),
            ),
            Padding(
              padding:
              const EdgeInsets
                  .fromLTRB(
                9,
                4,
                9,
                12,
              ),
              child: Text(
                product['name']
                    .toString(),
                maxLines: 2,
                overflow:
                TextOverflow
                    .ellipsis,
                style:
                const TextStyle(
                  fontSize: 11,
                  fontWeight:
                  FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // CART PAGE
  // ============================================================

  Widget _cartPage() {
    if (cartItems.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment:
          MainAxisAlignment.center,
          children: [
            Icon(
              Icons
                  .shopping_cart_outlined,
              size: 60,
              color: Colors.grey,
            ),
            SizedBox(height: 10),
            Text(
              'Your cart is empty',
              style: TextStyle(
                fontSize: 15,
                fontWeight:
                FontWeight.bold,
              ),
            ),
            SizedBox(height: 4),
            Text(
              'Add products to your cart',
              style: TextStyle(
                fontSize: 11,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      );
    }

    double cartTotal = 0;

    for (final item in cartItems) {
      final double price =
      (item['price'] as num)
          .toDouble();

      final int quantity =
          (item['quantity'] as num?)
              ?.toInt() ??
              0;

      cartTotal +=
          price * quantity;
    }

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding:
            const EdgeInsets.all(6),
            itemCount:
            cartItems.length,
            itemBuilder:
                (context, index) {
              final Map<String, dynamic>
              item =
              cartItems[index];

              final double price =
              (item['price'] as num)
                  .toDouble();

              final double oldPrice =
              (item['oldPrice'] as num)
                  .toDouble();

              final int quantity =
                  (item['quantity']
                  as num?)
                      ?.toInt() ??
                      0;

              final int discount =
              oldPrice > price
                  ? (((oldPrice -
                  price) /
                  oldPrice) *
                  100)
                  .round()
                  : 0;

              return Card(
                margin:
                const EdgeInsets.only(
                  bottom: 6,
                ),
                elevation: 1,
                clipBehavior:
                Clip.antiAlias,
                shape:
                RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(
                    8,
                  ),
                ),

                // COMPACT CART CARD
                child: SizedBox(
                  height: 105,
                  child: Row(
                    crossAxisAlignment:
                    CrossAxisAlignment
                        .center,
                    children: [
                      // PRODUCT IMAGE

                      InkWell(
                        onTap: () {
                          openProductDetail(
                            item,
                          );
                        },
                        child: Container(
                          width: 95,
                          height: 105,
                          padding:
                          const EdgeInsets
                              .all(
                            6,
                          ),
                          color: Colors.white,
                          child:
                          Image.asset(
                            item['image']
                                .toString(),
                            fit: BoxFit
                                .contain,
                            errorBuilder:
                                (
                                context,
                                error,
                                stackTrace,
                                ) {
                              return Container(
                                color: Colors
                                    .grey
                                    .shade100,
                                alignment:
                                Alignment
                                    .center,
                                child:
                                const Icon(
                                  Icons
                                      .image_not_supported_outlined,
                                  color:
                                  Colors.grey,
                                  size: 30,
                                ),
                              );
                            },
                          ),
                        ),
                      ),

                      const SizedBox(
                        width: 8,
                      ),

                      // TEXT + QUANTITY

                      Expanded(
                        child: Padding(
                          padding:
                          const EdgeInsets
                              .fromLTRB(
                            0,
                            6,
                            7,
                            6,
                          ),
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment
                                .start,
                            mainAxisAlignment:
                            MainAxisAlignment
                                .spaceBetween,
                            children: [
                              // NAME + DELETE

                              Row(
                                crossAxisAlignment:
                                CrossAxisAlignment
                                    .start,
                                children: [
                                  Expanded(
                                    child:
                                    InkWell(
                                      onTap: () {
                                        openProductDetail(
                                          item,
                                        );
                                      },
                                      child:
                                      Text(
                                        item['name']
                                            .toString(),
                                        maxLines:
                                        1,
                                        overflow:
                                        TextOverflow
                                            .ellipsis,
                                        style:
                                        const TextStyle(
                                          fontSize:
                                          11,
                                          fontWeight:
                                          FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),

                                  // DELETE WITH POPUP

                                  InkWell(
                                    onTap: () {
                                      _showDeleteConfirmation(
                                        item,
                                      );
                                    },
                                    borderRadius:
                                    BorderRadius
                                        .circular(
                                      20,
                                    ),
                                    child:
                                    const Padding(
                                      padding:
                                      EdgeInsets
                                          .all(
                                        2,
                                      ),
                                      child:
                                      Icon(
                                        Icons
                                            .delete_outline,
                                        size: 17,
                                        color:
                                        primaryColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              // SUB CATEGORY

                              Text(
                                item['subCategory']
                                    ?.toString() ??
                                    '',
                                maxLines: 1,
                                overflow:
                                TextOverflow
                                    .ellipsis,
                                style:
                                const TextStyle(
                                  fontSize: 8,
                                  color:
                                  Colors.grey,
                                ),
                              ),

                              // PRICE + MRP + DISCOUNT

                              Wrap(
                                spacing: 5,
                                runSpacing: 2,
                                crossAxisAlignment:
                                WrapCrossAlignment
                                    .center,
                                children: [
                                  Text(
                                    '₹${price.toStringAsFixed(0)}',
                                    style:
                                    const TextStyle(
                                      color:
                                      primaryColor,
                                      fontSize: 12,
                                      fontWeight:
                                      FontWeight.bold,
                                    ),
                                  ),
                                  if (oldPrice >
                                      price)
                                    Text(
                                      '₹${oldPrice.toStringAsFixed(0)}',
                                      style:
                                      const TextStyle(
                                        color:
                                        Colors.grey,
                                        fontSize: 8,
                                        decoration:
                                        TextDecoration.lineThrough,
                                      ),
                                    ),
                                  if (discount >
                                      0)
                                    Text(
                                      '$discount% OFF',
                                      style:
                                      TextStyle(
                                        color: Colors
                                            .green
                                            .shade700,
                                        fontSize: 8,
                                        fontWeight:
                                        FontWeight.bold,
                                      ),
                                    ),
                                ],
                              ),

                              // QUANTITY

                              _cartQuantityButton(
                                item,
                                quantity,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),

        // ======================================================
        // CART TOTAL + PROCEED TO BUY
        // ======================================================

        Container(
          width: double.infinity,
          padding:
          const EdgeInsets.fromLTRB(
            10,
            7,
            10,
            7,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black
                    .withValues(
                  alpha: 0.08,
                ),
                blurRadius: 5,
                offset:
                const Offset(
                  0,
                  -2,
                ),
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisSize:
                  MainAxisSize.min,
                  crossAxisAlignment:
                  CrossAxisAlignment
                      .start,
                  children: [
                    const Text(
                      'Cart Total',
                      style:
                      TextStyle(
                        fontSize: 9,
                        color:
                        Colors.grey,
                      ),
                    ),
                    const SizedBox(
                      height: 1,
                    ),
                    Text(
                      '₹${cartTotal.toStringAsFixed(0)}',
                      style:
                      const TextStyle(
                        color:
                        primaryColor,
                        fontSize: 16,
                        fontWeight:
                        FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: 38,
                child:
                ElevatedButton(
                  onPressed:
                  _proceedFromCart,
                  style:
                  ElevatedButton
                      .styleFrom(
                    backgroundColor:
                    primaryColor,
                    foregroundColor:
                    Colors.white,
                    elevation: 0,
                    padding:
                    const EdgeInsets
                        .symmetric(
                      horizontal: 20,
                    ),
                    shape:
                    RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius
                          .circular(
                        7,
                      ),
                    ),
                  ),
                  child: const Text(
                    'Proceed to Buy',
                    style:
                    TextStyle(
                      fontSize: 12,
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ============================================================
  // CART QUANTITY BUTTON
  // ============================================================

  Widget _cartQuantityButton(
      Map<String, dynamic> product,
      int quantity,
      ) {
    return Container(
      width: 100,
      height: 28,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: primaryColor,
          width: 1,
        ),
        borderRadius:
        BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          // MINUS

          Expanded(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: quantity > 0
                    ? () {
                  setCartQuantity(
                    product,
                    quantity - 1,
                  );
                }
                    : null,
                child: SizedBox(
                  height:
                  double.infinity,
                  child: Center(
                    child: Icon(
                      Icons.remove,
                      size: 15,
                      color: quantity > 0
                          ? primaryColor
                          : Colors.grey
                          .shade400,
                    ),
                  ),
                ),
              ),
            ),
          ),

          // QUANTITY

          SizedBox(
            width: 28,
            child: Center(
              child: Text(
                '$quantity',
                style:
                const TextStyle(
                  color:
                  primaryColor,
                  fontSize: 11,
                  fontWeight:
                  FontWeight.bold,
                ),
              ),
            ),
          ),

          // PLUS

          Expanded(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  setCartQuantity(
                    product,
                    quantity + 1,
                  );
                },
                child:
                const SizedBox(
                  height:
                  double.infinity,
                  child: Center(
                    child: Icon(
                      Icons.add,
                      size: 15,
                      color:
                      primaryColor,
                    ),
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
  // PROCEED FROM CART
  // ============================================================

  void _proceedFromCart() {
    if (cartItems.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            'Your cart is empty',
          ),
        ),
      );

      return;
    }

    final Map<String, dynamic>
    product =
        cartItems.first;

    final int quantity =
        (product['quantity'] as num?)
            ?.toInt() ??
            1;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            OrderSummaryScreen(
              product: product,
              quantity: quantity,
            ),
      ),
    );
  }

  // ============================================================
  // WISHLIST PAGE
  // ============================================================

  Widget _wishlistPage() {
    if (wishlistItems.isEmpty) {
      return Column(
        children: [
          Align(
            alignment:
            Alignment.centerLeft,
            child: TextButton.icon(
              onPressed: () {
                setState(() {
                  showWishlistPage =
                  false;
                });
              },
              icon: const Icon(
                Icons.arrow_back,
              ),
              label:
              const Text('Back'),
            ),
          ),
          const Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment:
                MainAxisAlignment
                    .center,
                children: [
                  Icon(
                    Icons
                        .favorite_border,
                    color: Colors.grey,
                    size: 60,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Your wishlist is empty',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    }

    return Column(
      children: [
        Row(
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  showWishlistPage =
                  false;
                });
              },
              icon: const Icon(
                Icons.arrow_back,
              ),
            ),
            const Text(
              'My Wishlist',
              style: TextStyle(
                fontSize: 17,
                fontWeight:
                FontWeight.bold,
              ),
            ),
          ],
        ),

        Expanded(
          child: GridView.builder(
            padding:
            const EdgeInsets.all(
              10,
            ),
            gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio:
              0.70,
            ),
            itemCount:
            wishlistItems.length,
            itemBuilder:
                (context, index) {
              final product =
              wishlistItems[index];

              final double price =
              (product['price']
              as num)
                  .toDouble();

              return Card(
                clipBehavior:
                Clip.antiAlias,
                child: InkWell(
                  onTap: () {
                    openProductDetail(
                      product,
                    );
                  },
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment
                        .start,
                    children: [
                      Expanded(
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child:
                              Padding(
                                padding:
                                const EdgeInsets
                                    .all(
                                  8,
                                ),
                                child:
                                Image.asset(
                                  product[
                                  'image']
                                      .toString(),
                                  fit: BoxFit
                                      .contain,
                                  errorBuilder:
                                      (
                                      context,
                                      error,
                                      stackTrace,
                                      ) {
                                    return const Center(
                                      child:
                                      Icon(
                                        Icons
                                            .image_not_supported_outlined,
                                        color:
                                        Colors.grey,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child:
                              IconButton(
                                onPressed:
                                    () {
                                  toggleWishlist(
                                    product,
                                  );
                                },
                                icon:
                                const Icon(
                                  Icons
                                      .favorite,
                                  color:
                                  primaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                        const EdgeInsets
                            .symmetric(
                          horizontal: 8,
                        ),
                        child: Text(
                          product['name']
                              .toString(),
                          maxLines: 2,
                          overflow:
                          TextOverflow
                              .ellipsis,
                          style:
                          const TextStyle(
                            fontSize: 11,
                            fontWeight:
                            FontWeight
                                .bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                        const EdgeInsets
                            .fromLTRB(
                          8,
                          5,
                          8,
                          10,
                        ),
                        child: Text(
                          '₹${price.toStringAsFixed(0)}',
                          style:
                          const TextStyle(
                            color:
                            primaryColor,
                            fontWeight:
                            FontWeight
                                .bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // ============================================================
  // MY ORDERS
  // ============================================================

  Widget _ordersPage() {
    if (appOrders.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment:
          MainAxisAlignment.center,
          children: [
            Icon(
              Icons
                  .inventory_2_outlined,
              size: 60,
              color: Colors.grey,
            ),
            SizedBox(height: 10),
            Text(
              'No orders yet',
              style: TextStyle(
                fontSize: 16,
                fontWeight:
                FontWeight.bold,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: appOrders.length,
      itemBuilder:
          (context, index) {
        final Map<String, dynamic>
        order =
        appOrders[index];

        final int quantity =
            (order['quantity']
            as num?)
                ?.toInt() ??
                1;

        final double total =
            (order['total']
            as num?)
                ?.toDouble() ??
                0;

        return Card(
          margin:
          const EdgeInsets.only(
            bottom: 8,
          ),
          elevation: 1,
          child: Padding(
            padding:
            const EdgeInsets.all(
              9,
            ),
            child: Row(
              children: [
                Container(
                  width: 80,
                  height: 90,
                  padding:
                  const EdgeInsets
                      .all(
                    4,
                  ),
                  child: Image.asset(
                    order['image']
                        ?.toString() ??
                        '',
                    fit: BoxFit.contain,
                    errorBuilder:
                        (
                        context,
                        error,
                        stackTrace,
                        ) {
                      return const Icon(
                        Icons
                            .image_outlined,
                        color:
                        Colors.grey,
                      );
                    },
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment
                        .start,
                    children: [
                      Text(
                        order['name']
                            ?.toString() ??
                            'Product',
                        maxLines: 2,
                        overflow:
                        TextOverflow
                            .ellipsis,
                        style:
                        const TextStyle(
                          fontSize: 12,
                          fontWeight:
                          FontWeight
                              .bold,
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        'Quantity: $quantity',
                        style:
                        const TextStyle(
                          fontSize: 10,
                          color:
                          Colors.grey,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Total: ₹${total.toStringAsFixed(0)}',
                        style:
                        const TextStyle(
                          color:
                          primaryColor,
                          fontWeight:
                          FontWeight
                              .bold,
                        ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        'Order Confirmed',
                        style:
                        TextStyle(
                          fontSize: 10,
                          color: Colors
                              .green
                              .shade700,
                          fontWeight:
                          FontWeight
                              .w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // ============================================================
  // BOTTOM NAVIGATION
  // ============================================================

  Widget _bottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      type:
      BottomNavigationBarType.fixed,
      selectedItemColor:
      primaryColor,
      unselectedItemColor:
      Colors.grey,
      selectedFontSize: 9,
      unselectedFontSize: 9,
      iconSize: 20,
      onTap: (index) {
        setState(() {
          selectedIndex = index;
          showWishlistPage = false;
        });
      },
      items: [
        const BottomNavigationBarItem(
          icon: Icon(
            Icons.home_outlined,
          ),
          activeIcon:
          Icon(Icons.home),
          label: 'Home',
        ),
        const BottomNavigationBarItem(
          icon: Icon(
            Icons.grid_view_outlined,
          ),
          activeIcon:
          Icon(Icons.grid_view),
          label: 'Categories',
        ),
        const BottomNavigationBarItem(
          icon: Icon(
            Icons
                .inventory_2_outlined,
          ),
          activeIcon: Icon(
            Icons.inventory_2,
          ),
          label: 'My Orders',
        ),
        BottomNavigationBarItem(
          icon: Stack(
            clipBehavior: Clip.none,
            children: [
              const Icon(
                Icons
                    .shopping_cart_outlined,
              ),
              if (totalCartQuantity >
                  0)
                Positioned(
                  right: -9,
                  top: -7,
                  child: Container(
                    constraints:
                    const BoxConstraints(
                      minWidth: 15,
                      minHeight: 15,
                    ),
                    alignment:
                    Alignment.center,
                    padding:
                    const EdgeInsets
                        .symmetric(
                      horizontal: 3,
                    ),
                    decoration:
                    BoxDecoration(
                      color:
                      primaryColor,
                      borderRadius:
                      BorderRadius
                          .circular(
                        10,
                      ),
                    ),
                    child: Text(
                      '$totalCartQuantity',
                      style:
                      const TextStyle(
                        color:
                        Colors.white,
                        fontSize: 8,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          activeIcon:
          const Icon(
            Icons.shopping_cart,
          ),
          label: 'Cart',
        ),
        const BottomNavigationBarItem(
          icon: Icon(
            Icons.person_outline,
          ),
          activeIcon:
          Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }
}