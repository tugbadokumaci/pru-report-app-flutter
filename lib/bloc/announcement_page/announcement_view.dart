import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/constants.dart';
import '../../utils/custom_bottom_nav_bar.dart';
import '../../utils/custom_colors.dart';
import '../../utils/custom_text_styles.dart';
import '../../widget/lottie_widget.dart';
import 'announcement_cubit.dart';
import 'announcement_state.dart';

class AnnouncementItem {
  final String title;
  final String description;
  final String date;

  AnnouncementItem({
    required this.title,
    required this.description,
    required this.date,
  });
}

class AnnouncementView extends StatefulWidget {
  AnnouncementCubit viewModel;

  AnnouncementView({super.key, required this.viewModel});

  @override
  State<AnnouncementView> createState() => _AnnouncementViewState();
}

class _AnnouncementViewState extends State<AnnouncementView> {
  List<AnnouncementItem> announcementItems = [
    AnnouncementItem(
        title: '“Piri Reis Üniversitesi Deniz Hukuku Dergisi” 5. Sayısı Hazırlanıyor',
        description:
            '“Pîrî Reis Üniversitesi Deniz Hukuku Dergisi”nin (Pîrî Reis University Journal of Maritime Law) 5. sayısı Haziran 2024 tarihinde yayınlanacaktır.   Dergide',
        date: 'Nisan 3, 2024'),
    AnnouncementItem(
        title: 'Erasmus+ Öğrenim Hareketliliği Faaliyeti İlanı (2023 Proje Dönemi)',
        description:
            'Erasmus+ Öğrenim Hareketliliği Faaliyeti İlanı Erasmus+ programı kapsamında öğrenim hareketliliğine katılarak 2024-2025 Öğretim yılının Güz ve/veya İlkbahar Dönemlerinde ders yükümlülüklerinin',
        date: 'Mart 27, 2024'),
    AnnouncementItem(
        title: 'Eramus+ Staj Hareketliliği Sonuçları',
        description:
            'Sıra Ad Soyad Eğitim Türü Birim Fakülte Öğrenci No Sınıf GENEL TOPLAM SONUÇ 1 Zey*** Öz*** Lisans Bilişim Sistemleri Mühendisliği',
        date: 'Mart 26, 2024'),
    AnnouncementItem(
        title: 'DMYO CanSALI Buluşmaları’nın 6. Faaliyeti Gerçekleştirildi',
        description:
            'Piri Reis Üniversitesi Denizcilik Meslek Yüksekokulu (PRU DMYO) tarafından her hafta düzenlenen “Can SALI Buluşmaları” adlı programın 2023-2024 Bahar Yarıyılı 6.oturumu gerçekleştirildi.',
        date: 'Mart 20, 2024'),
  ];

  int _selectedIndex = Pages.SAVED.index;
  @override
  void initState() {
    super.initState();
  }

  final int _selectedIndexDrawer = 0;
  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AnnouncementCubit>(create: (_) => widget.viewModel, child: _buildScaffold(context));
  }

  SafeArea _buildScaffold(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Bildirimler', style: CustomTextStyles2.appBarTextStyle(context)),
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
        body: SingleChildScrollView(
            child: BlocConsumer<AnnouncementCubit, AnnouncementState>(
          listener: ((context, state) {}),
          builder: (context, state) {
            debugPrint('Saved View State is : $state');
            if (state is AnnouncementInitial) {
              widget.viewModel.getSavedCards();
              return Container();
            } else if (state is AnnouncementLoading) {
              return _buildLoading();
            } else if (state is AnnouncementSuccess) {
              return _buildSuccess(context, state);
            } else if (state is AnnouncementError) {
              return _buildError(context);
            }
            return Container();
          },
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
        )),
      ),
    );
  }

  Widget _buildSuccess(BuildContext context, AnnouncementSuccess state) {
    return Padding(
      padding: kAllPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Use Expanded to allow the ListView to take remaining space
          SizedBox(height: 600, width: 600, child: _verticalCards(announcementItems)),
        ],
      ),
    );
  }

  Widget _verticalCards(List<AnnouncementItem> items) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: ListTile(
            leading: const Icon(Icons.star),
            title: Text(items[index].title),
            subtitle: Text(items[index].description),
            onTap: () {
              // Handle onTap action
            },
          ),
        );
      },
    );
  }

  Widget _buildLoading() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LinearProgressIndicator(
          color: Colors.yellow,
          backgroundColor: Colors.white,
        ),
      ],
    );
  }

  Widget _buildError(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Hata ile karşılaşıldı', style: CustomTextStyles2.titleMediumTextStyle(context, CustomColors.bwyYellow)),
        Container(
            color: Colors.black,
            child: const Align(
              alignment: Alignment.center,
              child: LottieWidget(path: 'error_animation'),
            )),
      ],
    );
  }
}

enum Pages {
  HOME,
  SCAN,
  SAVED,
  PROFILE,
}
