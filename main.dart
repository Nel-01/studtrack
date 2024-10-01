import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'login.dart'; 
import 'register.dart'; 

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StudTrack',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Arial',
      ),
      home: const DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Dashboard',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(
          color: Colors.white, // Set the icon color to white
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Navigate to Login Page
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.lightBlue, backgroundColor: Colors.white, // Set text color
            ),
            child: const Text(
              'Sign In',
              style: TextStyle(),
            ),
          ),
          const SizedBox(width: 16),
          TextButton(
            onPressed: () {
              // Navigate to Register Page
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const RegisterPage()),
              );
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.red, backgroundColor: Colors.white, // Set text color
            ),
            child: const Text(
              'Sign Up',
              style: TextStyle(),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        backgroundColor: Colors.black,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              child: Center(
                child: Text(
                  'Menu',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.dashboard, color: Colors.white),
              title: const Text('Dashboard', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.info, color: Colors.white),
              title: const Text('About Us', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => const AboutUsPage()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.contact_mail, color: Colors.white),
              title: const Text('Contact Us', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => const ContactUsPage()));
              },
            ),
          ],
        ),
      ),
      body: Row(
        children: [
          Expanded(
            child: Container(
              height: 1100,
              color: Colors.blueGrey,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child: Stack(
                children: [
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Dashboard',
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            shadows: [
                              Shadow(
                                blurRadius: 10.0,
                                color: Colors.black45,
                                offset: Offset(2, 2),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        AnimatedTextKit(
                          animatedTexts: [
                            TyperAnimatedText(
                              'Manage your data and track your performance from here. ',
                              textStyle: const TextStyle(fontSize: 18, color: Colors.black),
                              speed: const Duration(milliseconds: 100),
                            ),
                            TyperAnimatedText(
                              'Access key features such as reports, analytics, and user management.',
                              textStyle: const TextStyle(fontSize: 18, color: Colors.black),
                              speed: const Duration(milliseconds: 100),
                            ),
                            TyperAnimatedText(
                              'Stay informed with notifications and updates from the admin panel.',
                              textStyle: const TextStyle(fontSize: 18, color: Colors.black),
                              speed: const Duration(milliseconds: 100),
                            ),
                          ],
                          isRepeatingAnimation: false,
                        ),
                      ],
                    ),
                  ),
                  if (MediaQuery.of(context).size.width > 600) ...[
                    Positioned(
                      right: 20,
                      bottom: 20,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context, SlideTransitionRoute(page: const AboutUsPage()));
                        },
                        child: const Icon(
                          Icons.arrow_forward_ios,
                          size: 48,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: 1100,
              color: const Color(0xFF384959),
              child: const Image(
                image: NetworkImage('https://www.swipedon.com/hs-fs/hubfs/QR-scan3.gif?width=1600&name=QR-scan3.gif'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'About Us',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(
          color: Colors.white, // Set the icon color to white
        ),
      ),
      body: Row(
        children: [
          Expanded(
            child: Container(
              height: 1100,
              color: Colors.blueGrey,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child: Stack(
                children: [
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'About Us',
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            shadows: [
                              Shadow(
                                blurRadius: 10.0,
                                color: Colors.black45,
                                offset: Offset(2, 2),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        AnimatedTextKit(
                          animatedTexts: [
                            TyperAnimatedText(
                              'Learn more about our journey and what we do.',
                              textStyle: const TextStyle(fontSize: 18, color: Colors.black),
                              speed: const Duration(milliseconds: 100),
                            ),
                            TyperAnimatedText(
                              'Our mission is to provide innovative and reliable solutions to our users.',
                              textStyle: const TextStyle(fontSize: 18, color: Colors.black),
                              speed: const Duration(milliseconds: 100),
                            ),
                            TyperAnimatedText(
                              'With years of experience, we have built trust and excellence in our services.',
                              textStyle: const TextStyle(fontSize: 18, color: Colors.black),
                              speed: const Duration(milliseconds: 100),
                            ),
                          ],
                          isRepeatingAnimation: false,
                        ),
                      ],
                    ),
                  ),
                  if (MediaQuery.of(context).size.width > 600) ...[
                    Positioned(
                      left: 20,
                      bottom: 20,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.arrow_back_ios,
                          size: 48,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 20,
                      bottom: 20,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const ContactUsPage()));
                        },
                        child: const Icon(
                          Icons.arrow_forward_ios,
                          size: 48,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: 1100,
              color: const Color.fromARGB(255, 251, 253, 254),
              child: const Image(
                image: NetworkImage('https://cdn.dribbble.com/users/2851002/screenshots/7197919/search.gif'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ContactUsPage extends StatelessWidget {
  const ContactUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Contact Us',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(
          color: Colors.white, // Set the icon color to white
        ),
      ),
      body: Row(
        children: [
          Expanded(
            child: Container(
              height: 1100,
              color: Colors.blueGrey,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child: Stack(
                children: [
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Contact Us',
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            shadows: [
                              Shadow(
                                blurRadius: 10.0,
                                color: Colors.black45,
                                offset: Offset(2, 2),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        AnimatedTextKit(
                          animatedTexts: [
                            TyperAnimatedText(
                              'Reach out to us for any queries or support.',
                              textStyle: const TextStyle(fontSize: 18, color: Colors.black),
                              speed: const Duration(milliseconds: 100),
                            ),
                          ],
                          isRepeatingAnimation: false,
                        ),
                        const SizedBox(height: 10),
                        AnimatedTextKit(
                          animatedTexts: [
                            TyperAnimatedText(
                              'Facebook: https://www.facebook.com/sanfernando.sti.edu.',
                              textStyle: const TextStyle(fontSize: 18, color: Colors.black),
                              speed: const Duration(milliseconds: 100),
                            ),
                          ],
                          isRepeatingAnimation: false,
                        ),
                        const SizedBox(height: 10),
                        AnimatedTextKit(
                          animatedTexts: [
                            TyperAnimatedText(
                              'Contact no: 09472564271',
                              textStyle: const TextStyle(fontSize: 18, color: Colors.black),
                              speed: const Duration(milliseconds: 100),
                            ),
                          ],
                          isRepeatingAnimation: false,
                        ),
                                                const SizedBox(height: 10),
                        AnimatedTextKit(
                          animatedTexts: [
                            TyperAnimatedText(
                              'Email: stisanfernando@gmail.com.',
                              textStyle: const TextStyle(fontSize: 18, color: Colors.black),
                              speed: const Duration(milliseconds: 100),
                            ),
                          ],
                          isRepeatingAnimation: false,
                        ),
                      ],
                    ),
                  ),
                  if (MediaQuery.of(context).size.width > 600) ...[
                    Positioned(
                      left: 20,
                      bottom: 20,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.arrow_back_ios,
                          size: 48,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: 1100,
              color: const Color.fromARGB(255, 251, 253, 254),
              child: const Image(
                image: NetworkImage('https://cdn.dribbble.com/users/1602563/screenshots/8869646/qw.gif'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SlideTransitionRoute extends PageRouteBuilder {
  final Widget page;

  SlideTransitionRoute({required this.page})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.easeInOut;

            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            var offsetAnimation = animation.drive(tween);

            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
        );
}
