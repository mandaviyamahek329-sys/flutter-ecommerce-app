import 'package:flutter/material.dart';
import 'product_detail_screen.dart';

class CategoriesScreen extends StatefulWidget {
  final List<Map<String, dynamic>> products;

  final Function(
      Map<String, dynamic> product,
      int quantity,
      ) onAddToCart;

  final Function(
      Map<String, dynamic> product,
      ) onRemoveFromCart;

  final int Function(
      Map<String, dynamic> product,
      ) getCartQuantity;

  final Function(
      Map<String, dynamic> product,
      ) onToggleWishlist;

  final bool Function(
      Map<String, dynamic> product,
      ) isInWishlist;

  const CategoriesScreen({
    super.key,
    required this.products,
    required this.onAddToCart,
    required this.onRemoveFromCart,
    required this.getCartQuantity,
    required this.onToggleWishlist,
    required this.isInWishlist,
  });

  @override
  State<CategoriesScreen> createState() =>
      _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  static const Color primaryColor = Color(0xFFE91E63);

  String? selectedMainCategory;
  String selectedSubCategory = 'All';
  String searchText = '';

  final TextEditingController searchController =
  TextEditingController();

  // ============================================================
  // MAIN CATEGORIES
  // ============================================================

  final List<Map<String, String>> mainCategories = [
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
  // SUB CATEGORIES
  // ============================================================

  final Map<String, List<String>> subCategories = {
    'Women': [
      'All',
      'Dresses',
      'Party Wear',
      'Formal',
      'Sarees',
      'Tops',
      'Kurtis',
      'Jeans',
      'T-Shirts',
    ],
    'Men': [
      'All',
      'T-Shirt',
      'Shirt',
      'Kurta',
      'Ethnic Wear',
    ],
    'Kids': [
      'All',
      'Shorts',
      'Kids T-Shirt',
      'Ethnic Wear',
      'School Bag',
    ],
    'Beauty': [
      'All',
      'Lipstick',
      'Kajal',
      'Makeup',
      'Blush',
    ],
    'Shoes': [
      'All',
      'Kids Shoes',
      'Men Shoes',
      'Women Shoes',
      'Casual Shoes',
    ],
    'Bags': [
      'All',
      'School Bags',
      'Women Bag',
      'Men Bag',
      'Formal Bag',
    ],
    'Jewellery': [
      'All',
      'Ring',
      'Necklace',
      'Payal',
      'Bracelet',
    ],
    'Phone': [
      'All',
      'Android',
      'iOS',
      'OnePlus',
    ],
    'Laptop': [
      'All',
      'HP',
      'Dell',
      'Acer',
    ],
  };

  // ============================================================
  // FILTER PRODUCTS
  // ============================================================

  List<Map<String, dynamic>> get visibleProducts {
    List<Map<String, dynamic>> result =
    List<Map<String, dynamic>>.from(
      widget.products,
    );

    if (selectedMainCategory != null) {
      result = result.where((product) {
        return product['category'] == selectedMainCategory;
      }).toList();
    }

    if (selectedSubCategory != 'All') {
      result = result.where((product) {
        return product['subCategory'] == selectedSubCategory;
      }).toList();
    }

    if (searchText.trim().isNotEmpty) {
      final String query =
      searchText.trim().toLowerCase();

      result = result.where((product) {
        final String name =
        product['name'].toString().toLowerCase();

        final String category =
        product['category'].toString().toLowerCase();

        final String subCategory =
        product['subCategory'].toString().toLowerCase();

        return name.contains(query) ||
            category.contains(query) ||
            subCategory.contains(query);
      }).toList();
    }

    return result;
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    if (selectedMainCategory == null) {
      return _allCategoriesPage();
    }

    return _selectedCategoryPage();
  }

  // ============================================================
  // ALL CATEGORIES PAGE
  // ============================================================

  Widget _allCategoriesPage() {
    List<Map<String, String>> filteredCategories =
    List<Map<String, String>>.from(
      mainCategories,
    );

    if (searchText.trim().isNotEmpty) {
      final String query =
      searchText.trim().toLowerCase();

      filteredCategories =
          mainCategories.where((category) {
            return category['name']!
                .toLowerCase()
                .contains(query);
          }).toList();
    }

    return Column(
      children: [
        _searchBar(),

        const Padding(
          padding: EdgeInsets.fromLTRB(
            12,
            12,
            12,
            8,
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Shop By Category',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),

        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: filteredCategories.length,
            gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 9,
              mainAxisSpacing: 9,
              childAspectRatio: 0.83,
            ),
            itemBuilder: (context, index) {
              final Map<String, String> category =
              filteredCategories[index];

              return InkWell(
                onTap: () {
                  setState(() {
                    selectedMainCategory =
                    category['name'];

                    selectedSubCategory = 'All';

                    searchText = '';

                    searchController.clear();
                  });
                },
                borderRadius: BorderRadius.circular(10),
                child: Card(
                  margin: EdgeInsets.zero,
                  elevation: 1,
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Image.asset(
                            category['image']!,
                            width: double.infinity,
                            fit: BoxFit.contain,
                            errorBuilder: (
                                context,
                                error,
                                stackTrace,
                                ) {
                              return Container(
                                color: Colors.grey.shade100,
                                alignment: Alignment.center,
                                child: const Icon(
                                  Icons
                                      .image_not_supported_outlined,
                                  size: 35,
                                  color: Colors.grey,
                                ),
                              );
                            },
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(7),
                        child: Text(
                          category['name']!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
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
  // SELECTED CATEGORY PAGE
  // ============================================================

  Widget _selectedCategoryPage() {
    final List<String> subs =
        subCategories[selectedMainCategory] ?? ['All'];

    final List<Map<String, dynamic>> products =
        visibleProducts;

    return Column(
      children: [
        // TOP BAR
        Container(
          color: Colors.white,
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    selectedMainCategory = null;
                    selectedSubCategory = 'All';

                    searchText = '';
                    searchController.clear();
                  });
                },
                icon: const Icon(
                  Icons.arrow_back,
                ),
              ),

              Expanded(
                child: Text(
                  selectedMainCategory ?? '',
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),

        // SEARCH
        _searchBar(),

        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // =================================================
              // LEFT SUBCATEGORY
              // =================================================

              Container(
                width: 80,
                color: Colors.grey.shade100,
                child: ListView.builder(
                  itemCount: subs.length,
                  itemBuilder: (context, index) {
                    final String sub = subs[index];

                    final bool selected =
                        selectedSubCategory == sub;

                    return InkWell(
                      onTap: () {
                        setState(() {
                          selectedSubCategory = sub;
                        });
                      },
                      child: Container(
                        constraints:
                        const BoxConstraints(
                          minHeight: 58,
                        ),
                        alignment: Alignment.center,
                        padding:
                        const EdgeInsets.symmetric(
                          horizontal: 5,
                          vertical: 7,
                        ),
                        decoration: BoxDecoration(
                          color: selected
                              ? primaryColor.withValues(
                            alpha: 0.10,
                          )
                              : Colors.transparent,
                          border: Border(
                            left: BorderSide(
                              color: selected
                                  ? primaryColor
                                  : Colors.transparent,
                              width: 3,
                            ),
                          ),
                        ),
                        child: Text(
                          sub,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 10,
                            color: selected
                                ? primaryColor
                                : Colors.black87,
                            fontWeight: selected
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              // =================================================
              // PRODUCTS
              // =================================================

              Expanded(
                child: products.isEmpty
                    ? const Center(
                  child: Text(
                    'No products found',
                  ),
                )
                    : GridView.builder(
                  padding:
                  const EdgeInsets.all(7),
                  itemCount: products.length,
                  gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 7,
                    mainAxisSpacing: 7,
                    childAspectRatio: 0.54,
                  ),
                  itemBuilder: (
                      context,
                      index,
                      ) {
                    return _productCard(
                      products[index],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ============================================================
  // SEARCH BAR
  // ============================================================

  Widget _searchBar() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(
        9,
        7,
        9,
        7,
      ),
      child: SizedBox(
        height: 42,
        child: TextField(
          controller: searchController,
          onChanged: (value) {
            setState(() {
              searchText = value;
            });
          },
          decoration: InputDecoration(
            hintText: 'Search products...',
            hintStyle: const TextStyle(
              fontSize: 12,
            ),
            prefixIcon: const Icon(
              Icons.search,
              size: 19,
            ),
            suffixIcon: searchText.isNotEmpty
                ? IconButton(
              onPressed: () {
                searchController.clear();

                setState(() {
                  searchText = '';
                });
              },
              icon: const Icon(
                Icons.close,
                size: 18,
              ),
            )
                : null,
            filled: true,
            fillColor: Colors.grey.shade100,
            contentPadding: EdgeInsets.zero,
            border: OutlineInputBorder(
              borderRadius:
              BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
    );
  }

  // ============================================================
  // PRODUCT CARD
  // ============================================================

  Widget _productCard(
      Map<String, dynamic> product,
      ) {
    final int quantity =
    widget.getCartQuantity(product);

    final bool liked =
    widget.isInWishlist(product);

    // IMPORTANT:
    // Exact price and oldPrice product mathi levay chhe.
    // Koi price calculate/guess nathi thati.
    final double price =
    (product['price'] as num).toDouble();

    final double oldPrice =
    (product['oldPrice'] as num).toDouble();

    // Discount automatic exact price + oldPrice parthi
    final int discount = oldPrice > price
        ? (((oldPrice - price) / oldPrice) * 100)
        .round()
        : 0;

    return Card(
      margin: EdgeInsets.zero,
      elevation: 1,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(9),
      ),

      // IMPORTANT:
      // Whole Card par InkWell nathi.
      // Etle quantity button tap karta detail open nahi thay.
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ====================================================
          // CLICKABLE PRODUCT AREA
          // ====================================================

          Expanded(
            child: InkWell(
              onTap: () {
                _openProduct(product);
              },
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  // =============================================
                  // IMAGE + WISHLIST
                  // =============================================

                  Expanded(
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Padding(
                            padding:
                            const EdgeInsets.all(7),
                            child: Image.asset(
                              product['image'].toString(),
                              fit: BoxFit.contain,
                              errorBuilder: (
                                  context,
                                  error,
                                  stackTrace,
                                  ) {
                                return Container(
                                  color:
                                  Colors.grey.shade100,
                                  alignment:
                                  Alignment.center,
                                  child: const Icon(
                                    Icons
                                        .image_not_supported_outlined,
                                    color: Colors.grey,
                                    size: 30,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),

                        // WISHLIST
                        Positioned(
                          top: 0,
                          right: 0,
                          child: IconButton(
                            onPressed: () {
                              widget.onToggleWishlist(
                                product,
                              );

                              setState(() {});
                            },
                            icon: Icon(
                              liked
                                  ? Icons.favorite
                                  : Icons
                                  .favorite_border,
                              color: liked
                                  ? primaryColor
                                  : Colors.grey,
                              size: 19,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // =============================================
                  // SUB CATEGORY
                  // =============================================

                  Padding(
                    padding:
                    const EdgeInsets.fromLTRB(
                      8,
                      2,
                      8,
                      0,
                    ),
                    child: Text(
                      product['subCategory']
                          .toString(),
                      maxLines: 1,
                      overflow:
                      TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 9,
                        color: Colors.grey,
                      ),
                    ),
                  ),

                  // =============================================
                  // PRODUCT NAME
                  // =============================================

                  Padding(
                    padding:
                    const EdgeInsets.fromLTRB(
                      8,
                      3,
                      8,
                      0,
                    ),
                    child: Text(
                      product['name'].toString(),
                      maxLines: 2,
                      overflow:
                      TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight:
                        FontWeight.w600,
                      ),
                    ),
                  ),

                  // =============================================
                  // PRICE
                  // =============================================

                  Padding(
                    padding:
                    const EdgeInsets.fromLTRB(
                      8,
                      6,
                      8,
                      0,
                    ),
                    child: Wrap(
                      crossAxisAlignment:
                      WrapCrossAlignment.center,
                      spacing: 5,
                      runSpacing: 3,
                      children: [
                        // OFFER PRICE
                        Text(
                          '₹${price.toStringAsFixed(0)}',
                          style: const TextStyle(
                            fontSize: 13,
                            color: primaryColor,
                            fontWeight:
                            FontWeight.bold,
                          ),
                        ),

                        // OLD PRICE
                        if (oldPrice > price)
                          Text(
                            '₹${oldPrice.toStringAsFixed(0)}',
                            style:
                            const TextStyle(
                              fontSize: 9,
                              color: Colors.grey,
                              decoration:
                              TextDecoration
                                  .lineThrough,
                            ),
                          ),
                      ],
                    ),
                  ),

                  // =============================================
                  // DISCOUNT
                  // =============================================

                  if (discount > 0)
                    Padding(
                      padding:
                      const EdgeInsets.fromLTRB(
                        8,
                        4,
                        8,
                        4,
                      ),
                      child: Text(
                        '$discount% OFF',
                        style: TextStyle(
                          fontSize: 10,
                          color:
                          Colors.green.shade700,
                          fontWeight:
                          FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),

          // ====================================================
          // QUANTITY AREA
          //
          // IMPORTANT:
          // Aa product InkWell ni BAHAR chhe.
          // Etle +/- click karta Product Details open nahi thay.
          // ====================================================

          Padding(
            padding: const EdgeInsets.fromLTRB(
              8,
              5,
              8,
              9,
            ),
            child: Center(
              child: _quantityButton(
                product,
                quantity,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // QUANTITY BUTTON
  // ============================================================

  Widget _quantityButton(
      Map<String, dynamic> product,
      int quantity,
      ) {
    return Container(
      width: 105,
      height: 34,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: primaryColor,
          width: 1.2,
        ),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          // ====================================================
          // MINUS
          // ====================================================

          Expanded(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: quantity > 0
                    ? () {
                  final int newQuantity =
                      quantity - 1;

                  widget.onAddToCart(
                    product,
                    newQuantity,
                  );

                  setState(() {});
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
                          : Colors.grey.shade400,
                    ),
                  ),
                ),
              ),
            ),
          ),

          // ====================================================
          // QUANTITY NUMBER
          // ====================================================

          SizedBox(
            width: 30,
            child: Center(
              child: Text(
                '$quantity',
                style: const TextStyle(
                  color: primaryColor,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          // ====================================================
          // PLUS
          // ====================================================

          Expanded(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  final int newQuantity =
                      quantity + 1;

                  widget.onAddToCart(
                    product,
                    newQuantity,
                  );

                  setState(() {});
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
          ),
        ],
      ),
    );
  }

  // ============================================================
  // OPEN PRODUCT DETAILS
  // ============================================================

  void _openProduct(
      Map<String, dynamic> product,
      ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            ProductDetailScreen(
              // IMPORTANT:
              // Same complete product map pass thay chhe.
              // price/oldPrice change thati nathi.
              product: product,

              // Current Cart quantity
              initialQuantity:
              widget.getCartQuantity(
                product,
              ),

              // Exact quantity parent/cart ma set
              onAddToCart: (
                  selectedProduct,
                  quantity,
                  ) {
                widget.onAddToCart(
                  selectedProduct,
                  quantity,
                );

                if (mounted) {
                  setState(() {});
                }
              },

              // Wishlist
              onToggleWishlist: (
                  selectedProduct,
                  ) {
                widget.onToggleWishlist(
                  selectedProduct,
                );

                if (mounted) {
                  setState(() {});
                }
              },

              isWishlisted:
              widget.isInWishlist(
                product,
              ),
            ),
      ),
    ).then((_) {
      if (mounted) {
        setState(() {});
      }
    });
  }

  // ============================================================
  // DISPOSE
  // ============================================================

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}