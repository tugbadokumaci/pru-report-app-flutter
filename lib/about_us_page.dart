import 'package:flutter/material.dart';
import 'package:qr_code_app/utils/custom_text_styles.dart';

import 'enum/pages_enum.dart';
import 'utils/custom_bottom_nav_bar.dart';

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({super.key});

  @override
  State<AboutUsPage> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  int _selectedIndex = Pages.HOME.index; // creating index field for our state

  final int _selectedIndexDrawer = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hakkımızda', style: CustomTextStyles2.appBarTextStyle(context)),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Sayfanın başında yer alan resim
              Center(
                child: Image.network(
                  'https://prusam.pirireis.edu.tr/wp-content/uploads/2024/05/0017115.jpeg',
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 20),
              HakkimizdaWidget(),
              const SizedBox(height: 20),
              const PrusamWidget(),
              const SizedBox(height: 20),

              VizyonAndMisyonWidget(),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomNavigationBar(
          selectedIndex: _selectedIndex,
          onTabChange: (int index) {
            setState(() {
              _selectedIndex = index;
            });
          }),
      drawer: Drawer(
          child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Color(0xff1E376E),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('PRUSAM', style: CustomTextStyles2.drawerTitleTextStyle(context)),
                Text('PÎRÎ REİS ÜNİVERSİTESİ', style: CustomTextStyles2.drawerTitleTextStyle(context)),
                Text('SÜRDÜRÜLEBİLİRLİK ARAŞTIRMA VE UYGULAMA MERKEZİ',
                    style: CustomTextStyles2.drawerTitleTextStyle(context)),
              ],
            ),
          ),
          ListTile(
            title: const Text('Hakkımızda'),
            selected: _selectedIndexDrawer == 0,
            onTap: () {
              // Update the state of the app
              _onItemTapped(0);
              // Then close the drawer
              Navigator.pushNamed(context, '/aboutUs');
            },
          ),
          ExpansionTile(
            title: const Text('Araştırma'),
            children: <Widget>[
              ListTile(
                title: const Text("Avrupa Birliği Projeleri"),
                onTap: () {
                  Navigator.pushNamed(context, '/projectsRoute');
                },
              ),
              ListTile(
                title: const Text("Tübitak Projeleri"),
                onTap: () {
                  Navigator.pushNamed(context, '/home');
                },
              ),
              ListTile(
                title: const Text("BAP Projeleri"),
                onTap: () {
                  Navigator.pushNamed(context, '/home');
                },
              ),
              ListTile(
                title: const Text("Sanayi-Üniversite İşbirliği Projeleri"),
                onTap: () {
                  Navigator.pushNamed(context, '/home');
                },
              ),
              ListTile(
                title: const Text("Diğer Projeler"),
                onTap: () {
                  Navigator.pushNamed(context, '/home');
                },
              ),
            ],
          ),
          ListTile(
            title: const Text('Etkinlikler'),
            onTap: () {
              _onItemTapped(2);
              Navigator.pop(context);
              // Navigator.pushNamed(context, '/sampleReport');
              Navigator.pushNamed(context, '/home');
            },
            selected: _selectedIndexDrawer == 2,
          ),
          ListTile(
            title: const Text('Haberler'),
            onTap: () {
              _onItemTapped(2);
              Navigator.pop(context);
              // Navigator.pushNamed(context, '/sampleReport');
              Navigator.pushNamed(context, '/newsRoute');
            },
            selected: _selectedIndexDrawer == 3,
          ),
          ListTile(
            title: const Text('Bültenler'),
            onTap: () {
              _onItemTapped(2);
              Navigator.pop(context);
              // Navigator.pushNamed(context, '/sampleReport');
              Navigator.pushNamed(context, '/bulletinRoute');
            },
            selected: _selectedIndexDrawer == 4,
          ),
          ListTile(
            title: const Text('Kütüphane'),
            onTap: () {
              _onItemTapped(2);
              Navigator.pop(context);
              Navigator.pushNamed(context, '/home');
            },
            selected: _selectedIndexDrawer == 5,
          ),
          ListTile(
            title: const Text('İletişim'),
            onTap: () {
              _onItemTapped(2);
              Navigator.pop(context);
              Navigator.pushNamed(context, '/contact');
            },
            selected: _selectedIndexDrawer == 6,
          ),
        ],
      )),
    );
  }

  Widget VizyonAndMisyonWidget() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Vizyon',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        Text(
          '“Sürdürülebilirlik alanında yenilikçi çözümler üreterek ve küresel çapta alanında öncü araştırmalar yaparak daima gelişen, lider bir akademik merkez olmak.”',
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(height: 30),
        Text(
          'Misyon',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        Text(
          '“Pîrî Reis Üniversitesi Sürdürülebilirlik Araştırma ve Uygulama Merkezi olarak, sürdürülebilirlik ilkelerini bilimsel araştırmalar ve uygulama projeleriyle destekleyerek, üniversite işbirlikleri aracılığıyla çevre dostu ve ekonomik olarak etkili çözümler sunmayı hedefliyoruz. Toplumsal farkındalığı arttırarak ve geleceğe yönelik sürdürülebilir gelişimi teşvik ederek, bilimsel ve toplumsal katkılarda bulunuyoruz.”',
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }

  Widget HakkimizdaWidget() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('PRUSAM', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        Text(
          'Pîrî Reis Üniversitesi Sürdürülebilirlik Araştırma ve Uygulama Merkezi; 2024 yılında denizcilik alanında köklü bir geçmişe sahip Pîrî Reis Üniversitesi bünyesinde kurulmuştur.',
          style: TextStyle(fontSize: 16),
        )
      ],
    );
  }
}

class PrusamWidget extends StatelessWidget {
  const PrusamWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Text(
      '2024 yılında denizcilik alanında köklü bir geçmişe sahip Pîrî Reis Üniversitesi bünyesinde kurulmuştur. Merkezimiz, Atatürk’ün denizcilik konusundaki vizyonunu ve çevre bilincini rehber alarak, sürdürülebilir uygulamaları teşvik etmek ve toplumsal farkındalığı artırmak amacıyla faaliyet göstermektedir.\n\n'
      'Merkezimizin temel amacı, sürdürülebilir çevre yönetimi ve deniz ekosistemlerinin korunmasına yönelik yenilikçi araştırmalar yapmak ve uygulamalar geliştirmektir. Eğitim, araştırma ve uygulama alanlarında yürütülen projelerle, çevre bilincini yaygınlaştırmak ve denizlerin korunmasına katkıda bulunmak öncelikli hedeflerimizdendir.\n\n'
      'Yönetimimiz, sürdürülebilirlik konusunda uzman akademisyenler ve profesyonellerden oluşmaktadır. Merkezimiz, çevre dostu projeler geliştirmek ve toplumsal farkındalığı artırmak için sürekli olarak yeni stratejiler üretmektedir.\n\n'
      'Sizleri, çevre bilincinin ve sürdürülebilir uygulamaların yaygınlaşması için yürüttüğümüz bu önemli çalışmalara destek olmaya ve katkıda bulunmaya davet ediyoruz.',
      style: TextStyle(fontSize: 16),
    );
  }
}
