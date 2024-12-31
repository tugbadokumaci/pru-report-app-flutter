import 'package:flutter/material.dart';

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
      child: const Icon(Icons.search, color: Colors.white),
    );
  }
}
