import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:qr_code_app/utils/box_constrains.dart';
import 'package:qr_code_app/widget/box.dart';
import 'package:qr_code_app/widget/fabs.dart';

import 'constants/constants.dart';
import 'enum/pages_enum.dart';
import 'utils/custom_bottom_nav_bar.dart';
import 'utils/custom_colors.dart';
import 'utils/custom_text_styles.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  int _selectedIndex = Pages.HOME.index; // creating index field for our state

  final int _selectedIndexDrawer = 6;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  late GoogleMapController mapController;
  // Konumunuzu burada ayarlayabilirsiniz
  final LatLng _center = const LatLng(40.8149217, 29.2878197); // San Francisco örneği

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

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
                    icon: Icon(Icons.menu, color: CustomColors.pruBlue),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                  );
                },
              ),
            ),
            backgroundColor: Colors.white,
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
            floatingActionButton: FABs.buildCreateFab(context),
            body: SingleChildScrollView(
                child: Padding(
              padding: kAllPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: _map(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: _contactTable(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: _contactExpansionTiles(),
                  ),
                ],
              ),
            )),
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
            ))));
  }

  Widget _map() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 300,
          child: GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 15.0,
            ),
            markers: {
              Marker(
                markerId: const MarkerId('contactLocation'),
                position: _center,
                infoWindow: const InfoWindow(title: 'Piri Reis Üniversitesi'),
              ),
            },
          ),
        ),
      ],
    );
  }

  Widget _contactHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Box(size: BoxSize.EXTRASMALL, type: BoxType.VERTICAL),
        const Text('Bizimle İletişime Geçin',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            )),
        const Box(size: BoxSize.EXTRASMALL, type: BoxType.VERTICAL),
        const TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'İsminiz',
          ),
        ),
        const Box(size: BoxSize.EXTRASMALL, type: BoxType.VERTICAL),
        const TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Soyadınız',
          ),
        ),
        const Box(size: BoxSize.EXTRASMALL, type: BoxType.VERTICAL),
        const TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Mail',
          ),
        ),
        const Box(size: BoxSize.EXTRASMALL, type: BoxType.VERTICAL),
        const TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Telefon Numaranız',
          ),
        ),
        const Box(size: BoxSize.EXTRASMALL, type: BoxType.VERTICAL),
        const Text('Yeni raporlardan haberdar olmak ister misiniz?',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            )),
        const Box(size: BoxSize.EXTRASMALL, type: BoxType.VERTICAL),
        const TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'İletmek istediğiniz mesajınız',
          ),
        ),
        const Box(size: BoxSize.EXTRASMALL, type: BoxType.VERTICAL),
        Center(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  // Add your logic here
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black, // Background color
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15), // Button padding
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7), // Rounded corners
                  ),
                ),
                child: const SizedBox(
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

  Widget _contactTable() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'İletişim Bilgileri',
          style: CustomTextStyles2.textMediumTextStyle(context, Colors.black),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Table(
            border: TableBorder.all(color: Colors.grey),
            columnWidths: const {
              0: FractionColumnWidth(0.3), // İlk sütun genişliği
              1: FractionColumnWidth(0.7), // İkinci sütun genişliği
            },
            children: [
              _buildTableRow("Adres (Deniz Kampüsü)", "Postane Mahallesi, Eflatun Sk. No:8, 34940 Tuzla / İSTANBUL"),
              _buildTableRow("Telefon", "+90 216 581 0050"),
              _buildTableRow("Faks", "+90 216 581 0051"),
              _buildTableRow("E-Posta (Üniversite)", "simulator@pirireis.edu.tr\ndp-info@pirireis.edu.tr"),
            ],
          ),
        ),
      ],
    );
  }

  TableRow _buildTableRow(String title, String value) {
    return TableRow(
      children: [
        Container(
          color: const Color(0xFF1F366D), // İlk sütun arka planı
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.centerLeft, // Yazıları sola hizala
          child: Text(
            title,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold), // Beyaz yazı rengi
          ),
        ),
        Container(
          color: Colors.white, // İkinci sütun arka planı beyaz
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.centerLeft, // Yazıları sola hizala
          child: Text(
            value,
            style: const TextStyle(color: Colors.black),
          ),
        ),
      ],
    );
  }

  Widget _contactExpansionTiles() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Ulaşım Bilgileri',
            style: CustomTextStyles2.textMediumTextStyle(context, Colors.black),
          ),
          const ExpansionTile(
            iconColor: Color(0xff1F366D),
            title: Text("Otobüs Ulaşımı"),
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Piri Reis Üniversitesi durağından geçen otobüs hatları:\n"
                  "• Kadıköy Kalkışlı: 130 ve 130A,\n"
                  "• Bostancı Kalkışlı: 133T,\n"
                  "• Kartal Metro Kalkışlı: KM 12,\n"
                  "• Cevizlibağ Kalkışlı: 500T (İçmeler Köprüsünden aktarma yapılması gerekmektedir),\n"
                  "• Sabiha Gökçen Kalkışlı: 130H\n"
                  "Tüm hatları görmek için tıklayınız.",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
          // Otomobil Ulaşımı
          const ExpansionTile(
            iconColor: Color(0xff1F366D),
            title: Text("Otomobil Ulaşımı"),
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "İstanbul – Ankara istikametinde D-100 (eski adı E-5) yolunda seyrederken "
                  "Tersaneler kavşağından ayrılarak Deniz Harp Okulu istikameti takip edilip "
                  "PİRİ REİS ÜNV. levhalarını gördüğünüzde devam edip Eflatun Sk. tan ulaşılabilir.",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
          // Metro Ulaşımı
          const ExpansionTile(
            iconColor: Color(0xff1F366D),
            title: Text("Metro Ulaşımı"),
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Halkalı- Gebze Marmaray metro hattının Tuzla durağında inilmelidir. "
                  "Tuzla İstasyon dolmuşlarına binilerek Piri Reis Üniversitesi durağında inilmelidir.",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
