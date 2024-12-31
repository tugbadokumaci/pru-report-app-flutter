import 'dart:async';

import 'package:flutter/material.dart';
import 'package:qr_code_app/utils/box_constrains.dart';
import 'package:qr_code_app/utils/custom_text_styles.dart';
import 'package:qr_code_app/widget/box.dart';
import 'package:qr_code_app/widget/lottie_widget.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 3), () {
      // splash screen de 3 sn bekle, sonra home git. BAŞLANGIÇ TALLMATI
      Navigator.of(context).pushReplacementNamed('/home');
    });

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.zero,
              margin: EdgeInsets.zero,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: const LottieWidget(path: 'waves_blue'),
            ),
            Align(
              // Ortalamak için eklenen Align widget
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center, // Varsayılan olarak ortalar
                  children: [
                    Image.asset(
                      'assets/images/pru_logo.png',
                      width: 100,
                    ),
                    const Box(size: BoxSize.EXTRASMALL, type: BoxType.VERTICAL),
                    Text(
                      'PRUSAM',
                      style: CustomTextStyles2.titleLargeTextStyle(context, Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
