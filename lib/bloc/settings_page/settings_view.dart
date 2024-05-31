import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_code_app/bloc/settings_page/settings_cubit.dart';
import '../../bottom_nav_bar.dart';
import '../../constants/constants.dart';
import '../../utils/custom_colors.dart';
import '../../utils/custom_text_styles.dart';
import '../../widget/lottie_widget.dart';
import 'settings_state.dart';
import 'package:flutter/cupertino.dart';

class SettingsView extends StatefulWidget {
  SettingsCubit viewModel;
  SettingsView({super.key, required this.viewModel});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

List<Image> images = [
  Image.asset('assets/images/turkish.png', height: 50, width: 50),
  Image.asset('assets/images/english.png', height: 50, width: 50),
  Image.asset('assets/images/german.png', height: 50, width: 50)
];

List<String> languages = ["Türkçe", "English", "Deutch"];
// List<Map<String, dynamic>> languages = [
//   {'image': Image.asset('assets/images/turkish.png', height: 50, width: 50), 'name': "Türkçe"},
//   {'image': Image.asset('assets/images/english.png', height: 50, width: 50), 'name': "English"},
//   {'image': Image.asset('assets/images/german.png', height: 50, width: 50), 'name': "Deutsch"},
// ];

int dropdownIndex = 0; // otherwise will be assign to the index 0 after clicks

class _SettingsViewState extends State<SettingsView> {
  bool switchValue1 = true;
  bool switchValue2 = true;
  bool switchValue3 = true;
  bool switchValue4 = true;

  int _selectedIndex = Pages.PROFILE.index;
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
    return BlocProvider<SettingsCubit>(
      create: (context) => widget.viewModel,
      child: _buildScaffold(context),
    );
  }

  SafeArea _buildScaffold(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          // title: Text(LocaleKeys.home_appBarTitle.locale, style: CustomTextStyles2.appBarTextStyle(context)),
          title: Text('Ayarlar', style: CustomTextStyles2.appBarTextStyle(context)),
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
        body: SingleChildScrollView(
            child: BlocConsumer<SettingsCubit, SettingsState>(
          listener: ((context, state) {}),
          builder: (context, state) {
            debugPrint('Scan View State is : $state');
            if (state is SettingsInitial) {
              // widget.viewModel.getData();
              return _buildInitial();
            } else if (state is SettingsLoading) {
              return _buildLoading();
            } else if (state is SettingsSuccess) {
              return Container();
            } else if (state is SettingsError) {
              return _buildError(context);
            }
            return Container();
          },
        )),
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

  Widget _buildInitial() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Bildirim Ayarları',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: CupertinoSwitch(
              // This bool value toggles the switch.
              value: switchValue1,
              activeColor: CupertinoColors.systemGreen,
              onChanged: (bool? value) {
                // This is called when the user toggles the switch.
                setState(() {
                  switchValue1 = value ?? false;
                });
              },
            ),
            title: Text('Yeni Analiz Raporu Bildirimleri'),
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: CupertinoSwitch(
              // This bool value toggles the switch.
              value: switchValue2,
              activeColor: CupertinoColors.systemGreen,
              onChanged: (bool? value) {
                // This is called when the user toggles the switch.
                setState(() {
                  switchValue2 = value ?? false;
                });
              },
            ),
            title: Text('Yeni Video Bildirimleri'),
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: CupertinoSwitch(
              // This bool value toggles the switch.
              value: switchValue3,
              activeColor: CupertinoColors.systemGreen,
              onChanged: (bool? value) {
                // This is called when the user toggles the switch.
                setState(() {
                  switchValue3 = value ?? false;
                });
              },
            ),
            title: Text('Yeni Haber Bildirimleri'),
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: CupertinoSwitch(
              // This bool value toggles the switch.
              value: switchValue4,
              activeColor: CupertinoColors.systemGreen,
              onChanged: (bool? value) {
                // This is called when the user toggles the switch.
                setState(() {
                  switchValue4 = value ?? false;
                });
              },
            ),
            title: Text('Yeni Duyuru Bildirimleri'),
          ),
          Text('Current version 1.0.0')
        ],
      ),
    );
  }

  Widget _buildSuccess(BuildContext context) {
    return Column(
      children: [
        _profileHeader(),
        // Box(size: BoxSize.LARGE, type: BoxType.VERTICAL),
        // _profileBody(),
      ],
    );
  }

  Row _profileHeader() {
    return Row(
      children: [
        Image.asset('assets/images/user.png', height: 40),
        TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/profile');
            },
            child: Text('${Constants.USER.userName} ${Constants.USER.userSurname}',
                style: CustomTextStyles2.titleSmallTextStyle(context, Colors.white))),
        const Spacer(),
        DropdownButtonHideUnderline(
          child: DropdownButton<Image>(
            value: images[dropdownIndex],
            dropdownColor: Colors.black,
            onChanged: (Image? value) {
              setState(() {
                dropdownIndex = images.indexOf(value!);
                context.setLocale(Localization.SUPPORTED_LANGUAGES[dropdownIndex]);
              });
            },
            items: images.map<DropdownMenuItem<Image>>((Image value) {
              return DropdownMenuItem<Image>(
                value: value,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Row(
                    children: [
                      value,
                      // Box(size: BoxSize.EXTRASMALL, type: BoxType.HORIZONTAL),
                      // Text(languages[images.indexOf(value)],
                      //     style: TextStyle(fontSize: SizeConfig.defaultSize! * 1.7, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        )
      ],
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
  PROFILE,
}
