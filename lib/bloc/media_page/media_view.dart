import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_code_app/utils/box_constrains.dart';
import 'package:qr_code_app/widget/button.dart';
import 'package:qr_code_app/widget/container.dart';

import '../../bottom_nav_bar.dart';
import '../../constants/constants.dart';
import '../../utils/custom_colors.dart';
import '../../utils/custom_text_styles.dart';
import '../../widget/box.dart';
import '../../widget/lottie_widget.dart';
import 'media_cubit.dart';
import 'media_state.dart';

class VideoItem {
  final String imagePath;
  final String title;
  final String description;

  VideoItem({
    required this.imagePath,
    required this.title,
    required this.description,
  });
}

class MediaView extends StatefulWidget {
  final MediaCubit viewModel;
  const MediaView({super.key, required this.viewModel});

  @override
  State<MediaView> createState() => _MediaViewState();
}

class _MediaViewState extends State<MediaView> with TickerProviderStateMixin {
  int _selectedIndexDrawer = 0;
  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Görünüm',
      style: optionStyle,
    ),
    Text(
      'Index 1: Limanlar, Deniz ve Açık Deniz',
      style: optionStyle,
    ),
    Text(
      'Index 2: Gemi İnşaa/Bakım Onarım/Geri Dönüşüm',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<VideoItem> videoItems = [
    VideoItem(
      imagePath: 'assets/images/video1.png',
      title: 'Piri Reis Üniversitesi Rektörü Prof. Dr. Nafiz ...',
      description: '0:28',
    ),
    VideoItem(
      imagePath: 'assets/images/video2.png',
      title: 'Denizcilik Meslek Yüksekokulu Müdürü ...',
      description: '1:09',
    ),
    VideoItem(
      imagePath: 'assets/images/video3.png',
      title: 'Simülatör Merkezi Müdürü Sinan Tunçay’ın mesajı ...',
      description: '0:50',
    ),
    VideoItem(
      imagePath: 'assets/images/video4.png',
      title: 'Lisansüstü Eğitim Enstitüsü Öğretim Üyesi ...',
      description: '1:16',
    ),
  ];

  List<VideoItem> newsItems = [
    VideoItem(
      imagePath: 'assets/images/haber1.png',
      title: 'Üniversitemiz Öğretim Üyesi Doç. Dr. Orhan Özgür Aybar’ın yürütücüsü ...',
      description: 'Mayıs 3, 2024',
    ),
    VideoItem(
      imagePath: 'assets/images/haber2.png',
      title: 'DMYO CanSALI Buluşmaları’nın 8. Faaliyeti Gerçekleştirildi',
      description: 'Mayıs 2, 2024',
    ),
    VideoItem(
      imagePath: 'assets/images/haber3.png',
      title: 'Deniz Brokerliği öğrencilerimiz Asya Port Limanını ziyaret etti',
      description: 'Nisan 24, 2024',
    ),
    VideoItem(
      imagePath: 'assets/images/haber4.png',
      title: 'TÜBİTAK Ulusal Metroloji Enstitüsü’ne Teknik Gezi.',
      description: 'Nisan 22, 2024',
    ),
  ];
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this); // Length is set to 3 for three tabs
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  int _selectedIndex = Pages.MEDIA.index;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MediaCubit>(create: (_) => widget.viewModel, child: _buildScaffold(context));
  }

  SafeArea _buildScaffold(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Medya',
            style: CustomTextStyles2.appBarTextStyle(context),
          ),
          bottom: TabBar(
            controller: _tabController,
            dividerColor: Colors.transparent,
            labelColor: Colors.black,
            unselectedLabelColor: Color(0xff454E59),
            indicatorColor: Colors.black,
            tabs: const <Widget>[
              Tab(
                text: 'Videolar',
                icon: Icon(Icons.videocam),
              ),
              Tab(
                text: 'Haberler',
                icon: Icon(Icons.newspaper),
              ),
            ],
          ),
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
        body: TabBarView(
          controller: _tabController,
          children: [
            _buildVideosTab(context),
            _buildNewsTab(context),
          ],
        ),
        bottomNavigationBar: buildBottomNavigationBar,
        drawer: Drawer(
            child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xff37B6AE),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('PUSURA', style: CustomTextStyles2.drawerTitleTextStyle(context)),
                  Text('Piri Reis University', style: CustomTextStyles2.drawerTitleTextStyle(context)),
                  Text('SUSTAINABILITY RESEARCH AND APPLICATION CENTER',
                      style: CustomTextStyles2.drawerTitleTextStyle(context)),
                ],
              ),
            ),
            ListTile(
              title: const Text('Görünüm'),
              selected: _selectedIndexDrawer == 0,
              onTap: () {
                // Update the state of the app
                _onItemTapped(0);
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            const ExpansionTile(
              title: const Text('Limanlar, Deniz ve Açık Deniz'),
              children: <Widget>[
                Text("Görünüm"),
                Text("Gelişim İndexleri"),
                Text("Politikalar"),
                Text("Öncelikler"),
                Text("Yol Haritesı ve Hareketlilikler"),
              ],
              // onTap: () {
              // _onItemTapped(1);
              //   Navigator.pop(context);
              // },
              // selected: _selectedIndexDrawer == 2,
            ),
            const ExpansionTile(
              title: const Text('Gemi İnşaa/Bakım Onarım/Geri Dönüşüm'),
              children: <Widget>[
                Text("Görünüm"),
                Text("Gelişim İndexleri"),
                Text("Politikalar"),
                Text("Öncelikler"),
                Text("Yol Haritesı ve Hareketlilikler"),
              ],
              // onTap: () {
              //   _onItemTapped(2);
              //   Navigator.pop(context);
              // },
              // selected: _selectedIndexDrawer == 2,
            ),
            const ExpansionTile(
              title: Text("Deniz İşletmeciliği/Gemi Donatımı/Yeşil Finans"),
              children: <Widget>[
                Text("Görünüm"),
                Text("Gelişim İndexleri"),
                Text("Politikalar"),
                Text("Öncelikler"),
                Text("Yol Haritesı ve Hareketlilikler"),
              ],
              // onTap: () {
              //   _onItemTapped(2);
              //   Navigator.pop(context);
              // },
              // selected: _selectedIndexDrawer == 2,
            ),
            const ExpansionTile(
              title: Text("Teknolojiler/Yakıtlar/Dekarbonizasyon"),
              children: <Widget>[
                Text("Görünüm"),
                Text("Gelişim İndexleri"),
                Text("Politikalar"),
                Text("Öncelikler"),
                Text("Yol Haritesı ve Hareketlilikler"),
              ],
              // onTap: () {
              //   _onItemTapped(2);
              //   Navigator.pop(context);
              // },
              // selected: _selectedIndexDrawer == 2,
            ),
            const ExpansionTile(
              title: Text("Balıkçılık/Su Ürünleri"),
              children: <Widget>[
                Text("Görünüm"),
                Text("Gelişim İndexleri"),
                Text("Politikalar"),
                Text("Öncelikler"),
                Text("Yol Haritesı ve Hareketlilikler"),
              ],
              // onTap: () {
              //   _onItemTapped(2);
              //   Navigator.pop(context);
              // },
              // selected: _selectedIndexDrawer == 2,
            ),
            const ExpansionTile(
              title: Text("Eğitim"),
              children: <Widget>[
                Text("Görünüm"),
                Text("Gelişim İndexleri"),
                Text("Politikalar"),
                Text("Öncelikler"),
                Text("Yol Haritesı ve Hareketlilikler"),
              ],
              // onTap: () {
              //   _onItemTapped(2);
              //   Navigator.pop(context);
              // },
              // selected: _selectedIndexDrawer == 2,
            )
          ],
        )),
      ),
    );
  }

  CustomBottomNavigationBar get buildBottomNavigationBar {
    return CustomBottomNavigationBar(
      onTabChange: (int index) {
        setState(() {
          _selectedIndex = index;
        });
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
      selectedIndex: _selectedIndex,
    );
  }

  Widget _buildVideosTab(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        itemCount: videoItems.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: ListTile(
              leading: Image.asset(
                videoItems[index].imagePath,
                width: 100,
                height: 100,
                fit: BoxFit.fill,
              ),
              title: Text(videoItems[index].title),
              subtitle: Text(videoItems[index].description),
              onTap: () {
                // Handle onTap action
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildNewsTab(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        itemCount: newsItems.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: ListTile(
              leading: Image.asset(
                newsItems[index].imagePath,
                width: 120,
                height: 180,
                fit: BoxFit.cover,
              ),
              title: Text(newsItems[index].title),
              subtitle: Text(newsItems[index].description),
              onTap: () {
                // Handle onTap action
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildInitial(BuildContext context) {
    return Padding(padding: kAllPadding, child: Container());
  }

  Widget _buildSuccess(BuildContext context) {
    return Padding(
      padding: kAllPadding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          MyContainer(
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.check_circle, color: Colors.black, size: 50.0),
                    Box(size: BoxSize.SMALL, type: BoxType.VERTICAL),
                    Text('Scanned Successfully', style: CustomTextStyles2.titleMediumTextStyle(context, Colors.black)),
                    Box(size: BoxSize.SMALL, type: BoxType.VERTICAL),
                    Text('"Rik Samuel Vienna" was scanned successfully.',
                        textAlign: TextAlign.center,
                        style: CustomTextStyles2.titleExtraSmallTextStyle(context, CustomColors.darkGray)),
                  ],
                ),
              ),
              backgroundColor: CustomColors.bgGray),
          Box(size: BoxSize.LARGE, type: BoxType.VERTICAL),
          MyButtonWidget(
            content: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text('Scan', style: CustomTextStyles2.titleMediumTextStyle(context, CustomColors.darkGray)),
            ),
            onPressed: () {
              // widget.viewModel.scanQR();
            },
            context: context,
            buttonColor: CustomColors.bgGray,
          ),
          Box(size: BoxSize.MEDIUM, type: BoxType.VERTICAL),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Scan a new card',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.underline)),
              Icon(Icons.arrow_forward, color: Colors.black, size: 30.0)
            ],
          )
        ],
      ),
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
  MEDIA,
  ANNOUNCEMENT,
  SETTINGS,
}
