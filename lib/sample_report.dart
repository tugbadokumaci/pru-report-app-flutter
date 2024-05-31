import 'package:flutter/material.dart';
import 'package:qr_code_app/constants/constants.dart';
import 'package:qr_code_app/utils/box_constrains.dart';
import 'package:qr_code_app/widget/box.dart';

import 'utils/custom_colors.dart';
import 'utils/custom_text_styles.dart';
import 'widget/fabs.dart';

class SampleReport extends StatelessWidget {
  const SampleReport({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text('Raporlar', style: CustomTextStyles2.appBarTextStyle(context)),
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
      backgroundColor: Color(0xffE7F4FD),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: SingleChildScrollView(
          child: Padding(
        padding: kAllPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: _reportHeader(),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: _reportBody(),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: _reportFooter(),
            ),
          ],
        ),
      )),
    ));
  }

  Widget _reportBody() {
    return Column(
      children: [
        Text(
          'Denizlerimizin güncel sorunlarına önem verdiğimiz projemizde Karadeniz Bölgesi Denizcilik Sektöründe %30 iyileşme sağlandık.',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xff454E59), fontFamily: 'Inter'),
        ),
        Box(size: BoxSize.EXTRASMALL, type: BoxType.VERTICAL),
        Text(
          'Bu başarı, sürdürülebilirlik ve çevresel duyarlılık konularında 7 uluslarası proje katılımcımız ve üniversitemizden değerli 9 katılımcının desteği ile 116,169 km² alanda ilerlemeye devam etmektedir.',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Color(0xff313437), fontFamily: 'Inter'),
        ),
      ],
    );
  }

  Widget _reportFooter() {
    return Column(
      children: [
        Image.asset('assets/images/report_footer.png'),
      ],
    );
  }

  Widget _reportHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('MINE-EMI: Denizcilik Sektöründe Sürdürülebilirlik',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            )),
        Box(size: BoxSize.EXTRASMALL, type: BoxType.VERTICAL),
        Text('Raporlar >Çevre Raporları > MINE-EMI: Denizcilik Sektöründe Sürdürülebilirlik',
            style: TextStyle(fontSize: 20, color: Color(0xff8D8D8D), fontWeight: FontWeight.bold)),
        Box(size: BoxSize.EXTRASMALL, type: BoxType.VERTICAL),
        Text(
          '7.05.2024 12:34',
          style: TextStyle(fontSize: 20, color: Color(0xff6F7F91), fontWeight: FontWeight.bold),
        ),
        Image.asset('assets/images/report_body.png'),
      ],
    );
  }
}
