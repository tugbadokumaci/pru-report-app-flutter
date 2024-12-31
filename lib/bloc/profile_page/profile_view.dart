import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_code_app/bloc/profile_page/profile_cubit.dart';
import '../../bottom_nav_bar.dart';
import '../../constants/constants.dart';
import '../../utils/custom_colors.dart';
import '../../utils/custom_text_styles.dart';
import '../../widget/lottie_widget.dart';
import 'profile_state.dart';
import 'package:flutter/cupertino.dart';

class ProfileView extends StatefulWidget {
  ProfileCubit viewModel;
  ProfileView({super.key, required this.viewModel});

  @override
  State<ProfileView> createState() => _ProfileViewState();
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

class _ProfileViewState extends State<ProfileView> {
  // String? fcmToken;

  bool switchValue1 = false;
  bool switchValue2 = false;
  bool switchValue3 = false;
  bool switchValue4 = false; // isSubscribed

  int _selectedIndex = Pages.PROFILE.index;
  final int _selectedIndexDrawer = 0;
  // @override
  // void initState() {
  //   super.initState();
  //   _initializeFCM();
  // }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Future<void> _initializeFCM() async {
  //   FirebaseMessaging messaging = FirebaseMessaging.instance;

  //   // Kullanıcıdan izin iste
  //   NotificationSettings settings = await messaging.requestPermission(
  //     alert: true,
  //     badge: true,
  //     sound: true,
  //   );

  //   if (settings.authorizationStatus == AuthorizationStatus.authorized) {
  //     // FCM Token al
  //     String? token = await messaging.getToken();
  //     setState(() {
  //       fcmToken = token;
  //     });
  //     print("FCM Token: $token");
  //   } else {
  //     print("Bildirim izni verilmedi.");
  //   }

  //   // Gelen bildirimleri dinle
  //   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //     if (message.notification != null) {
  //       // Bildirim içeriği
  //       _showNotificationDialog(
  //         title: message.notification!.title ?? 'Bildirim',
  //         body: message.notification!.body ?? 'İçerik',
  //       );
  //     }
  //   });
  // }

  // void _showNotificationDialog({required String title, required String body}) {
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //         title: Text(title),
  //         content: Text(body),
  //         actions: [
  //           TextButton(
  //             onPressed: () => Navigator.pop(context),
  //             child: const Text('Tamam'),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileCubit>(
      create: (context) => widget.viewModel,
      child: _buildScaffold(context),
    );
  }

  SafeArea _buildScaffold(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          // title: Text(LocaleKeys.home_appBarTitle.locale, style: CustomTextStyles2.appBarTextStyle(context)),
          title: Text('Hesabım', style: CustomTextStyles2.appBarTextStyle(context)),
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
            child: BlocConsumer<ProfileCubit, ProfileState>(
          listener: (context, state) {
            // if (state is SubscriptionStatusChanged) {
            //   setState(() {
            //     switchValue4 = state.isSubscribed; // Update the subscription status
            //   });
            // }
          },
          builder: (context, state) {
            debugPrint('Scan View State is : $state');
            if (state is ProfileInitial) {
              // widget.viewModel.getData();
              return _buildInitial();
            } else if (state is ProfileLoading) {
              return _buildLoading();
            } else if (state is ProfileSuccess) {
              return Container();
            } else if (state is ProfileError) {
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
              decoration: const BoxDecoration(
                color: Color(0xff1E376E),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
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
          const Text(
            'Bildirim Ayarları',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
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
            title: const Text('Yeni Analiz Raporu Bildirimleri'),
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
            title: const Text('Yeni Video Bildirimleri'),
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
            title: const Text('Yeni Haber Bildirimleri'),
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: CupertinoSwitch(
              // This bool value toggles the switch.
              value: switchValue4,
              activeColor: CupertinoColors.systemGreen,
              onChanged: (bool? value) {
                setState(() {
                  switchValue4 = value ?? false;
                });
                if (switchValue4) {
                  widget.viewModel.subscribeToTopic();
                } else {
                  widget.viewModel.unsubscribeFromTopic();
                }
                // if (value != null) {
                //             context.read<ProfileCubit>().toggleSubscription();
                //           }
              },
            ),
            title: const Text('Yeni Bültenler Bildirimi'),
          ),
          const Text('Current version 1.0.0'),
          // Center(
          //   child: fcmToken == null
          //       ? const CircularProgressIndicator()
          //       : Column(
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           children: [
          //             const Text('FCM Token:'),
          //             Padding(
          //               padding: const EdgeInsets.all(8.0),
          //               child: SelectableText(fcmToken ?? ''),
          //             ),
          //           ],
          //         ),
          // ),
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
