import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  String selectedCategory = 'Drinks';

  final Map<String, List<Map<String, dynamic>>> menuItems = {
    'Veg': [
      {'name': 'Paneer Tikka', 'price': 120},
      {'name': 'Veg Burger', 'price': 100},
    ],
    'Non-Veg': [
      {'name': 'Chicken Biryani', 'price': 180},
      {'name': 'Mutton Curry', 'price': 220},
    ],
    'Drinks': [
      {'name': 'Fresh Lime Soda', 'price': 60},
      {'name': 'Mohito', 'price': 80},
      {'name': 'Gin 60ml', 'price': 150},
      {'name': 'Vodka 60ml', 'price': 100},
      {'name': 'Black Label 60ml', 'price': 120},
    ],
    'Desert': [
      {'name': 'Chocolate Cake', 'price': 90},
      {'name': 'Ice Cream', 'price': 70},
    ],
  };

  // store count for each item
  Map<String, int> itemCounts = {};

  // store spice level per item
  Map<String, String> itemSpiceLevels = {};

  @override
  Widget build(BuildContext context) {
    final items = menuItems[selectedCategory]!;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF625D9F),
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Menu',
            style: GoogleFonts.poppins(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Category chips
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: ['Veg', 'Non-Veg', 'Drinks', 'Desert']
                    .map(
                      (cat) => Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: ChoiceChip(
                          label: Text(cat),
                          selected: selectedCategory == cat,
                          onSelected: (_) => setState(() {
                            selectedCategory = cat;
                          }),
                          selectedColor: const Color(0xFF625D9F),
                          labelStyle: TextStyle(
                            color: selectedCategory == cat
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),

            const SizedBox(height: 10),

            // Menu list
            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  final count = itemCounts[item['name']] ?? 0;
                  final selectedSpice = itemSpiceLevels[item['name']];

                  return Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    margin: const EdgeInsets.only(bottom: 12),
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Item name and price row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item['name'],
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    '₹ ${item['price']}',
                                    style: GoogleFonts.poppins(fontSize: 14),
                                  ),
                                ],
                              ),
                              // Add/Counter button
                              Container(
                                decoration: BoxDecoration(
                                  color:
                                      const Color(0xFF625D9F).withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    count == 0
                                        ? TextButton(
                                            onPressed: () {
                                              setState(() =>
                                                  itemCounts[item['name']] = 1);
                                            },
                                            style: TextButton.styleFrom(
                                              backgroundColor:
                                                  const Color(0xFF625D9F),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20,
                                                      vertical: 8),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                            ),
                                            child: const Text(
                                              "Add",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          )
                                        : Row(
                                            children: [
                                              IconButton(
                                                icon:
                                                    const Icon(Icons.remove),
                                                onPressed: () {
                                                  setState(() {
                                                    if (count > 0) {
                                                      itemCounts[
                                                              item['name']] =
                                                          count - 1;
                                                    }
                                                  });
                                                },
                                              ),
                                              Text(
                                                '$count',
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              IconButton(
                                                icon: const Icon(Icons.add),
                                                onPressed: () {
                                                  setState(() {
                                                    itemCounts[item['name']] =
                                                        count + 1;
                                                  });
                                                },
                                              ),
                                            ],
                                          ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 10),

                          // 🌶 Spice level (only for Veg, Non-Veg)
                          if (['Veg', 'Non-Veg'].contains(selectedCategory))
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Choose Spice Level:",
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Row(
                                  children: [
                                    ChoiceChip(
                                      label: const Text("Mild 🌶"),
                                      selected: selectedSpice == "Mild",
                                      onSelected: (_) => setState(() =>
                                          itemSpiceLevels[item['name']] =
                                              "Mild"),
                                      selectedColor: Colors.orangeAccent,
                                    ),
                                    const SizedBox(width: 8),
                                    ChoiceChip(
                                      label: const Text("Medium 🌶🌶"),
                                      selected: selectedSpice == "Medium",
                                      onSelected: (_) => setState(() =>
                                          itemSpiceLevels[item['name']] =
                                              "Medium"),
                                      selectedColor: Colors.deepOrangeAccent,
                                    ),
                                    const SizedBox(width: 8),
                                    ChoiceChip(
                                      label: const Text("Spicy 🌶🌶🌶"),
                                      selected: selectedSpice == "Spicy",
                                      onSelected: (_) => setState(() =>
                                          itemSpiceLevels[item['name']] =
                                              "Spicy"),
                                      selectedColor: Colors.redAccent,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            // Confirm Order button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // print all selected items, counts, and spice levels
                  for (var item in itemCounts.keys) {
                    final count = itemCounts[item];
                    final spice = itemSpiceLevels[item] ?? 'N/A';
                    debugPrint('$item - Qty: $count, Spice: $spice');
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  side: const BorderSide(color: Color(0xFF625D9F)),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text(
                  "Confirm Meals",
                  style: TextStyle(color: Color(0xFF625D9F)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
