import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_code_app/bloc/home_page/home_state.dart';
import 'package:qr_code_app/bloc/reports_page/reports_cubit.dart';
import 'package:qr_code_app/size_config.dart';

import '../../bottom_nav_bar.dart';
import '../../enum/pages_enum.dart';
import '../../models/post_model.dart';
import '../../utils/custom_colors.dart';
import '../../utils/custom_text_styles.dart';
import '../../utils/regex_img_func.dart';
import '../../widget/lottie_widget.dart';
import 'reports_state.dart';

class ReportsView extends StatefulWidget {
  final ReportsCubit viewModel;
  const ReportsView({Key? key, required this.viewModel}) : super(key: key);

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

  final int _selectedIndexDrawer = 0;
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
          widget.viewModel.getAllPosts();
          return Container();
        } else if (state is ReportsLoading) {
          return _buildLoading();
        } else if (state is ReportsSuccess) {
          return _buildSuccess(context, state);
        } else if (state is ReportsDetail) {
          return _buildDetail(context, state.post);
        } else if (state is HomeError) {
          return _buildError(context);
        }
        return Container();
      },
    ));
  }

  Widget _buildDetail(BuildContext context, PostModel postModel) {
    // Extract the thumbnail URL
    String? thumbnailUrl = extractImageUrl(postModel.postThumbnail);

    // List of image URLs, filtering out any null values
    List<String> imageUrls = postModel.imageUrls.where((url) => url != null).cast<String>().toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Rapor Detay',
          style: CustomTextStyles2.titleLargeTextStyle(context, Colors.black),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left,
            color: CustomColors.pruBlue,
            size: 40,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thumbnail image
            if (thumbnailUrl.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Image.network(
                  thumbnailUrl,
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
            // Descriptions
            if (postModel.aciklama_1_ust_baslik.isNotEmpty)
              Text(
                postModel.aciklama_1_ust_baslik,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            if (postModel.aciklama_1.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  postModel.aciklama_1,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            if (postModel.aciklama_2_ust_baslik.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  postModel.aciklama_2_ust_baslik,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            if (postModel.aciklama_2.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  postModel.aciklama_2,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            // Additional images
            if (imageUrls.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'İlgili Resimler:',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8.0),
                    Column(
                      children: imageUrls.map((url) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Image.network(url),
                        );
                      }).toList(),
                    ),
                  ],
                ),
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
                  Navigator.pushNamed(context, '/projects');
                },
              ),
              ListTile(
                title: const Text("Tübitak Projeleri"),
                onTap: () {
                  Navigator.pushNamed(context, '/projects');
                },
              ),
              ListTile(
                title: const Text("BAP Projeleri"),
                onTap: () {
                  Navigator.pushNamed(context, '/projects');
                },
              ),
              ListTile(
                title: const Text("Sanayi-Üniversite İşbirliği Projeleri"),
                onTap: () {
                  Navigator.pushNamed(context, '/projects');
                },
              ),
              ListTile(
                title: const Text("Diğer Projeler"),
                onTap: () {
                  Navigator.pushNamed(context, '/projects');
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

  Widget _reportsContainer(ReportsSuccess state) {
    return ListView.builder(
      itemCount: state.reportResource.data!.length,
      itemBuilder: (context, index) {
        PostModel page = state.reportResource.data![index];
        return ListTile(
          leading: page.postThumbnail.isNotEmpty
              ? Image.network(
                  extractImageUrl(page.postThumbnail),
                  width: 50, // İstediğiniz thumbnail boyutunu belirleyin
                  height: 50,
                  fit: BoxFit.cover,
                )
              : const Icon(Icons.image_not_supported), // Yedek resim veya ikon
          title: Text('${page.postTitle} kategori: ${page.termTaxonomyIds.join(', ')}'),
          subtitle: Text(page.aciklama_1),
          onTap: () {
            widget.viewModel.goToDetail(page);
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
