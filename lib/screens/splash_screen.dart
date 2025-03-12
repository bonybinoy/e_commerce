import 'dart:async';
import 'package:e_commerce/screens/home_page.dart';
import 'package:e_commerce/widget/bottomnav_widget.dart';
import 'package:e_commerce/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 2),
      () =>
          Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const BottomnavWidget(
            index: 0,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          // Center image and title
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  "assets/images/bag.png",
                  height: MediaQuery.of(context).size.height / 8,
                ),
                const SizedBox(height: 16),
                Text(
                  'E-comGrove',
                  style: GoogleFonts.cabin(fontSize: 20),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Text(
                'Your trusted shopping companion',
                style: GoogleFonts.abel(fontSize: 15, color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
