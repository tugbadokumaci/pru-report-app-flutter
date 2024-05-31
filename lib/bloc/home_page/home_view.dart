import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../bottom_nav_bar.dart';
import '../../constants/constants.dart';

import '../../models/card_model.dart';
import '../../size_config.dart';
import '../../utils/box_constrains.dart';
import '../../utils/custom_colors.dart';
import '../../utils/custom_text_styles.dart';
import '../../widget/box.dart';
import '../../widget/fabs.dart';
import '../../widget/lottie_widget.dart';
import 'home_cubit.dart';
import 'home_state.dart';

class HomeView extends StatefulWidget {
  // outside world of our constractor
  HomeCubit viewModel;
  HomeView({super.key, required this.viewModel});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
  }

  int _selectedIndex = Pages.HOME.index; // creating index field for our state
  // static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.w600, color: Colors.white);
  // static List<Widget> _widgetOptions = <Widget>[
  //   Text(LocaleKeys.home_appBarTitle.locale, style: optionStyle),
  //   Text(LocaleKeys.about_us_appBarTitle.locale, style: optionStyle),
  //   Text(LocaleKeys.contact_appBarTitle.locale, style: optionStyle),
  //   Text(LocaleKeys.profile_appBarTitle.locale, style: optionStyle),
  // ];

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

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeCubit>(create: (_) => widget.viewModel, child: _buildScaffold(context));
  }

  SafeArea _buildScaffold(BuildContext context) {
    // debugPrint("important: ${context.locale}");
    SizeConfig().init(context);
    return SafeArea(
        child: BlocConsumer<HomeCubit, HomeState>(
      listener: ((context, state) {}),
      builder: (context, state) {
        debugPrint('Home View State is : $state');
        if (state is HomeInitial) {
          // widget.viewModel.getData();
          widget.viewModel.getCards();
          return Container();
        } else if (state is HomeLoading) {
          return _buildLoading();
        } else if (state is HomeSuccess) {
          return _buildSuccess(context, state);
        } else if (state is HomeError) {
          return _buildError(context);
        }
        return Container();
      },
    ));
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
          case 1:
            Navigator.pushNamed(context, '/media', arguments: -1);
          case 2:
            Navigator.pushNamed(context, '/announcement');
          case 3:
            Navigator.pushNamed(context, '/profile');
        }
      },
      selectedIndex: _selectedIndex,
    );
  }

  Widget _buildSuccess(BuildContext context, HomeSuccess state) {
    return Scaffold(
      appBar: AppBar(
        // title: Text(LocaleKeys.home_appBarTitle.locale, style: CustomTextStyles2.appBarTextStyle(context)),
        title: Text('Home', style: CustomTextStyles2.appBarTextStyle(context)),
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
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FABs.buildCreateFab(context),
      // drawer: const Navbar(),
      // bottomNavigationBar: CustomBottomNavBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: kAllPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: _profileHeader(state.cardResource.data!.length),
              ),
              Padding(
                padding: kVerticalPadding,
                child: _horizontalCards(state.cardResource.data!),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: _profileHeader2(context),
              ),
              Padding(
                padding: kVerticalPadding,
                child: _horizontalCards2(state.cardResource.data!),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: _profileHeader3(context),
              ),
              Padding(
                padding: kVerticalPadding,
                child: _container(),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: _profileHeader4(context),
              ),
              Padding(
                padding: kVerticalPadding,
                child: _container2(),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: buildBottomNavigationBar,
      drawer: Drawer(
          child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xff1E376E),
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
          ExpansionTile(
            title: Text('Limanlar, Deniz ve Açık Deniz'),
            children: <Widget>[
              ListTile(
                title: Text("Görünüm"),
                onTap: () {
                  Navigator.pushNamed(context, '/submenu1');
                },
              ),
              ListTile(
                title: Text("Gelişim İndexleri"),
                onTap: () {
                  Navigator.pushNamed(context, '/submenu2');
                },
              ),
              ListTile(
                title: Text("Politikalar"),
                onTap: () {
                  Navigator.pushNamed(context, '/submenu3');
                },
              ),
              ListTile(
                title: Text("Öncelikler"),
                onTap: () {
                  Navigator.pushNamed(context, '/submenu4');
                },
              ),
              ListTile(
                title: Text("Yol Haritesı ve Hareketlilikler"),
                onTap: () {
                  Navigator.pushNamed(context, '/submenu5');
                },
              ),
            ],
          ),
          ExpansionTile(
            title: Text('Deniz İşletmeciliği/Gemi Donatımı/Yeşil Finans'),
            children: <Widget>[
              ListTile(
                title: Text("Görünüm"),
                onTap: () {
                  Navigator.pushNamed(context, '/submenu1');
                },
              ),
              ListTile(
                title: Text("Gelişim İndexleri"),
                onTap: () {
                  Navigator.pushNamed(context, '/submenu2');
                },
              ),
              ListTile(
                title: Text("Politikalar"),
                onTap: () {
                  Navigator.pushNamed(context, '/submenu3');
                },
              ),
              ListTile(
                title: Text("Öncelikler"),
                onTap: () {
                  Navigator.pushNamed(context, '/submenu4');
                },
              ),
              ListTile(
                title: Text("Yol Haritesı ve Hareketlilikler"),
                onTap: () {
                  Navigator.pushNamed(context, '/submenu5');
                },
              ),
            ],
          ),
          ExpansionTile(
            title: Text('Teknolojiler/Yakıtlar/Dekarbonizasyon'),
            children: <Widget>[
              ListTile(
                title: Text("Görünüm"),
                onTap: () {
                  Navigator.pushNamed(context, '/submenu1');
                },
              ),
              ListTile(
                title: Text("Gelişim İndexleri"),
                onTap: () {
                  Navigator.pushNamed(context, '/submenu2');
                },
              ),
              ListTile(
                title: Text("Politikalar"),
                onTap: () {
                  Navigator.pushNamed(context, '/submenu3');
                },
              ),
              ListTile(
                title: Text("Öncelikler"),
                onTap: () {
                  Navigator.pushNamed(context, '/submenu4');
                },
              ),
              ListTile(
                title: Text("Yol Haritesı ve Hareketlilikler"),
                onTap: () {
                  Navigator.pushNamed(context, '/submenu5');
                },
              ),
            ],
          ),
          ExpansionTile(
            title: Text('Balıkçılık/Su Ürünleri'),
            children: <Widget>[
              ListTile(
                title: Text("Görünüm"),
                onTap: () {
                  Navigator.pushNamed(context, '/submenu1');
                },
              ),
              ListTile(
                title: Text("Gelişim İndexleri"),
                onTap: () {
                  Navigator.pushNamed(context, '/submenu2');
                },
              ),
              ListTile(
                title: Text("Politikalar"),
                onTap: () {
                  Navigator.pushNamed(context, '/submenu3');
                },
              ),
              ListTile(
                title: Text("Öncelikler"),
                onTap: () {
                  Navigator.pushNamed(context, '/submenu4');
                },
              ),
              ListTile(
                title: Text("Yol Haritesı ve Hareketlilikler"),
                onTap: () {
                  Navigator.pushNamed(context, '/submenu5');
                },
              ),
            ],
          ),
          ExpansionTile(
            title: Text('Eğitim'),
            children: <Widget>[
              ListTile(
                title: Text("Görünüm"),
                onTap: () {
                  Navigator.pushNamed(context, '/submenu1');
                },
              ),
              ListTile(
                title: Text("Gelişim İndexleri"),
                onTap: () {
                  Navigator.pushNamed(context, '/submenu2');
                },
              ),
              ListTile(
                title: Text("Politikalar"),
                onTap: () {
                  Navigator.pushNamed(context, '/submenu3');
                },
              ),
              ListTile(
                title: Text("Öncelikler"),
                onTap: () {
                  Navigator.pushNamed(context, '/submenu4');
                },
              ),
              ListTile(
                title: Text("Yol Haritesı ve Hareketlilikler"),
                onTap: () {
                  Navigator.pushNamed(context, '/submenu5');
                },
              ),
            ],
          ),
          ListTile(
            title: Text('Rapor Örneği'),
            onTap: () {
              _onItemTapped(2);
              Navigator.pop(context);
              Navigator.pushNamed(context, '/sampleReport');
            },
            selected: _selectedIndexDrawer == 2,
          ),
          ListTile(
            title: Text('Tüm Raporlar'),
            onTap: () {
              _onItemTapped(2);
              Navigator.pop(context);
              Navigator.pushNamed(context, '/reports');
            },
            selected: _selectedIndexDrawer == 2,
          ),
          ListTile(
            title: Text('İletişim'),
            onTap: () {
              _onItemTapped(2);
              Navigator.pop(context);
              Navigator.pushNamed(context, '/contact');
            },
            selected: _selectedIndexDrawer == 2,
          ),
        ],
      )),
    );
  }

  Column _profileHeader(int length) {
    return Column(
      children: [
        Row(
          children: [
            Text('Yeni Nesil Görselleştirme',
                // LocaleKeys.home_servicesTitle.locale,
                style: CustomTextStyles2.titleLargeTextStyle(context, Colors.black)),
            const Spacer(),
            const Icon(Icons.add_circle, color: Colors.black, size: 40),
          ],
        ),
        const Text('Yeni nesil görselleştirme teknikleri ile  raporlarımızı şimdi daha kolay inceleyin.')
      ],
    );
  }

  Widget _horizontalCards(List<CardModel> cards) {
    if (cards.isEmpty) {
      return Column(
        children: [
          Icon(Icons.error_outline, color: CustomColors.bwyYellow),
          const Box(size: BoxSize.EXTRASMALL, type: BoxType.VERTICAL),
          Text(
            'Bulunamadı',
            textAlign: TextAlign.center,
            style: CustomTextStyles2.titleSmallTextStyle(context, Colors.grey),
          )
        ],
      );
    }
    return Container(
        height: 200,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 4,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 370,
                child: Image.asset('assets/images/slider${index}.png', height: 200, fit: BoxFit.fitWidth),
              ),
            );
          },
        ));
  }

  Widget _horizontalCards2(List<CardModel> cards) {
    if (cards.isEmpty) {
      return Column(
        children: [
          Icon(Icons.error_outline, color: CustomColors.bwyYellow),
          const Box(size: BoxSize.EXTRASMALL, type: BoxType.VERTICAL),
          Text(
            'Bulunamadı',
            textAlign: TextAlign.center,
            style: CustomTextStyles2.titleSmallTextStyle(context, Colors.grey),
          )
        ],
      );
    }
    return Container(
        height: 200,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 4,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 370,
                child: Image.asset('assets/images/hakkimizda${index}.png', height: 200, fit: BoxFit.fitWidth),
              ),
            );
          },
        ));
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
    return Scaffold(
        body: Column(
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
    ));
  }

  Widget _profileHeader2(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Bizi Tanıyın',
            // LocaleKeys.home_myServicesTitle.locale,
            style: CustomTextStyles2.titleLargeTextStyle(context, Colors.black)),
        const Text('Denizcilik Sektörünün göz bebeği Piri Reis Üniversitesini yakından tanıyın.')
      ],
    );
  }

  Widget _profileHeader3(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Verimlilik İçin Raporluyoruz',
            // LocaleKeys.home_myServicesTitle.locale,
            style: CustomTextStyles2.titleLargeTextStyle(context, Colors.black)),
        const Text(
            'Modern görselleştirilme teknikleri ile hazırladığımız analizlerimizi okuyucuya daha etkili sunuyoruz. ')
      ],
    );
  }

  Widget _container() {
    return Image.asset('assets/images/graphics.png');
  }

  Widget _profileHeader4(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Sayılarla PRU',
            // LocaleKeys.home_myServicesTitle.locale,
            style: CustomTextStyles2.titleLargeTextStyle(context, Colors.black)),
        const Text('Deniz Ticaret Odası destekleriyle popüler  analiz raporlarımızı keşfetmeye başlayın.')
      ],
    );
  }

  Widget _container2() {
    return Column(
      children: [
        Image.asset('assets/images/graphics2.png'),
        const ExpansionTile(
          title: Text('Haftanın en çok okunan analiz raporları'),
          subtitle: Text('Haftanın en çok görüntülenen analiz raporlarını inceleyin.'),
          controlAffinity: ListTileControlAffinity.leading,
          children: <Widget>[
            ListTile(title: Text('Rapor-11-04-2024.pdf')),
            ListTile(title: Text('Rapor-17-01-2024.pdf')),
            ListTile(title: Text('Rapor-13.05.2024.pdf')),
          ],
        ),
        const ExpansionTile(
          title: Text('Enerji verimliliğinde biz - PRU'),
          subtitle: Text('Leading expansion arrow icon'),
          controlAffinity: ListTileControlAffinity.leading,
          children: <Widget>[
            ListTile(title: Text('This is tile number 3')),
          ],
        ),
        const ExpansionTile(
          title: Text('Daha temiz yarınlar için - PRU'),
          subtitle: Text('Leading expansion arrow icon'),
          controlAffinity: ListTileControlAffinity.leading,
          children: <Widget>[
            ListTile(title: Text('This is tile number 3')),
          ],
        ),
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
