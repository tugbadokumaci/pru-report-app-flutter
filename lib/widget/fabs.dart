import 'package:flutter/material.dart';
import 'package:qr_code_app/bloc/home_page/home_view.dart';

import '../constants/constants.dart';
import '../utils/custom_colors.dart';

class FABs {
  static FloatingActionButton buildCreateFab(BuildContext context) {
    return FloatingActionButton(
      heroTag: 'callButton',
      backgroundColor: CustomColors.bwyRed,
      tooltip: 'Ara $phoneNumber',
      onPressed: () {
        Navigator.pushNamed(context, '/home');
      },
      child: Icon(Icons.add, color: Colors.white),
    );
  }
}
