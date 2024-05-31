import 'package:flutter/material.dart';
import 'package:qr_code_app/utils/box_constrains.dart';
import 'package:qr_code_app/widget/box.dart';

import 'constants/constants.dart';
import 'utils/custom_colors.dart';
import 'utils/custom_text_styles.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text('İletişim', style: CustomTextStyles2.appBarTextStyle(context)),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: Icon(
                Icons.chevron_left,
                color: CustomColors.pruBlue,
                size: 40,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            );
          },
        ),
      ),
      backgroundColor: Colors.white,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: SingleChildScrollView(
          child: Padding(
        padding: kAllPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: _contactHeader(),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: _contactBody(),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: _contactFooter(),
            ),
          ],
        ),
      )),
    ));
  }

  Widget _contactHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Konumumuz',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            )),
        Box(size: BoxSize.EXTRASMALL, type: BoxType.VERTICAL),
        Image.asset('assets/images/contact_image.png'),
        Box(size: BoxSize.EXTRASMALL, type: BoxType.VERTICAL),
        Text('Bizimle İletişime Geçin',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            )),
        Box(size: BoxSize.EXTRASMALL, type: BoxType.VERTICAL),
        TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'İsminiz',
          ),
        ),
        Box(size: BoxSize.EXTRASMALL, type: BoxType.VERTICAL),
        TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Soyadınız',
          ),
        ),
        Box(size: BoxSize.EXTRASMALL, type: BoxType.VERTICAL),
        TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Mail',
          ),
        ),
        Box(size: BoxSize.EXTRASMALL, type: BoxType.VERTICAL),
        TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Telefon Numaranız',
          ),
        ),
        Box(size: BoxSize.EXTRASMALL, type: BoxType.VERTICAL),
        Text('Yeni raporlardan haberdar olmak ister misiniz?',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            )),
        Box(size: BoxSize.EXTRASMALL, type: BoxType.VERTICAL),
        TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'İletmek istediğiniz mesajınız',
          ),
        ),
        Box(size: BoxSize.EXTRASMALL, type: BoxType.VERTICAL),
        Center(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  // Add your logic here
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black, // Background color
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15), // Button padding
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7), // Rounded corners
                  ),
                ),
                child: Container(
                  height: 21,
                  width: 274,
                  child: Center(
                      child: Text(
                    'Gönder',
                    style: TextStyle(fontSize: 16),
                  )),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _contactBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [],
    );
  }

  Widget _contactFooter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [],
    );
  }
}
