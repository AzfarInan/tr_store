import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:tr_store/src/core/widgets/button.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: Lottie.asset('assets/animations/splash_animation.json'),
            ),
            Text(
              'TR Store',
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            Button(
              onPressed: () {
                // Navigator.pushNamed(context, WalletAppRoute.onBoardingScreen);
              },
              label: "Continue",
              borderRadius: 50,
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
