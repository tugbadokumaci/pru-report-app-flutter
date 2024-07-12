import 'dart:async';

import 'package:flutter/material.dart';
import 'package:qr_code_app/utils/custom_colors.dart';
import 'package:qr_code_app/utils/custom_text_styles.dart';
import 'package:qr_code_app/widget/lottie_widget.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacementNamed('/home');
    });

    return MaterialApp(
      home: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Hata ile karşılaşıldı',
                style: CustomTextStyles2.titleMediumTextStyle(context, CustomColors.bwyYellow)),
            Container(
                color: Colors.black,
                child: const Align(
                  alignment: Alignment.center,
                  child: LottieWidget(path: 'splash_screen'),
                )),
          ],
        ),
      ),
    );
  }
}
