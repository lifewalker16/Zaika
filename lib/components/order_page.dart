import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    final orderItems = [
      {'name': 'Veg Biryani', 'qty': 1, 'price': 180.0},
      {'name': 'Pulua', 'qty': 2, 'price': 150.0},
      {'name': 'Roti', 'qty': 5, 'price': 20.0},
      {'name': 'Mohito', 'qty': 1, 'price': 80.0},
      {'name': 'Gin', 'qty': 2, 'price': 150.0},
      {'name': 'Black Label', 'qty': 5, 'price': 120.0},
    ];

    double total = orderItems.fold(
        0, (sum, item) => sum + (item['qty'] as int) * (item['price'] as double));
    double gst = total * 0.18;
    double grandTotal = total + gst;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Location Section
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    const Icon(Icons.location_pin, color: Colors.red, size: 36),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Sonsodo, Raia, Goa",
                              style: GoogleFonts.poppins(
                                  fontSize: 14, color: Colors.grey[600])),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Order Details
            Text(
              "Order no.: 201",
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),

            // Order Table
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _buildTableHeader(),
                    const Divider(),
                    ...orderItems.map((item) => _buildOrderRow(item)),
                    const Divider(),
                    _buildSummaryRow("TOTAL", total),
                    _buildSummaryRow("GST 18%", gst),
                    const SizedBox(height: 8),
                    _buildSummaryRow("GRAND TOTAL", grandTotal, bold: true),
                  ],
                ),
              ),
            ),
            const Spacer(),

            // Confirm Order Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  side: const BorderSide(color: Color(0xFF625D9F)),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text(
                  "Confirm Order",
                  style: TextStyle(
                    color: Color(0xFF625D9F),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTableHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildHeaderCell("Item", flex: 3),
        _buildHeaderCell("Qty"),
        _buildHeaderCell("Price"),
        _buildHeaderCell("Total Price"),
      ],
    );
  }

  Widget _buildHeaderCell(String text, {int flex = 1}) {
    return Expanded(
      flex: flex,
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildOrderRow(Map<String, dynamic> item) {
    double total = item['qty'] * item['price'];
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(flex: 3, child: Text(item['name'])),
          Expanded(child: Text('${item['qty']}')),
          Expanded(child: Text('${item['price'].toStringAsFixed(2)}')),
          Expanded(child: Text('${total.toStringAsFixed(2)}')),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String title, double value, {bool bold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            fontWeight: bold ? FontWeight.bold : FontWeight.w500,
            fontSize: bold ? 16 : 14,
          ),
        ),
        Text(
          value.toStringAsFixed(2),
          style: GoogleFonts.poppins(
            fontWeight: bold ? FontWeight.bold : FontWeight.w500,
            fontSize: bold ? 16 : 14,
          ),
        ),
      ],
    );
  }
}
