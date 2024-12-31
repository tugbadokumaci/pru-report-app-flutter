import 'package:flutter/material.dart';

import '../bottom_nav_bar.dart';

class CustomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTabChange;

  const CustomNavigationBar({
    Key? key,
    required this.selectedIndex,
    required this.onTabChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomBottomNavigationBar(
      onTabChange: (int index) {
        onTabChange(index); // onTabChange çağırılıyor
        switch (index) {
          case 0:
            Navigator.pushNamed(context, '/home');
            break;
          case 1:
            Navigator.pushNamed(context, '/media', arguments: -1);
            break;
          case 2:
            Navigator.pushNamed(context, '/announcement');
            break;
          case 3:
            Navigator.pushNamed(context, '/profile');
            break;
        }
      },
      selectedIndex: selectedIndex,
    );
  }
}
