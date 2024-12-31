import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

// import 'lang/locale_keys.g.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final void Function(int)? onTabChange;
  int selectedIndex;
  CustomBottomNavigationBar({super.key, required this.onTabChange, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        boxShadow: [
          BoxShadow(
            blurRadius: 20,
            color: Colors.white.withOpacity(.1), // beyaza cevir
          )
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
          child: GNav(
            rippleColor: Colors.grey[300]!,
            hoverColor: Colors.grey[100]!,
            gap: 8,
            activeColor: Colors.white,
            iconSize: 24,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            duration: const Duration(milliseconds: 400),
            tabBackgroundColor: const Color(0xff222023),
            color: Colors.grey,
            tabs: const [
              GButton(
                icon: Icons.home,
                // text: LocaleKeys.home_appBarTitle.locale,
                text: 'Ana Sayfa',
              ),
              GButton(
                icon: Icons.perm_media,
                // text: LocaleKeys.about_us_appBarTitle.locale,
                text: 'Medya',
              ),
              GButton(
                icon: Icons.notifications,
                // text: LocaleKeys.contact_appBarTitle.locale,
                text: 'Bildirimler',
              ),
              GButton(
                icon: Icons.person,
                // text: LocaleKeys.profile_appBarTitle.locale,
                text: 'Hesabım',
              ),
            ],
            selectedIndex: selectedIndex,
            onTabChange: onTabChange,
          ),
        ),
      ),
    );
  }
}
