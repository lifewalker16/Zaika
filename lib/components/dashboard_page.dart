import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'user_signin_page.dart';

class DashboardPage extends StatelessWidget {
  final String userName;

  const DashboardPage({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: const Color(0xFF625D9F),
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Image.asset(
              'assets/images/zaika_logo.png',
              height: 40,
            ),
            const SizedBox(width: 10),
            Image.asset(
              'assets/images/zaika_text_purple.png',
              height: 40,
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: GestureDetector(
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const UserSignInPage()),
                );
              },
              child: const CircleAvatar(
                backgroundColor: Color(0xFF625D9F),
                child: Icon(Icons.logout, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome user
            Text(
              'Welcome, $userName',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 20),

            // Hero Image
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                'assets/images/zaika_restaurant.jpeg',
                height: 220,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 25),

            // Option Cards
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildOptionCard(context, 'Book', 'assets/images/book.jpeg', Colors.orange),
                buildOptionCard(context, 'Menu', 'assets/images/menu.jpeg', Colors.green),
                buildOptionCard(context, 'Order', 'assets/images/order.jpeg', Colors.purple),
              ],
            ),
            const SizedBox(height: 20),

            // Add more sections if needed
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant_menu),
            label: 'Menu',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.feedback),
            label: 'Feedback',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event_seat),
            label: 'Booking',
          ),
        ],
      ),
    );
  }

  Widget buildOptionCard(BuildContext context, String title, String imagePath, Color color) {
    return Expanded(
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        shadowColor: color.withOpacity(0.4),
        child: InkWell(
          onTap: () {
            // TODO: Navigate to respective page
          },
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.all(12),
            height: 130,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [color.withOpacity(0.8), color],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    imagePath,
                    height: 60,
                    width: 60,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
