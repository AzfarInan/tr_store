import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:tr_store/src/core/route/tr_store_routes.dart';
import 'package:tr_store/src/core/widgets/button.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Spacer(),
            Padding(
              padding: EdgeInsets.all(32.w),
              child: Lottie.asset('assets/animations/splash_animation.json'),
            ),
            Text(
              'TR Store',
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                fontSize: 32.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            Button(
              onPressed: () {
                Navigator.pushNamed(context, TRStoreRoute.productList);
              },
              label: "Continue",
              borderRadius: 50.sp,
            ),
            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }
}
