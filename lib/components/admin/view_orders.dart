import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ViewOrdersPage extends StatelessWidget {
  const ViewOrdersPage({super.key});

  // Stream to fetch all orders in real-time
  Stream<QuerySnapshot> getOrdersStream() {
    return FirebaseFirestore.instance
        .collection('orders')
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  // Function to get user name from userId
  Future<String> getUserName(String userId) async {
    try {
      final doc =
          await FirebaseFirestore.instance.collection('users').doc(userId).get();
      if (doc.exists) {
        final data = doc.data() as Map<String, dynamic>;
        return data['name'] ?? 'No Name';
      }
      return 'User Not Found';
    } catch (e) {
      debugPrint('Error fetching user name: $e');
      return 'Error';
    }
  }

  // Function to format timestamp
  String formatTimestamp(dynamic timestampField) {
    if (timestampField == null) return 'Unknown Time';

    if (timestampField is Timestamp) {
      final date = timestampField.toDate();
      final day = date.day.toString().padLeft(2, '0');
      final month = date.month.toString().padLeft(2, '0');
      final year = date.year.toString();
      final hour = date.hour > 12 ? date.hour - 12 : date.hour;
      final minute = date.minute.toString().padLeft(2, '0');
      final ampm = date.hour >= 12 ? 'PM' : 'AM';
      return '$day/$month/$year, $hour:$minute $ampm';
    } else if (timestampField is String) {
      return timestampField;
    } else {
      return 'Unknown Time';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        title: const Text(
          'View Orders',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        backgroundColor: const Color(0xFF8173C3),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: getOrdersStream(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Error loading orders.'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No orders found.'));
          }

          final orders = snapshot.data!.docs;

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final doc = orders[index];
              final order = doc.data() as Map<String, dynamic>;
              final orderId = doc.id;
              final items = List<Map<String, dynamic>>.from(order['items'] ?? []);
              final totalAmount = order['totalAmount'] ?? 0;
              final status = order['status'] ?? 'Unknown';
              final timestampField = order['timestamp'];
              final userId = order['userId'] ?? 'N/A';
              final formattedTime = formatTimestamp(timestampField);

              return Card(
                margin: const EdgeInsets.only(bottom: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Order ID
                      Text(
                        'Order ID: $orderId',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(height: 8),

                      // User name and status
                      Row(
                        children: [
                          const Icon(Icons.person, size: 20),
                          const SizedBox(width: 8),
                          FutureBuilder<String>(
                            future: getUserName(userId),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return const Text('Loading user...');
                              } else if (snapshot.hasError) {
                                return const Text('Error');
                              } else {
                                final userName = snapshot.data ?? 'Unknown';
                                return Text(userName,
                                    style: const TextStyle(fontWeight: FontWeight.bold));
                              }
                            },
                          ),
                          const Spacer(),
                          // Status badge
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: status.toLowerCase() == 'pending'
                                  ? Colors.orange.shade100
                                  : (status.toLowerCase() == 'completed'
                                      ? Colors.green.shade100
                                      : Colors.red.shade100),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              status,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: status.toLowerCase() == 'pending'
                                      ? Colors.orange
                                      : (status.toLowerCase() == 'completed'
                                          ? Colors.green
                                          : Colors.red)),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      // List of items
                      ...items.map((item) {
                        final name = item['name'] ?? 'Item';
                        final qty = item['quantity'] ?? 0;
                        final price = item['price'] ?? 0;
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(child: Text('$name x$qty')),
                              Text('₹$price'),
                            ],
                          ),
                        );
                      }).toList(),

                      const Divider(height: 20, thickness: 1),

                      // Total amount
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Total Amount',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          Text(
                            '₹$totalAmount',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),

                      // Timestamp
                      Row(
                        children: [
                          const Icon(Icons.access_time, size: 18, color: Colors.grey),
                          const SizedBox(width: 6),
                          Text(
                            formattedTime,
                            style: const TextStyle(color: Colors.grey, fontSize: 13),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
