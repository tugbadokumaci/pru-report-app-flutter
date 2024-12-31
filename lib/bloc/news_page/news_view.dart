import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_code_app/bloc/news_page/news_cubit.dart';
import 'package:qr_code_app/bloc/news_page/news_state.dart';
import 'package:qr_code_app/constants/constants.dart';
import 'package:qr_code_app/models/news_model.dart';
import 'package:qr_code_app/utils/news_card.dart';

import '../../enum/pages_enum.dart';
import '../../utils/custom_bottom_nav_bar.dart';
import '../../utils/custom_colors.dart';
import '../../utils/custom_text_styles.dart';
import '../../widget/lottie_widget.dart';

class NewsView extends StatefulWidget {
  final NewsCubit viewModel;

  const NewsView({Key? key, required this.viewModel}) : super(key: key);

  @override
  State<NewsView> createState() => _NewsViewState();
}

class _NewsViewState extends State<NewsView> {
  @override
  void initState() {
    super.initState();
    widget.viewModel.getAllNews();
  }

  int _selectedIndex = Pages.HOME.index;

  final int _selectedIndexDrawer = 3;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NewsCubit>(
      create: (_) => widget.viewModel,
      child: BlocConsumer<NewsCubit, NewsState>(
        listener: (context, state) {
          if (state is NewsDetail) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NewsDetailView(news: state.news),
              ),
            ).then((_) {
              // Haber detayından geri dönüldüğünde haber listesini yenile
              context.read<NewsCubit>().getAllNews();
            });
          }
        },
        builder: (context, state) {
          if (state is NewsLoading) {
            return _buildLoading(context);
          } else if (state is NewsSuccess) {
            return _buildSuccess(context, state);
          } else if (state is NewsError) {
            return _buildError(context);
          }
          return Container();
        },
      ),
    );
  }

  Widget _buildSuccess(BuildContext context, NewsSuccess state) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Haberler', style: CustomTextStyles2.appBarTextStyle(context)),
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
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: state.newsResource.data?.length ?? 0,
                itemBuilder: (context, index) {
                  News newsItem = state.newsResource.data![index];
                  return GestureDetector(
                      onTap: () {
                        context.read<NewsCubit>().showNewsDetail(newsItem);
                      },
                      child: NewsCard(
                        news: newsItem,
                        onTap: () {
                          context
                              .read<NewsCubit>()
                              .showNewsDetail(newsItem); // Buraya istediğiniz fonksiyonu verebilirsiniz
                        },
                      ));
                },
              ),
            ],
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

  Widget _buildError(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Bir hata oluştu.',
          style: CustomTextStyles2.titleMediumTextStyle(context, CustomColors.bwyYellow),
        ),
      ),
    );
  }
}

class NewsDetailView extends StatelessWidget {
  final News news;

  const NewsDetailView({Key? key, required this.news}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Haber Detayı", style: CustomTextStyles2.appBarTextStyle(context)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(news.coverImage),
              const SizedBox(height: 16),
              Text(
                news.title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.start,
              ),
              const SizedBox(height: 16),
              // Content text
              Text(
                news.content,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 32),
              // Image Gallery
              const Text(
                "Galeri",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Column(
                children: news.photoGallery.map((imageUrl) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Image.network(
                      imageUrl,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        }
                        return const Center(child: CircularProgressIndicator());
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return const Center(
                          child: Text(
                            "Resim yüklenemedi.",
                            style: TextStyle(color: Colors.red),
                          ),
                        );
                      },
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
