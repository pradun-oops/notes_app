import 'package:flutter/material.dart';
import 'package:notes/route/page_route.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    goToNotePage();
  }

  void goToNotePage() async {
    await Future.delayed(
      const Duration(
        seconds: 3,
      ),
    );
    notePage();
  }

  void notePage() {
    Navigator.pushReplacementNamed(context, AppRoutes.ROUTE_NOTE);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/logo/writing.png",
              width: 250,
            ),
            const SizedBox(height: 50),
            Text(
              "MyNotes",
              style: TextStyle(
                color: Colors.white,
                fontSize: 40,
                fontWeight: FontWeight.bold,
                fontFamily: "Midnight",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
