import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_code_app/bloc/media_page/media_state.dart';

import '../../enum/pages_enum.dart';
import '../../models/news_model.dart';
import '../../utils/custom_bottom_nav_bar.dart';
import '../../utils/custom_colors.dart';
import '../../utils/custom_text_styles.dart';
import '../../utils/news_card.dart';
import '../../widget/lottie_widget.dart';
import '../news_page/news_view.dart';
import 'media_cubit.dart';

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
  final int _selectedIndexDrawer = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this); // Length is set to 3 for three tabs
    widget.viewModel.getAllNews();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  int _selectedIndex = Pages.MEDIA.index;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MediaCubit>(
        create: (_) => widget.viewModel,
        child: BlocConsumer<MediaCubit, MediaState>(
          listener: (context, state) {
            if (state is MediaDetail) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NewsDetailView(news: state.news),
                ),
              ).then((_) {
                // Haber detayından geri dönüldüğünde haber listesini yenile
                context.read<MediaCubit>().getAllNews();
              });
            }
          },
          builder: (context, state) {
            if (state is MediaLoading) {
              return _buildLoading(context);
            } else if (state is MediaSuccess) {
              return _buildSuccess(context, state);
            } else if (state is MediaError) {
              return _buildError(context);
            }
            return Container();
          },
        ));
  }

  SafeArea _buildSuccess(BuildContext context, MediaSuccess state) {
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
              unselectedLabelColor: const Color(0xff454E59),
              indicatorColor: Colors.black,
              tabs: const <Widget>[
                Tab(
                  text: 'Haberler',
                  icon: Icon(Icons.newspaper),
                ),
                Tab(
                  text: 'Etkinlikler',
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
              _buildNewsTab(context, state),
              _buildVideosTab(context),
            ],
          ),
          backgroundColor: CustomColors.bgGray,
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
          ))),
    );
  }

  Widget _buildVideosTab(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.green.withOpacity(0.2), // Hafif uyarı rengi
          borderRadius: BorderRadius.circular(12), // Radius ile yuvarlatma
        ),
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Icon(
              Icons.notifications, // Bildirim ikonu
              color: Colors.green, // İkon rengi
              size: 40, // İkon boyutu
            ),
            const SizedBox(width: 12), // İkon ile metin arasında boşluk
            Expanded(
              child: Text(
                'Güncel etkinlikleri eklendiği zaman burada takip edebilirsiniz.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.green[800], // Yazı rengi
                  fontWeight: FontWeight.w600, // Yazı kalınlığı
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNewsTab(BuildContext context, MediaSuccess state) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: state.newsResource.data?.length ?? 0,
        itemBuilder: (context, index) {
          News newsItem = state.newsResource.data![index];
          return NewsCard(
            news: newsItem,
            onTap: () {
              context.read<MediaCubit>().showNewsDetail(newsItem);
            },
          );
        },
      ),
    );
  }

  // Widget _buildSuccess(BuildContext context) {
  //   return Padding(
  //     padding: kAllPadding,
  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       crossAxisAlignment: CrossAxisAlignment.center,
  //       children: [
  //         MyContainer(
  //             backgroundColor: CustomColors.bgGray,
  //             child: Padding(
  //               padding: const EdgeInsets.all(18.0),
  //               child: Column(
  //                 mainAxisSize: MainAxisSize.min,
  //                 crossAxisAlignment: CrossAxisAlignment.center,
  //                 children: [
  //                   const Icon(Icons.check_circle, color: Colors.black, size: 50.0),
  //                   const Box(size: BoxSize.SMALL, type: BoxType.VERTICAL),
  //                   Text('Scanned Successfully', style: CustomTextStyles2.titleMediumTextStyle(context, Colors.black)),
  //                   const Box(size: BoxSize.SMALL, type: BoxType.VERTICAL),
  //                   Text('"Rik Samuel Vienna" was scanned successfully.',
  //                       textAlign: TextAlign.center,
  //                       style: CustomTextStyles2.titleExtraSmallTextStyle(context, CustomColors.darkGray)),
  //                 ],
  //               ),
  //             )),
  //         const Box(size: BoxSize.LARGE, type: BoxType.VERTICAL),
  //         MyButtonWidget(
  //           content: Padding(
  //             padding: const EdgeInsets.all(18.0),
  //             child: Text('Scan', style: CustomTextStyles2.titleMediumTextStyle(context, CustomColors.darkGray)),
  //           ),
  //           onPressed: () {
  //             // widget.viewModel.scanQR();
  //           },
  //           context: context,
  //           buttonColor: CustomColors.bgGray,
  //         ),
  //         const Box(size: BoxSize.MEDIUM, type: BoxType.VERTICAL),
  //         const Row(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             Text('Scan a new card',
  //                 style: TextStyle(
  //                     color: Colors.black,
  //                     fontSize: 20.0,
  //                     fontFamily: 'Inter',
  //                     fontWeight: FontWeight.w600,
  //                     decoration: TextDecoration.underline)),
  //             Icon(Icons.arrow_forward, color: Colors.black, size: 30.0)
  //           ],
  //         )
  //       ],
  //     ),
  //   );
  // }

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
