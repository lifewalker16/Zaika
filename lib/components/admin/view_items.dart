import 'package:flutter/material.dart';

class ViewItemsPage extends StatelessWidget {
  const ViewItemsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Items'),
        backgroundColor: const Color(0xFF8173C3),
        centerTitle: true,
      ),
      body: const Center(
        child: Text('This is the View Items page.'),
      ),
    );
  }
}
