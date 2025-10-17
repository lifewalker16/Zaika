import 'package:flutter/material.dart';
import 'package:zaika_app/components/splash_screen.dart';

void main() {
  runApp(const ZaikaApp());
}

class ZaikaApp extends StatelessWidget {
  const ZaikaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
