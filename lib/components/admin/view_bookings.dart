import 'package:flutter/material.dart';

class ViewBookingsPage extends StatelessWidget {
  const ViewBookingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Bookings'),
        backgroundColor: const Color(0xFF8173C3),
        centerTitle: true,
      ),
      body: const Center(
        child: Text('This is the View Bookings page.'),
      ),
    );
  }
}
