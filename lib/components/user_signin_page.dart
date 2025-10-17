  import 'package:flutter/material.dart';
  import 'choose_user_widget.dart';
  import 'user_signup_page.dart';

  class UserSignInPage extends StatelessWidget {
    const UserSignInPage({super.key});

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              // 🔙 Back button with manual positioning
              Positioned(
                top: 20, // distance from top
                left: 10, // distance from left
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

              // 🧱 Main content (centered, scrollable)
              Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 60), // spacing below back button

                        // Logo image
                        Image.asset(
                          'assets/images/zaika_logo.png',
                          width: 80,
                          height: 80,
                          fit: BoxFit.contain,
                        ),

                        const SizedBox(height: 20),

                        // Zaika text image
                        Image.asset(
                          'assets/images/zaika_text.png',
                          width: 200,
                          height: 50,
                          fit: BoxFit.contain,
                        ),

                        const SizedBox(height: 40),

                        // Email TextField
                        TextField(
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.email_outlined),
                            hintText: 'Email',
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

                        // Password TextField
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

                        const SizedBox(height: 10),

                        // Forgot password link
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {},
                            child: const Text(
                              'Forgot password?',
                              style: TextStyle(
                                color: Color(0xFF8173C3),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Sign in button
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF8173C3),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text(
                              'Sign in',
                              style: TextStyle(
                                fontSize: 16,
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 15),

                        // Sign Up link
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Don't have an account? "),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const UserSignUpPage(),
                                    ),
                                  );
                                },
                                child: const Text(
                                  'Sign Up',
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
