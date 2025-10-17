import 'package:flutter/material.dart';
import 'choose_user_widget.dart';
import 'user_signin_page.dart';

class UserSignUpPage extends StatelessWidget {
  const UserSignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // 🔙 Back button at top-left (adjust position manually)
            Positioned(
              top: 20,
              left: 10,
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Color(0xFF8173C3),
                  size: 26,
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ChooseUserWidget(),
                    ),
                  );
                },
              ),
            ),

            // 🌟 Main Content
            Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 60),

                      // 🔥 Logo image (on top of Zaika text)
                      Image.asset(
                        'assets/images/zaika_logo.png',
                        width: 80,
                        height: 80,
                        fit: BoxFit.contain,
                      ),

                      const SizedBox(height: 15),

                      // Zaika text image
                      Image.asset(
                        'assets/images/zaika_text.png',
                        width: 180,
                        height: 60,
                        fit: BoxFit.contain,
                      ),

                      const SizedBox(height: 40),

                      // 🧍 Name field
                      TextField(
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.person_outline),
                          hintText: 'Name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide:
                                const BorderSide(color: Color(0xFF8173C3)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide:
                                const BorderSide(color: Color(0xFF8173C3)),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // 🏠 Address field
                      TextField(
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.home_outlined),
                          hintText: 'Address',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide:
                                const BorderSide(color: Color(0xFF8173C3)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide:
                                const BorderSide(color: Color(0xFF8173C3)),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // 🔒 Password field
                      TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.lock_outline),
                          hintText: 'Password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide:
                                const BorderSide(color: Color(0xFF8173C3)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide:
                                const BorderSide(color: Color(0xFF8173C3)),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // 🔒 Confirm Password field
                      TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.lock_outline),
                          hintText: 'Confirm Password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide:
                                const BorderSide(color: Color(0xFF8173C3)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide:
                                const BorderSide(color: Color(0xFF8173C3)),
                          ),
                        ),
                      ),

                      const SizedBox(height: 30),

                      // 🎯 Sign Up button
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            // TODO: Add sign-up logic
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF8173C3),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 15),

                      // 🔁 Already have account
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Already have an account? "),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const UserSignInPage(),
                                ),
                              );
                            },
                            child: const Text(
                              'Sign in',
                              style: TextStyle(
                                color: Color(0xFF8173C3),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
