import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:qr_code_app/bloc/bulletin_page/bulletin_state.dart';
import 'package:qr_code_app/utils/custom_colors.dart';
import 'package:qr_code_app/utils/custom_text_styles.dart';
import 'package:qr_code_app/widget/lottie_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../enum/pages_enum.dart';
import '../../utils/custom_bottom_nav_bar.dart';
import 'bulletin_cubit.dart';
import '../../models/bulletin_model.dart';
import '../../constants/constants.dart';

class BulletinView extends StatefulWidget {
  final BulletinCubit viewModel;

  const BulletinView({Key? key, required this.viewModel}) : super(key: key);

  @override
  State<BulletinView> createState() => _BulletinViewState();
}

class _BulletinViewState extends State<BulletinView> {
  int _selectedIndex = Pages.HOME.index; // creating index field for our state

  final int _selectedIndexDrawer = 4;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

// PDF dosyasını açmak için URL Launcher kullanma
  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url); // String URL'yi Uri'ya dönüştür
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication); // Tarayıcıda açmak için
    } else {
      throw 'Could not launch $url';
    }
  }

// PDF dosyasını indirmek için flutter_downloader kullanma
  Future<void> _downloadPDF(String url) async {
    final Uri uri = Uri.parse(url); // String URL'yi Uri'ya dönüştür
    await FlutterDownloader.enqueue(
      url: uri.toString(), // `uri`'yi tekrar String'e çevir
      savedDir: '/storage/emulated/0/Download', // Android cihazı için indirme yolu
      fileName: 'bulletin.pdf',
      showNotification: true,
      openFileFromNotification: true,
    );
  }

  @override
  void initState() {
    super.initState();
    widget.viewModel.getAllBulletin();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BulletinCubit>(
      create: (_) => widget.viewModel,
      child: _buildScaffold(context),
    );
  }

  SafeArea _buildScaffold(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<BulletinCubit, BulletinState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is BulletinLoading) {
            return _buildLoading(context);
          } else if (state is BulletinSuccess) {
            return _buildSuccess(context, state);
          } else if (state is BulletinError) {
            return _buildError(context, state);
          }
          return Container();
        },
      ),
    );
  }

  Widget _buildSuccess(BuildContext context, BulletinSuccess state) {
    List<Bulletin> bulletins = state.bulletinResource.data ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text('Bültenler', style: CustomTextStyles2.appBarTextStyle(context)),
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
      backgroundColor: CustomColors.bgGray,
      body: SingleChildScrollView(
        child: Padding(
          padding: kAllPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: bulletins.map((bulletin) {
              return InkWell(
                onTap: () {
                  _launchURL(bulletin.pdfDosyasi); // PDF URL'yi aç
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Image
                      Image.network(
                        bulletin.kapakResmi ?? '',
                        fit: BoxFit.contain,
                        height: null,
                        width: double.infinity,
                      ),
                      const SizedBox(height: 8),
                      // Title
                      Text(
                        bulletin.baslik ?? 'No Title',
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              );
            }).toList(),
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

  Widget _buildLoading(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: const Color(0xff315891),
          width: double.infinity,
          height: double.infinity,
        ),
        Align(
          // Ortalamak için eklenen Align widget
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center, // Varsayılan olarak ortalar
            children: [
              const LottieWidget(path: 'compass_loading'),
              const SizedBox(height: 20),
              Text(
                'Yükleniyor..',
                style: CustomTextStyles2.titleMediumTextStyle(context, Colors.white),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildError(BuildContext context, BulletinError state) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Hata ile karşılaşıldı: ${state.message}',
              style: CustomTextStyles2.titleMediumTextStyle(context, CustomColors.bwyYellow)),
          Container(
            color: Colors.black,
            child: const Align(
              alignment: Alignment.center,
              child: LottieWidget(path: 'error_animation'),
            ),
          ),
        ],
      ),
    );
  }
}
