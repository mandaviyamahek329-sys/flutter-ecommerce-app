import 'package:flutter/material.dart';

const Color primaryColor = Color(0xFFE91E63);

Future<int?> showCategoryFilterPopup({
  required BuildContext context,
  required int selectedCategory,
  required List<Map<String, String>> categories,
}) {
  int tempSelectedCategory = selectedCategory;

  return showModalBottomSheet<int>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    showDragHandle: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(25),
      ),
    ),
    builder: (sheetContext) {
      return StatefulBuilder(
        builder: (context, setPopupState) {
          return SafeArea(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.72,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 5,
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.tune,
                          color: primaryColor,
                        ),
                        const SizedBox(width: 8),
                        const Expanded(
                          child: Text(
                            'Filter',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        IconButton(
                          onPressed: () {
                            Navigator.pop(sheetContext);
                          },
                          icon: const Icon(Icons.close),
                        ),
                      ],
                    ),
                  ),

                  const Divider(),

                  const Padding(
                    padding: EdgeInsets.fromLTRB(
                      18,
                      8,
                      18,
                      12,
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Select Category',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                  Expanded(
                    child: GridView.builder(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                      itemCount: categories.length,
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 0.80,
                      ),
                      itemBuilder: (context, index) {
                        final category = categories[index];

                        final bool selected =
                            tempSelectedCategory == index;

                        return InkWell(
                          borderRadius: BorderRadius.circular(15),
                          onTap: () {
                            setPopupState(() {
                              tempSelectedCategory = index;
                            });
                          },
                          child: AnimatedContainer(
                            duration:
                            const Duration(milliseconds: 200),
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: selected
                                  ? primaryColor.withOpacity(0.08)
                                  : Colors.white,
                              borderRadius:
                              BorderRadius.circular(15),
                              border: Border.all(
                                color: selected
                                    ? primaryColor
                                    : Colors.grey.shade300,
                                width: selected ? 2 : 1,
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 62,
                                  height: 62,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: selected
                                          ? primaryColor
                                          : Colors.grey.shade300,
                                    ),
                                  ),
                                  child: ClipOval(
                                    child: Image.asset(
                                      category['image']!,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 8),

                                Text(
                                  category['name']!,
                                  style: TextStyle(
                                    color: selected
                                        ? primaryColor
                                        : Colors.black87,
                                    fontWeight: selected
                                        ? FontWeight.bold
                                        : FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                      18,
                      10,
                      18,
                      18,
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pop(
                            sheetContext,
                            tempSelectedCategory,
                          );
                        },
                        icon: const Icon(Icons.check),
                        label: const Text('Apply Filter'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}