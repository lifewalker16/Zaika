import 'package:flutter/material.dart';

class ViewOrdersPage extends StatelessWidget {
  const ViewOrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Orders'),
        backgroundColor: const Color(0xFF8173C3),
        centerTitle: true,
      ),
      body: const Center(
        child: Text('This is the View Orders page.'),
      ),
    );
  }
}
