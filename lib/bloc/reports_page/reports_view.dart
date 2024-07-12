import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_code_app/bloc/home_page/home_state.dart';
import 'package:qr_code_app/bloc/reports_page/reports_cubit.dart';
import 'package:qr_code_app/models/report_model.dart';
import 'package:qr_code_app/size_config.dart';

import '../../bottom_nav_bar.dart';
import '../../utils/custom_colors.dart';
import '../../utils/custom_text_styles.dart';
import '../../widget/lottie_widget.dart';
import 'reports_state.dart';

class ReportsView extends StatefulWidget {
  final ReportsCubit viewModel;
  ReportsView({Key? key, required this.viewModel}) : super(key: key);

  @override
  State<ReportsView> createState() => _ReportsViewState();
}

class _ReportsViewState extends State<ReportsView> {
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
    return BlocProvider<ReportsCubit>(create: (_) => widget.viewModel, child: _buildScaffold(context));
  }

  SafeArea _buildScaffold(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
        child: BlocConsumer<ReportsCubit, ReportsState>(
      listener: ((context, state) {}),
      builder: (context, state) {
        debugPrint('Reports View State is: $state');
        if (state is ReportsInitial) {
          widget.viewModel.getAllReports();
          return Container();
        } else if (state is ReportsLoading) {
          return _buildLoading();
        } else if (state is ReportsSuccess) {
          return _buildSuccess(context, state);
        } else if (state is ReportsDetail) {
          return _buildDetail(context, state.report);
        } else if (state is HomeError) {
          return _buildError(context);
        }
        return Container();
      },
    ));
  }

  Widget _buildDetail(BuildContext context, ReportModel reportModel) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rapor Detay', style: CustomTextStyles2.titleLargeTextStyle(context, Colors.black)),
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Title: ${reportModel.reportTitle}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Description: ${reportModel.reportDescription}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              'Text: ${reportModel.reportText}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              'Date: ${reportModel.reportDate}',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSuccess(BuildContext context, ReportsSuccess state) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tüm Raporlar', style: CustomTextStyles2.titleLargeTextStyle(context, Colors.black)),
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
      body: _reportsContainer(state),
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

  Widget _reportsContainer(ReportsSuccess state) {
    return ListView.builder(
      itemCount: state.reportResource.data!.length,
      itemBuilder: (context, index) {
        ReportModel report = state.reportResource.data![index];
        return ListTile(
          title: Text(report.reportTitle),
          subtitle: Text(report.reportDescription),
          onTap: () {
            widget.viewModel.goToDetail(report);
          },
        );
      },
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
}

enum Pages {
  HOME,
  MEDIA,
  ANNOUNCEMENT,
  SETTINGS,
}
